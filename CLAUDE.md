# CLAUDE.md - AI Accounts Assistant

This document provides context for AI assistants working on this project.

## Project Overview

**AI Accounts Assistant** is a debt list analyzer for a veterinary practice. It reads a CSV export of outstanding balances from Teleos and uses AI to categorize each account (MED, PAY, INS, etc.).

### Key Technologies
- **Backend**: Python 3.10+, Flask (Port 5003)
- **AI**: Anthropic Claude API (claude-sonnet-4)
- **Database**: SQLite (accounts.db)
- **Excel**: openpyxl for output generation
- **Integration**: Teleos MCP server (localhost:3000)

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
           │ MCP Server│ │ /mnt/...  │ │ Database  │
           │ (Port 3000)│ │           │ │           │
           └───────────┘ └───────────┘ └───────────┘
```

## Key Files

| File | Purpose |
|------|---------|
| `app.py` | Flask application, routes, background analysis |
| `config.py` | Configuration (ports, paths, API keys) |
| `database.py` | SQLite operations for runs and accounts |
| `teleos_client.py` | MCP client for Teleos queries (balance, SMS, transactions) |
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
| `MCP_HOST` | No | localhost | Teleos MCP server host |
| `MCP_PORT` | No | 3000 | Teleos MCP server port |
| `FLASK_PORT` | No | 5003 | Flask server port |

## Related Projects

- **AI-Case-Assistant**: Port 5002 - Veterinary case analysis
- **AI-Lab-Reports**: Port 5000 - Lab report analysis
- **Teleos MCP Server**: Port 3000 - Practice management integration

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

## Version History

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
