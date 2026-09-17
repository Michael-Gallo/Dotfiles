---
name: bill-split
description: Use when the user wants to split a restaurant bill, receipt, or group tab among people. Triggers on "bill split", "split the bill", "who owes what", "split receipt", "divide bill", "track who owes me". Builds a simple .xlsx spreadsheet where each line item is tagged to exactly one person, with red highlighting on unassigned items. Never uses a "shared" column; every item is assigned to one person.
---

# Bill Split

Turn receipts into a shareable `.xlsx`. Each line item belongs to exactly one person.

## Rules

1. Parse every receipt in the prompt (images and text) before asking anything.
2. Ask once for whatever is missing: group names, date, restaurant name(s). Do not ask these in separate turns.
3. Lowercase names. Pre-fill `Assigned To` when the user already named a recipient.
4. One item per row. Split qty lines (`2 Mojitos $26` → two `$13` Mojito rows); if one person takes the whole qty line, one row at the line total (`12 $1 oysters $12` → one `$12.00` row). Fold $0 modifiers into the parent item's name (`Tuscan Chicken Sandwich`), never their own rows. Round each split to cents; leftover penny goes on the last row.
5. No shared items. If two people split something, make two rows at half price and assign one to each.
6. Reconcile: `sum(item prices)` must equal the receipt subtotal. Stop and ask if they differ. Do not invent prices. Discounts go in `discount`, not as negative line items.
7. Tax, tip, and discount split proportionally by each person's subtotal. For a discount the payer brings (credit bought below face, comps): `discount` = pct × what the payer actually covered — anything paid outside it (e.g. a separately-paid tip) keeps full value. State that assumption in one line in your reply.
8. Multiple receipts → one file, one tab per receipt.
9. Write to `~/Documents/YYYY-MM-DD-restaurant.xlsx` (lowercase). If that file exists, ask before overwriting.

## Build

Always run the existing script with the venv. Never write a one-off generator. Never write the JSON to disk — pipe it via stdin.

```bash
~/.config/opencode/skills/bill-split/.venv/bin/python \
  ~/.config/opencode/skills/bill-split/build_bill_split.py <<'JSON'
{
  "people": ["me", "alice", "bob"],
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
JSON
```

Schema: `schema.json`. Fake fixture only: `fixtures/fake.json`.

venv: `~/.config/opencode/skills/bill-split/.venv` (`openpyxl`, `jsonschema`). Recreate with `.venv/bin/pip install openpyxl jsonschema` if missing.

Red rows are unassigned. Person totals ignore them, so they will not match the receipt until every row has a name. Changing the dropdown updates the summary.
