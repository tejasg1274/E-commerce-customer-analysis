
# creating the database as ecommerce-analysis for storing the data 
CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

SELECT COUNT(*) AS total_records FROM customerdata;

DESCRIBE customerdata;

SELECT
    Customer_ID,
    COUNT(*) AS id_count
FROM customerdata
GROUP BY Customer_ID
HAVING COUNT(*) > 1
LIMIT 20;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    ROUND(AVG(Total_Spend), 2) AS avg_spend,
    ROUND(AVG(Average_Rating), 2) AS avg_rating,
    ROUND(AVG(Items_Purchased), 2) AS avg_items_purchased
FROM customerdata;


# Overall Customer Summary
SELECT
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend,
    AVG(Average_Rating) AS avg_rating
FROM customerdata;


# Membership-wise Analysis
SELECT
    Membership_Type,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY Membership_Type
ORDER BY avg_spend DESC;


# Satisfaction-wise Analysis
SELECT
    Satisfaction_Level,
    COUNT(*) AS total_customers,
    AVG(Average_Rating) AS avg_rating
FROM customerdata
GROUP BY Satisfaction_Level;


# Membership-wise Customer Analysis
SELECT
    Membership_Type,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY Membership_Type
ORDER BY avg_spend DESC;


# Satisfaction Analysis
SELECT
    Satisfaction_Level,
    COUNT(*) AS total_customers,
    AVG(Average_Rating) AS avg_rating
FROM customerdata
GROUP BY Satisfaction_Level;


# Discount mule spending madhye farak padto ka?
SELECT
    Discount_Applied,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY Discount_Applied;


# City-wise Analysis
SELECT
    City,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY City
ORDER BY avg_spend DESC;


# Gender-wise Analysis
SELECT
    Gender,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY Gender;


# Age Group Analysis
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45 and Above'
    END AS age_group,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY age_group
ORDER BY avg_spend DESC;


# Days Since Last Purchase Analysis
SELECT
    Days_Since_Last_Purchase,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY Days_Since_Last_Purchase
ORDER BY Days_Since_Last_Purchase;


# Items Purchased vs Spending
SELECT
    Items_Purchased,
    COUNT(*) AS total_customers,
    AVG(Total_Spend) AS avg_spend
FROM customerdata
GROUP BY Items_Purchased
ORDER BY Items_Purchased;


# Membership vs Satisfaction
SELECT
    Membership_Type,
    Satisfaction_Level,
    COUNT(*) AS total_customers
FROM customerdata
GROUP BY Membership_Type, Satisfaction_Level
ORDER BY Membership_Type;


# Low-Rating Customers
SELECT
    Customer_ID,
    Membership_Type,
    Average_Rating,
    Satisfaction_Level
FROM customerdata
WHERE Average_Rating <= 3
ORDER BY Average_Rating;


# Business related querry 

SELECT*
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
ORDER BY Days_Since_Last_Purchase DESC;



SELECT
    COUNT(*) AS at_risk_customers
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3;

# 
SELECT
    Membership_Type,
    COUNT(*) AS at_risk_customers
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
GROUP BY Membership_Type
ORDER BY at_risk_customers DESC;


# Membership-wise at-risk customers
SELECT
    Membership_Type,
    COUNT(*) AS at_risk_customers
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
GROUP BY Membership_Type
ORDER BY at_risk_customers DESC;

SELECT
    Membership_Type,
    COUNT(*) AS at_risk_customers
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
GROUP BY Membership_Type
ORDER BY at_risk_customers DESC;

SELECT
    Membership_Type,
    COUNT(*) AS at_risk_customers
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
GROUP BY Membership_Type
ORDER BY at_risk_customers DESC;


# City-wise At-Risk Customers
SELECT
    City,
    COUNT(*) AS at_risk_customers
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
GROUP BY City
ORDER BY at_risk_customers DESC;


# Membership-wise At-Risk Customers

SELECT
    Membership_Type,
    COUNT(*) AS at_risk_customers,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
GROUP BY Membership_Type
ORDER BY at_risk_customers DESC;


# City-wise At-Risk Percentage

SELECT
    City,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN Days_Since_Last_Purchase >= 60
             AND Average_Rating <= 3
            THEN 1
            ELSE 0
        END
    ) AS at_risk_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN Days_Since_Last_Purchase >= 60
                 AND Average_Rating <= 3
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS at_risk_percentage
FROM customerdata
GROUP BY City
ORDER BY at_risk_percentage DESC;


# High-Value At-Risk Customers
SELECT
    Customer_ID,
    City,
    Membership_Type,
    Total_Spend,
    Days_Since_Last_Purchase,
    Average_Rating
FROM customerdata
WHERE Days_Since_Last_Purchase >= 60
  AND Average_Rating <= 3
  AND Total_Spend >= 500
ORDER BY Total_Spend DESC;
