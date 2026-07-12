-- Calculate total sales 
SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore;

-- Calculate total profit
SELECT
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore;

-- Count unique orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

-- Count unique customers 
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM superstore;

-- Calculate average sales amount 
SELECT
    ROUND(AVG(sales),2) AS average_sales
FROM superstore;

-- Sales by product category 
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Profit by category 
SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- Sales by sub-category 
SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Profit by sub-category 
SELECT
    sub_category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

-- Sales by region 
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Profit by region
SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

-- Top states by sales
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

-- Monthly sales trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;

-- Monthly profit trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY month
ORDER BY month;

-- Top customers by sales
SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top products by sales
SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Average discount by category
SELECT
    category,
    ROUND(AVG(discount),2) AS average_discount
FROM superstore
GROUP BY category
ORDER BY average_discount DESC;

-- Number of orders by shipping mode
SELECT
    ship_mode,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;

