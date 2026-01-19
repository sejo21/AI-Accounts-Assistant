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

    def get_payment_allocations(self, client_id: int) -> Dict[int, float]:
        """
        Get payment allocations for a client's transactions.

        Returns dict mapping TransactionID -> total amount allocated (paid).
        Also accounts for reversed allocations.
        """
        # Get allocations
        alloc_query = f"""
        SELECT TransactionID, SUM(Amount) as AllocatedAmount
        FROM paymentallocations
        WHERE ClientID = {int(client_id)}
        AND TransactionID IS NOT NULL
        GROUP BY TransactionID
        """
        allocations = self.execute_custom_query(alloc_query)

        # Get reversed allocations (to subtract)
        reversed_query = f"""
        SELECT TransactionID, SUM(Amount) as ReversedAmount
        FROM `paymentallocations:reversed`
        WHERE ClientID = {int(client_id)}
        AND TransactionID IS NOT NULL
        GROUP BY TransactionID
        """
        reversed_allocs = self.execute_custom_query(reversed_query)

        # Build allocation map
        alloc_map = {}
        for row in allocations:
            txn_id = row.get('TransactionID')
            if txn_id:
                alloc_map[txn_id] = float(row.get('AllocatedAmount', 0) or 0)

        # Subtract reversed allocations
        for row in reversed_allocs:
            txn_id = row.get('TransactionID')
            if txn_id and txn_id in alloc_map:
                alloc_map[txn_id] -= float(row.get('ReversedAmount', 0) or 0)

        return alloc_map

    def get_unpaid_transactions(self, client_id: int) -> List[dict]:
        """
        Get unpaid transactions for a client from the last 6 months.

        Uses payment allocations table for accurate paid/unpaid status.
        Falls back to Invoiced/Paid flags if no allocation data.

        Returns transactions that contribute to the outstanding balance.
        Includes Stock_or_Procedure column for reliable item type detection.
        """
        # Get all recent transactions with positive value
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
            t.Animal_ID,
            t.Stock_or_Procedure
        FROM transactions t
        WHERE t.Client_ID = {int(client_id)}
        AND (t.Net_value + t.VAT_amount) > 0
        AND t.Invoice_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
        ORDER BY t.Invoice_date DESC
        """
        transactions = self.execute_custom_query(query)

        # Get payment allocations for this client
        allocations = self.get_payment_allocations(client_id)

        # Filter to unpaid/partially paid transactions
        unpaid = []
        for txn in transactions:
            txn_id = txn.get('Transaction_ID')
            total = float(txn.get('Total', txn.get('Net_value', 0)) or 0)
            allocated = allocations.get(txn_id, 0)

            # Calculate remaining unpaid amount
            remaining = total - allocated

            if remaining > 0.01:  # More than 1p unpaid
                # Add remaining amount info
                txn['Allocated'] = allocated
                txn['Remaining'] = remaining
                txn['FullyPaid'] = False
                unpaid.append(txn)

        return unpaid

    def get_outstanding_items(self, client_id: int) -> dict:
        """
        Get items that contribute to the current outstanding balance.

        Smart approach:
        1. Get current balance from clientbalance table
        2. Get unpaid transactions (Invoiced=0)
        3. If unpaid total matches current balance, analyze all items
        4. If mismatch, try to identify which subset of items makes up the balance
           - Check if stock items alone match the balance (common case: procedures paid, meds pending)
           - Check if most recent items match the balance
        5. Analyze only the items that contribute to the actual balance

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
            'balance_match': False,
            'balance_explanation': None
        }

        # Get current balance from clientbalance table
        current_balance = self.get_client_balance(client_id) or 0

        # Get unpaid transactions (Invoiced=0)
        unpaid = self.get_unpaid_transactions(client_id)

        # Calculate total of unpaid items
        unpaid_total = sum(float(t.get('Total', t.get('Net_value', 0)) or 0) for t in unpaid)

        # Check if unpaid total roughly matches current balance (within £1 or 10%)
        if current_balance > 0 and unpaid_total > 0:
            diff = abs(unpaid_total - current_balance)
            if diff < 1.0 or (diff / current_balance) < 0.1:
                # Good match - analyze all unpaid items
                result['items'] = unpaid
                result['balance_match'] = True
                result['analysis'] = self.analyze_transaction_types(unpaid)
                return result

        # Balance mismatch - try to identify which items make up the current balance
        # This happens when payments were made but individual items weren't marked as paid

        if current_balance > 0 and unpaid:
            # Strategy 1: Find items that were likely paid by matching the difference
            # E.g., if unpaid total is £109.80 and current balance is £97.70,
            # the difference (£12.10) was likely paid - find items matching that amount
            paid_amount = unpaid_total - current_balance
            if paid_amount > 0:
                paid_items, remaining_items = self._find_items_matching_amount(unpaid, paid_amount)
                if paid_items and remaining_items:
                    remaining_total = sum(float(t.get('Total', t.get('Net_value', 0)) or 0) for t in remaining_items)
                    if abs(remaining_total - current_balance) < 1.0:
                        # Found items that explain the payment - analyze remaining items
                        paid_desc = ', '.join(t.get('Details', '')[:30] for t in paid_items[:2])
                        result['items'] = remaining_items
                        result['balance_match'] = True
                        result['balance_explanation'] = f'Items likely paid: {paid_desc}'
                        result['analysis'] = self.analyze_transaction_types(remaining_items)
                        return result

            # Strategy 2: Check if stock items alone match the current balance
            # Common case: client paid for procedures but meds are awaiting collection
            stock_items, procedure_items, other_items = self._categorize_items(unpaid)

            stock_total = sum(float(t.get('Total', t.get('Net_value', 0)) or 0) for t in stock_items)
            stock_diff = abs(stock_total - current_balance)

            if stock_total > 0 and (stock_diff < 1.0 or (current_balance > 0 and stock_diff / current_balance < 0.15)):
                # Stock items match the balance - likely procedures were paid
                result['items'] = stock_items
                result['balance_match'] = True
                result['balance_explanation'] = 'Stock items match current balance (procedures likely paid)'
                result['analysis'] = self.analyze_transaction_types(stock_items)
                return result

            # Strategy 3: Check most recent items (sorted by date desc)
            # Items are already sorted by date desc from query
            running_total = 0
            matching_items = []
            for txn in unpaid:
                amount = float(txn.get('Total', txn.get('Net_value', 0)) or 0)
                if running_total + amount <= current_balance + 1.0:  # Allow £1 tolerance
                    matching_items.append(txn)
                    running_total += amount
                    if abs(running_total - current_balance) < 1.0:
                        break

            if matching_items and abs(running_total - current_balance) < 1.0:
                result['items'] = matching_items
                result['balance_match'] = True
                result['balance_explanation'] = 'Most recent items match current balance'
                result['analysis'] = self.analyze_transaction_types(matching_items)
                return result

        # Could not determine which items make up the balance - return all for review
        result['items'] = unpaid
        result['balance_match'] = False
        result['analysis'] = self.analyze_transaction_types(unpaid)
        return result

    def _categorize_items(self, transactions: List[dict]) -> tuple:
        """
        Categorize transactions into stock, procedure, and other items.

        Returns tuple of (stock_items, procedure_items, other_items)
        """
        import re

        stock_items = []
        procedure_items = []
        other_items = []

        # Patterns to skip (non-balance-affecting)
        skip_patterns = [
            re.compile(r'^Invoice\s+\d+\s+(created|printed)', re.IGNORECASE),
            re.compile(r'^Statement\s+\d+\s+(created|printed)', re.IGNORECASE),
            re.compile(r'^Receipt\s+\d+\s+created', re.IGNORECASE),
            re.compile(r'^Auth\s*Code:', re.IGNORECASE),
            re.compile(r'^Card\s*Num:', re.IGNORECASE),
        ]
        estimate_pattern = re.compile(r'\(\d+\.\d{2}\)$')

        stock_keywords = [
            'tablet', 'capsule', 'injection', 'cream', 'ointment', 'drops',
            'solution', 'suspension', 'wormer', 'flea', 'vaccine', 'prescription',
            'food', 'diet', 'biscuit', 'treats', 'shampoo', 'spray', 'collar',
            'mg', 'ml', 'g ', 'kg', 'pack', 'box', 'bottle', 'tube'
        ]

        for txn in transactions:
            details = txn.get('Details') or ''
            details_lower = details.lower()
            amount = float(txn.get('Total', txn.get('Net_value', 0)) or 0)

            # Skip zero/negative amounts
            if amount <= 0:
                continue

            # Skip estimate and non-balance items
            if estimate_pattern.search(details) or any(p.match(details) for p in skip_patterns):
                continue

            # Use Stock_or_Procedure column if available
            item_type = txn.get('Stock_or_Procedure', '').upper()

            if item_type == 'S':
                stock_items.append(txn)
            elif item_type == 'P':
                procedure_items.append(txn)
            elif item_type == 'N':
                continue  # Skip notes
            elif any(kw in details_lower for kw in stock_keywords):
                stock_items.append(txn)
            else:
                procedure_items.append(txn)

        return stock_items, procedure_items, other_items

    def _find_items_matching_amount(self, transactions: List[dict], target_amount: float, tolerance: float = 1.0) -> tuple:
        """
        Find a subset of transactions that sum to the target amount.

        Used to identify which items were likely paid when there's a balance mismatch.
        E.g., if unpaid total is £109.80 and current balance is £97.70,
        find items totaling £12.10 (the difference) - these were likely paid.

        Returns tuple of (matching_items, remaining_items)
        """
        # First, try to find a single item that matches exactly
        for i, txn in enumerate(transactions):
            amount = float(txn.get('Total', txn.get('Net_value', 0)) or 0)
            if abs(amount - target_amount) < tolerance:
                matching = [txn]
                remaining = transactions[:i] + transactions[i+1:]
                return matching, remaining

        # Try to find two items that match
        for i, txn1 in enumerate(transactions):
            amt1 = float(txn1.get('Total', txn1.get('Net_value', 0)) or 0)
            for j, txn2 in enumerate(transactions[i+1:], i+1):
                amt2 = float(txn2.get('Total', txn2.get('Net_value', 0)) or 0)
                if abs(amt1 + amt2 - target_amount) < tolerance:
                    matching = [txn1, txn2]
                    remaining = [t for k, t in enumerate(transactions) if k != i and k != j]
                    return matching, remaining

        # Could not find matching items
        return [], transactions

    def analyze_transaction_types(self, transactions: List[dict]) -> dict:
        """
        Analyze a list of transactions to determine item types and payment status.

        Uses Stock_or_Procedure column when available (S=Stock, P=Procedure, N=Note).
        Falls back to keyword matching if column not present.

        Filters out:
        - Estimate items (prices in parentheses like "(75.00)" at end)
        - Non-balance-affecting entries (Invoice/Statement/Receipt created, Auth Code, etc.)

        Key distinction:
        - Stock item, NOT invoiced → MED (awaiting collection)
        - Stock item, INVOICED but not paid → PAY (they owe money for it)
        - Procedure items → PAY

        Returns dict with:
            - has_stock_items: bool (medications, products - NOT invoiced)
            - has_invoiced_unpaid: bool (items invoiced but not paid - always PAY)
            - has_procedures: bool (consultations, treatments)
            - has_insurance: bool (insurance-related items)
            - stock_items: list of stock item descriptions (not invoiced)
            - invoiced_unpaid_items: list of invoiced but unpaid items
            - procedure_items: list of procedure descriptions
            - insurance_items: list of insurance item descriptions
        """
        import re

        result = {
            'has_stock_items': False,
            'has_invoiced_unpaid': False,
            'has_procedures': False,
            'has_insurance': False,
            'stock_items': [],
            'invoiced_unpaid_items': [],
            'procedure_items': [],
            'insurance_items': []
        }

        # Regex pattern for estimate items: prices in parentheses at end like "(75.00)"
        estimate_pattern = re.compile(r'\(\d+\.\d{2}\)$')

        # Patterns for non-balance-affecting entries (reference entries only)
        skip_patterns = [
            re.compile(r'^Invoice\s+\d+\s+(created|printed)', re.IGNORECASE),
            re.compile(r'^Statement\s+\d+\s+(created|printed)', re.IGNORECASE),
            re.compile(r'^Receipt\s+\d+\s+created', re.IGNORECASE),
            re.compile(r'^Auth\s*Code:', re.IGNORECASE),
            re.compile(r'^Card\s*Num:', re.IGNORECASE),
        ]

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
            details = txn.get('Details') or ''
            details_lower = details.lower()
            amount = float(txn.get('Total', txn.get('Net_value', 0)) or 0)

            # Skip zero cost items - they don't affect the balance
            if amount <= 0:
                continue

            # Skip estimate items (prices in parentheses at end - these are quotes, not charges)
            if estimate_pattern.search(details):
                continue

            # Skip non-balance-affecting entries
            if any(pattern.match(details) for pattern in skip_patterns):
                continue

            # Check if this item is INVOICED but NOT PAID - always PAY category
            is_invoiced = txn.get('Invoiced') == 1 or txn.get('Invoiced') == '1'
            is_paid = txn.get('Paid') == 1 or txn.get('Paid') == '1'

            if is_invoiced and not is_paid:
                # Invoiced but unpaid = they owe money for this = PAY
                result['has_invoiced_unpaid'] = True
                result['invoiced_unpaid_items'].append(details)
                continue

            # For non-invoiced items, determine type (stock vs procedure)
            item_type = txn.get('Stock_or_Procedure', '').upper()

            # Check for insurance first (keyword-based, as no column for this)
            if any(kw in details_lower for kw in insurance_keywords):
                result['has_insurance'] = True
                result['insurance_items'].append(details)
            # Use Stock_or_Procedure column when available
            elif item_type == 'S':
                result['has_stock_items'] = True
                result['stock_items'].append(details)
            elif item_type == 'P':
                result['has_procedures'] = True
                result['procedure_items'].append(details)
            elif item_type == 'N':
                # Notes don't affect categorization - skip
                continue
            # Fall back to keyword matching
            elif any(kw in details_lower for kw in stock_keywords):
                result['has_stock_items'] = True
                result['stock_items'].append(details)
            elif any(kw in details_lower for kw in procedure_keywords):
                result['has_procedures'] = True
                result['procedure_items'].append(details)
            else:
                # Default to procedure if can't determine
                result['has_procedures'] = True
                result['procedure_items'].append(details)

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
