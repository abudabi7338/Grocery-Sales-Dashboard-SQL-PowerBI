-- =====================================================
-- DATA CLEANING - grocery_sales Database
-- Author: [Twoje imię]
-- Date: 11-02-2026
-- Purpose: Standaryzacja i czyszczenie tabel przed Power BI
-- =====================================================

-- =====================================================
-- TABLE OF CONTENTS
-- =====================================================
-- 1. CATEGORIES  - TRIM, no major issues
-- 2. CITIES      - TRIM, no major issues
-- 3. COUNTRIES   - TRIM, no major issues
-- 4. CUSTOMERS   - TRIM, NULL w MiddleInitial (akceptowalne)
-- 5. EMPLOYEES   - TRIM, no major issues
-- 6. PRODUCTS    - TODO
-- 7. SALES       - TODO
-- =====================================================


-- =====================================================
-- 1. CATEGORIES
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: Tylko TRIM jako zabezpieczenie

SELECT
    CategoryID,
    TRIM(CategoryName) AS CategoryName
FROM categories
ORDER BY CategoryID;

-- Eksport do: categories_clean.csv


-- =====================================================
-- 2. CITIES
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: Tylko TRIM jako zabezpieczenie

SELECT
    CityID,
    TRIM(CityName) AS CityName,
    ZipCode,
    CountryID
FROM cities
ORDER BY CityID;

-- Eksport do: cities_clean.csv


-- =====================================================
-- 3. COUNTRIES
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: Tylko TRIM jako zabezpieczenie

SELECT 
    CountryID,
    TRIM(CountryName) AS CountryName,
    TRIM(CountryCode) AS CountryCode
FROM countries
ORDER BY CountryID;

-- Eksport do: countries_clean.csv


-- =====================================================
-- 4. CUSTOMERS
-- =====================================================
-- Status: Tabela czysta, NULL w MiddleInitial (akceptowalne - nie każdy ma drugie imię)
-- Action: TRIM na kolumnach tekstowych

SELECT 
    CustomerID,
    TRIM(FirstName) AS FirstName,
    TRIM(MiddleInitial) AS MiddleInitial,
    TRIM(LastName) AS LastName,
    CityID,
    TRIM(Address) AS Address
FROM customers
ORDER BY CustomerID;

-- Eksport do: customers_clean.csv


-- =====================================================
-- 5. EMPLOYEES
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: TRIM na kolumnach tekstowych

SELECT
    EmployeeID,
    TRIM(FirstName) AS FirstName,
    TRIM(MiddleInitial) AS MiddleInitial,
    TRIM(LastName) AS LastName,
    BirthDate,
    Gender,
    CityID,
    HireDate
FROM employees
ORDER BY EmployeeID;

-- Eksport do: employees_clean.csv


-- =====================================================
-- 6. PRODUCTS
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: TRIM na kolumnach tekstowych
SELECT 
     ProductID,
    TRIM(ProductName) AS ProductName,
    Price,
    CategoryID,
    TRIM(Class) AS Class,
    ModifyDate,
    TRIM(Resistant) AS Resistant,
    TRIM(IsAllergic) AS IsAllergic,
    VitalityDays

FROM products
ORDER BY ProductID;

-- Eksport do: products_clean.csv

-- =====================================================
-- 7. SALES
-- =====================================================
