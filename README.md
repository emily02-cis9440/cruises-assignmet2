# cruises-assignmet2

CIS 9440 – Assignment 2: Cruise Data Warehouse

## BigQuery Dataset

Project: `cruise-assignment1`  
Dataset: `cruises_assignment2_dw`

## Tables

- `stg_cruises_clean` – cleaned staging table from `cruises_raw`
- `dim_cruise` – cruise-level dimension
- `dim_date` – date dimension (sail date, year, month, week, season)
- `dim_ship` – ship / line / region dimension
- `dim_suite` – suite pricing dimension
- `fact_cruise_prices` – fact table with prices, savings and keys

## How to run

1. Open BigQuery in the **cruise-assignment1** project.
2. For each file in this repo:
   - Copy the SQL into a new query.
   - Run it to (re)create the corresponding table in `cruises_assignment2_dw`.
3. Use the `fact_cruise_prices` and dimension tables for reporting/analysis.
