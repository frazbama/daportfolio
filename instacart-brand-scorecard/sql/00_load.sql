CREATE OR REPLACE TABLE aisles      AS SELECT * FROM read_csv_auto('data/raw/aisles.csv');
CREATE OR REPLACE TABLE departments AS SELECT * FROM read_csv_auto('data/raw/departments.csv');
CREATE OR REPLACE TABLE products    AS SELECT * FROM read_csv_auto('data/raw/products.csv');
CREATE OR REPLACE TABLE orders      AS SELECT * FROM read_csv_auto('data/raw/orders.csv');
CREATE OR REPLACE TABLE op_prior    AS SELECT * FROM read_csv_auto('data/raw/order_products__prior.csv');
CREATE OR REPLACE TABLE op_train    AS SELECT * FROM read_csv_auto('data/raw/order_products__train.csv');

SELECT 'op_prior' AS tbl, COUNT(*) AS row_count FROM op_prior
UNION ALL SELECT 'op_train', COUNT(*) FROM op_train
UNION ALL SELECT 'orders',   COUNT(*) FROM orders
UNION ALL SELECT 'products', COUNT(*) FROM products;

SELECT aisle_id, aisle FROM aisles WHERE aisle ILIKE '%yogurt%';