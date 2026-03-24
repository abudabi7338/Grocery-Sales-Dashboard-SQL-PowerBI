
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

SELECT  DATE_FORMAT(SalesDate, '%Y-%m-01') AS DateSales, 
         ROUND(SUM(Revenue), 2) AS MonthRevenue,
         COUNT(*) AS OrderCount

FROM sales_clean
GROUP BY DateSales

ORDER BY DateSales ASC;

--Date Format for PowerBI '%Y-%m-01'



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
       cities.CityName,
       ROUND(SUM(Revenue), 2) AS TotalRevenue

FROM sales_clean

INNER JOIN customers ON sales_clean.CustomerID = customers.CustomerID
INNER JOIN cities ON cities.CityID = customers.CityID

GROUP BY sales_clean.CustomerID, customers.FirstName, customers.LastName, cities.CityName 
ORDER BY TotalRevenue DESC
LIMIT 10;


-- =====================================================
-- 8. MONTH-OVER-MONTH REVENUE GROWTH
-- =====================================================
-- Question: "How does revenue change month to month 
--            and what is the percentage growth?"


   WITH MoM AS (
              SELECT  DATE_FORMAT(SalesDate, '%Y-%m-01') AS DateSales, 
         ROUND(SUM(Revenue), 2) AS MonthRevenue,
         COUNT(*) AS OrderCount
       FROM sales_clean
       GROUP BY DateSales
       ORDER BY DateSales ASC)

SELECT DateSales,
       MonthRevenue,
       ROUND(
       ((MonthRevenue - LAG(MonthRevenue) OVER (ORDER BY DateSales)) 
       / LAG(MonthRevenue) OVER (ORDER BY DateSales)) * 100
       , 2) AS GrowthPercent
        
FROM MoM
ORDER BY DateSales ASC;


-- =====================================================
-- 9. EMPLOYEE PERFORMANCE RANKING
-- =====================================================
--Question: "Which sales employees generate the most revenue 
--            and handle the most transactions?

WITH RankTotal AS (
SELECT employees.FirstName,
       employees.LastName,
       ROUND(SUM(Revenue), 2) AS TotalRevenue,
       COUNT(*) AS CountTransaction,
       DENSE_RANK() OVER (ORDER BY ROUND(SUM(Revenue), 2) DESC) AS RevenueRank,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS TransactionRank

FROM sales_clean
INNER JOIN employees ON sales_clean.SalesPersonID = employees.EmployeeID
GROUP BY sales_clean.SalesPersonID, employees.FirstName, employees.LastName

)

SELECT *,
       ROUND((RevenueRank +  TransactionRank)/ 2, 1) AS OverllRank
FROM RankTotal
ORDER BY OverllRank

