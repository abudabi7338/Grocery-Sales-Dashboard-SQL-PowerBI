-- Dla pewności że pracuje sie na bazie grocery_sales
USE grocery_sales;

--Usuwanie starej tabeli sales
DROP TABLE IF EXISTS sales;


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

-- 2. Załadpwanie dane z pliku CSV

LOAD DATA LOCAL INFILE 'ścieżka/do/pliku/sales.csv''
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;