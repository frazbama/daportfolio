-- 02_brand_map.sql (v2)
-- Brand attribution for the yogurt aisle (aisle_id 120).
-- Product names mostly omit brand, so brands are inferred from product-line
-- keywords verified against retailer listings (High), or from keyword /
-- basket-behaviour evidence (Medium). Lower priority number wins.
-- v2: adds five basket-inferred Fage products (lift > 10, 72-89% of orders
--     contain Fage, matching the 65-83% benchmark for confirmed Fage flavoured cups)
--     and a flavour_type attribute.

CREATE OR REPLACE TABLE brand_map AS
SELECT * FROM (VALUES
  ( 1, 'Fage',           'High',   'Total %'),
  ( 2, 'Fage',           'High',   '%fage%'),
  ( 3, 'Siggi''s',       'High',   '%icelandic%'),
  ( 4, 'Siggi''s',       'High',   '%siggi%'),
  ( 5, 'Stonyfield',     'High',   '%yokids%'),
  ( 6, 'Stonyfield',     'High',   '%yobaby%'),
  ( 7, 'Stonyfield',     'High',   '%yotot%'),
  ( 8, 'Stonyfield',     'High',   '%stonyfield%'),
  ( 9, 'Noosa',          'High',   '%yoghurt%'),
  (10, 'Noosa',          'High',   '%noosa%'),
  (11, 'Oikos',          'High',   '%oikos%'),
  (12, 'Activia',        'High',   '%activia%'),
  (13, 'Dannon',         'High',   '%dannon%'),
  (14, 'Chobani',        'High',   '%chobani%'),
  (15, 'Yoplait',        'High',   '%yoplait%'),
  (16, 'Wallaby',        'High',   '%wallaby%'),
  (17, 'Brown Cow',      'High',   '%brown cow%'),
  (18, 'The Greek Gods', 'High',   '%greek gods%'),
  (20, 'Siggi''s',       'Medium', '%skyr%'),
  (21, 'Siggi''s',       'Medium', '%strained low-fat, coconut%'),
  (22, 'Fage',           'Medium', 'Blackberry Yogurt'),
  (23, 'Fage',           'Medium', 'Pineapple Yogurt 2%'),
  (24, 'Fage',           'Medium', 'Fat Free Blueberry Yogurt'),
  (25, 'Fage',           'Medium', 'Cherry Pomegranate Greek Yogurt'),
  (26, 'Fage',           'Medium', 'Fat Free Strawberry Yogurt')
) AS t(priority, brand, confidence, pattern);

CREATE OR REPLACE TABLE dim_product AS
WITH matches AS (
  SELECT p.product_id,
         m.brand,
         m.confidence,
         ROW_NUMBER() OVER (PARTITION BY p.product_id ORDER BY m.priority) AS rn
  FROM products p
  JOIN brand_map m ON p.product_name ILIKE m.pattern
  WHERE p.aisle_id = 120
)
SELECT p.product_id,
       p.product_name,
       p.aisle_id,
       a.aisle,
       p.department_id,
       d.department,
       CASE WHEN p.aisle_id = 120 THEN COALESCE(m.brand, 'Unattributed')
            ELSE 'n/a (other aisle)' END                                   AS brand,
       CASE WHEN p.aisle_id = 120 THEN COALESCE(m.confidence, 'None')
            ELSE 'n/a' END                                                 AS brand_confidence,
       CASE WHEN m.brand = 'Fage' THEN 1 ELSE 0 END                        AS is_focus_brand,
       CASE
         WHEN p.aisle_id <> 120 THEN 'n/a'
         WHEN p.product_name ILIKE '%plain%' THEN 'Plain'
         WHEN regexp_matches(lower(p.product_name),
              'berr|cherr|peach|honey|mango|lime|lemon|pomegranate|acai|apple|pineapple|vanilla|coconut|banana|chocolate|caramel|orange|ginger|passion|guanabana|maple|coffee|pumpkin|fig|apricot|pear|rhubarb|smoothie|fruit|nana')
           THEN 'Flavoured'
         ELSE 'Plain'
       END                                                                 AS flavour_type
FROM products p
JOIN aisles a       USING (aisle_id)
JOIN departments d  USING (department_id)
LEFT JOIN matches m ON m.product_id = p.product_id AND m.rn = 1;

-- Check: Fage by confidence and flavour type
SELECT dp.brand_confidence,
       dp.flavour_type,
       COUNT(DISTINCT dp.product_id)                                   AS products,
       SUM(f.item_purchases)                                           AS item_purchases,
       ROUND(100.0 * SUM(f.item_purchases) / 1452343, 1)               AS share_of_aisle_pct,
       ROUND(100.0 * SUM(f.reorders) / SUM(f.item_purchases), 1)       AS reorder_rate_pct
FROM dim_product dp
JOIN fact_product f USING (product_id)
WHERE dp.is_focus_brand = 1
GROUP BY dp.brand_confidence, dp.flavour_type
ORDER BY dp.brand_confidence, dp.flavour_type;