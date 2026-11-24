-- 06_probable_fage_check.sql
-- Uses basket lift to surface yogurt products likely belonging to the focus brand
-- but missed by keyword attribution.

SELECT
  dp.product_id,
  dp.product_name,
  dp.brand,
  f.item_purchases,
  ROUND(100.0 * f.reorders / f.item_purchases, 1)                                    AS reorder_rate_pct,
  b.co_orders,
  ROUND(100.0 * b.co_orders / f.item_purchases, 1)                                   AS pct_orders_with_fage,
  ROUND((b.co_orders * 1.0 / b.focus_orders) / (b.item_orders * 1.0 / b.total_orders), 2) AS lift
FROM fact_basket_product b
JOIN dim_product dp  USING (product_id)
JOIN fact_product f  USING (product_id)
WHERE dp.aisle_id = 120
ORDER BY lift DESC
LIMIT 20;