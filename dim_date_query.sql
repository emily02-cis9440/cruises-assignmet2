CREATE OR REPLACE TABLE
  `cruise-assigment1.cruises_assignment2_dw.dim_date` AS

SELECT
  CAST(FORMAT_DATE('%Y%m%d', sail_date) AS INT64) AS date_key,
  sail_date,
  EXTRACT(YEAR  FROM sail_date) AS sail_year,
  EXTRACT(MONTH FROM sail_date) AS sail_month,
  EXTRACT(WEEK  FROM sail_date) AS sail_week,
  FORMAT_DATE('%A', sail_date)  AS sail_day_of_week,
  CASE
    WHEN EXTRACT(MONTH FROM sail_date) IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM sail_date) IN (3, 4, 5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM sail_date) IN (6, 7, 8) THEN 'Summer'
    ELSE 'Fall'
  END AS season
FROM `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean`
WHERE sail_date IS NOT NULL
GROUP BY
  date_key, sail_date, sail_year, sail_month,
  sail_week, sail_day_of_week, season
ORDER BY sail_date;

SELECT COUNT(*) AS row_count
FROM `cruise-assigment1.cruises_assignment2_dw.dim_date`;