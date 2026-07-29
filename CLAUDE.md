# CLAUDE.md - AI Accounts Assistant

This document provides context for AI assistants working on this project.

## Project Overview

**AI Accounts Assistant** is a debt list analyzer for a veterinary practice. It reads a CSV export of outstanding balances from Teleos and uses AI to categorize each account (MED, PAY, INS, etc.).

### Key Technologies
- **Backend**: Python 3.10+, Flask (Port 5003)
- **AI**: Anthropic Claude API (claude-sonnet-4)
- **Database**: SQLite (accounts.db)
- **Excel**: openpyxl for output generation
- **Integration**: Teleos direct MySQL via shared teleos_read module (/home/sejo/teleos-api) — migrated off the MCP server 2026-07-29; legacy MCP path behind `TELEOS_DATA_BACKEND=mcp`

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Web Browser    │────▶│  Flask App       │────▶│  Claude API     │
│  (Port 5003)    │     │  (app.py)        │     │                 │
└─────────────────┘     └────────┬─────────┘     └─────────────────┘
                                │
                   ┌────────────┼────────────┐
                   ▼            ▼            ▼
           ┌───────────┐ ┌───────────┐ ┌───────────┐
           │ Teleos    │ │ CSV File  │ │ SQLite    │
           │ MySQL     │ │ /mnt/...  │ │ Database  │
           │(teleos_read)│ │           │ │           │
           └───────────┘ └───────────┘ └───────────┘
```

## Key Files

| File | Purpose |
|------|---------|
| `app.py` | Flask application, routes, background analysis |
| `config.py` | Configuration (ports, paths, API keys) |
| `database.py` | SQLite operations for runs and accounts |
| `teleos_client.py` | Teleos data client — direct MySQL via teleos_read (balance, SMS, transactions); `_call_tool` dispatches on `TELEOS_DATA_BACKEND` (mysql default / mcp legacy rollback) |
| `csv_parser.py` | Parse mdebtor.CSV from Teleos |
| `debt_analyzer.py` | AI categorization logic with Claude |
| `excel_generator.py` | Generate Excel output with categories |

## Debt Categories

| Category | Meaning | In Excel |
|----------|---------|----------|
| MED | Medication awaiting collection | Yes |
| MED READY | Medication ready, client notified (SMS sent) | Yes |
| PAY | Payment required for procedures | Yes |
| PAID | Balance now zero | No (web only) |
| INS | Insurance claim pending | Yes |
| SMJ | Needs human review (practice manager) | Yes |
| STAFF | Staff account | Yes |
| BAD | Bad debtor - flagged in Teleos | No (web only) |
| INV | Invoice account - pays monthly | No (web only) |

## CSV File Format (mdebtor.CSV)

No header row. Columns:
1. Client ID
2. Client Name
3. Last Payment (format: "760.24 on 04.11.2025")
4. Current (0-30 days)
5. 30 days
6. 60 days
7. 90+ days
8. Total Balance

## Running the App

```bash
cd /home/sejo/AI-Accounts-Assistant
./venv/bin/python app.py
```

**To stop (port-specific):**
```bash
lsof -ti:5003 | xargs kill
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `ANTHROPIC_API_KEY` | Yes | - | Claude API key |
| `TELEOS_MYSQL_*` | Yes | - | Direct Teleos MySQL (host/port/user/password/database, read-only) |
| `TELEOS_DATA_BACKEND` | No | mysql | `mcp` = legacy rollback path (MCP_HOST/PORT/API_KEY then apply) |
| `FLASK_PORT` | No | 5003 | Flask server port |

## Related Projects

- **AI-Case-Assistant**: Port 5002 - Veterinary case analysis
- **AI-Lab-Reports**: Port 5000 - Lab report analysis
- **teleos-api**: shared TelAPI client + teleos_read direct-MySQL module

## Excel Output Format

The generated Excel file contains the following columns:
1. **ID** - Client ID from Teleos
2. **Name** - Client name
3. **Last Payment** - Amount and date of last payment
4. **Current** - 0-30 days balance
5. **30 Days** - 30 days overdue
6. **60 Days** - 60 days overdue
7. **90 Days** - 90+ days overdue
8. **Total** - Total balance owing
9. **SMS** - Empty, for practice manager to mark if SMS sent
10. **EMAIL** - Empty, for practice manager to mark if email sent
11. **TYPE** - AI-assigned category (MED, PAY, INS, etc.)
12. **ADMIN NOTES** - Empty, for practice manager to add manual notes
13. **AI ANALYSIS NOTES** - AI-generated explanation of categorization

The summary section at the bottom uses Excel formulas (COUNTIF/SUMIF), so totals update dynamically if the user manually changes category values.

**Conditional Formatting**: Columns A-K use conditional formatting based on the TYPE value in column K. If you change the TYPE, the row color will automatically update to match the new category.

## Transaction Analysis

The `teleos_client.py` analyzes transactions using:

1. **Payment allocations** (most accurate):
   - Queries `paymentallocations` table to see which transactions have been paid
   - Accounts for `paymentallocations:reversed` (cancelled allocations)
   - Transaction is unpaid if: `Total - AllocatedAmount > £0.01`

2. **Invoice status check** (fallback if no allocations):
   - `Invoiced=1, Paid=0` → **PAY** (invoiced but unpaid - they owe money)
   - `Invoiced=0` → Check item type below

3. **Stock_or_Procedure column** (when available):
   - `S` = Stock item (medication, products) → **MED** (if not invoiced)
   - `P` = Procedure (consultations, treatments) → **PAY**
   - `N` = Note (skipped)

4. **Keyword matching** (fallback when column unavailable)

5. **Balance matching** (when unpaid total doesn't match current balance):
   - **Payment deduction**: Calculates what was paid (unpaid total - current balance), finds items matching that amount, removes them from analysis
   - Checks if stock items alone match the balance (procedures likely paid)
   - Checks if most recent items match the balance
   - Only analyzes items that contribute to current balance

6. **Filtered out automatically**:
   - Estimate items (prices in parentheses like `"General Anaesthetic (75.00)"`)
   - Non-balance-affecting entries: "Invoice X created", "Receipt X created", "Auth Code:", etc.

## Future Work / TODO

### Fully automate the weekly debt run (currently manual CSV)
**Today (2026-06):** the weekly debt analysis is manual — a human runs the debtor
report in Teleos, exports `mdebtor.CSV` to `/mnt/TELEVETLIVE`, then uploads it in
the web app, which categorises each account. **Goal:** make it fully automatic —
source the debtor list directly from Teleos (no human CSV export), run the
categorisation, and produce the Excel / email on a schedule. The daily-report
work (v1.3.0) already proves the building blocks: direct Teleos querying via MCP,
Microsoft Graph email, and a cron schedule, all server-side.

**⚠️ Critical finding before building this (2026-06-08, from the dropped cumulative experiment):**
A naive cumulative query — `SUM(transaction Total − allocated payments)` over a
date window — **over-reports debt and is NOT safe to use.** Proven by client
`-1322844281` (Miss A Tibbles, BAD): she shows £1,204.80 of "unpaid" procedures
(a Mar-2026 PYOMETRA £1,102.20 + Vetscan £102.60, both `Invoiced=0, Paid=0`,
zero allocation) but her **actual `clientbalance.Balance` is £20.50.** Those
charges were written off / never invoiced; the transaction-level "unpaid" maths
doesn't know that. Lessons for automation:
- **`clientbalance.Balance` is the ground truth** for what a client owes — not the
  sum of un-allocated transactions. Old un-invoiced lines, write-offs, estimates,
  and unallocated payments all make transaction-level "unpaid" diverge from the
  real balance.
- The **existing CSV debt run already handles this correctly** via the smart
  balance-reconciliation in `teleos_client.get_outstanding_items` /
  `_categorize_items` (it matches unpaid items against the actual balance and
  drops items that don't contribute). Any automated debtor-sourcing MUST keep
  that reconciliation — don't replace it with a naive transaction scan.
- The **daily report (v1.3.0) is reliable despite this** only because it looks at
  *fresh* charges (yesterday), where allocations reflect reality; the divergence
  is a problem for *historical* cumulative scans, which is why the Monday
  cumulative cross-check idea was dropped.
- Likely automation path: query the debtor list from Teleos (e.g. `clientbalance`
  WHERE Balance > threshold, joined to client/department) to replace the manual
  `mdebtor.CSV` export, then feed those clients through the *existing*
  per-account analyzer (`debt_analyzer` + `get_client_account_data`) unchanged.
- **The actual mdebtor report SQL has been reverse-engineered** — see
  `docs/teleos_aged_debtor_report.md`. It lives in `teleos3.exe` (native VB6 —
  extract with `strings -e l`, .NET decompilers fail). That doc has the aging-bucket
  logic, the `Procedure_ID` transaction-type semantics (2=charge, 8/9=payment),
  HEJ's standard wizard answers mapped to the SQL placeholders, the
  payment-netting that makes it reconcile to `clientbalance` (and dodge the
  Tibbles over-report), and the legacy→MySQL column mapping. That's the blueprint
  to port the debtor query to live MySQL for the automation.

## Version History

### v1.4.0 (2026-07-29) - Migrated off the MCP server to direct MySQL (MCP migration Step 4)
- `teleos_client.py`: `_call_tool` dispatches on `TELEOS_DATA_BACKEND` — `mysql` (default)
  routes the 3 tools + all `execute_custom_query` SQL through the shared `teleos_read` module
  (read-only `claude_read`, param-bound); `mcp` is the legacy rollback path (one-line `.env`
  change + restart; delete after burn-in). All public methods and callers unchanged.
- **Verified with an exact two-backend diff on a live account** (balance £1331.70, INV
  department, 50-txn history, outstanding + unpaid lists, SMS history): every row identical
  except the two expected deltas — datetimes now correct naive UK-local (MCP shifted them
  -1h during BST) and Decimals as floats instead of strings (all consumers `float()` them,
  so no behavioural change).
- No MCP dependency remains on the default path; `MCP_*` config retained only for the
  rollback flag.

### v1.3.0 (2026-06-08) - Prescription category fix + daily unpaid-procedure report
- **Prescriptions now classed MED / MED READY, not PAY.** In Teleos a prescription/dispensing fee is logged as a Procedure (`Stock_or_Procedure='P'`) with `Details='PRESCRIPTION'`, so `analyze_transaction_types` was bucketing it as a procedure → PAY. Now a `P` line whose details contain "prescription" is treated as a stock/medication item, so it flows through the existing medication rules: **MED** (no collection/payment SMS) or **MED READY** (SMS sent). Verified against 4 live examples (all → MED READY). Single change in `teleos_client.py analyze_transaction_types`.
- **New daily unpaid-procedure report** (`daily_report.py` + `email_service.py`) — emailed 07:00 daily to `accounts@` via cron, independent of the manual CSV-upload flow.
  - Queries Teleos directly (read-only, MCP) for **procedure** charges (`Stock_or_Procedure='P'`, excluding `PRESCRIPTION`) dated **yesterday** that are still **unpaid** (payment-allocation logic, same as the categoriser).
  - **Gate**: an account is included if it has ≥1 unpaid procedure from yesterday **AND** its overall `clientbalance` > £0 — the balance guard drops clients who are in credit / pre-paid via an unallocated deposit (the "Murray" case). Catches consults/treatments done but not settled at the desk.
  - Email via Microsoft Graph (same Graph app as VetNotes-Sync; creds copied into `.env`). Sends **from and to** `accounts@heathandreachvets.co.uk`, **CC `sean.johnston@`** (`REPORT_CC_ADDRESSES`, comma-separated) — the Graph app has `Mail.Send` on the accounts mailbox (verified by live test).
  - **Weekend handling**: `charge_dates_for()` — a Monday run covers Saturday + Sunday (the practice doesn't action the weekend reports); every other day covers just yesterday. Empty days still send (heartbeat).
  - **Account-type column** (`get_client_department`: ACC/BAD/INS/INV/PAY/REF/RET/ZST). Row highlight: PAY = orange, BAD = red, INS = green; others unshaded. Legend in the email footer.
  - **NOT cumulative** — a daily snapshot of procedures charged on the covered date(s) that are still unpaid. An item appears once (the morning after the charge); if it stays unpaid it does NOT re-appear next day (the full CSV debt run is the cumulative debtors view).
  - `daily_report.py` runs standalone: `--dry-run` (build + print), `--date YYYY-MM-DD` (a specific charge date) for testing.
  - New config: `GRAPH_TENANT_ID/CLIENT_ID/CLIENT_SECRET`, `REPORT_FROM_ADDRESS`, `REPORT_TO_ADDRESS`, `REPORT_ENABLED`. New dep: `msal`.
  - Cron (user crontab): `0 7 * * * cd /home/sejo/AI-Accounts-Assistant && venv/bin/python daily_report.py >> output/daily_report.log 2>&1`
  - Currently sends every day even when the list is empty (shows "No unpaid procedure charges"), acting as a heartbeat; flip to send-only-when-non-empty if that's noise.

### v1.2.0 (2026-04-28) - Sonnet 4.6 Migration
- **Model upgraded** from `claude-sonnet-4-20250514` (original Sonnet 4.0) to `claude-sonnet-4-6` (current generation). Same price tier, improved intelligence. Model is env-driven via `CLAUDE_MODEL` for one-line rollback.
- **API call cleanup** in `debt_analyzer.py:_ai_categorize`:
  - Dropped `top_p=0.9` — Claude 4+ rejects requests passing both `temperature` and `top_p`. Kept `temperature=0.1` for deterministic JSON categorization.
  - Added `thinking={"type": "disabled"}` for explicit-off behavior across model versions.
  - Added `output_config={"effort": "low"}` — Sonnet 4.6 defaults to `high`, which would burn unnecessary latency/tokens on this short, deterministic classification task.
- **SDK upgrade**: `anthropic>=0.25.0` → `anthropic>=0.97.0` (matches lab-app and case-app pins; older SDK predated the `output_config` keyword).

### v1.1.1 (2026-01-19) - Analysis Accuracy Improvements
- **PAID accounts excluded from Excel** - No action needed for paid accounts, only shown on web
- **Aging-aware notes**: MED/MED READY items in 30+ days aging now show "Not collected for X days - verify still required"
- **Reduced AI hallucination**:
  - Temperature lowered to 0.1, top_p set to 0.9
  - Prompt rules added: don't invent invoice numbers, keep notes brief
  - Today's date added to context
  - Explicit note that invoice numbers are not provided
- **Better transaction display**: Shows allocated/remaining amounts, item type (S/P)

### v1.1.0 (2026-01-19) - Phase 9 Improvements
- **STAFF accounts now included in Excel** for visibility
- **New "ADMIN NOTES" column** between TYPE and AI ANALYSIS NOTES for practice manager notes
- **Renamed NOTES to "AI ANALYSIS NOTES"** for clarity
- **Text wrapping** enabled on both notes columns
- **Dynamic Excel formulas** for summary section (COUNTIF/SUMIF) - totals update when user edits categories
- **Conditional formatting** for row colors (columns A-K) based on TYPE value - colors update automatically when TYPE is changed
- **Improved transaction analysis**:
  - **Payment allocations**: Uses `paymentallocations` table for accurate paid/unpaid status (accounts for reversed allocations too)
  - **Invoiced-but-unpaid detection**: Items with `Invoiced=1, Paid=0` are now PAY (even stock items)
  - Uses `Stock_or_Procedure` column from Teleos for more accurate item type detection
  - **Smart balance matching**: When unpaid items don't match current balance:
    - Calculates payment difference and finds items that were likely paid (e.g., £12.10 synulox paid, £97.70 thyronorm remains → MED)
    - Checks if stock items match the balance (procedures likely paid)
    - Checks most recent items
  - Filters out estimate items (prices in parentheses at end)
  - Skips non-balance-affecting entries (Invoice/Statement/Receipt created, Auth Code, Card Num)

### v1.0.0 (Initial Release)
- Initial implementation with CSV parsing, Teleos integration, AI categorization, and Excel export
