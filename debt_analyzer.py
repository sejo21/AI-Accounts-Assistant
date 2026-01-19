"""AI-powered debt categorization using Claude."""

import json
from pathlib import Path
from typing import Optional, List
from dataclasses import dataclass
from anthropic import Anthropic

from config import config
from csv_parser import DebtAccount
from teleos_client import TeleosClient, get_account_data
import database as db


@dataclass
class CategorizationResult:
    """Result of categorizing a single account."""
    client_id: int
    category: str  # MED, MED READY, PAY, PAID, INS, SMJ, BAD, INV, STAFF
    confidence: str  # HIGH, MEDIUM, LOW
    notes: str
    action_suggested: Optional[str] = None
    error: Optional[str] = None
    exclude_from_excel: bool = False
    department_code: Optional[str] = None

    @property
    def is_valid(self) -> bool:
        valid_categories = ['MED', 'MED READY', 'PAY', 'PAID', 'INS', 'SMJ', 'BAD', 'INV', 'STAFF']
        return self.error is None and self.category in valid_categories


class DebtAnalyzer:
    """Analyzes debt accounts and categorizes them using AI."""

    def __init__(self):
        self.client = Anthropic(api_key=config.ANTHROPIC_API_KEY)
        self.teleos = TeleosClient()
        self.model = config.CLAUDE_MODEL
        self.system_prompt = self._load_prompt()

    def _load_prompt(self) -> str:
        """Load the categorization prompt from file."""
        prompt_path = config.PROMPTS_FOLDER / 'debt_categorization.txt'
        if prompt_path.exists():
            return prompt_path.read_text()
        return "Categorize this debt account as MED, MED READY, PAY, INS, or SMJ."

    def _apply_aging_notes(self, result: CategorizationResult, account: DebtAccount) -> CategorizationResult:
        """Add aging-aware notes for MED/MED READY items that are overdue for collection."""
        if result.category in ['MED', 'MED READY']:
            aging = account.aging_category
            if aging in ['30 Days', '60 Days', '90+ Days']:
                aging_note = f"Not collected for {aging.lower()} - verify still required"
                result.notes = f"{result.notes}. {aging_note}" if result.notes else aging_note
                if not result.action_suggested:
                    result.action_suggested = "Check if medication still needed"
        return result

    def _build_context(self, account: DebtAccount, teleos_data: dict) -> str:
        """Build context string for AI analysis."""
        from datetime import date
        lines = []

        # Today's date for context
        lines.append(f"**Today's Date: {date.today().strftime('%d/%m/%Y')}**\n")

        # Basic account info
        lines.append("## Account Information")
        lines.append(f"Client ID: {account.client_id}")
        lines.append(f"Client Name: {account.client_name}")
        lines.append(f"Total Balance: £{account.total_balance:.2f}")
        lines.append(f"Aging: {account.aging_category}")

        if account.last_payment_date:
            lines.append(f"Last Payment: £{account.last_payment_amount:.2f} on {account.last_payment_date.strftime('%d/%m/%Y')}")

        lines.append(f"\nBalance Breakdown:")
        lines.append(f"  Current (0-30 days): £{account.current:.2f}")
        lines.append(f"  30 days: £{account.days_30:.2f}")
        lines.append(f"  60 days: £{account.days_60:.2f}")
        lines.append(f"  90+ days: £{account.days_90:.2f}")

        # Current balance from Teleos
        lines.append(f"\n## Current Status")
        current_balance = float(teleos_data.get('current_balance', 0) or 0)
        lines.append(f"Current Balance in Teleos: £{current_balance:.2f}")

        if current_balance == 0:
            lines.append("NOTE: Balance is now ZERO - this account may have been PAID since the CSV was generated.")

        # Outstanding items (unpaid transactions)
        transactions = teleos_data.get('unpaid_transactions', [])
        balance_match = teleos_data.get('balance_match', False)
        balance_explanation = teleos_data.get('balance_explanation', '')

        lines.append(f"\n## Outstanding Items (Unpaid Transactions)")
        lines.append("NOTE: Invoice numbers are NOT provided. Do not reference specific invoice numbers.")

        if balance_match:
            lines.append("Confidence: HIGH - Unpaid items match current balance")
            if balance_explanation:
                lines.append(f"Explanation: {balance_explanation}")
        else:
            lines.append("Confidence: LOW - Unpaid items may not fully explain current balance")

        if transactions:
            lines.append(f"\n{len(transactions)} unpaid item(s):")
            for txn in transactions[:10]:  # Limit to 10 for context
                details = txn.get('Details', 'No details')
                total = float(txn.get('Total', txn.get('Net_value', 0)) or 0)
                allocated = float(txn.get('Allocated', 0) or 0)
                remaining = float(txn.get('Remaining', total) or total)
                date = txn.get('Invoice_date', '')
                item_type = txn.get('Stock_or_Procedure', '?')

                # Show allocated/remaining if partial payment
                if allocated > 0:
                    lines.append(f"  - {details} | Total: £{total:.2f} | Paid: £{allocated:.2f} | Owing: £{remaining:.2f} | Date: {date} | Type: {item_type}")
                else:
                    lines.append(f"  - {details} | Owing: £{remaining:.2f} | Date: {date} | Type: {item_type}")
        else:
            lines.append("  No unpaid transactions found")

        # Transaction type analysis
        analysis = teleos_data.get('transaction_analysis', {})
        lines.append(f"\n## Transaction Type Analysis")
        lines.append(f"Has Invoiced But Unpaid Items: {analysis.get('has_invoiced_unpaid', False)}")
        lines.append(f"Has Stock Items (medications, not invoiced): {analysis.get('has_stock_items', False)}")
        lines.append(f"Has Procedures (services): {analysis.get('has_procedures', False)}")
        lines.append(f"Has Insurance Items: {analysis.get('has_insurance', False)}")

        if analysis.get('invoiced_unpaid_items'):
            lines.append(f"\nInvoiced But Unpaid (PAY): {', '.join(analysis['invoiced_unpaid_items'][:5])}")
        if analysis.get('stock_items'):
            lines.append(f"\nStock Items (MED): {', '.join(analysis['stock_items'][:5])}")
        if analysis.get('procedure_items'):
            lines.append(f"\nProcedure Items (PAY): {', '.join(analysis['procedure_items'][:5])}")
        if analysis.get('insurance_items'):
            lines.append(f"\nInsurance Items (INS): {', '.join(analysis['insurance_items'][:3])}")

        # SMS history
        sms_history = teleos_data.get('sms_history', [])
        has_ready_sms = teleos_data.get('has_medication_ready_sms', False)

        lines.append(f"\n## SMS Communication")
        lines.append(f"Medication Ready SMS Sent: {'Yes' if has_ready_sms else 'No'}")

        if sms_history:
            lines.append(f"\nRecent SMS Messages ({len(sms_history)} total):")
            for sms in sms_history[:3]:
                date = sms.get('sent_date', 'Unknown date')
                message = sms.get('message', '')[:100]  # Truncate long messages
                lines.append(f"  [{date}] {message}...")
        else:
            lines.append("No recent SMS messages found")

        return '\n'.join(lines)

    def categorize_account(self, account: DebtAccount) -> CategorizationResult:
        """
        Categorize a single debt account.

        Uses Teleos data + AI to determine the appropriate category.
        """
        # Check if this is a known staff account (persisted from previous runs)
        if db.is_staff_account(account.client_id):
            return CategorizationResult(
                client_id=account.client_id,
                category='STAFF',
                confidence='HIGH',
                notes='Staff account (previously marked)',
                action_suggested=None,
                exclude_from_excel=False  # Include STAFF in Excel for visibility
            )

        # First check if this is a known "skip" case
        # Check for zero balance first (PAID)
        teleos_data = get_account_data(account.client_id)

        # Check for connection errors
        if teleos_data.get('error'):
            # Try to categorize without Teleos data
            return self._categorize_without_teleos(account, teleos_data.get('error'))

        # Get department code
        dept_code = teleos_data.get('department_code')

        # Check department code first - some departments skip AI analysis
        if dept_code in ['BAD', 'INV']:
            notes = {
                'BAD': 'Bad debtor account - flagged in Teleos. Manual review required.',
                'INV': 'Invoice account - pays monthly by invoice.'
            }.get(dept_code, f'Department: {dept_code}')

            return CategorizationResult(
                client_id=account.client_id,
                category=dept_code,
                confidence='HIGH',
                notes=notes,
                action_suggested=None,
                exclude_from_excel=True,
                department_code=dept_code
            )

        # Insurance department - categorize as INS
        if dept_code == 'INS':
            return CategorizationResult(
                client_id=account.client_id,
                category='INS',
                confidence='HIGH',
                notes='Insurance account (per department).',
                action_suggested=None,
                department_code=dept_code
            )

        # Check if now paid
        current_balance = float(teleos_data.get('current_balance', 0) or 0)
        if current_balance == 0 or current_balance < config.MIN_BALANCE_THRESHOLD:
            return CategorizationResult(
                client_id=account.client_id,
                category='PAID',
                confidence='HIGH',
                notes=f'Balance is now £{current_balance:.2f} in Teleos - account has been paid.',
                action_suggested=None,
                exclude_from_excel=True,  # No action needed - already paid
                department_code=dept_code
            )

        # Build context for AI
        context = self._build_context(account, teleos_data)

        # Try rule-based categorization first
        rule_result = self._apply_rules(account, teleos_data, dept_code)
        if rule_result and rule_result.confidence == 'HIGH':
            # If PAY department, override category but keep notes
            if dept_code == 'PAY' and rule_result.category != 'PAY':
                rule_result.category = 'PAY'
                rule_result.notes = f'PAY account. {rule_result.notes}'
            return self._apply_aging_notes(rule_result, account)

        # Use AI for complex cases
        try:
            result = self._ai_categorize(account, context)
            result.department_code = dept_code
            # If PAY department, override category but keep notes
            if dept_code == 'PAY' and result.category != 'PAY':
                result.category = 'PAY'
                result.notes = f'PAY account. {result.notes}'
            return self._apply_aging_notes(result, account)
        except Exception as e:
            # Fall back to rule-based if AI fails
            if rule_result:
                if dept_code == 'PAY':
                    rule_result.category = 'PAY'
                    rule_result.notes = f'PAY account. {rule_result.notes}'
                return self._apply_aging_notes(rule_result, account)
            return CategorizationResult(
                client_id=account.client_id,
                category='PAY' if dept_code == 'PAY' else 'SMJ',
                confidence='LOW' if dept_code != 'PAY' else 'HIGH',
                notes=f'PAY account. AI categorization failed: {str(e)}' if dept_code == 'PAY' else f'AI categorization failed: {str(e)}',
                error=str(e),
                department_code=dept_code
            )

    def _apply_rules(self, account: DebtAccount, teleos_data: dict, dept_code: str = None) -> Optional[CategorizationResult]:
        """Apply rule-based categorization for clear-cut cases."""
        analysis = teleos_data.get('transaction_analysis', {})
        has_ready_sms = teleos_data.get('has_medication_ready_sms', False)
        unpaid_transactions = teleos_data.get('unpaid_transactions', [])
        balance_match = teleos_data.get('balance_match', False)
        current_balance = float(teleos_data.get('current_balance', 0) or 0)

        # No unpaid transactions found but there's a balance - needs manual review
        if not unpaid_transactions and current_balance > 1.0:
            return CategorizationResult(
                client_id=account.client_id,
                category='SMJ',
                confidence='LOW',
                notes=f'Balance of £{current_balance:.2f} but no unpaid transactions found in system. May be manually entered.',
                action_suggested='Manual review required',
                department_code=dept_code
            )

        # INVOICED BUT UNPAID items = PAY (they owe money for something already billed)
        # This takes priority - even if it's a stock item, if it's been invoiced they need to pay
        if analysis.get('has_invoiced_unpaid'):
            invoiced_items = analysis.get('invoiced_unpaid_items', [])
            item_desc = invoiced_items[0] if invoiced_items else 'items'
            return CategorizationResult(
                client_id=account.client_id,
                category='PAY',
                confidence='HIGH',
                notes=f'Invoiced but unpaid: {item_desc}',
                action_suggested='Send payment reminder',
                department_code=dept_code
            )

        # Pure insurance case
        if analysis.get('has_insurance') and not analysis.get('has_procedures') and not analysis.get('has_stock_items'):
            return CategorizationResult(
                client_id=account.client_id,
                category='INS',
                confidence='HIGH',
                notes='Balance relates to insurance items only.',
                action_suggested='Follow up on insurance claim status',
                department_code=dept_code
            )

        # Pure medication case (stock items NOT invoiced - awaiting collection)
        if analysis.get('has_stock_items') and not analysis.get('has_procedures') and not analysis.get('has_insurance'):
            if has_ready_sms:
                return CategorizationResult(
                    client_id=account.client_id,
                    category='MED READY',
                    confidence='HIGH',
                    notes='Stock items only, medication ready SMS has been sent.',
                    action_suggested=None,
                    department_code=dept_code
                )
            else:
                return CategorizationResult(
                    client_id=account.client_id,
                    category='MED',
                    confidence='HIGH',
                    notes='Stock items only, awaiting collection.',
                    action_suggested='Send collection notification',
                    department_code=dept_code
                )

        # Pure procedure case
        if analysis.get('has_procedures') and not analysis.get('has_stock_items') and not analysis.get('has_insurance'):
            return CategorizationResult(
                client_id=account.client_id,
                category='PAY',
                confidence='HIGH',
                notes='Procedure items require payment.',
                action_suggested='Send payment reminder',
                department_code=dept_code
            )

        # Mixed or unclear - return None to trigger AI analysis
        return None

    def _categorize_without_teleos(self, account: DebtAccount, error: str) -> CategorizationResult:
        """Categorize when Teleos data is unavailable."""
        return CategorizationResult(
            client_id=account.client_id,
            category='SMJ',
            confidence='LOW',
            notes=f'Could not retrieve Teleos data: {error}',
            action_suggested='Manual review required - Teleos lookup failed',
            error=error
        )

    def _ai_categorize(self, account: DebtAccount, context: str) -> CategorizationResult:
        """Use Claude to categorize the account."""
        message = f"""Please categorize this debt account based on the following information:

{context}

Respond with a JSON object only, no other text."""

        response = self.client.messages.create(
            model=self.model,
            max_tokens=300,  # Reduced - we want brief notes
            temperature=0.1,  # Low for factual, deterministic output
            top_p=0.9,  # Focus on most likely tokens
            system=self.system_prompt,
            messages=[{"role": "user", "content": message}]
        )

        # Parse response
        response_text = response.content[0].text.strip()

        # Extract JSON from response (handle markdown code blocks)
        if '```json' in response_text:
            response_text = response_text.split('```json')[1].split('```')[0].strip()
        elif '```' in response_text:
            response_text = response_text.split('```')[1].split('```')[0].strip()

        try:
            result = json.loads(response_text)
        except json.JSONDecodeError:
            # Try to find JSON object in response
            import re
            json_match = re.search(r'\{[^}]+\}', response_text, re.DOTALL)
            if json_match:
                result = json.loads(json_match.group())
            else:
                raise ValueError(f"Could not parse JSON from response: {response_text}")

        return CategorizationResult(
            client_id=account.client_id,
            category=result.get('category', 'SMJ'),
            confidence=result.get('confidence', 'LOW'),
            notes=result.get('notes', ''),
            action_suggested=result.get('action_suggested')
        )

    def analyze_batch(
        self,
        accounts: List[DebtAccount],
        progress_callback=None
    ) -> List[CategorizationResult]:
        """
        Analyze a batch of accounts.

        Args:
            accounts: List of DebtAccount objects to analyze
            progress_callback: Optional callback(current, total, account) for progress updates

        Returns:
            List of CategorizationResult objects
        """
        results = []
        total = len(accounts)

        for i, account in enumerate(accounts):
            if progress_callback:
                progress_callback(i + 1, total, account)

            result = self.categorize_account(account)
            results.append(result)

        return results


# Convenience function
def analyze_account(account: DebtAccount) -> CategorizationResult:
    """Analyze a single debt account."""
    analyzer = DebtAnalyzer()
    return analyzer.categorize_account(account)


# For testing
if __name__ == '__main__':
    from csv_parser import load_debt_csv

    # Load sample accounts
    test_path = Path(__file__).parent / 'mdebtor.csv'
    accounts = load_debt_csv(test_path)

    print(f"Testing with {len(accounts)} accounts\n")

    # Test first 3 accounts
    analyzer = DebtAnalyzer()

    for account in accounts[:3]:
        print(f"\n{'='*60}")
        print(f"Analyzing: {account.client_name} (ID: {account.client_id})")
        print(f"Balance: £{account.total_balance:.2f}")

        result = analyzer.categorize_account(account)

        print(f"\nResult:")
        print(f"  Category: {result.category}")
        print(f"  Confidence: {result.confidence}")
        print(f"  Notes: {result.notes}")
        if result.action_suggested:
            print(f"  Action: {result.action_suggested}")
        if result.error:
            print(f"  Error: {result.error}")
