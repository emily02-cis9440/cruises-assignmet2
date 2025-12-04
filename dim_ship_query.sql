CREATE OR REPLACE TABLE `cruise-assigment1.cruises_assignment2_dw.dim_ship` AS
SELECT
  ship_id,
  ship_name,
  cruise_line,
  home_port,
  'Unknown' AS region,
  'Unknown' AS ship_class
FROM (
  SELECT DISTINCT
    ship_id,
    ship_name,
    cruise_line,
    home_port
  FROM `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean`
);

SELECT COUNT(*) AS row_count
FROM `cruise-assigment1.cruises_assignment2_dw.dim_ship`;