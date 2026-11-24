-- 05_fact_basket.sql (v2, brand-agnostic)
-- Co-occurrence of other products / aisles with EACH named yogurt brand.
-- Raw counts stored; lift calculated in DAX:
-- Lift = (co_orders / brand_orders) / (item_orders / total_orders)
-- A brand's own products are excluded from its co-occurrence counts.

CREATE OR REPLACE TABLE brand_order_list AS
SELECT DISTINCT dp.brand, op.order_id
FROM op_prior op
JOIN dim_product dp USING (product_id)
WHERE dp.aisle_id = 120
  AND dp.brand <> 'Unattributed';

-- Product level
CREATE OR REPLACE TABLE fact_basket_product AS
WITH totals AS (
  SELECT COUNT(DISTINCT order_id) AS total_orders FROM op_prior
),
brand_tot AS (
  SELECT brand, COUNT(*) AS brand_orders FROM brand_order_list GROUP BY brand
),
co AS (
  SELECT bo.brand, op.product_id, COUNT(*) AS co_orders
  FROM brand_order_list bo
  JOIN op_prior op    USING (order_id)
  JOIN dim_product dp USING (product_id)
  WHERE dp.brand <> bo.brand
  GROUP BY bo.brand, op.product_id
)
SELECT co.brand,
       co.product_id,
       co.co_orders,
       f.item_purchases AS item_orders,
       bt.brand_orders,
       t.total_orders
FROM co
JOIN fact_product f USING (product_id)
JOIN brand_tot bt   USING (brand)
CROSS JOIN totals t
WHERE co.co_orders >= 50;

-- Aisle level
CREATE OR REPLACE TABLE fact_basket_aisle AS
WITH totals AS (
  SELECT COUNT(DISTINCT order_id) AS total_orders FROM op_prior
),
brand_tot AS (
  SELECT brand, COUNT(*) AS brand_orders FROM brand_order_list GROUP BY brand
),
aisle_all AS (
  SELECT aisle_id, COUNT(*) AS item_orders
  FROM (SELECT DISTINCT op.order_id, dp.aisle_id
        FROM op_prior op JOIN dim_product dp USING (product_id))
  GROUP BY aisle_id
),
yog AS (
  SELECT DISTINCT op.order_id, dp.brand
  FROM op_prior op JOIN dim_product dp USING (product_id)
  WHERE dp.aisle_id = 120
),
yog_other AS (
  SELECT b.brand, COUNT(DISTINCT y.order_id) AS item_orders
  FROM brand_tot b
  JOIN yog y ON y.brand <> b.brand
  GROUP BY b.brand
),
co AS (
  SELECT bo.brand, dp.aisle_id, COUNT(DISTINCT bo.order_id) AS co_orders
  FROM brand_order_list bo
  JOIN op_prior op    USING (order_id)
  JOIN dim_product dp USING (product_id)
  WHERE dp.brand <> bo.brand
  GROUP BY bo.brand, dp.aisle_id
)
SELECT co.brand,
       co.aisle_id,
       co.co_orders,
       CASE WHEN co.aisle_id = 120 THEN yo.item_orders ELSE aa.item_orders END AS item_orders,
       bt.brand_orders,
       t.total_orders
FROM co
JOIN aisle_all aa      USING (aisle_id)
JOIN brand_tot bt      USING (brand)
LEFT JOIN yog_other yo USING (brand)
CROSS JOIN totals t;

-- Check 1: orders per brand (Fage should be 231,495)
SELECT DISTINCT brand, brand_orders, total_orders,
       ROUND(100.0 * brand_orders / total_orders, 2) AS penetration_pct
FROM fact_basket_aisle
ORDER BY brand_orders DESC;

-- Check 2: top 3 aisles by lift for each brand (min 500 co-orders)
SELECT brand, aisle, co_orders, lift
FROM (
  SELECT b.brand, a.aisle, b.co_orders,
         ROUND((b.co_orders * 1.0 / b.brand_orders) / (b.item_orders * 1.0 / b.total_orders), 2) AS lift,
         ROW_NUMBER() OVER (PARTITION BY b.brand
                            ORDER BY (b.co_orders * 1.0 / b.brand_orders) / (b.item_orders * 1.0 / b.total_orders) DESC) AS rn
  FROM fact_basket_aisle b
  JOIN aisles a USING (aisle_id)
  WHERE b.co_orders >= 500
)
WHERE rn <= 3
ORDER BY brand, rn;