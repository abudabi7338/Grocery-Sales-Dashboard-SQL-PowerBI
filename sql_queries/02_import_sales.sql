-- Upewnij się, że pracujesz na bazie grocery_sales
USE grocery_sales;

-- Na wszelki wypadek usuń starą tabelę sales, jeśli istnieje
DROP TABLE IF EXISTS sales;

-- 1. Stwórz tabelę sales z odpowiednimi kolumnami
-- Uwaga: SalesDate jako VARCHAR, bo dane daty są uszkodzone / dziwne ("38:25.42" itd.)
CREATE TABLE sales (
    SalesID INT,
    SalesPersonID INT,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    Discount DECIMAL(10,2),
    TotalPrice DECIMAL(10,2),
    SalesDate VARCHAR(50),
    TransactionNumber VARCHAR(100)
);

-- 2. Załaduj dane z pliku CSV
-- PODMIEŃ ŚCIEŻKĘ PONIŻEJ NA SWOJĄ:
LOAD DATA LOCAL INFILE 'D:\Data Analyst\Projects\Portfolio_2026\01_Grocery_Sales\raw_datasales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;