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
