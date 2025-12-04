CREATE OR REPLACE TABLE `cruise-assigment1.cruises_assignment2_dw.dim_cruise` AS
SELECT DISTINCT
  cruise_id,
  special_type,
  number_of_nights,
  suite_bucket,
  from_price,
  brochure_price
FROM `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean`;

SELECT COUNT(*) AS row_count
FROM `cruise-assigment1.cruises_assignment2_dw.dim_cruise`;