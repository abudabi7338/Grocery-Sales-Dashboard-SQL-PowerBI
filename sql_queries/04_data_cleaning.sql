-- =====================================================
-- TABLE OF CONTENTS
-- =====================================================
-- 1. CATEGORIES     (line 15)  - TRIM, no major issues


-- =====================================================
-- DATA CLEANING - grocery_sales Database
-- Author: [Twoje imię]
-- Date: 11-02-2026
-- Purpose: Standaryzacja i czyszczenie tabel przed Power BI
-- =====================================================


-- 1. CATEGORIES
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: Tylko TRIM jako zabezpieczenie

SELECT
     CategoryID,
     TRIM(CategoryName) as CategoryName
FROM categories
ORDER BY CategoryID


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
ORDER BY CityID



-- 3. COUNTRIES
-- =====================================================
-- Status: Tabela czysta, brak NULL-i i duplikatów
-- Action: Tylko TRIM jako zabezpieczenie

    
    SELECT 
    CountryID,
    TRIM(CountryName) AS CountryName,
    TRIM(CountryCode) AS CountryCode

    FROM countries
    ORDER BY CountryID