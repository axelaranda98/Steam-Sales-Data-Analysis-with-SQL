# Steam-Sales-Data-Analysis-with-SQL
This project is an exploratory analysis of the **Steam Sales Historical Dataset** from Kaggle, with the primary objective of uncovering key insights related to game pricing, sales trends, and user ratings.  
Dataset: https://www.kaggle.com/datasets/benjaminlundkvist/steam-sales-historical-dataset

### 🛠️ Tools & Methodology

- **Tools**: Google BigQuery (SQL)  
- **Methodology**: I conducted a bottom-up analysis, beginning with essential data cleaning and exploration. I then moved to more complex queries to identify trends, correlations, and key metrics.

---

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
    release_year IS NOT NULL
GROUP BY
    release_year
ORDER BY
    release_year;

