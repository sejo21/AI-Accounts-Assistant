"""CSV parser for Teleos debt report (mdebtor.CSV)."""

import csv
import re
from pathlib import Path
from typing import List, Optional
from dataclasses import dataclass
from datetime import datetime
from config import config


@dataclass
class DebtAccount:
    """Represents a single account from the debt CSV."""
    client_id: int
    client_name: str
    last_payment_amount: float
    last_payment_date: Optional[datetime]
    current: float  # 0-30 days
    days_30: float  # 30 days overdue
    days_60: float  # 60 days overdue
    days_90: float  # 90+ days overdue
    total_balance: float
    raw_row: List[str]  # Original CSV row data

    @property
    def aging_category(self) -> str:
        """Return the primary aging category for this debt."""
        if self.days_90 > 0:
            return '90+ days'
        elif self.days_60 > 0:
            return '60 days'
        elif self.days_30 > 0:
            return '30 days'
        else:
            return 'Current'

    @property
    def is_old_debt(self) -> bool:
        """Return True if debt is 60+ days old."""
        return self.days_60 > 0 or self.days_90 > 0


def parse_last_payment(value: str) -> tuple:
    """
    Parse the last payment field.

    Format: "760.24 on 04.11.2025" or "-50.00 on 23.11.2024"

    Returns:
        Tuple of (amount: float, date: datetime or None)
    """
    if not value or not value.strip():
        return (0.0, None)

    # Pattern: amount on DD.MM.YYYY
    pattern = r'^(-?[\d.]+)\s+on\s+(\d{2})\.(\d{2})\.(\d{4})$'
    match = re.match(pattern, value.strip())

    if match:
        try:
            amount = float(match.group(1))
            day = int(match.group(2))
            month = int(match.group(3))
            year = int(match.group(4))
            date = datetime(year, month, day)
            return (amount, date)
        except (ValueError, TypeError):
            pass

    # Try to extract just the amount if date parsing fails
    try:
        amount_match = re.match(r'^(-?[\d.]+)', value.strip())
        if amount_match:
            return (float(amount_match.group(1)), None)
    except (ValueError, TypeError):
        pass

    return (0.0, None)


def parse_amount(value: str) -> float:
    """Parse an amount field, handling empty values."""
    if not value or not value.strip():
        return 0.0
    try:
        return float(value.strip())
    except (ValueError, TypeError):
        return 0.0


def parse_csv_row(row: List[str]) -> Optional[DebtAccount]:
    """
    Parse a single CSV row into a DebtAccount.

    CSV columns (no header):
        0: Account Number (Client ID)
        1: Client Name
        2: Last Payment (amount on date)
        3: Current (0-30 days)
        4: 30 days
        5: 60 days
        6: 90+ days
        7: Total balance

    Returns:
        DebtAccount object or None if row is invalid
    """
    # Skip empty rows
    if not row or len(row) < 8:
        return None

    # Skip if no client ID
    if not row[0] or not row[0].strip():
        return None

    try:
        client_id = int(row[0].strip())
    except (ValueError, TypeError):
        return None

    client_name = row[1].strip() if len(row) > 1 else ''

    # Parse last payment
    last_payment_str = row[2].strip() if len(row) > 2 else ''
    last_amount, last_date = parse_last_payment(last_payment_str)

    # Parse aging amounts
    current = parse_amount(row[3]) if len(row) > 3 else 0.0
    days_30 = parse_amount(row[4]) if len(row) > 4 else 0.0
    days_60 = parse_amount(row[5]) if len(row) > 5 else 0.0
    days_90 = parse_amount(row[6]) if len(row) > 6 else 0.0
    total = parse_amount(row[7]) if len(row) > 7 else 0.0

    return DebtAccount(
        client_id=client_id,
        client_name=client_name,
        last_payment_amount=last_amount,
        last_payment_date=last_date,
        current=current,
        days_30=days_30,
        days_60=days_60,
        days_90=days_90,
        total_balance=total,
        raw_row=row
    )


def load_debt_csv(csv_path: Path = None) -> List[DebtAccount]:
    """
    Load and parse the debt CSV file.

    Args:
        csv_path: Path to CSV file. Defaults to config.CSV_PATH

    Returns:
        List of DebtAccount objects, filtered to exclude balances < £1.00
    """
    if csv_path is None:
        csv_path = config.CSV_PATH

    accounts = []

    if not csv_path.exists():
        raise FileNotFoundError(f"CSV file not found: {csv_path}")

    with open(csv_path, 'r', encoding='utf-8', errors='replace') as f:
        reader = csv.reader(f)

        for row in reader:
            account = parse_csv_row(row)
            if account is not None:
                # Filter out trivial balances (< £1.00)
                if account.total_balance >= config.MIN_BALANCE_THRESHOLD:
                    accounts.append(account)

    return accounts


def get_summary(accounts: List[DebtAccount]) -> dict:
    """
    Get summary statistics for a list of accounts.

    Returns:
        Dict with total count, total value, and breakdown by aging category
    """
    summary = {
        'total_accounts': len(accounts),
        'total_value': sum(a.total_balance for a in accounts),
        'by_aging': {
            'Current': {'count': 0, 'value': 0.0},
            '30 days': {'count': 0, 'value': 0.0},
            '60 days': {'count': 0, 'value': 0.0},
            '90+ days': {'count': 0, 'value': 0.0}
        }
    }

    for account in accounts:
        category = account.aging_category
        summary['by_aging'][category]['count'] += 1
        summary['by_aging'][category]['value'] += account.total_balance

    return summary


# For testing
if __name__ == '__main__':
    # Try loading from project directory first (for testing with sample file)
    test_path = Path(__file__).parent / 'mdebtor.csv'
    if test_path.exists():
        accounts = load_debt_csv(test_path)
    else:
        accounts = load_debt_csv()

    print(f"Loaded {len(accounts)} accounts")

    summary = get_summary(accounts)
    print(f"\nTotal value: £{summary['total_value']:.2f}")
    print("\nBy aging category:")
    for cat, data in summary['by_aging'].items():
        print(f"  {cat}: {data['count']} accounts, £{data['value']:.2f}")

    print("\nFirst 5 accounts:")
    for acc in accounts[:5]:
        print(f"  {acc.client_id}: {acc.client_name} - £{acc.total_balance:.2f} ({acc.aging_category})")
