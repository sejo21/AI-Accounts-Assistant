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

| Category | Meaning |
|----------|---------|
| MED | Medication awaiting collection |
| MED READY | Medication ready, client notified (SMS sent) |
| PAY | Payment required for procedures |
| PAID | Balance now zero |
| INS | Insurance claim pending |
| SMJ | Needs human review (practice manager) |
| STAFF | Staff account (skip) |
| BAD/INV | Bad debt or invoice dispute (skip) |

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
