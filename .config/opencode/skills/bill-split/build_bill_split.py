#!/usr/bin/env python3
"""Build a simple bill-split .xlsx from a JSON config.

Reads JSON from stdin (or a file path arg for testing with fake data).
Never persist a config containing real receipt data; pipe it in.

    config_json | ./build_bill_split.py
    ./build_bill_split.py - < config.json        # explicit stdin
    ./build_bill_split.py fixtures/fake.json     # local fake data only

The config shape is defined and validated against schema.json (JSON Schema
Draft 2020-12) sitting next to this script. Items without "assigned" are
left blank (red highlight).
"""

import json
import sys
import datetime
from pathlib import Path

from jsonschema import validate, FormatChecker
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment
from openpyxl.utils import get_column_letter
from openpyxl.worksheet.datavalidation import DataValidation
from openpyxl.formatting.rule import FormulaRule

MONEY = '"$"#,##0.00'
SCHEMA_PATH = Path(__file__).resolve().parent / "schema.json"


def make_sheet(
    ws,
    items,
    people,
    tax,
    tip,
    receipt_subtotal,
    title,
    date,
    discount=0,
):
    """Simple layout: Item | Price | Assigned To. Summary below."""
    n = len(people)

    ws["A1"] = f"{title} — {date}"
    ws["A1"].font = Font(bold=True, size=14)
    ws.merge_cells(start_row=1, start_column=1, end_row=1, end_column=3)

    # Receipt totals in top-right
    ws["F1"] = "Subtotal"
    ws["G1"] = receipt_subtotal
    ws["G1"].number_format = MONEY
    ws["F2"] = "Tax"
    ws["G2"] = tax
    ws["G2"].number_format = MONEY
    ws["F3"] = "Tip"
    ws["G3"] = tip
    ws["G3"].number_format = MONEY
    ws["F4"] = "Discount"
    ws["G4"] = discount
    ws["G4"].number_format = MONEY
    ws["F5"] = "Total"
    ws["G5"] = receipt_subtotal + tax + tip - discount
    ws["G5"].number_format = MONEY

    # Header row
    for col, header in enumerate(["Item", "Price", "Assigned To"], 1):
        cell = ws.cell(row=2, column=col, value=header)
        cell.font = Font(bold=True)
        cell.alignment = Alignment(horizontal="center")

    first_data_row = 3
    for i, item in enumerate(items):
        row = first_data_row + i
        ws.cell(row=row, column=1, value=item["name"])
        ws.cell(row=row, column=2, value=item["price"]).number_format = MONEY
        ws.cell(row=row, column=3, value=item.get("assigned", ""))

    last_data_row = first_data_row + len(items) - 1

    # Dropdown for Assigned To
    dv = DataValidation(type="list", formula1=f'"{",".join(people)}"', allow_blank=True)
    dv.error = "Pick a person."
    dv.errorTitle = "Invalid"
    ws.add_data_validation(dv)
    dv.add(f"C{first_data_row}:C{last_data_row}")

    # Red fill for unassigned rows (C empty)
    red_fill = PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid")
    red_font = Font(color="9C0006")
    ws.conditional_formatting.add(
        f"A{first_data_row}:C{last_data_row}",
        FormulaRule(
            formula=[f"$C{first_data_row}=\"\""],
            fill=red_fill,
            font=red_font,
        ),
    )

    # Summary section
    summary_row = last_data_row + 2
    ws.cell(row=summary_row, column=1, value="Person").font = Font(bold=True)
    for p_idx, person in enumerate(people, 2):
        ws.cell(row=summary_row, column=p_idx, value=person).font = Font(bold=True)

    ws.cell(row=summary_row + 1, column=1, value="Subtotal").font = Font(bold=True)
    ws.cell(row=summary_row + 2, column=1, value="Tax").font = Font(bold=True)
    ws.cell(row=summary_row + 3, column=1, value="Tip").font = Font(bold=True)
    ws.cell(row=summary_row + 4, column=1, value="Discount").font = Font(bold=True)
    ws.cell(row=summary_row + 5, column=1, value="Total Owed").font = Font(bold=True)

    subtotal_row = summary_row + 1
    tax_row = summary_row + 2
    tip_row = summary_row + 3
    discount_row = summary_row + 4
    total_row = summary_row + 5

    for p_idx, person in enumerate(people, 2):
        col_letter = get_column_letter(p_idx)
        ws.cell(
            row=subtotal_row,
            column=p_idx,
            value=f"=SUMIF($C${first_data_row}:$C${last_data_row},\"{person}\",$B${first_data_row}:$B${last_data_row})",
        ).number_format = MONEY

        ws.cell(
            row=tax_row,
            column=p_idx,
            value=f"=IFERROR({col_letter}{subtotal_row}/SUM($B${subtotal_row}:${get_column_letter(1+n)}${subtotal_row})*$G$2,0)",
        ).number_format = MONEY
        ws.cell(
            row=tip_row,
            column=p_idx,
            value=f"=IFERROR({col_letter}{subtotal_row}/SUM($B${subtotal_row}:${get_column_letter(1+n)}${subtotal_row})*$G$3,0)",
        ).number_format = MONEY
        ws.cell(
            row=discount_row,
            column=p_idx,
            value=f"=IFERROR({col_letter}{subtotal_row}/SUM($B${subtotal_row}:${get_column_letter(1+n)}${subtotal_row})*$G$4,0)",
        ).number_format = MONEY
        ws.cell(
            row=total_row,
            column=p_idx,
            value=f"={col_letter}{subtotal_row}+{col_letter}{tax_row}+{col_letter}{tip_row}-{col_letter}{discount_row}",
        ).number_format = MONEY
        ws.cell(row=total_row, column=p_idx).font = Font(bold=True)

    # Column widths
    ws.column_dimensions["A"].width = 40
    ws.column_dimensions["B"].width = 10
    ws.column_dimensions["C"].width = 12
    for col in range(2, 2 + n):
        ws.column_dimensions[get_column_letter(col)].width = 12

    ws.freeze_panes = "A3"


def load_schema():
    with open(SCHEMA_PATH) as f:
        return json.load(f)


def validate_config(config):
    validate(instance=config, schema=load_schema(), format_checker=FormatChecker())
    # ponytail: "assigned must be in people" is a cross-field rule JSON Schema
    # can't express without non-standard $data refs; checked here instead.
    people = set(config["people"])
    for receipt in config["receipts"]:
        for item in receipt["items"]:
            assigned = item.get("assigned")
            if assigned is not None and assigned not in people:
                raise ValueError(
                    f"{receipt['title']}: item {item['name']!r} assigned to "
                    f"{assigned!r}, who is not in people {sorted(people)}"
                )


def build(config):
    validate_config(config)
    people = config["people"]
    filename = config["filename"]
    date = config.get("date", datetime.date.today().isoformat())

    wb = Workbook()
    first = True
    for receipt in config["receipts"]:
        items = receipt["items"]
        expected = receipt["subtotal"]
        calculated = sum(item["price"] for item in items)
        if round(calculated, 2) != round(expected, 2):
            raise ValueError(
                f"{receipt['title']} subtotal mismatch: calculated ${calculated:.2f}, receipt ${expected:.2f}"
            )

        if first:
            ws = wb.active
            ws.title = receipt["title"]
            first = False
        else:
            ws = wb.create_sheet(title=receipt["title"])

        make_sheet(
            ws,
            items,
            people,
            tax=receipt["tax"],
            tip=receipt["tip"],
            receipt_subtotal=receipt["subtotal"],
            title=receipt["title"],
            date=date,
            discount=receipt.get("discount", 0),
        )

    wb.save(filename)
    print(f"Saved {filename}")


if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] == "-":
        raw = sys.stdin.read()
    else:
        with open(sys.argv[1]) as f:
            raw = f.read()
    config = json.loads(raw)
    build(config)
