CREATE OR REPLACE TABLE
  `cruise-assigment1.cruises_assignment2_dw.dim_suite` AS
WITH suite_stats AS (
  SELECT
    suite_bucket,
    MIN(from_price)                                    AS suite_best_price,
    AVG(brochure_price - from_price)                   AS suite_savings_amount,
    AVG(
      SAFE_DIVIDE(brochure_price - from_price,
                  NULLIF(brochure_price, 0))
    ) * 100                                            AS suite_savings_pct
  FROM `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean`
  WHERE suite_bucket IS NOT NULL
  GROUP BY suite_bucket
)
SELECT *
FROM suite_stats;

SELECT COUNT(*) AS row_count
FROM `cruise-assigment1.cruises_assignment2_dw.dim_suite`;