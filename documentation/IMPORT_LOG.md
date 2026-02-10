# Import Log (MySQL) – Grocery Sales Project

**Date:** 2026-02-10  
**Database:** grocery_sales  
**Tools:** MySQL Workbench, VS Code (SQLTools)

## Imported tables
- categories
- countries
- cities
- customers
- employees
- products
- sales

## Row counts after import
| Table | Rows | Notes |
|------|------:|------|
| categories | [11 ] |  |
| countries | [206 ] |  |
| cities | [ 96] |  |
| customers | [ 98685] | Import Wizard was slow but completed |
| employees | [23 ] | Dates imported successfully |
| products | [ 452] |  |
| sales | [6555645 ] | Imported using `LOAD DATA LOCAL INFILE` |

## Issues & fixes
- `sales.csv` (~500MB) was too slow to import via Table Data Import Wizard.
- Used `LOAD DATA LOCAL INFILE` for fast import.
- Encountered Workbench security restriction (Error 2068) → enabled LOCAL INFILE in Workbench connection settings.