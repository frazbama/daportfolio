WITH yp AS (
  SELECT p.product_id, p.product_name
  FROM products p
  WHERE p.aisle_id = 120
),
tagged AS (
  SELECT *,
    CASE
      WHEN product_name ILIKE '%chobani%'     THEN 'Chobani'
      WHEN product_name ILIKE '%fage%'        THEN 'Fage'
      WHEN product_name ILIKE '%stonyfield%'  THEN 'Stonyfield'
      WHEN product_name ILIKE '%oikos%'       THEN 'Oikos'
      WHEN product_name ILIKE '%activia%'     THEN 'Activia'
      WHEN product_name ILIKE '%dannon%'      THEN 'Dannon'
      WHEN product_name ILIKE '%yoplait%'     THEN 'Yoplait'
      WHEN product_name ILIKE '%siggi%'       THEN 'Siggi''s'
      WHEN product_name ILIKE '%noosa%'       THEN 'Noosa'
      WHEN product_name ILIKE '%brown cow%'   THEN 'Brown Cow'
      WHEN product_name ILIKE '%wallaby%'     THEN 'Wallaby'
      WHEN product_name ILIKE '%greek gods%'  THEN 'The Greek Gods'
      ELSE 'Other / Unmatched'
    END AS brand
  FROM yp
)
SELECT
  t.brand,
  COUNT(DISTINCT t.product_id)                          AS products,
  COUNT(*)                                              AS item_purchases,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)    AS share_of_aisle_pct,
  ROUND(100.0 * AVG(o.reordered), 1)                    AS reorder_rate_pct,
  ROUND(AVG(o.add_to_cart_order), 1)                    AS avg_cart_position
FROM tagged t
JOIN op_prior o USING (product_id)
GROUP BY t.brand
ORDER BY item_purchases DESC;