-- 04_fact_time.sql
-- fact_yogurt_time: grain = yogurt product x day of week x hour (prior orders)
-- fact_store_time:  grain = day of week x hour, all orders (traffic baseline)

CREATE OR REPLACE TABLE fact_yogurt_time AS
SELECT
  op.product_id,
  o.order_dow,
  o.order_hour_of_day,
  COUNT(*)                       AS item_purchases,
  SUM(op.reordered)              AS reorders,
  COUNT(*) - SUM(op.reordered)   AS first_purchases
FROM op_prior op
JOIN orders o       USING (order_id)
JOIN products p     USING (product_id)
WHERE p.aisle_id = 120
GROUP BY op.product_id, o.order_dow, o.order_hour_of_day;

CREATE OR REPLACE TABLE fact_store_time AS
SELECT
  order_dow,
  order_hour_of_day,
  COUNT(*) AS orders
FROM orders
WHERE eval_set = 'prior'
GROUP BY order_dow, order_hour_of_day;

-- Check: day-of-week volumes and Fage share of yogurt by day
SELECT
  t.order_dow,
  s.store_orders,
  SUM(t.item_purchases)                                                   AS yogurt_purchases,
  SUM(CASE WHEN dp.is_focus_brand = 1 THEN t.item_purchases ELSE 0 END)   AS fage_purchases,
  ROUND(100.0 * SUM(CASE WHEN dp.is_focus_brand = 1 THEN t.item_purchases ELSE 0 END)
        / SUM(t.item_purchases), 1)                                       AS fage_share_pct
FROM fact_yogurt_time t
JOIN dim_product dp USING (product_id)
JOIN (SELECT order_dow, SUM(orders) AS store_orders
      FROM fact_store_time GROUP BY order_dow) s USING (order_dow)
GROUP BY t.order_dow, s.store_orders
ORDER BY t.order_dow;