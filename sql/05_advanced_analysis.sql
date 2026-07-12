-- 1. Rank states by total sales
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM superstore
GROUP BY state
ORDER BY sales_rank;

-- 2. Top customer in each region
WITH customer_sales AS (
    SELECT
        region,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY region, customer_name
)
SELECT
    region,
    customer_name,
    ROUND(total_sales,2) AS total_sales
FROM (
    SELECT *,
           RANK() OVER(PARTITION BY region ORDER BY total_sales DESC) AS rnk
    FROM customer_sales
) ranked
WHERE rnk = 1;

-- 3. Running monthly sales
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS monthly_sales
    FROM superstore
    GROUP BY month
)
SELECT
    month,
    ROUND(monthly_sales,2) AS monthly_sales,
    ROUND(SUM(monthly_sales) OVER(ORDER BY month),2) AS cumulative_sales
FROM monthly_sales;

-- 4. Running monthly profit
WITH monthly_profit AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(profit) AS monthly_profit
    FROM superstore
    GROUP BY month
)
SELECT
    month,
    ROUND(monthly_profit,2) AS monthly_profit,
    ROUND(SUM(monthly_profit) OVER(ORDER BY month),2) AS cumulative_profit
FROM monthly_profit;

-- 5. Year-over-year sales
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY year
)
SELECT
    year,
    ROUND(total_sales,2) AS total_sales,
    ROUND(LAG(total_sales) OVER(ORDER BY year),2) AS previous_year_sales,
    ROUND(total_sales - LAG(total_sales) OVER(ORDER BY year),2) AS sales_growth
FROM yearly_sales;

-- 6. Profit margin by state
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percent
FROM superstore
GROUP BY state
ORDER BY profit_margin_percent DESC;

-- 7. Best-selling product in each category
WITH product_sales AS (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY category, product_name
)
SELECT
    category,
    product_name,
    ROUND(total_sales,2) AS total_sales
FROM (
    SELECT *,
           RANK() OVER(PARTITION BY category ORDER BY total_sales DESC) AS rnk
    FROM product_sales
) ranked
WHERE rnk = 1;

-- 8. Average order value by customer
SELECT
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM superstore
GROUP BY customer_name
ORDER BY average_order_value DESC;

-- 9. Top 10 most profitable products
SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) AS profit_rank
FROM superstore
GROUP BY product_name
ORDER BY profit_rank
LIMIT 10;

-- 10. Discount impact on profitability
SELECT
    discount,
    COUNT(*) AS total_orders,
    ROUND(AVG(sales),2) AS average_sales,
    ROUND(AVG(profit),2) AS average_profit
FROM superstore
GROUP BY discount
ORDER BY discount;
