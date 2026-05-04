CREATE DATABASE kenya_debt;
USE kenya_debt;

-- see all rows
SELECT * FROM public_debt;

-- see specific colums
SELECT Year, Month, Total from public_debt;

-- debt from year 2021
SELECT * FROM public_debt WHERE Year=2021;

-- show years after 2015
SELECT * FROM public_debt WHERE Year > 2015;

-- specific year and month
SELECT * FROM public_debt WHERE Year = 2015 AND Month= 'June';

-- sort by total debt highest to lowest
SELECT * FROM public_debt ORDER BY Total Desc;

-- sort by year oldest to newest
SELECT * FROM public_debt ORDER BY Year Asc;

-- total sum of all debt
SELECT SUM(Total) AS Total_All_Years FROM public_debt;

-- average monthly debt 
SELECT AVG(Total) As Average_Monthly_Debt FROM public_debt;

-- highest and lowest debt ever recorded
SELECT MAX(Total) AS Highest_Debt, Min(Total) As Lowest_Debt FROM public_debt;

-- total number of records
SELECT COUNT(*) AS Total_Records FROM public_debt;

-- total debt per year
SELECT Year, Sum(Total) As Yearly_Total_Debt from public_debt GROUP BY Year Order by Year Asc;

-- average debt per year
SELECT Year, AVG(Total) AS Avg_Monthly_Debt, MAX(Total) AS Peak_debt FROM public_debt GROUP BY Year ORDER BY YEAR Asc;

-- show only years where total debt exceeded 5,000,000
SELECT YEAR,
 SUM(TOTAL) AS Yearly_Total_Debt
FROM public_debt
GROUP BY Year 
HAVING SUM(Total) > 5000000
ORDER BY Year Asc; 

-- What is the Year with the highest debt growth?
SELECT YEAR,
  SUM(Total) AS Yearly_Total,
  SUM(TOTAL) -LAG(SUM(Total)) OVER (ORDER BY YEAR) AS Yearly_Growth
FROM public_debt
GROUP BY Year 
ORDER BY Year Asc;

-- which month consistently has the highest debt?
SELECT MONTH,
  AVG(Total) AS AVG_Debt,
  COUNT(*) AS Times_Recorded
FROM public_debt
GROUP BY Month 
ORDER BY AVG_Debt DESC;

-- Domestic vs external debt ratio per year ERROR
SELECT 
    Year,
    ROUND(AVG(`Domestic Debt`), 2) AS Avg_Domestic,
    ROUND(AVG(`External Debt`), 2) AS Avg_External,
    ROUND(AVG(`Domestic Debt`) / AVG(Total) * 100, 2) AS Domestic_Pct,
    ROUND(AVG(`External Debt`) / AVG(Total) * 100, 2) AS External_Pct
FROM public_debt
GROUP BY Year
ORDER BY Year ASC;

SELECT 
    Year,
    ROUND(AVG(`Domestic Debt`) / AVG(Total) * 100, 2) AS Domestic_Pct,
    ROUND(AVG(`External Debt`) / AVG(Total) * 100, 2) AS External_Pct
FROM public_debt
GROUP BY Year
ORDER BY Year ASC;

--  Top 5 Highest Debt Months Ever
SELECT 
    Year,
    Month,
    Total AS Total_Debt
FROM public_debt
ORDER BY Total DESC
LIMIT 5;

-- Debt Milestones — When Did Debt Cross Key Thresholds?
-- When did debt first cross 1 Million?
SELECT Year, Month, Total
FROM public_debt
WHERE Total > 1000000
ORDER BY Year ASC
LIMIT 1;

-- When did debt first cross 5 Million?
SELECT Year, Month, Total
FROM public_debt
WHERE Total > 5000000
ORDER BY Year ASC
LIMIT 1;

-- When did debt first cross 8 Million?
SELECT Year, Month, Total
FROM public_debt
WHERE Total > 8000000
ORDER BY Year ASC
LIMIT 1;

  