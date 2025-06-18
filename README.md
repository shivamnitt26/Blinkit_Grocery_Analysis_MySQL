# 📊 Blinkit Grocery Data Analysis using SQL

## 🗂️ Database: `blinkitgrocery`
### 📌 Table: `blinkitdata`

This project uses SQL to explore and analyze Blinkit’s grocery sales dataset. The analysis includes data cleaning, KPI tracking, and deep-dives into sales metrics based on outlet attributes.

---

## 🔧 Data Cleaning

```sql
-- Standardizing Item_Fat_Content values
UPDATE blinkitdata
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-- Verify changes
SELECT DISTINCT Item_Fat_Content FROM blinkitdata;
```

## 📈 Key Performance Indicators (KPIs)

```sql
-- 1. Total Sales


SELECT CONCAT(CAST(SUM(total_sales) / 1000000.00 AS DECIMAL(10,2)), ' Million') AS Total_Sales 
FROM blinkitdata;

![image](https://github.com/user-attachments/assets/3ad1b513-168a-487a-9182-805776974b97)


-- 2. Average Sales

SELECT ROUND(AVG(total_sales), 2) AS Avg_Sales 
FROM blinkitdata;

-- 3. Average Rating

SELECT ROUND(AVG(rating), 2) AS Avg_Rating 
FROM blinkitdata;
```


##  📈 Segment-Wise Sales Analysis

```sql 
-- A. Total Sales by Fat Content
SELECT Item_fat_content AS Fat_Content, ROUND(SUM(total_sales), 2) AS Total_Sales 
FROM blinkitdata 
GROUP BY Item_fat_content;

-- B. Total Sales by Item Type
SELECT `item type` AS Item_Type, ROUND(SUM(total_sales), 2) AS Total_Sales 
FROM blinkitdata 
GROUP BY `item type`;

-- C. Fat Content by Outlet Location Type
SELECT `Outlet Location Type`, 
       ROUND(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END), 2) AS Low_Fat,
       ROUND(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END), 2) AS Regular
FROM blinkitdata 
GROUP BY `Outlet Location Type` 
ORDER BY `Outlet Location Type`;

-- D. Sales by Outlet Establishment Year
SELECT `outlet establishment year` AS Outlet_Establishment_Year, ROUND(SUM(total_sales), 2) AS Total_Sales 
FROM blinkitdata 
GROUP BY `outlet establishment year`;

-- E. % of Sales by Outlet Size
SELECT `Outlet Size` AS Outlet_Size,
       ROUND(SUM(total_sales), 2) AS Total_Sales,
       CONCAT(ROUND(SUM(total_sales) * 100 / (SELECT SUM(total_sales) FROM blinkitdata), 2), '%') AS Percentage_Sales 
FROM blinkitdata 
GROUP BY `Outlet Size` 
ORDER BY Percentage_Sales DESC;

-- F. Sales by Outlet Location
SELECT `Outlet Location Type` AS Outlet_Location_Type, ROUND(SUM(total_sales), 2) AS Total_Sales 
FROM blinkitdata 
GROUP BY `Outlet Location Type` 
ORDER BY Total_Sales DESC;

-- G. All Metrics by Outlet Type
SELECT `outlet type` AS Outlet_Type,
       ROUND(SUM(total_sales), 2) AS Total_Sales,
       ROUND(AVG(total_sales), 2) AS Avg_Sales,
       COUNT(*) AS No_of_Items,
       ROUND(AVG(Rating), 2) AS Avg_Rating,
       ROUND(AVG(`Item Visibility`), 2) AS Avg_Item_Visibility 
FROM blinkitdata 
GROUP BY `outlet type`;
```
## 🎯 Objectives
- Correlate Outlet Size with sales performance
- Assess Location-wise sales performance
- Analyze Fat Content Preference
- Combine outlet metrics for multi-dimensional insights

## 🛠️ Tools Used
- SQL (MySQL)
- CSV dataset (Blinkit)

