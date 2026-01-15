"""Teleos MCP HTTP client for retrieving client financial data."""

import json
import requests
from typing import Optional, List, Dict
from config import config


class TeleosClient:
    """HTTP client for communicating with the Teleos MCP server."""

    def __init__(self, host: str = None, port: int = None, api_key: str = None):
        self.host = host or config.MCP_HOST
        self.port = port or config.MCP_PORT
        self.api_key = api_key or config.MCP_API_KEY
        self.base_url = f"http://{self.host}:{self.port}"
        self.timeout = 30

    def _get_headers(self) -> dict:
        """Get headers for API requests."""
        headers = {'Content-Type': 'application/json'}
        if self.api_key:
            headers['X-API-Key'] = self.api_key
        return headers

    def _call_tool(self, tool_name: str, params: dict = None) -> dict:
        """Call an MCP tool and return the result."""
        url = f"{self.base_url}/tools/{tool_name}"
        try:
            response = requests.post(
                url,
                headers=self._get_headers(),
                json=params or {},
                timeout=self.timeout
            )
            response.raise_for_status()
            result = response.json()

            # Parse the MCP HTTP server response format
            # Format: {"success": true, "result": {"content": [{"type": "text", "text": "{...}"}]}}
            if 'result' in result:
                result = result['result']

            if 'content' in result and len(result['content']) > 0:
                text_content = result['content'][0].get('text', '{}')
                return json.loads(text_content)
            return result
        except requests.exceptions.RequestException as e:
            raise TeleosConnectionError(f"Failed to connect to Teleos MCP: {e}")
        except json.JSONDecodeError as e:
            raise TeleosParseError(f"Failed to parse Teleos response: {e}")

    def health_check(self) -> bool:
        """Check if the MCP server is running."""
        try:
            response = requests.get(
                f"{self.base_url}/health",
                timeout=5
            )
            return response.status_code == 200
        except requests.exceptions.RequestException:
            return False

    def execute_custom_query(self, query: str) -> List[dict]:
        """Execute a custom SQL query on the Teleos database."""
        try:
            result = self._call_tool('execute_custom_query', {'query': query})
            if isinstance(result, list):
                return result
            return []
        except (TeleosConnectionError, TeleosParseError):
            return []

    def get_client_by_id(self, client_id: int) -> Optional[dict]:
        """Fetch client details from Teleos by Client_ID."""
        try:
            result = self._call_tool('get_client_by_id', {'clientId': int(client_id)})
            if result and not result.get('error'):
                return result
            return None
        except (TeleosConnectionError, TeleosParseError):
            return None

    def get_client_balance(self, client_id: int) -> Optional[float]:
        """Get the current balance for a client from clientbalance table."""
        query = f"""
        SELECT Balance FROM clientbalance
        WHERE ClientID = {int(client_id)}
        """
        try:
            result = self.execute_custom_query(query)
            if result and len(result) > 0:
                return float(result[0].get('Balance', 0))
            return None
        except (ValueError, TypeError):
            return None

    def get_client_department(self, client_id: int) -> Optional[str]:
        """
        Get the client's department code.

        Joins client table with client_department to get department code.
        Returns codes like: BAD, INV, RET, ACC, PAY, INS, REF, ZST
        """
        query = f"""
        SELECT cd.Client_department_number
        FROM client c
        JOIN client_department cd ON c.Client_department_ID = cd.Client_department_ID
        WHERE c.Client_ID = {int(client_id)}
        """
        try:
            result = self.execute_custom_query(query)
            if result and len(result) > 0:
                return result[0].get('Client_department_number')
            return None
        except Exception:
            return None

    def get_financial_history(self, client_id: int, limit: int = 50) -> List[dict]:
        """
        Get financial transaction history for a client.

        Returns list of transactions with details, amounts, paid status etc.
        """
        try:
            result = self._call_tool('get_financial_history', {'clientId': int(client_id)})
            if isinstance(result, list):
                return result[:limit]
            return []
        except (TeleosConnectionError, TeleosParseError):
            return []

    def get_outstanding_invoices(self, client_id: int) -> List[dict]:
        """Get unpaid invoices for a client."""
        try:
            result = self._call_tool('get_client_outstanding_invoices', {'clientId': int(client_id)})
            if isinstance(result, list):
                return result
            return []
        except (TeleosConnectionError, TeleosParseError):
            return []

    def get_recent_transactions(self, client_id: int, days: int = 90) -> List[dict]:
        """
        Get recent transactions for a client with item type information.

        Returns transactions with procedure/stock distinction.
        """
        query = f"""
        SELECT
            t.Transaction_ID,
            t.Invoice_date,
            t.Details,
            t.Net_value,
            t.VAT_amount,
            t.Invoiced,
            t.Paid,
            t.Animal_ID
        FROM transactions t
        WHERE t.Client_ID = {int(client_id)}
        AND t.Invoice_date >= DATE_SUB(CURDATE(), INTERVAL {int(days)} DAY)
        ORDER BY t.Invoice_date DESC
        LIMIT 100
        """
        return self.execute_custom_query(query)

    def get_sms_history(self, client_id: int, days: int = 60) -> List[dict]:
        """
        Get SMS and email message history for a client.

        Checks contactlog table for messages sent to this client.
        Used to detect MED READY status (medication ready notifications).
        """
        query = f"""
        SELECT
            cl.ContactLogID as id,
            cl.DateSent as sent_date,
            cl.Method,
            cl.MessageContent as message
        FROM contactlog cl
        WHERE cl.ClientID = {int(client_id)}
        AND cl.DateSent >= DATE_SUB(CURDATE(), INTERVAL {int(days)} DAY)
        AND cl.Method IN ('SMS', 'Email')
        ORDER BY cl.DateSent DESC
        """
        return self.execute_custom_query(query)

    def check_medication_ready_notification(self, client_id: int) -> bool:
        """
        Check if a medication ready SMS/email has been sent to this client recently.

        Looks for keywords like 'ready', 'collect', 'collection', 'prescription'
        in recent contact log messages.
        """
        contact_history = self.get_sms_history(client_id, days=60)

        ready_keywords = ['ready', 'collect', 'collection', 'prescription ready',
                          'medication ready', 'waiting for you', 'available',
                          'repeat', 'medication', 'prescription', 'payment',
                          'pay', 'owing', 'balance', 'outstanding']

        for contact in contact_history:
            message = (contact.get('message') or '').lower()
            contact_type = (contact.get('Contact_type') or '').lower()

            # Check if it's an SMS/email about medication being ready
            if any(keyword in message for keyword in ready_keywords):
                return True

        return False

    def get_unpaid_transactions(self, client_id: int) -> List[dict]:
        """
        Get unpaid transactions for a client from the last 6 months.

        Returns transactions where the item has not been invoiced yet.
        Items with Invoiced=0 are awaiting payment at collection.
        Ignores items older than 6 months as these may be legacy data.
        """
        query = f"""
        SELECT
            t.Transaction_ID,
            t.Invoice_date,
            t.Details,
            t.Net_value,
            t.VAT_amount,
            (t.Net_value + t.VAT_amount) as Total,
            t.Invoiced,
            t.Paid,
            t.Animal_ID
        FROM transactions t
        WHERE t.Client_ID = {int(client_id)}
        AND (t.Invoiced = 0 OR t.Invoiced IS NULL)
        AND (t.Net_value + t.VAT_amount) > 0
        AND t.Invoice_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
        ORDER BY t.Invoice_date DESC
        """
        return self.execute_custom_query(query)

    def get_outstanding_items(self, client_id: int) -> dict:
        """
        Get items that contribute to the current outstanding balance.

        Simple approach:
        1. Get current balance from clientbalance table
        2. Get unpaid transactions (Paid=0)
        3. Compare totals to verify accuracy
        4. Analyze transaction types

        Returns dict with:
            - items: list of transactions contributing to current balance
            - analysis: breakdown of item types
            - balance_match: whether unpaid items match current balance
        """
        result = {
            'items': [],
            'analysis': {
                'has_stock_items': False,
                'has_procedures': False,
                'has_insurance': False,
                'stock_items': [],
                'procedure_items': [],
                'insurance_items': []
            },
            'balance_match': False
        }

        # Get current balance from clientbalance table
        current_balance = self.get_client_balance(client_id) or 0

        # Get unpaid transactions (Paid=0)
        unpaid = self.get_unpaid_transactions(client_id)
        result['items'] = unpaid

        # Calculate total of unpaid items
        unpaid_total = sum(float(t.get('Total', t.get('Net_value', 0)) or 0) for t in unpaid)

        # Check if unpaid total roughly matches current balance (within £1 or 10%)
        if current_balance > 0:
            diff = abs(unpaid_total - current_balance)
            if diff < 1.0 or (diff / current_balance) < 0.1:
                result['balance_match'] = True

        # Analyze the transaction types
        result['analysis'] = self.analyze_transaction_types(unpaid)

        return result

    def analyze_transaction_types(self, transactions: List[dict]) -> dict:
        """
        Analyze a list of transactions to determine item types.

        Returns dict with:
            - has_stock_items: bool (medications, products)
            - has_procedures: bool (consultations, treatments)
            - has_insurance: bool (insurance-related items)
            - stock_items: list of stock item descriptions
            - procedure_items: list of procedure descriptions
            - insurance_items: list of insurance item descriptions
        """
        result = {
            'has_stock_items': False,
            'has_procedures': False,
            'has_insurance': False,
            'stock_items': [],
            'procedure_items': [],
            'insurance_items': []
        }

        # Keywords indicating stock/medication items
        stock_keywords = [
            'tablet', 'capsule', 'injection', 'cream', 'ointment', 'drops',
            'solution', 'suspension', 'wormer', 'flea', 'vaccine', 'prescription',
            'food', 'diet', 'biscuit', 'treats', 'shampoo', 'spray', 'collar',
            'mg', 'ml', 'g ', 'kg', 'pack', 'box', 'bottle', 'tube'
        ]

        # Keywords indicating procedures/services
        procedure_keywords = [
            'consult', 'examination', 'consultation', 'check', 'visit',
            'surgery', 'operation', 'anaesth', 'sedat', 'x-ray', 'xray',
            'ultrasound', 'scan', 'blood', 'test', 'sample', 'admission',
            'hospitalisation', 'hospitaliz', 'dental', 'neuter', 'spay', 'castrat'
        ]

        # Keywords indicating insurance items
        insurance_keywords = [
            'insurance', 'insur', 'claim', 'direct', 'pet plan', 'petplan',
            'agria', 'animal friends', 'bought by many', 'direct line'
        ]

        for txn in transactions:
            details = (txn.get('Details') or '').lower()
            amount = float(txn.get('Total', txn.get('Net_value', 0)) or 0)

            # Skip zero cost items - they don't affect the balance
            if amount <= 0:
                continue

            # Check for insurance
            if any(kw in details for kw in insurance_keywords):
                result['has_insurance'] = True
                result['insurance_items'].append(txn.get('Details', ''))
            # Check for stock items
            elif any(kw in details for kw in stock_keywords):
                result['has_stock_items'] = True
                result['stock_items'].append(txn.get('Details', ''))
            # Check for procedures
            elif any(kw in details for kw in procedure_keywords):
                result['has_procedures'] = True
                result['procedure_items'].append(txn.get('Details', ''))
            else:
                # Default to procedure if can't determine
                result['has_procedures'] = True
                result['procedure_items'].append(txn.get('Details', ''))

        return result

    def get_client_account_data(self, client_id: int) -> dict:
        """
        Get comprehensive account data for debt analysis.

        Returns dict with all data needed for categorization:
            - client: client details
            - current_balance: float
            - unpaid_transactions: list
            - transaction_analysis: dict with item type breakdown
            - sms_history: list of recent SMS messages
            - has_medication_ready_sms: bool
            - outstanding_invoices: list
        """
        data = {
            'client_id': client_id,
            'client': None,
            'department_code': None,
            'current_balance': 0.0,
            'unpaid_transactions': [],
            'transaction_analysis': {},
            'balance_match': False,
            'sms_history': [],
            'has_medication_ready_sms': False,
            'outstanding_invoices': [],
            'error': None
        }

        try:
            # Get client details
            data['client'] = self.get_client_by_id(client_id)

            # Get department code
            data['department_code'] = self.get_client_department(client_id)

            # Get current balance
            balance = self.get_client_balance(client_id)
            data['current_balance'] = balance if balance is not None else 0.0

            # Get outstanding items (unpaid transactions)
            outstanding = self.get_outstanding_items(client_id)
            data['unpaid_transactions'] = outstanding['items']
            data['balance_match'] = outstanding.get('balance_match', False)

            # Use the analysis from outstanding items
            data['transaction_analysis'] = outstanding['analysis']

            # Get SMS history
            data['sms_history'] = self.get_sms_history(client_id)

            # Check for medication ready notification
            data['has_medication_ready_sms'] = self.check_medication_ready_notification(client_id)

            # Get outstanding invoices
            data['outstanding_invoices'] = self.get_outstanding_invoices(client_id)

        except Exception as e:
            data['error'] = str(e)

        return data


class TeleosConnectionError(Exception):
    """Raised when connection to Teleos MCP fails."""
    pass


class TeleosParseError(Exception):
    """Raised when parsing Teleos response fails."""
    pass


# Convenience function for quick account lookup
def get_account_data(client_id: int) -> dict:
    """Get comprehensive account data for a client."""
    client = TeleosClient()
    return client.get_client_account_data(client_id)
