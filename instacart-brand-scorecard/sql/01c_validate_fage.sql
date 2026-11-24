SELECT p.product_id,
       p.product_name,
       COUNT(*)                          AS item_purchases,
       ROUND(100.0 * AVG(o.reordered),1) AS reorder_rate_pct
FROM products p
JOIN op_prior o USING (product_id)
WHERE p.aisle_id = 120
  AND (p.product_name ILIKE 'Total %' OR p.product_name ILIKE '%fage%')
GROUP BY p.product_id, p.product_name
ORDER BY item_purchases DESC;