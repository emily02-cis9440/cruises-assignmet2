-- Rebuild fact table from the staging table
CREATE OR REPLACE TABLE
  `cruise-assigment1.cruises_assignment2_dw.fact_cruise_prices` AS

SELECT
  -- Surrogate key for the fact table
  ROW_NUMBER() OVER () AS fact_cruise_price_id,

  -- Foreign keys
  s.cruise_id,                         
  s.ship_id,                            
  CAST(FORMAT_DATE('%Y%m%d', s.sail_date) AS INT64) AS date_key, 
  s.suite_bucket,                        

  -- Measures
  s.number_of_nights,
  s.from_price,
  s.brochure_price,
  s.suite_best_price,                  
  s.savings_amount,                      
  s.savings_amount AS suites_savings_amount,

  SAFE_DIVIDE(
    s.savings_amount,
    NULLIF(s.brochure_price, 0)
  ) * 100 AS savings_pct

FROM `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean` AS s
WHERE s.sail_date IS NOT NULL;

SELECT COUNT(*) AS row_count
FROM `cruise-assigment1.cruises_assignment2_dw.fact_cruise_prices`;