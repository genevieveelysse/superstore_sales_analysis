-- Sales by Category
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Profit by Category
SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- High Sales, Low Profit Products
SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name
HAVING SUM(sales) > 5000
ORDER BY total_profit ASC;

-- Loss-Making Products
SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_loss
FROM superstore
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_loss;

-- Top States by Sales
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

-- Least Profitable States
SELECT
    state,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_profit
LIMIT 10;

-- Sales by Customer Segment
SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;

-- Top Customers
SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Discount vs Profit
SELECT
    discount,
    ROUND(AVG(profit),2) AS average_profit,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY discount
ORDER BY discount;

-- Profit by Shipping Mode
SELECT
    ship_mode,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY ship_mode
ORDER BY total_profit DESC;

-- Sales and Profit by Sub-Category
SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

-- Regional Performance
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

-- Highest Discount Orders
SELECT
    order_id,
    customer_name,
    discount,
    sales,
    profit
FROM superstore
ORDER BY discount DESC, sales DESC;

-- Profit Margin by Category
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percent
FROM superstore
GROUP BY category
ORDER BY profit_margin_percent DESC;

-- Annual Sales Performance
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY year
ORDER BY year;



