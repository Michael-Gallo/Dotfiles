---
name: bill-split
description: Use when the user wants to split a restaurant bill, receipt, or group tab among people. Triggers on "bill split", "split the bill", "who owes what", "split receipt", "divide bill", "track who owes me". Builds a simple .xlsx spreadsheet where each line item is tagged to exactly one person, with red highlighting on unassigned items. Never uses a "shared" column; every item is assigned to one person.
---

# Bill Split Skill

## Goal

Turn receipts into a simple, shareable `.xlsx` spreadsheet that shows exactly how much each person owes.

## Core rules

1. **Read the entire prompt.** The user may paste multiple receipts in one message (images, text, or both). Parse every receipt before asking questions.
2. **One item per row.** Split quantity/multi-item lines into the same number of individual rows. Example: `2 Mojitos ... $26` becomes two rows of `Mojito` at $13.00.
3. **Every item is assigned to exactly one person.** No shared items, no partial splits, no "Shared" column. If the user says an item was for two people, split it into two rows at equal unit price and assign one row to each person.
4. **Highlight unassigned items in red.** Use conditional formatting so any row with an empty `Assigned To` is red.
5. **Tax and tip are split proportionally.**
   - `tax_share_person = (person_subtotal / total_subtotal) * tax`
   - `tip_share_person = (person_subtotal / total_subtotal) * tip`
6. **Output an `.xlsx` with formulas.** Use Python + openpyxl. Use `SUMIF` formulas so the user can edit assignments later and the summary totals update automatically.
7. **Names and context:** Ask for the group list if not provided. Ask for the restaurant name and/or date for each receipt. Name the output file using the date and one restaurant name (e.g., `2026-07-05-diner.xlsx`). Use lowercase names consistently.
8. **Pre-allocate items the user already assigned.** If the user says "Alice got the wine", fill `Assigned To` on that row. Only leave rows blank when the recipient is unknown.
9. **Reconcile the subtotal.** After extracting all items, sum them. If the calculated subtotal does not match the receipt subtotal, stop and ask the user for missing items, quantities, or prices before building the spreadsheet. Do not silently invent prices.
10. **Multiple receipts in one file.** If the user provides multiple receipts in one prompt, create one `.xlsx` with a separate tab per receipt.

## Spreadsheet layout

Each receipt gets one tab with these columns:

| A | B | C |
|---|---|---|
| Item | Price | Assigned To |

Below the item list, add a summary table with one column per person:

| Person | me | alice | bob | carol | ... |
|---|---|---|---|---|
| Subtotal | =SUMIF(...) | ... | ... | ... |
| Tax | =Subtotal / TotalSubtotal * Tax | ... | ... | ... |
| Tip | =Subtotal / TotalSubtotal * Tip | ... | ... | ... |
| Total Owed | =Subtotal + Tax + Tip | ... | ... | ... |

- `Assigned To` is a dropdown matching one of the group names.
- Put the receipt subtotal, tax, tip, and total in a small block at the top-right (e.g., F1:G4).
- `Subtotal` row uses `SUMIF($C$3:$C$N, person, $B$3:$B$N)` for each person.
- `Tax` and `Tip` rows use proportional formulas based on the `Subtotal` row.
- `Total Owed` = Subtotal + Tax + Tip.

## Conditional formatting

Apply a red fill to any data row where `Assigned To` is empty. This makes unassigned items jump out.

## Workflow

1. Extract item names, quantities, prices, and any stated assignments from every receipt in the prompt.
2. Ask for the group of people if not provided.
3. Ask for the restaurant name and/or date for each receipt. Name the output file using the date and one restaurant name (e.g., `2026-07-05-diner.xlsx`).
4. Expand quantities into individual rows.
5. Pre-fill `Assigned To` for any item the user already named a recipient for.
6. Reconcile each receipt's item subtotal against its receipt subtotal. If they do not match, prompt the user for missing items, quantities, or prices. Do not proceed until the subtotal matches (or the user explicitly says to ignore it).
7. Create one `.xlsx` with a tab per receipt. Each tab uses the simple layout above. Leave only truly unassigned items blank.
8. Apply red conditional formatting to unassigned rows.
9. Tell the user: red rows are not yet assigned; once you choose a person, the summary totals update automatically.

## Reference script

A generic generator script lives at `~/.config/opencode/skills/bill-split/build_bill_split.py` (tracked). It reads a JSON config from **stdin** and produces the `.xlsx`. The config shape is defined by `~/.config/opencode/skills/bill-split/schema.json` (JSON Schema Draft 2020-12, tracked) — the script validates against it on every run.

**Never persist a config containing real receipt data.** No receipt JSON files are written to disk, tracked or otherwise. Build the JSON in memory and pipe it in via a heredoc. Real names, restaurants, and prices must never land in a file under this skill (or anywhere on disk beyond the final `.xlsx` the user asked for).

Usage (pipe via stdin; `-` is explicit stdin):
```bash
./build_bill_split.py <<'JSON'
{ ...config... }
JSON
```

A file path arg is supported **only for local fake/test fixtures** (`./build_bill_split.py fixtures/fake.json`). Never use it with real data.

Config shape (see `schema.json` for the authoritative contract):
```json
{
  "people": ["me", "alice", "bob", "carol"],
  "filename": "/home/mike/Documents/2026-07-05-diner.xlsx",
  "date": "2026-07-05",
  "receipts": [
    {
      "title": "Diner",
      "tax": 8.00,
      "tip": 15.00,
      "subtotal": 80.00,
      "items": [
        {"name": "Burger", "price": 18.50},
        {"name": "Fries", "price": 6.00, "assigned": "me"}
      ]
    }
  ]
}
```

Validation enforced by the script:
- JSON Schema (`schema.json`): required fields, types, `minItems`, `date` format.
- Cross-check: every `item.assigned` (if present) must be in `people`.
- Subtotal reconciliation: `sum(item.price)` must equal `receipt.subtotal`.

It uses a Python virtualenv at `~/.config/opencode/skills/bill-split/.venv` with `openpyxl` and `jsonschema` installed:
```bash
./.venv/bin/pip install openpyxl jsonschema
```
