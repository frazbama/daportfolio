-- 06b_fage_benchmark.sql
-- Benchmark: for confirmed Fage products, % of their orders containing ANOTHER Fage product.
-- Compared against the 72-89% seen for the five suspected products.

WITH fage_order_counts AS (
  SELECT op.order_id, COUNT(*) AS fage_items
  FROM op_prior op
  JOIN dim_product dp USING (product_id)
  WHERE dp.is_focus_brand = 1
  GROUP BY op.order_id
)
SELECT
  dp.product_name,
  f.item_purchases,
  ROUND(100.0 * SUM(CASE WHEN c.fage_items >= 2 THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_orders_with_other_fage
FROM op_prior op
JOIN dim_product dp       USING (product_id)
JOIN fact_product f       USING (product_id)
JOIN fage_order_counts c  USING (order_id)
WHERE dp.is_focus_brand = 1
GROUP BY dp.product_name, f.item_purchases
ORDER BY f.item_purchases DESC;