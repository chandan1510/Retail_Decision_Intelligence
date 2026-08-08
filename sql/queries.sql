USE retail_db;

-- 1. Basic Dataset Overview
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Invoice) AS total_orders,
    COUNT(DISTINCT StockCode) AS unique_products,
    COUNT(DISTINCT Customers_ID) AS total_customers
FROM sales_data;

-- 2. Revenue Overview
SELECT
    ROUND(SUM(Quantity * Price),2) AS total_revenue,
    SUM(quantity) AS total_unit_sold,
    ROUND(AVG(Quantity*Price),2) AS avg_transaction_value
FROM sales_data;

-- 3. Top revenue generating Countries
SELECT
    Country,
    ROUND(SUM(Quantity * Price), 2) AS revenue
FROM sales_data
GROUP BY Country
ORDER BY revenue DESC
LIMIT 10;

-- 4. Monthly Revenue

SELECT
    YEAR(InvoiceDate) AS sales_year,
    MONTH(InvoiceDate) AS sales_month,
    ROUND(SUM(Quantity * Price), 2) AS revenue
FROM sales_data
GROUP BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate)
ORDER BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate);


-- 5. Top 10 Products by Revenue

SELECT
    Description,
    ROUND(SUM(Quantity * Price), 2) AS revenue,
    SUM(Quantity) AS units_sold
FROM sales_data
WHERE Description IS NOT NULL
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;


-- 6. Executive KPI Analysis

SELECT
    ROUND(SUM(Quantity * Price), 2) AS total_revenue,
    COUNT(DISTINCT Invoice) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT StockCode) AS unique_products,
    SUM(Quantity) AS items_sold,
    ROUND(
        SUM(Quantity * Price) / COUNT(DISTINCT Invoice),
        2
    ) AS average_order_value,
    ROUND(
        SUM(Quantity) / COUNT(DISTINCT Invoice),
        2
    ) AS average_basket_size
FROM sales_data;


-- 7. Top 10 Products by Revenue

SELECT
    Description,
    ROUND(SUM(Quantity * Price), 2) AS revenue,
    SUM(Quantity) AS units_sold
FROM sales_data
WHERE Description IS NOT NULL
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;


-- 8. Top 10 Products by Quantity Sold

SELECT
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * Price), 2) AS revenue
FROM sales_data
WHERE Description IS NOT NULL
GROUP BY Description
ORDER BY units_sold DESC
LIMIT 10;


-- 9. Revenue by Country

SELECT
    Country,
    ROUND(SUM(Quantity * Price), 2) AS revenue,
    ROUND(
        SUM(Quantity * Price) * 100 /
        (SELECT SUM(Quantity * Price) FROM sales_data),
        2
    ) AS revenue_contribution_pct
FROM sales_data
WHERE Country IS NOT NULL
GROUP BY Country
ORDER BY revenue DESC;

-- 10. Quarterly Revenue Analysis

SELECT
    YEAR(InvoiceDate) AS year,
    QUARTER(InvoiceDate) AS quarter,
    ROUND(SUM(Quantity * Price), 2) AS revenue,
    COUNT(DISTINCT Invoice) AS total_orders
FROM sales_data
GROUP BY
    YEAR(InvoiceDate),
    QUARTER(InvoiceDate)
ORDER BY
    year,
    quarter;


-- 11. Cancellation and Return Analysis

SELECT
    CASE
        WHEN Invoice LIKE 'C%' THEN 'Cancelled/Returned'
        ELSE 'Completed'
    END AS transaction_status,
    COUNT(DISTINCT Invoice) AS total_orders,
    SUM(Quantity) AS units,
    ROUND(SUM(Quantity * Price), 2) AS revenue
FROM sales_data
GROUP BY
    CASE
        WHEN Invoice LIKE 'C%' THEN 'Cancelled/Returned'
        ELSE 'Completed'
    END
ORDER BY total_orders DESC;


-- 12. Customer Revenue Segmentation

SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(customer_revenue), 2) AS revenue,
    ROUND(
        SUM(customer_revenue) * 100 /
        (SELECT SUM(Quantity * Price)
         FROM sales_data
         WHERE Customer_ID IS NOT NULL
           AND Customer_ID <> ''),
        2
    ) AS revenue_contribution_pct
FROM
(
    SELECT
        Customer_ID,
        SUM(Quantity * Price) AS customer_revenue,
        CASE
            WHEN SUM(Quantity * Price) >= 5000 THEN 'High Value'
            WHEN SUM(Quantity * Price) >= 1000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM sales_data
    WHERE Customer_ID IS NOT NULL
      AND Customer_ID <> ''
    GROUP BY Customer_ID
) AS customer_data
GROUP BY customer_segment
ORDER BY
    CASE customer_segment
        WHEN 'High Value' THEN 1
        WHEN 'Medium Value' THEN 2
        WHEN 'Low Value' THEN 3
    END;


-- 13. Order Value Segmentation

SELECT
    order_segment,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_value), 2) AS revenue,
    ROUND(
        SUM(order_value) * 100 /
        (SELECT SUM(Quantity * Price)
         FROM sales_data),
        2
    ) AS revenue_contribution_pct
FROM
(
    SELECT
        Invoice,
        SUM(Quantity * Price) AS order_value,
        CASE
            WHEN SUM(Quantity * Price) >= 1000 THEN 'High Value Order'
            WHEN SUM(Quantity * Price) >= 500 THEN 'Medium Value Order'
            ELSE 'Low Value Order'
        END AS order_segment
    FROM sales_data
    GROUP BY Invoice
) AS order_data
GROUP BY order_segment
ORDER BY
    CASE order_segment
        WHEN 'High Value Order' THEN 1
        WHEN 'Medium Value Order' THEN 2
        WHEN 'Low Value Order' THEN 3
    END;