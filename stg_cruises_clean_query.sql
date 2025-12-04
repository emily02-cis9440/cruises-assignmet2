-- Rebuild staging table from cruises_raw
CREATE OR REPLACE TABLE
  `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean` AS

WITH cleaned AS (
  SELECT
    -- Surrogate key
    ROW_NUMBER() OVER ()                      AS cruise_id,

    -- Ship / line info
    CAST(vesselId AS INT64)                   AS ship_id,
    vesselName                                AS ship_name,
    cruiseLineName                            AS cruise_line,
    departurePort                             AS home_port,

    -- Cruise / pricing
    numberOfNights                            AS number_of_nights,
    specialType                               AS special_type,
    suiteBestPriceDTOBucket                   AS suite_bucket,
    SAFE_CAST(fromPrice          AS NUMERIC)  AS from_price,
    SAFE_CAST(brochurePrice      AS NUMERIC)  AS brochure_price,
    SAFE_CAST(savings            AS NUMERIC)  AS savings_amount,
    SAFE_CAST(suiteBestPriceDTOPrice AS NUMERIC) AS suite_best_price,

    sailingDates,

    -- Robust parsing for the FIRST sailing date we see in sailingDates
    COALESCE(
      -- 2025-01-15 style
      SAFE.PARSE_DATE(
        '%Y-%m-%d',
        REGEXP_EXTRACT(sailingDates, r'(\d{4}-\d{2}-\d{2})')
      ),
      -- 1/15/2025 or 01/15/2025 style
      SAFE.PARSE_DATE(
        '%m/%d/%Y',
        REGEXP_EXTRACT(sailingDates, r'(\d{1,2}/\d{1,2}/\d{4})')
      ),
      -- Jan 15, 2025 style
      SAFE.PARSE_DATE(
        '%b %e, %Y',
        REGEXP_EXTRACT(sailingDates, r'([A-Za-z]{3} \d{1,2}, \d{4})')
      ),
      -- January 15, 2025 style
      SAFE.PARSE_DATE(
        '%B %e, %Y',
        REGEXP_EXTRACT(sailingDates, r'([A-Za-z]+ \d{1,2}, \d{4})')
      )
    ) AS sail_date
  FROM `cruise-assigment1.cruises_assignment2_dw.cruises_raw`
)

SELECT *
FROM cleaned
WHERE from_price     IS NOT NULL
  AND brochure_price IS NOT NULL;

  SELECT
  COUNT(*)                            AS total_rows,
  COUNTIF(sail_date IS NOT NULL)      AS non_null_dates,
  COUNTIF(sail_date IS NULL)          AS null_dates
FROM `cruise-assigment1.cruises_assignment2_dw.stg_cruises_clean`;