/* Retail Sales Analysis */

-- 1. Overall KPIs
SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(sales),2) AS avg_sale
FROM superstore;


-- 2. Sales & profit by category
SELECT
    category,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY category
ORDER BY sales DESC;


-- 3. Best-performing sub-categories
SELECT
    sub_category,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY sub_category
ORDER BY profit DESC;


-- 4. Top 10 products
SELECT
    product_name,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY product_name
ORDER BY sales DESC
LIMIT 10;


-- 5. Regional performance
SELECT
    region,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY region
ORDER BY sales DESC;


-- 6. Top 10 states
SELECT
    state,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY state
ORDER BY sales DESC
LIMIT 10;


-- 7. Customer segments
SELECT
    segment,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY segment
ORDER BY sales DESC;


-- 8. Top customers
SELECT
    customer_name,
    ROUND(SUM(sales),2) AS sales
FROM superstore
GROUP BY customer_name
ORDER BY sales DESC
LIMIT 10;


-- 9. Monthly sales trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY month
ORDER BY month;


-- 10. Annual performance
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY year
ORDER BY year;


-- 11. Discount impact
SELECT
    discount,
    COUNT(*) AS orders,
    ROUND(AVG(sales),2) AS avg_sales,
    ROUND(AVG(profit),2) AS avg_profit
FROM superstore
GROUP BY discount
ORDER BY discount;


-- 12. Shipping mode performance
SELECT
    ship_mode,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY ship_mode
ORDER BY profit DESC;


-- 13. Products with high sales but low profit
SELECT
    product_name,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY product_name
HAVING SUM(sales) > 5000
ORDER BY profit;


-- 14. Profit margin by category
SELECT
    category,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS margin
FROM superstore
GROUP BY category
ORDER BY margin DESC;


-- 15. Rank states by sales
SELECT
    state,
    ROUND(SUM(sales),2) AS sales,
    RANK() OVER(ORDER BY SUM(sales) DESC) AS sales_rank
FROM superstore
GROUP BY state;


-- 16. Running monthly sales
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS sales
    FROM superstore
    GROUP BY month
)
SELECT
    month,
    ROUND(sales,2) AS sales,
    ROUND(SUM(sales) OVER(ORDER BY month),2) AS running_sales
FROM monthly;


-- 17. Top customer in each region
WITH customer_sales AS (
    SELECT
        region,
        customer_name,
        SUM(sales) AS sales
    FROM superstore
    GROUP BY region, customer_name
)
SELECT
    region,
    customer_name,
    ROUND(sales,2) AS sales
FROM (
    SELECT *,
           RANK() OVER(PARTITION BY region ORDER BY sales DESC) AS rnk
    FROM customer_sales
) x
WHERE rnk = 1;


-- 18. Top-selling product in each category
WITH product_sales AS (
    SELECT
        category,
        product_name,
        SUM(sales) AS sales
    FROM superstore
    GROUP BY category, product_name
)
SELECT
    category,
    product_name,
    ROUND(sales,2) AS sales
FROM (
    SELECT *,
           RANK() OVER(PARTITION BY category ORDER BY sales DESC) AS rnk
    FROM product_sales
) x
WHERE rnk = 1;
