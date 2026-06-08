# Teleos Aged Debtor Report — reverse-engineered SQL (for future automation)

This is the query behind Teleos's **Aged Debtor Reports** menu (Management
reports → Aged Debtor) — the same report that produces the `mdebtor.CSV` the
AI-Accounts web app currently ingests. Documented so the weekly debt run can
eventually be **fully automated** (query Teleos directly, no manual export).

## How it was found (2026-06-08)

`teleos3.exe` is a **native VB6 executable**, not .NET — that's why `monodis` /
`ikdasm` fail with `BadImageFormatException`. VB6 stores its SQL as UTF-16
string literals, so:

```bash
strings -e l -n 8 teleos3.exe | grep -iE "datediff|debtor|Procedure ID"
```

extracts the report SQL. Raw dump saved alongside this file:
`teleos3_aged_debtor_sql_raw.txt`. The SQL is built at runtime by substituting
the `<...>` / `#<...>#` placeholders below from the report wizard answers.

## The report wizard (HEJ's standard answers) → SQL placeholders

| Wizard prompt | HEJ answer | Effect on the SQL |
|---|---|---|
| Report date | **2 days before today** | `#<DateToBeInsertedHere>#` — both the aging origin (`datediff(date, Invoice_date)`) and the cut-off (`Invoice_date < date`). 2 days back excludes today's churn. |
| Print / Display | Display | output only |
| Include bad-debt allocations | **No** | toggles the refund/allocation exclusion |
| Department | **All** | `<ClientDepartmentJoinToBeInsertedHere>` left empty (no dept filter) |
| Include **credit** balances | **No** | net client total must be **> 0** (exclude credits) |
| Include balances currently **zero** | **No** | net client total **≠ 0** |
| Include **all work whether invoiced or not** | **Yes** | **no `Invoiced` filter** — picks up un-invoiced charges |
| Use the date the work was entered on | **Yes** | age by `Invoice_date` (= work date) |
| Payments up to the present included | **Yes** | payments netted even if dated after the cut-off |
| Include -ve transactions after cut-off | **Yes** | refunds/credits after the cut-off still counted |
| List alphabetically without separating by department | **No** | results **grouped by department** |

## The logic (reconstructed)

**Aging buckets** — for each client, sum transaction amounts into buckets by
how old the charge is, where `D = datediff(reportDate, Invoice_date)`:

| Bucket (CSV column) | Condition | Default period |
|---|---|---|
| `Current`  | `D <= intPeriod30`  | 30 |
| `ThirtyDays` | `intPeriod30 < D <= intPeriod60` | 60 |
| `SixtyDays` | `intPeriod60 < D <= intPeriod90` | 90 |
| `NinetyDays` | `intPeriod90 < D <= intPeriod120` | 120 |
| `OneHundredTwentyDays` | `D > intPeriod120` | — |

Total balance = `SUM(Amount in currency)` across the client's qualifying rows.

**Charges** are `Procedure_ID = 2 AND [Amount in currency] > 0`. (In the
`transactions` table `Procedure_ID` here is a **transaction TYPE**, not the
`Stock_or_Procedure` flag: **2 = charge/invoice line**, **9 = payment**,
**8 = payment/adjustment** where `Details LIKE 'payment%'/'betaling%'/'zahlung%'`.
Verified live: Procedure_ID=2 is by far the most common positive-value type.)

**Filters** (charges query):
- `(C.[Bill type] <> 'Z' OR C.[Bill type] IS NULL)` — exclude bill-type Z
- `T.[Procedure ID] = 2 AND T.[Amount in currency] > 0`
- `T.[Invoice date] < #reportDate#`
- `Transaction_ID NOT IN (… FullyAllocatedRefunds …)` — drop fully-refunded lines
  (the "include bad-debt allocations = No" toggle)

**Netting** — a separate pass sums payments (`Procedure_ID = 9`, or `= 8` with
`Details LIKE 'payment%'`) and -ve transactions, and subtracts them from the
aged charges. Credit / zero **net** balances are then dropped (the "include
credit / zero balances = No" answers). Grouped and presented by department.

### Why this is the CORRECT cumulative logic (the Tibbles fix)

The naive approach we tried for the dropped Monday cross-check —
`SUM(transaction Total − payment-allocations)` — **over-reports**, because old
un-invoiced / written-off charges still look unpaid at the row level. Client
`-1322844281` (Tibbles, BAD) showed £1,204.80 that way but her real balance is
£20.50. The official report avoids this by **netting all payments against the
aged charges and excluding zero/credit net balances** — so it reconciles to
`clientbalance.Balance`. Any automated debtor-sourcing must replicate this
netting, not a per-transaction allocation scan.

## Legacy → MySQL column mapping (needs care when porting)

The extracted SQL uses the original Access/Jet bracketed names. Live MySQL uses
underscores. Known mappings + the ones to confirm:

| Extracted (`[…]`) | MySQL `transactions` / `client` |
|---|---|
| `[Client ID]` | `Client_ID` |
| `[Invoice date]` | `Invoice_date` |
| `[Procedure ID]` | `Procedure_ID` |
| `[Net value]` | `Net_value` |
| `[Bill type]` | `Bill_type` |
| `[Amount in currency]` | **TBC** — likely gross `Net_value + VAT_amount`, or a stored column; verify before relying on it |
| `[Client department ID/number]` | `client.Client_department_ID` → `client_department.Client_department_number` |

`datediff`, `IF`, `CONCAT_WS` are already MySQL-dialect (the app translates the
Jet SQL before running it), so the structure ports directly once column names
and `[Amount in currency]` are resolved.

## Suggested automation path

1. Port the charges-aging + payment-netting query to live MySQL (resolve the
   column names above), parameterised by report date (today − 2) and the
   aging periods (30/60/90/120).
2. Filter exactly as HEJ does: bill-type ≠ Z, all-work (no invoiced filter),
   exclude zero/credit net balances, group by department.
3. Feed the resulting debtor list into the **existing** `debt_analyzer` /
   `get_client_account_data` per-account categoriser (MED / PAY / INS / …) —
   unchanged — replacing the manual `mdebtor.CSV` upload.
4. Emit the Excel + email on a schedule (Graph + cron already proven by the
   daily report).
