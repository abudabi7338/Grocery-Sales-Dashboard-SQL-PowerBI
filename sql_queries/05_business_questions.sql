
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


-- 4. SALES BY DAY OF WEEK
-- =====================================================
-- Question: "On which day of the week do customers make the most purchases?"

SELECT
       DAYNAME(SalesDate) AS DayWeek,
       ROUND(SUM(Revenue), 2) AS TotalDayRevenue

FROM sales_clean
GROUP BY DAYNAME(SalesDate)
ORDER BY TotalDayRevenue DESC;



-- 5. REVENUE BY CATEGORY
-- =====================================================
-- Question: "On which category earn most money?"


SELECT categories.CategoryName,
       ROUND(SUM(Revenue), 2) AS TotalRevenue,
       SUM(sales_clean.Quantity) AS TotalQuantity


FROM sales_clean
JOIN products ON sales_clean.ProductID = products.ProductID
JOIN categories ON products.CategoryID = categories.CategoryID

GROUP BY categories.CategoryName
ORDER BY TotalRevenue DESC;



-- 6. IMPACT OF DICOUNT ON SALES
-- =====================================================
-- Question: "Bigger dicounnt =  biger sales?"

SELECT Discount,
       SUM(Quantity) AS TotalQuantity,
       ROUND(SUM(Revenue), 2) AS TotalRevenue,
       COUNT(*) AS OrderCount

FROM sales_clean
GROUP BY Discount
ORDER BY Discount ASC;


-- 7. TOP CUSTOMERS BY REVENUE
-- =====================================================
-- Question: "Which customers generate the most revenue?"

SELECT sales_clean.CustomerID,
       customers.FirstName,
       customers.LastName,
       ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM sales_clean
INNER JOIN customers ON sales_clean.CustomerID = customers.CustomerID
GROUP BY sales_clean.CustomerID, customers.FirstName, customers.LastName
ORDER BY TotalRevenue DESC
LIMIT 10;
