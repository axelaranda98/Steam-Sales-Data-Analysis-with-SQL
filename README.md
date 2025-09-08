# Steam-Sales-Data-Analysis-with-SQL
This project is an exploratory analysis of the **Steam Sales Historical Dataset** from Kaggle, with the primary objective of uncovering key insights related to game pricing, sales trends, and user ratings.
Dataset: https://www.kaggle.com/datasets/benjaminlundkvist/steam-sales-historical-dataset

### 🛠️ Tools & Methodology

-   **Tools**: Google BigQuery (SQL)
-   **Methodology**: I conducted a bottom-up analysis, beginning with essential data cleaning and exploration. I then moved to more complex queries to identify trends, correlations, and key metrics.

### 📊 Key Analysis and Insights

#### 📈 Game Release Trends by Year

**SQL Query:**
```sql
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
    parsed_date IS NOT NULL
GROUP BY
    release_year
ORDER BY
    release_year;

Insight: The number of new games released on Steam shows a consistent, sharp upward trend, with a significant increase in recent years (2023-2025). This suggests a rapidly expanding market for game development and publishing.

#### 🎮 Platform Distribution

SQL Queries:

SELECT
    SUM(CASE WHEN Linux = 1 THEN 1 ELSE 0 END) AS Linux_games,
    SUM(CASE WHEN Windows = 1 THEN 1 ELSE 0 END) AS Windows_games,
    SUM(CASE WHEN MacOS = 1 THEN 1 ELSE 0 END) AS MacOS_games
FROM
    `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`;

Insight: The market is heavily dominated by Windows, which has over three times as many games as both macOS and Linux combined, indicating that platform support is not balanced.

#### 💰 Pricing and Discounts

SQL Queries:

SQL
SELECT AVG(`Original Price ___`) FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`;
-- Result: $27,314

SELECT AVG(`Price ___`) FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`;
-- Result: $12,575

SELECT `Game Name`, `Discount%` FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
ORDER BY (`Discount%`) LIMIT 10

SELECT COUNT(*) AS games_90_discount FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
WHERE `Discount%` = -90.0;
-- Result: 18

Insight: The data shows a significant difference between the average original price ($27,314) and the average current price ($12,575), highlighting that deep discounts are a common practice on Steam. The list of games with major discounts also shows that multiple titles have a 90% discount, suggesting this is a frequent marketing strategy.

#### ⭐ Game Ratings and Price Correlation

SQL Query:

SQL
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

Insight: The majority of games in this dataset fall within the 6.00-7.99 rating range (431 games), indicating that most titles receive a positive but not top-tier rating. The data also suggests a slight inverse correlation, where the highest-rated games are not necessarily the most expensive.

#### 📊 Market Distribution

SQL Query:

SQL
SELECT COUNT(*)
FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`
WHERE `Price ___` > (SELECT AVG(`Price ___`) FROM `profound-actor-470909-r8.Steam_Sales_Historical_Dataset.steam_sales`);

Insight: The distribution of game prices is positively skewed, with a long tail of higher-priced games pulling the average up. The fact that more than a third of the games (36.7%) are priced above the average suggests a market with a wide range of pricing tiers.

#### ✅ Key Learnings

This project demonstrated my ability to perform a complete data analysis workflow, from writing complex queries to deriving meaningful insights. My key learnings include:

Data Cleaning & Transformation: I used COALESCE and SAFE.PARSE_DATE to handle inconsistent date formats and CASE to create meaningful data categories.

Data Aggregation: I applied functions like AVG(), COUNT(), and SUM() to calculate key metrics from the dataset.

Intermediate SQL: I effectively used Common Table Expressions (CTEs) to structure my queries and WHERE clauses with subqueries for dynamic filtering.
