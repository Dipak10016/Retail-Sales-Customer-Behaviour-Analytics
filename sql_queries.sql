-- ============================================================
-- RETAIL SALES ANALYTICS — SQL QUERIES
-- Database: retail_db  |  Table: retail_sales
-- ============================================================

-- ─── 1. TOTAL REVENUE & PROFIT ────────────────────────────────
SELECT
    COUNT(DISTINCT order_id)          AS total_orders,
    COUNT(DISTINCT customer_id)       AS total_customers,
    ROUND(SUM(total_sales), 2)        AS total_revenue,
    ROUND(SUM(profit), 2)             AS total_profit,
    ROUND(AVG(total_sales), 2)        AS avg_order_value,
    ROUND(AVG(profit_margin), 2)      AS avg_profit_margin_pct,
    SUM(quantity)                     AS total_units_sold
FROM retail_sales;


-- ─── 2. MONTHLY SALES TREND ───────────────────────────────────
SELECT
    YEAR(order_date)                                    AS year,
    MONTH(order_date)                                   AS month,
    DATE_FORMAT(order_date, '%b %Y')                   AS period,
    COUNT(order_id)                                     AS orders,
    ROUND(SUM(total_sales), 2)                          AS revenue,
    ROUND(SUM(profit), 2)                               AS profit,
    ROUND(
        (SUM(total_sales) - LAG(SUM(total_sales)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)))
        / LAG(SUM(total_sales)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) * 100
    , 2)                                                AS mom_growth_pct
FROM retail_sales
GROUP BY YEAR(order_date), MONTH(order_date), DATE_FORMAT(order_date, '%b %Y')
ORDER BY year, month;


-- ─── 3. REVENUE BY PRODUCT CATEGORY ──────────────────────────
SELECT
    product_category,
    COUNT(order_id)                                     AS orders,
    SUM(quantity)                                       AS units_sold,
    ROUND(SUM(total_sales), 2)                          AS revenue,
    ROUND(SUM(profit), 2)                               AS profit,
    ROUND(AVG(profit_margin), 2)                        AS avg_margin_pct,
    ROUND(SUM(total_sales) / SUM(SUM(total_sales)) OVER () * 100, 2) AS revenue_share_pct
FROM retail_sales
GROUP BY product_category
ORDER BY revenue DESC;


-- ─── 4. TOP 10 PRODUCTS BY REVENUE ───────────────────────────
SELECT
    product_name,
    product_category,
    COUNT(order_id)                     AS orders,
    SUM(quantity)                       AS units_sold,
    ROUND(SUM(total_sales), 2)          AS total_revenue,
    ROUND(SUM(profit), 2)               AS total_profit,
    ROUND(AVG(price), 2)                AS avg_price,
    RANK() OVER (ORDER BY SUM(total_sales) DESC) AS revenue_rank
FROM retail_sales
GROUP BY product_name, product_category
ORDER BY total_revenue DESC
LIMIT 10;


-- ─── 5. REVENUE BY REGION ─────────────────────────────────────
SELECT
    region,
    COUNT(DISTINCT customer_id)         AS unique_customers,
    COUNT(order_id)                     AS orders,
    ROUND(SUM(total_sales), 2)          AS revenue,
    ROUND(SUM(profit), 2)               AS profit,
    ROUND(AVG(profit_margin), 2)        AS avg_margin_pct,
    ROUND(SUM(total_sales) / SUM(SUM(total_sales)) OVER () * 100, 2) AS revenue_share_pct
FROM retail_sales
GROUP BY region
ORDER BY revenue DESC;


-- ─── 6. CUSTOMER DEMOGRAPHICS ANALYSIS ───────────────────────
-- By Gender
SELECT
    customer_gender,
    COUNT(DISTINCT customer_id)         AS customers,
    COUNT(order_id)                     AS orders,
    ROUND(SUM(total_sales), 2)          AS revenue,
    ROUND(AVG(total_sales), 2)          AS avg_order_value
FROM retail_sales
GROUP BY customer_gender
ORDER BY revenue DESC;

-- By Age Group
SELECT
    CASE
        WHEN customer_age BETWEEN 18 AND 25 THEN '18–25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26–35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36–45'
        WHEN customer_age BETWEEN 46 AND 55 THEN '46–55'
        ELSE '56–70'
    END                                 AS age_group,
    COUNT(DISTINCT customer_id)         AS customers,
    COUNT(order_id)                     AS orders,
    ROUND(SUM(total_sales), 2)          AS revenue,
    ROUND(AVG(total_sales), 2)          AS avg_order_value
FROM retail_sales
GROUP BY age_group
ORDER BY MIN(customer_age);


-- ─── 7. PAYMENT METHOD ANALYSIS ──────────────────────────────
SELECT
    payment_method,
    COUNT(order_id)                     AS transaction_count,
    ROUND(SUM(total_sales), 2)          AS revenue,
    ROUND(AVG(total_sales), 2)          AS avg_order_value,
    ROUND(COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER (), 2) AS usage_pct
FROM retail_sales
GROUP BY payment_method
ORDER BY transaction_count DESC;


-- ─── 8. QUARTERLY PERFORMANCE ─────────────────────────────────
SELECT
    YEAR(order_date)                    AS year,
    QUARTER(order_date)                 AS quarter,
    CONCAT('Q', QUARTER(order_date), ' ', YEAR(order_date)) AS period,
    COUNT(order_id)                     AS orders,
    ROUND(SUM(total_sales), 2)          AS revenue,
    ROUND(SUM(profit), 2)               AS profit,
    ROUND(AVG(discount), 2)             AS avg_discount_pct
FROM retail_sales
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY year, quarter;


-- ─── 9. DISCOUNT EFFECTIVENESS ───────────────────────────────
SELECT
    CASE
        WHEN discount = 0          THEN 'No Discount'
        WHEN discount BETWEEN 1 AND 10 THEN '1–10%'
        WHEN discount BETWEEN 11 AND 20 THEN '11–20%'
        WHEN discount BETWEEN 21 AND 30 THEN '21–30%'
    END                                 AS discount_band,
    COUNT(order_id)                     AS orders,
    ROUND(AVG(quantity), 2)             AS avg_units,
    ROUND(AVG(total_sales), 2)          AS avg_order_value,
    ROUND(SUM(total_sales), 2)          AS total_revenue,
    ROUND(SUM(profit), 2)               AS total_profit
FROM retail_sales
GROUP BY discount_band
ORDER BY MIN(discount);


-- ─── 10. REPEAT CUSTOMER ANALYSIS ────────────────────────────
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id)                 AS order_count,
        ROUND(SUM(total_sales), 2)      AS lifetime_value,
        MIN(order_date)                 AS first_order,
        MAX(order_date)                 AS last_order
    FROM retail_sales
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count = 2 THEN '2 orders'
        WHEN order_count BETWEEN 3 AND 5 THEN '3–5 orders'
        ELSE '6+ orders'
    END                                 AS customer_type,
    COUNT(customer_id)                  AS customers,
    ROUND(AVG(lifetime_value), 2)       AS avg_ltv,
    ROUND(SUM(lifetime_value), 2)       AS total_revenue
FROM customer_orders
GROUP BY customer_type
ORDER BY AVG(order_count) DESC;


-- ─── 11. REGIONAL CATEGORY HEATMAP ───────────────────────────
SELECT
    region,
    product_category,
    ROUND(SUM(total_sales), 2)          AS revenue,
    COUNT(order_id)                     AS orders
FROM retail_sales
GROUP BY region, product_category
ORDER BY region, revenue DESC;


-- ─── 12. YOY GROWTH ANALYSIS ─────────────────────────────────
WITH yearly AS (
    SELECT
        YEAR(order_date)                AS yr,
        ROUND(SUM(total_sales), 2)      AS revenue,
        COUNT(order_id)                 AS orders
    FROM retail_sales
    GROUP BY YEAR(order_date)
)
SELECT
    y.yr,
    y.revenue,
    y.orders,
    ROUND((y.revenue - p.revenue) / p.revenue * 100, 2) AS yoy_growth_pct
FROM yearly y
LEFT JOIN yearly p ON p.yr = y.yr - 1
ORDER BY y.yr;
