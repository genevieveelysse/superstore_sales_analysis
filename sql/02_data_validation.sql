-- Check total number or records
SELECT COUNT(*) AS total_records
FROM superstore;

-- Preview the dataset
SELECT *
FROM superstore
LIMIT 10;

-- Check for missing values
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM superstore;

-- Check duplicate Order IDs
SELECT
    order_id,
    COUNT(*)
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Check categories
SELECT DISTINCT category
FROM superstore
ORDER BY category;

-- Check sub-categories
SELECT DISTINCT sub_category
FROM superstore
ORDER BY sub_category;

-- Check regions
SELECT DISTINCT region
FROM superstore;

-- Check ship modes
SELECT DISTINCT ship_mode
FROM superstore;

-- Find negative profits
SELECT *
FROM superstore
WHERE profit < 0
ORDER BY profit;

