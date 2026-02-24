-- =====================================================
-- DATA EXPLORATION - grocery_sales Database
-- =====================================================

-- =====================================================
-- 1. CATEGORIES
-- =====================================================

--sprawdzenie czy CategoryID sie powtarza
SELECT
     CategoryID,
     COUNT(CategoryID) AS CountCategoryID
FROM categories
GROUP BY CategoryID
HAVING CountCategoryID > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie CategoryName czy sa NULL lub spacje
SELECT CategoryName
FROM categories
WHERE CategoryName IS NULL OR CategoryName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

-- PODSUMOWANIE: Tabela categories jest czysta.
-- Brak duplikatów, NULL-i i błędów logicznych.

-- =====================================================
-- 2. CITIES
-- =====================================================

--sprawdzenie CityID czy sie powtarza
SELECT 
    CityID,
    COUNT(CityID) AS CountCityID
FROM cities
GROUP BY CityID
HAVING CountCityID > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie ZipCode czy jest NULL
SELECT ZipCode
FROM cities
WHERE ZipCode IS NULL OR ZipCode = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie CityName czy jest NULL
SELECT CityName
FROM cities
WHERE CityName IS NULL OR CityName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie CountryID czy jest NULL
SELECT CountryID
FROM cities
WHERE CountryID IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie i grupowanie miasta do krajów
SELECT CountryID
FROM cities
GROUP BY CountryID;
-- WYNIK: 1 kraj (USA) → wszystkie miasta z jednego kraju

-- PODSUMOWANIE: Tabela cities jest czysta.
-- Brak duplikatów, NULL-i i błędów logicznych.

-- =====================================================
-- 3. COUNTRIES
-- =====================================================

--sprawdzenie countryID czy sie powtarza
SELECT CountryID,
    COUNT(CountryID) AS CountCountryID
FROM countries
GROUP BY CountryID
HAVING CountCountryID > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie czy CountryName sie powtarza
SELECT 
    TRIM(CountryName) AS CountryName,
    COUNT(CountryName) AS CountCountryName
FROM countries
GROUP BY TRIM(CountryName)
HAVING CountCountryName > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie czy CountryCode sie powtarza
SELECT 
    TRIM(CountryCode) AS CleanCountryCode,
    COUNT(CountryCode) AS CountCountryCode  
FROM countries
GROUP BY TRIM(CountryCode)
HAVING CountCountryCode > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie NULL i '' w CountryName
SELECT CountryName
FROM countries
WHERE CountryName IS NULL OR CountryName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie NULL i '' w CountryCode
SELECT CountryCode
FROM countries
WHERE CountryCode IS NULL OR CountryCode = '';
-- WYNIK: 0 wierszy → brak NULL ✓

-- PODSUMOWANIE: Tabela countries jest czysta.
-- Brak duplikatów, NULL-i i błędów logicznych.

-- =====================================================
-- 4. CUSTOMERS
-- =====================================================

--sprawdzenie czy CustomerID sie powtarza
SELECT CustomerID,
    COUNT(CustomerID) AS CountCustomerID
FROM customers
GROUP BY CustomerID
HAVING CountCustomerID > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie FirstName czy sa NULL i ''
SELECT FirstName
FROM customers
WHERE FirstName IS NULL OR FirstName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie MiddleInitial NULL oraz ''
SELECT MiddleInitial
FROM customers
WHERE MiddleInitial IS NULL OR MiddleInitial = '';
-- WYNIK: są NULL-e → to OK, nie każdy ma drugie imię

--sprawdzenie LastName czy sa NULL i ''
SELECT LastName
FROM customers
WHERE LastName IS NULL OR LastName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie CityID czy sa NULL
SELECT CityID
FROM customers
WHERE CityID IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie Address czy sa NULL i ''
SELECT Address
FROM customers
WHERE Address IS NULL OR Address = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie relacji LEFT JOIN customers.CityID z cities.CityID
SELECT
    customers.CustomerID,
    customers.CityID
FROM customers
LEFT JOIN cities
    ON cities.CityID = customers.CityID
WHERE cities.CityID IS NULL;
-- WYNIK: 0 wierszy → relacja OK ✓

-- PODSUMOWANIE: Tabela customers jest czysta.
-- Brak duplikatów i błędów logicznych.
-- MiddleInitial ma NULL-e (akceptowalne - nie każdy ma drugie imię).
-- Relacja z cities OK.

-- =====================================================
-- 5. EMPLOYEES
-- =====================================================

--sprawdzenie czy EmployeeID sie powtarza
SELECT EmployeeID,
    COUNT(EmployeeID) AS CountEmployeeID
FROM employees
GROUP BY EmployeeID
HAVING CountEmployeeID > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓

--sprawdzenie FirstName NULL i ''
SELECT FirstName
FROM employees
WHERE FirstName IS NULL OR FirstName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie MiddleInitial NULL oraz ''
SELECT MiddleInitial
FROM employees
WHERE MiddleInitial IS NULL OR MiddleInitial = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie LastName czy sa NULL i ''
SELECT LastName
FROM employees
WHERE LastName IS NULL OR LastName = '';
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie BirthDate NULL i ''
SELECT BirthDate
FROM employees
WHERE BirthDate = '' OR BirthDate IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie BirthDate czy ktos nie urodzil sie w przyszlosci
SELECT BirthDate
FROM employees
WHERE BirthDate > CURDATE();
-- WYNIK: 0 wierszy → brak błędów logicznych ✓

--sprawdzenie Gender NULL i ''
SELECT Gender
FROM employees
WHERE Gender = '' OR Gender IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie wartosci Gender
SELECT COUNT(Gender) AS GenderCount,
    Gender
FROM employees
GROUP BY Gender;
-- WYNIK: 2 wartości (M, F) → dane ustandaryzowane ✓

--sprawdzenie HireDate NULL i ''
SELECT HireDate
FROM employees
WHERE HireDate = '' OR HireDate IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie HireDate blad logiczny
SELECT HireDate
FROM employees
WHERE HireDate > CURDATE() OR HireDate < BirthDate;
-- WYNIK: 0 wierszy → brak błędów logicznych ✓

--sprawdzenie relacji LEFT JOIN employees.CityID z cities.CityID
SELECT employees.EmployeeID,
    employees.CityID 
FROM employees
LEFT JOIN cities
    ON employees.CityID = cities.CityID
WHERE cities.CityID IS NULL;
-- WYNIK: 0 wierszy → relacja OK ✓


-- =====================================================
-- 6. PRODUCTS
-- =====================================================

--sprawdzenie czy ProductID sie powtarza
SELECT ProductID,
    COUNT(ProductID) AS CountProductID
FROM products
GROUP BY ProductID
HAVING CountProductID > 1;
-- WYNIK: 0 wierszy → brak duplikatów ✓


--sprawdzenie ProductName NULL i ''

SELECT ProductName
FROM products
WHERE ProductName = '' OR ProductName IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie ProductName czy się coś powtarza

SELECT ProductName,
    COUNT(ProductName) AS CountProductName
FROM products
GROUP BY ProductName
HAVING CountProductName > 1;
-- WYNIK: 0 wierszy → brak powtórzeń ✓


--sprawdzenie Price NULL i ''

SELECT Price
FROM products
WHERE Price = '' OR Price IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓


--sprawdzenie CategoryID NULL i ''
SELECT CategoryID
FROM products
WHERE CategoryID = '' OR CategoryID IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓


--sprawdzenie relacji LEFT JOIN categories.CategoryID z products.CategoryID
SELECT categories.CategoryID, 
    products.CategoryID
    FROM products

    LEFT JOIN categories 
            ON categories.CategoryID = products.CategoryID
    WHERE categories.CategoryID IS NULL
-- WYNIK: 0 wierszy → relacja OK ✓


--sprawdzenie Class NULL i ''
SELECT Class
FROM products
WHERE Class = '' OR Class IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie Class jakie są wartości
SELECT Class,
        COUNT(*) AS ile
FROM products
GROUP BY Class
-- WYNIK: 3 wartości: Medium, Low, High



--sprawdzenie ModifyDate NULL i ''
SELECT ModifyDate
FROM products
WHERE ModifyDate = '' OR ModifyDate IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓


--sprawdzenie Resistant NULL i ''
SELECT Resistant
FROM products
WHERE Resistant = '' OR Resistant IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓


--sprawdzenie Resistant jakie są wartości
SELECT Resistant,
        COUNT(*) AS ile
FROM products
GROUP BY Resistant
-- WYNIK: 3 wartości: Durable, Unknown, Weak


--sprawdzenie IsAllergic NULL i ''
SELECT IsAllergic
FROM products
WHERE IsAllergic = '' OR IsAllergic IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓


--sprawdzenie IsAllergic jakie są wartości
SELECT IsAllergic,
        COUNT(*) AS ile
FROM products
GROUP BY IsAllergic
-- WYNIK: 3 wartości: Unknown, False, True

--sprawdzenie VitalityDays NULL i ''
SELECT VitalityDays
FROM products
WHERE VitalityDays IS NULL;
-- WYNIK: 0 wierszy → brak NULL ✓

--sprawdzenie VitalityDays < 0 
SELECT VitalityDays
FROM products
WHERE VitalityDays < 0 
-- WYNIK: 0 wierszy → brak wartości ujemnych ✓








-- PODSUMOWANIE: Tabela employees jest czysta.
-- Brak duplikatów, NULL-i i błędów logicznych.
-- Relacja z cities OK.

-- =====================================================
-- PODSUMOWANIE OGÓLNE
-- =====================================================
-- Wszystkie tabele wymiarów są czyste i gotowe do użycia.
-- Jedyny NULL: MiddleInitial w customers (akceptowalne).
-- Wszystkie relacje z cities są poprawne.
-- =====================================================-