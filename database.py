"""SQLite database operations for AI Accounts Assistant."""

import sqlite3
from datetime import datetime
from pathlib import Path
from typing import List, Optional, Dict, Any
from contextlib import contextmanager

from config import config


def get_db_path() -> Path:
    """Get the database file path."""
    return config.DATABASE_PATH


@contextmanager
def get_connection():
    """Context manager for database connections."""
    conn = sqlite3.connect(get_db_path())
    conn.row_factory = sqlite3.Row
    try:
        yield conn
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


def init_database():
    """Initialize the database schema."""
    with get_connection() as conn:
        cursor = conn.cursor()

        # Debt runs table - each time we analyze the CSV
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS debt_runs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                csv_filename TEXT,
                total_accounts INTEGER DEFAULT 0,
                total_value REAL DEFAULT 0,
                status TEXT DEFAULT 'pending',
                excel_path TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                completed_at TIMESTAMP
            )
        ''')

        # Debt accounts table - individual accounts per run
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS debt_accounts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                run_id INTEGER NOT NULL,
                client_id INTEGER NOT NULL,
                client_name TEXT,
                department_code TEXT,
                last_payment_amount REAL,
                last_payment_date TEXT,
                current_balance REAL DEFAULT 0,
                days_30 REAL DEFAULT 0,
                days_60 REAL DEFAULT 0,
                days_90 REAL DEFAULT 0,
                total_balance REAL DEFAULT 0,
                category TEXT,
                confidence TEXT,
                notes TEXT,
                action_suggested TEXT,
                exclude_from_excel INTEGER DEFAULT 0,
                sms_sent INTEGER DEFAULT 0,
                email_sent INTEGER DEFAULT 0,
                manually_updated INTEGER DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP,
                FOREIGN KEY (run_id) REFERENCES debt_runs(id)
            )
        ''')

        # Migration: Add new columns to existing tables
        try:
            cursor.execute('ALTER TABLE debt_accounts ADD COLUMN department_code TEXT')
        except sqlite3.OperationalError:
            pass  # Column already exists

        try:
            cursor.execute('ALTER TABLE debt_accounts ADD COLUMN exclude_from_excel INTEGER DEFAULT 0')
        except sqlite3.OperationalError:
            pass  # Column already exists

        # Staff accounts table - persists across runs
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS staff_accounts (
                client_id INTEGER PRIMARY KEY,
                client_name TEXT,
                marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')

        # Create indexes
        cursor.execute('''
            CREATE INDEX IF NOT EXISTS idx_accounts_run_id
            ON debt_accounts(run_id)
        ''')

        cursor.execute('''
            CREATE INDEX IF NOT EXISTS idx_accounts_category
            ON debt_accounts(category)
        ''')

        cursor.execute('''
            CREATE INDEX IF NOT EXISTS idx_accounts_client_id
            ON debt_accounts(client_id)
        ''')


# Debt Runs Operations

def create_run(csv_filename: str) -> int:
    """Create a new debt analysis run."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO debt_runs (csv_filename, status)
            VALUES (?, 'pending')
        ''', (csv_filename,))
        return cursor.lastrowid


def update_run_status(run_id: int, status: str, excel_path: str = None):
    """Update the status of a run."""
    with get_connection() as conn:
        cursor = conn.cursor()
        if status == 'completed':
            cursor.execute('''
                UPDATE debt_runs
                SET status = ?, excel_path = ?, completed_at = ?
                WHERE id = ?
            ''', (status, excel_path, datetime.now(), run_id))
        else:
            cursor.execute('''
                UPDATE debt_runs
                SET status = ?
                WHERE id = ?
            ''', (status, run_id))


def update_run_totals(run_id: int, total_accounts: int, total_value: float):
    """Update the totals for a run."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE debt_runs
            SET total_accounts = ?, total_value = ?
            WHERE id = ?
        ''', (total_accounts, total_value, run_id))


def get_run(run_id: int) -> Optional[Dict]:
    """Get a single run by ID."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM debt_runs WHERE id = ?', (run_id,))
        row = cursor.fetchone()
        return dict(row) if row else None


def get_recent_runs(limit: int = 20) -> List[Dict]:
    """Get recent runs."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            SELECT * FROM debt_runs
            ORDER BY created_at DESC
            LIMIT ?
        ''', (limit,))
        return [dict(row) for row in cursor.fetchall()]


def delete_run(run_id: int):
    """Delete a run and its accounts."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('DELETE FROM debt_accounts WHERE run_id = ?', (run_id,))
        cursor.execute('DELETE FROM debt_runs WHERE id = ?', (run_id,))


# Debt Accounts Operations

def add_account(
    run_id: int,
    client_id: int,
    client_name: str,
    last_payment_amount: float,
    last_payment_date: str,
    current_balance: float,
    days_30: float,
    days_60: float,
    days_90: float,
    total_balance: float,
    department_code: str = None
) -> int:
    """Add an account to a run."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO debt_accounts (
                run_id, client_id, client_name, department_code,
                last_payment_amount, last_payment_date,
                current_balance, days_30, days_60, days_90, total_balance
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            run_id, client_id, client_name, department_code,
            last_payment_amount, last_payment_date,
            current_balance, days_30, days_60, days_90, total_balance
        ))
        return cursor.lastrowid


def update_account_category(
    account_id: int,
    category: str,
    confidence: str,
    notes: str,
    action_suggested: str = None,
    exclude_from_excel: bool = False
):
    """Update the categorization for an account."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE debt_accounts
            SET category = ?, confidence = ?, notes = ?,
                action_suggested = ?, exclude_from_excel = ?, updated_at = ?
            WHERE id = ?
        ''', (category, confidence, notes, action_suggested,
              1 if exclude_from_excel else 0, datetime.now(), account_id))


def update_account_manual(
    account_id: int,
    category: str,
    notes: str
):
    """Manually update an account's category."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE debt_accounts
            SET category = ?, notes = ?,
                manually_updated = 1, updated_at = ?
            WHERE id = ?
        ''', (category, notes, datetime.now(), account_id))


def mark_sms_sent(account_id: int):
    """Mark that an SMS has been sent for this account."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE debt_accounts
            SET sms_sent = 1, updated_at = ?
            WHERE id = ?
        ''', (datetime.now(), account_id))


def mark_email_sent(account_id: int):
    """Mark that an email has been sent for this account."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE debt_accounts
            SET email_sent = 1, updated_at = ?
            WHERE id = ?
        ''', (datetime.now(), account_id))


def get_account(account_id: int) -> Optional[Dict]:
    """Get a single account by ID."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM debt_accounts WHERE id = ?', (account_id,))
        row = cursor.fetchone()
        return dict(row) if row else None


def get_accounts_by_run(run_id: int) -> List[Dict]:
    """Get all accounts for a run, ordered by category then age (oldest first)."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            SELECT * FROM debt_accounts
            WHERE run_id = ?
            ORDER BY
                CASE category
                    WHEN 'MED' THEN 1
                    WHEN 'MED READY' THEN 2
                    WHEN 'PAY' THEN 3
                    WHEN 'PAID' THEN 4
                    WHEN 'SMJ' THEN 5
                    WHEN 'INS' THEN 6
                    WHEN 'STAFF' THEN 7
                    WHEN 'INV' THEN 8
                    WHEN 'BAD' THEN 9
                    ELSE 10
                END,
                CASE
                    WHEN days_90 > 0 THEN 1
                    WHEN days_60 > 0 THEN 2
                    WHEN days_30 > 0 THEN 3
                    ELSE 4
                END,
                total_balance DESC
        ''', (run_id,))
        return [dict(row) for row in cursor.fetchall()]


def get_accounts_by_category(run_id: int, category: str) -> List[Dict]:
    """Get accounts for a run filtered by category."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            SELECT * FROM debt_accounts
            WHERE run_id = ? AND category = ?
            ORDER BY total_balance DESC
        ''', (run_id, category))
        return [dict(row) for row in cursor.fetchall()]


def get_run_summary(run_id: int) -> Dict:
    """Get summary statistics for a run."""
    with get_connection() as conn:
        cursor = conn.cursor()

        # Total counts
        cursor.execute('''
            SELECT COUNT(*) as count, SUM(total_balance) as total
            FROM debt_accounts WHERE run_id = ?
        ''', (run_id,))
        row = cursor.fetchone()
        total_count = row['count'] if row else 0
        total_value = row['total'] if row and row['total'] else 0

        # By category
        cursor.execute('''
            SELECT category, COUNT(*) as count, SUM(total_balance) as total
            FROM debt_accounts
            WHERE run_id = ?
            GROUP BY category
        ''', (run_id,))
        by_category = {row['category']: {'count': row['count'], 'value': row['total']}
                       for row in cursor.fetchall()}

        # By aging
        cursor.execute('''
            SELECT
                CASE
                    WHEN days_90 > 0 THEN '90+ Days'
                    WHEN days_60 > 0 THEN '60 Days'
                    WHEN days_30 > 0 THEN '30 Days'
                    ELSE 'Current'
                END as aging,
                COUNT(*) as count,
                SUM(total_balance) as total
            FROM debt_accounts
            WHERE run_id = ?
            GROUP BY aging
        ''', (run_id,))
        by_aging = {row['aging']: {'count': row['count'], 'value': row['total']}
                    for row in cursor.fetchall()}

        return {
            'total_accounts': total_count,
            'total_value': total_value,
            'by_category': by_category,
            'by_aging': by_aging
        }


# Staff Accounts Operations (persist across runs)

def mark_as_staff(client_id: int, client_name: str = None):
    """Mark a client ID as a staff account (persists across runs)."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            INSERT OR REPLACE INTO staff_accounts (client_id, client_name, marked_at)
            VALUES (?, ?, ?)
        ''', (client_id, client_name, datetime.now()))


def unmark_as_staff(client_id: int):
    """Remove staff designation from a client."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('DELETE FROM staff_accounts WHERE client_id = ?', (client_id,))


def is_staff_account(client_id: int) -> bool:
    """Check if a client ID is marked as staff."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('SELECT 1 FROM staff_accounts WHERE client_id = ?', (client_id,))
        return cursor.fetchone() is not None


def get_all_staff_accounts() -> List[Dict]:
    """Get all client IDs marked as staff."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM staff_accounts ORDER BY client_name')
        return [dict(row) for row in cursor.fetchall()]


# Initialize database on import
init_database()
