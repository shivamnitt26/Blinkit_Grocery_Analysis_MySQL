use blinkitgrocery;
SET SQL_SAFE_UPDATES = 0;

select * from blinkitdata;

-- 	DATA CLEANING:
# Cleaning the Item_Fat_Content field ensures data consistency and accuracy in analysis.The presence of multiple variations of the same category (e.g., LF, low fat vs. Low Fat) can cause issues in reporting, aggregations, and filtering. By standardizing these values, we improve data quality, making it easier to generate insights and maintain uniformity in our datasets.
UPDATE blinkitdata
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

SELECT 
     DISTINCT item_fat_content 
FROM
     blinkitdata;
     
-- A. KPI’s
-- 1. TOTAL SALES:
SELECT 
    CONCAT(
        CAST(SUM(total_sales) / 1000000.00 AS DECIMAL(10,2)), 
        ' Million'
    ) AS Total_Sales
FROM 
    blinkitdata;


-- 2. AVERAGE SALES
SELECT  
      ROUND(AVG(total_sales), 2) AS Avg_Sales
FROM 
      blinkitdata;


-- 3. AVG RATING
SELECT 
    ROUND(AVG(rating), 2) AS Avg_Rating
FROM 
    blinkitdata;


-- B. Total Sales by Fat Content:
SELECT 
    Item_fat_content AS Fat_Content, 
    ROUND(SUM(total_sales), 2) AS Total_Sales
FROM 
    blinkitdata
GROUP BY 
    Item_fat_content;


-- C. Total Sales by Item Type
SELECT 
    `item type` AS Item_Type, 
    ROUND(SUM(total_sales), 2) AS Total_Sales
FROM 
    blinkitdata
GROUP BY 
    `item type`;

 
-- D. Fat Content by Outlet for Total Sales
SELECT 
     `Outlet Location Type`,
    ROUND(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END), 2) AS Low_Fat,
    ROUND(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END), 2) AS Regular
FROM 
    blinkitdata
GROUP BY 
    `Outlet Location Type`
ORDER BY 
    `Outlet Location Type`;
    
-- E. Total Sales by Outlet Establishment
SELECT 
    `outlet establishment year` AS Outlet_Establishment_Year, 
    ROUND(SUM(total_sales), 2) AS Total_Sales
FROM 
    blinkitdata
GROUP BY 
    `outlet establishment year`;


-- F. Percentage of Sales by Outlet Size

SELECT 
    `Outlet Size` AS Outlet_Size,
    ROUND(SUM(total_sales), 2) AS Total_Sales,
    CONCAT(
        ROUND(SUM(total_sales) * 100 / (SELECT SUM(total_sales) FROM blinkitdata), 2), 
        '%'
    ) AS Percentage_Sales
FROM 
    blinkitdata
GROUP BY 
    `Outlet Size`
ORDER BY 
    Percentage_Sales DESC;


-- G. Sales by Outlet Location
SELECT 
    `Outlet Location Type` AS Outlet_Location_Type,
    ROUND(SUM(total_sales), 2) AS Total_Sales
FROM 
    blinkitdata
GROUP BY 
    `Outlet Location Type`
ORDER BY 
    Total_Sales DESC;


-- H. All Metrics (TotalSales, AvgSales, No_of_items, Avg_rating, Item_visibility by Outlet Type:
SELECT 
    `outlet type` AS Outlet_Type, 
    ROUND(SUM(total_sales), 2) AS Total_Sales, 
    ROUND(AVG(total_sales), 2) AS Avg_Sales, 
    COUNT(*) AS No_of_Items, 
    ROUND(AVG(Rating), 2) AS Avg_Rating, 
    ROUND(AVG(`Item Visibility`), 2) AS Avg_Item_Visibility
FROM 
    blinkitdata
GROUP BY 
    `outlet type`;








