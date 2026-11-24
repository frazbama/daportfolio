-- 07_export.sql
-- Exports the star-schema tables for Power BI (CSV, with headers).
-- Output folder data/model is git-ignored; raw/derived data is not redistributed.

COPY dim_product          TO 'data/model/dim_product.csv'          (HEADER, DELIMITER ',');
COPY aisles               TO 'data/model/dim_aisle.csv'            (HEADER, DELIMITER ',');
COPY departments          TO 'data/model/dim_department.csv'       (HEADER, DELIMITER ',');
COPY brand_map            TO 'data/model/brand_map.csv'            (HEADER, DELIMITER ',');
COPY fact_product         TO 'data/model/fact_product.csv'         (HEADER, DELIMITER ',');
COPY fact_yogurt_time     TO 'data/model/fact_yogurt_time.csv'     (HEADER, DELIMITER ',');
COPY fact_store_time      TO 'data/model/fact_store_time.csv'      (HEADER, DELIMITER ',');
COPY fact_basket_product  TO 'data/model/fact_basket_product.csv'  (HEADER, DELIMITER ',');
COPY fact_basket_aisle    TO 'data/model/fact_basket_aisle.csv'    (HEADER, DELIMITER ',');

-- Check: row counts of exported tables
SELECT 'dim_product' AS tbl, COUNT(*) AS rows_exported FROM dim_product
UNION ALL SELECT 'fact_product',        COUNT(*) FROM fact_product
UNION ALL SELECT 'fact_yogurt_time',    COUNT(*) FROM fact_yogurt_time
UNION ALL SELECT 'fact_store_time',     COUNT(*) FROM fact_store_time
UNION ALL SELECT 'fact_basket_product', COUNT(*) FROM fact_basket_product
UNION ALL SELECT 'fact_basket_aisle',   COUNT(*) FROM fact_basket_aisle
UNION ALL SELECT 'brand_map',           COUNT(*) FROM brand_map;