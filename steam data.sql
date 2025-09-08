 -- Game Release Trends by Year
WITH parsed_dates AS (   

    SELECT
        EXTRACT(YEAR FROM SAFE.PARSE_DATE('%b %d, %Y', `Release Date`)) AS release_year
    FROM
        `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
)
SELECT
    release_year,
    COUNT(*) AS total_games
FROM
    parsed_dates
WHERE
    release_year IS NOT NULL
GROUP BY
    release_year
ORDER BY
    release_year;

-- Platform Distribution

SELECT
    SUM(CASE WHEN Linux = 1 THEN 1 ELSE 0 END) AS Linux_games,
    SUM(CASE WHEN Windows = 1 THEN 1 ELSE 0 END) AS Windows_games,
    SUM(CASE WHEN MacOS = 1 THEN 1 ELSE 0 END) AS MacOS_games
FROM
    `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`;

-- Pricing and Discounts


SELECT AVG(`Original Price ___`) 
FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`;
-- Result: $27,314
SELECT AVG(`Price ___`) 
FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`;
-- Result: $12,575
SELECT `Game Name`, `Discount%` 
FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
ORDER BY (`Discount%`) 
LIMIT 10;
SELECT COUNT(*) AS games_90_discount 
FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
WHERE `Discount%` = -90.0;
-- Result: 18

-- Game Ratings and Price Correlation

SELECT
    CASE
        WHEN Rating BETWEEN 0 AND 1.99 THEN '0-1.99'
        WHEN Rating BETWEEN 2 AND 3.99 THEN '2-3.99'
        WHEN Rating BETWEEN 4 AND 5.99 THEN '4-5.99'
        WHEN Rating BETWEEN 6 AND 7.99 THEN '6-7.99'
        WHEN Rating = 8 THEN '8 (Max Rating)'
        ELSE 'Unrated'
    END AS Rating_Range,
    AVG(`Price ___`) AS Average_Price,
    COUNT(*) AS Number_of_Games
FROM
    `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
GROUP BY
    Rating_Range
ORDER BY
    MIN(Rating);

--  Market Distribution

SELECT COUNT(*)
FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
WHERE `Price ___` > (
    SELECT AVG(`Price ___`) 
    FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
);



