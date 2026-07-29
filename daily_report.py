"""Daily unpaid-procedure report.

Queries Teleos directly (read-only, direct MySQL via teleos_read) for procedure charges dated
YESTERDAY that are still unpaid — i.e. consults / treatments done but not
settled at the desk — and emails the list to the accounts mailbox.

Gate (confirmed with practice 2026-06-08): an account is included if it has
AT LEAST ONE unpaid PROCEDURE charge dated yesterday. Prescriptions
(Details == 'PRESCRIPTION') and stock/medication items are deliberately
EXCLUDED — those are collected/paid later by design (MED / MED READY), this
report is specifically to catch chargeable work that wasn't paid for.

Runs from cron at 07:00. Independent of the manual CSV-upload flow.

Usage:
    python daily_report.py                # yesterday, send email
    python daily_report.py --dry-run      # build + print, don't send
    python daily_report.py --date 2026-06-05   # a specific charge date
"""
from __future__ import annotations

import argparse
import sys
from collections import defaultdict
from datetime import datetime, timedelta

from config import config
from teleos_client import TeleosClient
from email_service import get_email_service


# Account types (Teleos departments) to leave OUT of the report. INV accounts
# are invoiced monthly, so they'll always carry an unpaid balance until the
# month-end invoice — chasing them daily is noise.
EXCLUDE_DEPTS = {'INV'}


def _uk_date(d: datetime) -> str:
    return d.strftime('%d/%m/%Y')


def charge_dates_for(run_dt: datetime) -> list:
    """Which charge dates a report run on `run_dt` should cover.

    Normally just yesterday. On a Monday it also sweeps up the weekend
    (Saturday + Sunday), since the practice doesn't action the Sat/Sun reports
    — so a procedure done over the weekend still surfaces first thing Monday.
    """
    yesterday = run_dt - timedelta(days=1)
    if run_dt.weekday() == 0:  # Monday
        return [run_dt - timedelta(days=2), yesterday]  # Saturday, Sunday
    return [yesterday]


def find_unpaid_procedures(client: TeleosClient, charge_dates: list) -> list:
    """Return per-client unpaid procedure charges across the given date(s).

    charge_dates: list of 'YYYY-MM-DD'. Returns a list of dicts:
        {client_id, client_name, balance, items: [{details, amount}], total}
    sorted by total descending.
    """
    date_list = ', '.join(f"'{d}'" for d in charge_dates)
    # All procedure charges on those dates (exclude prescriptions + non-positive)
    query = f"""
    SELECT t.Transaction_ID, t.Client_ID, t.Details,
           (t.Net_value + t.VAT_amount) AS Total
    FROM transactions t
    WHERE DATE(t.Invoice_date) IN ({date_list})
      AND t.Stock_or_Procedure = 'P'
      AND (t.Net_value + t.VAT_amount) > 0
      AND UPPER(TRIM(t.Details)) <> 'PRESCRIPTION'
    ORDER BY t.Client_ID
    """
    rows = client.execute_custom_query(query)

    # Group transactions by client
    by_client = defaultdict(list)
    for r in rows:
        by_client[r.get('Client_ID')].append(r)

    results = []
    for client_id, txns in by_client.items():
        if not client_id:
            continue
        # Determine which of these procedures are still unpaid, using the same
        # payment-allocation logic the categoriser uses.
        allocations = client.get_payment_allocations(client_id)
        unpaid_items = []
        for t in txns:
            total = float(t.get('Total', 0) or 0)
            allocated = allocations.get(t.get('Transaction_ID'), 0)
            if total - allocated > 0.01:
                unpaid_items.append({
                    'details': (t.get('Details') or '').strip(),
                    'amount': round(total - allocated, 2),
                })
        if not unpaid_items:
            continue  # all of yesterday's procedures for this client were paid

        # Require the account to actually owe money overall. A client can show
        # an unpaid procedure at the transaction level while being in credit
        # overall — e.g. a deposit was taken but not yet allocated to those
        # transactions (the Murray case, 2026-06-08). Those are effectively
        # pre-paid, so we don't chase them.
        balance = client.get_client_balance(client_id) or 0.0
        if balance < 0.01:
            continue

        info = client.get_client_by_id(client_id) or {}
        name = ' '.join(p for p in (
            (info.get('Title') or '').strip(),
            (info.get('First_name_or_initials') or '').strip(),
            (info.get('Surname') or '').strip(),
        ) if p) or f"Client {client_id}"
        dept = (client.get_client_department(client_id) or '').strip().upper()
        if dept in EXCLUDE_DEPTS:
            continue  # e.g. INV — monthly-invoiced, expected to carry a balance
        results.append({
            'client_id': client_id,
            'client_name': name,
            'dept': dept,           # account type: PAY/BAD/INS/ACC/INV/RET/REF/ZST
            'balance': float(balance),
            'items': unpaid_items,
            'total': round(sum(i['amount'] for i in unpaid_items), 2),
        })

    results.sort(key=lambda r: r['total'], reverse=True)
    return results


ROW_BG = {'PAY': '#FFE7C2', 'BAD': '#F8C9C9', 'INS': '#CDEBCD'}  # orange/red/green
_TH = 'style="padding:8px 10px;text-align:left;"'
_THR = 'style="padding:8px 10px;text-align:right;"'
_TD = 'style="padding:6px 10px;border-bottom:1px solid #eee;"'
_TDR = 'style="padding:6px 10px;border-bottom:1px solid #eee;text-align:right;"'


def _table(results: list) -> str:
    """Render the account table for the daily report (itemised procedure lines)."""
    rows = []
    for r in results:
        bg = ROW_BG.get(r['dept'], '')
        style = f' style="background:{bg};"' if bg else ''
        items = '<br>'.join(f"{i['details']} &mdash; £{i['amount']:.2f}" for i in r['items'])
        rows.append(f"""<tr{style}>
          <td {_TD}>{r['client_id']}</td>
          <td {_TD}>{r['client_name']}</td>
          <td {_TD}><strong>{r['dept'] or '—'}</strong></td>
          <td {_TD}>{items}</td>
          <td {_TDR}><strong>£{r['total']:.2f}</strong></td>
          <td {_TDR} style="color:#666;">£{r['balance']:.2f}</td>
        </tr>""")
    body = ''.join(rows) if results else (
        '<tr><td colspan="6" style="padding:14px;text-align:center;color:#666;">'
        'No unpaid procedure charges for this date. 🎉</td></tr>')
    return f"""<table style="border-collapse:collapse;width:100%;font-size:14px;">
      <thead><tr style="background:#1E3A5F;color:white;">
        <th {_TH}>Client ID</th><th {_TH}>Name</th><th {_TH}>Type</th>
        <th {_TH}>Unpaid procedure(s)</th><th {_THR}>Unpaid</th><th {_THR}>Total balance</th>
      </tr></thead><tbody>{body}</tbody></table>"""


def build_html(charge_dates: list, results: list) -> str:
    fmt = lambda s: datetime.strptime(s, '%Y-%m-%d').strftime('%d/%m/%Y')
    date_str = fmt(charge_dates[0]) if len(charge_dates) == 1 else \
        f"{fmt(charge_dates[0])} – {fmt(charge_dates[-1])}"
    daily_total = sum(r['total'] for r in results)
    return f"""<!doctype html><html><body style="font-family:Segoe UI,Arial,sans-serif;color:#222;">
    <h2 style="color:#1E3A5F;margin-bottom:2px;">Unpaid procedure charges</h2>
    <div style="color:#666;margin-bottom:14px;">Dated <strong>{date_str}</strong> &middot;
      {len(results)} account(s) &middot; £{daily_total:.2f} total</div>
    {_table(results)}
    <p style="color:#555;font-size:12px;margin:10px 0;">Account-type highlight:
      <span style="background:#FFE7C2;padding:1px 6px;border-radius:3px;">PAY</span>
      <span style="background:#F8C9C9;padding:1px 6px;border-radius:3px;">BAD</span>
      <span style="background:#CDEBCD;padding:1px 6px;border-radius:3px;">INS</span>
      &nbsp;others unshaded.</p>
    <p style="color:#888;font-size:12px;margin-top:6px;">
      Accounts with at least one procedure charge from {date_str} that hasn't been settled
      (and an overall balance owing). Prescriptions, medication (MED / MED READY) and
      monthly-invoiced (INV) accounts are excluded. Generated automatically from Teleos.
    </p></body></html>"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--date', help="Charge date YYYY-MM-DD (overrides the "
                    "auto weekday/Monday logic; single date)")
    ap.add_argument('--run-date', help="Pretend the report runs on this date "
                    "YYYY-MM-DD (to test the Monday=weekend logic)")
    ap.add_argument('--dry-run', action='store_true', help="Build + print, don't email")
    args = ap.parse_args()

    if args.date:
        charge_dates = [args.date]
    else:
        run_dt = (datetime.strptime(args.run_date, '%Y-%m-%d')
                  if args.run_date else datetime.now())
        charge_dates = [d.strftime('%Y-%m-%d') for d in charge_dates_for(run_dt)]

    client = TeleosClient()
    if not client.health_check():
        print("ERROR: Teleos database not reachable", file=sys.stderr)
        sys.exit(1)

    results = find_unpaid_procedures(client, charge_dates)
    span = charge_dates[0] if len(charge_dates) == 1 else f"{charge_dates[0]}..{charge_dates[-1]}"
    print(f"{span}: {len(results)} account(s) with unpaid procedures, "
          f"£{sum(r['total'] for r in results):.2f} total")
    for r in results:
        print(f"  {r['client_id']}  {r['client_name']:30s}  £{r['total']:.2f}")

    html = build_html(charge_dates, results)
    fmt = lambda s: datetime.strptime(s, '%Y-%m-%d').strftime('%d/%m/%Y')
    label = fmt(charge_dates[0]) if len(charge_dates) == 1 else f"{fmt(charge_dates[0])}–{fmt(charge_dates[-1])}"
    subject = f"[Accounts] Unpaid procedure charges {label} — {len(results)} account(s)"

    if args.dry_run:
        print("\n--dry-run: not sending. HTML length:", len(html))
        return
    if not config.REPORT_ENABLED:
        print("REPORT_ENABLED=false — not sending.")
        return

    result = get_email_service().send_report(subject, html)
    if result.get('success'):
        print(f"Report emailed to {config.REPORT_TO_ADDRESS}")
    else:
        print(f"Email FAILED: {result.get('error')}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
