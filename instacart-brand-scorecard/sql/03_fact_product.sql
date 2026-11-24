-- 03_fact_product.sql
-- Grain: one row per product (prior orders only).
-- Stores additive sums/counts so DAX can compute weighted averages at any level.

CREATE OR REPLACE TABLE fact_product AS
SELECT
  op.product_id,
  COUNT(*)                              AS item_purchases,
  SUM(op.reordered)                     AS reorders,
  COUNT(*) - SUM(op.reordered)          AS first_purchases,
  COUNT(DISTINCT o.user_id)             AS buyers,
  SUM(op.add_to_cart_order)             AS sum_cart_position,
  SUM(o.days_since_prior_order)         AS sum_days_since_prior,
  COUNT(o.days_since_prior_order)       AS n_days_since_prior
FROM op_prior op
JOIN orders o USING (order_id)
GROUP BY op.product_id;

-- Check: yogurt brands from the fact table
SELECT
  dp.brand,
  SUM(f.item_purchases)                                          AS item_purchases,
  SUM(f.buyers)                                                  AS buyers_summed,
  ROUND(SUM(f.item_purchases) * 1.0 / SUM(f.buyers), 2)          AS purchases_per_buyer,
  ROUND(100.0 * SUM(f.first_purchases) / SUM(f.item_purchases), 1) AS first_purchase_pct,
  ROUND(SUM(f.sum_cart_position) * 1.0 / SUM(f.item_purchases), 1) AS avg_cart_position,
  ROUND(SUM(f.sum_days_since_prior) / SUM(f.n_days_since_prior), 1) AS avg_days_since_prior
FROM fact_product f
JOIN dim_product dp USING (product_id)
WHERE dp.aisle_id = 120
GROUP BY dp.brand
ORDER BY item_purchases DESC;