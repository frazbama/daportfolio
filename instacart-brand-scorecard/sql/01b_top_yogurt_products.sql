SELECT p.product_name,
       COUNT(*) AS item_purchases
FROM products p
JOIN op_prior o USING (product_id)
WHERE p.aisle_id = 120
GROUP BY p.product_name
ORDER BY item_purchases DESC
LIMIT 40;