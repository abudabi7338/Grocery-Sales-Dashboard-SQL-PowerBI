--categoires.csv--

    --sprawdznie czy CategoryID sie powtarza

SELECT
     CategoryID,
     COUNT (CategoryID) AS CountCategoryID
 FROM categories
GROUP BY CategoryID
HAVING CountCategoryID > 1

    --Sprawdzenie CategoryName czy sa NULL lub spacje

SELECT CategoryName
FROM categories
WHERE CategoryName IS NULL OR CategoryName = ''


--Cities.csv--
    --sprawdznie CityID  czy sie powtarza

SELECT 
    CityID,
    COUNT(CityID) AS CountCityID
FROM cities
GROUP BY CityID
HAVING CountCityID > 1

    --Sprawdznie ZipCode czy jest null
    SELECT ZipCode
    FROM cities
    WHERE ZipCode IS NULL OR ZipCode = ''


    --Sprawdznie CityName czy jest null
    SELECT CityName
    FROM cities
    WHERE CityName IS NULL OR CityName = ''


       --Sprawdznie CountryID czy jest null
    SELECT CountryID
    FROM cities
    WHERE CountryID IS NULL 


    --Sprawdznie i grupowanie miasta do krajów
    SELECT CountryID
    FROM cities
    GROUP BY CountryID

    --