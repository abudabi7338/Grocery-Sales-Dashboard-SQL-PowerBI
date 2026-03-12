
-- =====================================================
-- BUSINESS QUESTIONS - grocery_sales Database
-- =====================================================

-- =====================================================
-- 1. TOP 10 PRODUCTS BY REVENUE
-- =====================================================
-- Question: "Which products generate the most revenue?"


SELECT products.ProductName,
       ROUND(SUM(sales_clean.Revenue), 2) AS TotalRevenue
        
FROM sales_clean
JOIN products ON sales_clean.ProductID = products.ProductID

GROUP BY ProductName
ORDER BY TotalRevenue DESC

LIMIT 10;

-- =====================================================
-- 2. TOP PRODUCTS IN CATEGORIES BY REVENUE 
-- =====================================================
-- Question: "Which products generate the most revenue in categories?"

WITH RankedProducts AS 

(SELECT products.ProductName,
       categories.CategoryName,
       ROUND(SUM(sales_clean.Revenue), 2) AS TotalRevenue,
       RANK() OVER (PARTITION BY categories.CategoryName ORDER BY SUM(sales_clean.Revenue) DESC) AS Ranking

FROM sales_clean
JOIN products ON sales_clean.ProductID = products.ProductID
JOIN categories ON products.CategoryID = categories.CategoryID

GROUP BY products.ProductName, categories.CategoryName)


SELECT *
FROM RankedProducts

WHERE Ranking = 1;

-- =====================================================
-- 3. MONTHLY REVENUE TREND
-- =====================================================
-- Question: "How sales changes over time?"

SELECT  DATE_FORMAT(SalesDate, '%Y-%m-01') AS DateSales, --Date Format for PowerBI '%Y-%m-01'
         ROUND(SUM(Revenue), 2) AS MonthRevenue,
         COUNT(*)
    

FROM sales_clean
GROUP BY DateSales

ORDER BY DateSales ASC;
