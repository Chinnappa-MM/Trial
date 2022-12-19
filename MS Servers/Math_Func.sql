--Mathametical Funcelect
Select * from Features
Select * from Sales
Select * from Stores
--1
Select Count(*) as Row_Count from Features where Temperature>50.00 and Unemployment>8.00

--2
Select AVG(Unemployment) as AVG_Unemploymet from Features where Temperature>60 and Fuel_Price>3

--3

Alter table Features
Add Logtemp as log10(Temperature)
--Calculated Column
--Make sure there are no -ve values in the column you are finding the Log of. Else u'll get the error "An invalid floating point operation occurred."
Delete from Features where Temperature<0 --To Remove -ve from Temaperature column

--4
Select Square(Temperature) as S_Temp from Features

--5
Select Count(*) as Count_FP_Below_Avg from Features Where Fuel_Price < 
(Select Avg(Fuel_Price) from Features)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Date Time Func 

--1
Select Day([Date]) as Day from Features

--2
SELECT DATEADD(Year,-1,[Date])as new_date from Features;
--DATE_SUB does not work on any DBMS workbenches (please Check)

--3
 Alter table Features
Add Is_Holiday as Case 
when IsHoliday='0' then 'False'
when IsHoliday='1' then 'True'
end

-- calculated Column

--4
Select Format([Date],'dd-MMM-yyyy') as Date from Features

--5
Alter Table Features Add Present_Date as getdate();
--Calculated Column

use New_HandsOn

--Innner Joins DONE!! 
--Left Joins DONE!!
--Right joins DONE!!
--Full Joins DONE!!
--Self Joins
--Cartisian Joins DONE!!
--Delete & Turnicate DONE!!
--Update DONE!!
--Update & Delete Using Joins DONE!!
--Merge
--Alter DONE!!
--Temporary Table DONE!!
--Case Statement DONE!!


--ALTER
--Modifies a table definition by altering, adding, or dropping columns and constraints.

-- Change The data type of Date column in Features table to Datetime datatype
ALTER TABLE Features
ALTER COLUMN [Date] datetime
-- Add a month column to the features table 
ALTER TABLE Features
Add Month as Month([Date])

--Temporary Table 
--Temporary tables are tables that exist temporarily on the SQL Server.The temporary tables are useful for storing the immediate result sets that are accessed multiple times.

--Create a Temp table containing Average of Temperature, Fuel_price, CPI, Unemployment of each Store where avg Cpi is less then 150
CREATE TABLE #Avg_F(Store INT, Avg_Temp DECIMAL(18,2),Avg_Fuel_P DECIMAL(18,2),Avg_CPI DECIMAL(18,2),Avg_UnEmp DECIMAL(18,2))
INSERT INTO #Avg_F(Store, Avg_Temp, Avg_Fuel_P, Avg_CPI, Avg_UnEmp)
SELECT Store,AVG(Temperature),AVG(Fuel_Price),AVG(CPI), AVG(Unemployment) FROM Features GROUP BY Store having AVG(CPI)<150 order by Store
SELECT * FROM #Avg_F

--Create a Temp table containing Average of weekly sales of each Store and dept where Average weekly sales is more then 30000
CREATE TABLE #Avg_S(Store INT, Dept INT,Avg_WS DECIMAL(18,2))
INSERT INTO #Avg_S(Store,Dept,Avg_WS)
SELECT Store, Dept, AVG(Weekly_Sales) FROM sales GROUP BY Store, Dept Having AVG(Weekly_Sales)>30000
Select * from #Avg_S

--Create a Temp table containing Minimum of Temperature, Fuel_price, CPI, Unemployment of each Store
CREATE TABLE #Min_F(Store INT, Min_Temp DECIMAL(18,2),Min_Fuel_P DECIMAL(18,2),Min_CPI DECIMAL(18,2),Min_UnEmp DECIMAL(18,2))
INSERT INTO #Min_F(Store, Min_Temp, Min_Fuel_P, Min_CPI, Min_UnEmp)
SELECT Store, MIN(Temperature), MIN(Fuel_Price), MIN(CPI), MIN(Unemployment) FROM Features GROUP BY Store
SELECT * FROM #Min_F

--Create a Temp table containing Maximum of Temperature, Fuel_price, CPI, Unemployment of each Store
CREATE TABLE #Max_F(Store INT, Max_Temp DECIMAL(18,2), Max_Fuel_P DECIMAL(18,2), Max_CPI DECIMAL(18,2),Max_UnEmp DECIMAL(18,2))
INSERT INTO #Max_F(Store, Max_Temp, Max_Fuel_P, Max_CPI, Max_UnEmp)
SELECT Store, MAX(Temperature), MAX(Fuel_Price), MAX(CPI), MAX(Unemployment) FROM [dbo].[Features] GROUP BY Store
SELECT * FROM #Max_F

-- Delete
-- Removes one or more rows from a table or view in SQL Server

-- Delete rows which have Max_CPI less then 150 and dose not belong to Store 45
DELETE 
FROM #Max_F 
where Max_CPI <150 and Store<>45

-- Turncate
-- Removes all rows from a table or specified partitions of a table, without logging the individual row deletions. TRUNCATE TABLE is similar to the DELETE statement with no WHERE clause; however, TRUNCATE TABLE is faster and uses fewer system and transaction log resources.

-- Remoove all the rows from #MIN_F without compromising the structure of the table
TRUNCATE TABLE #Min_F

-- Update
-- Changes existing data in a table or view in SQL Server.

-- Increments the maximum fuel price column values in the table #Max_F if the maximum fuel price is more then 4.00 dollors 
UPDATE #Max_F
SET Max_Fuel_P=Max_Fuel_P+1
WHERE Max_Fuel_P>4.00

-- Joins
-- By using joins, you can retrieve data from two or more tables based on logical relationships between the tables. 
-- Joins indicate how SQL Server should use data from one table to select the rows in another table..

-- SQL Server implements logical join operations, as determined by Transact-SQL syntax:
-- Inner join
-- Left join
-- Right join
-- Full join
-- Cross join

-- Inner join

-- Find the inner join of #Avg_F and #Avg_S where Average weekly sales is more then 50000
SELECT * 
FROM #Avg_F F
INNER JOIN #Avg_S S
ON F.Store=S.Store
WHERE Avg_WS>50000

-- OR

Select f.store, s.dept, AVG(s.Weekly_Sales) as A
from Features f
inner join sales s
on f.store=s.Store
GROUP BY f.Store
HAVING 

-- Left join

-- Find the Left Join of #Avg_F and #Avg_S where Average weekly sales is less then 50000
SELECT * 
FROM #Avg_F F
LEFT JOIN #Avg_S S
ON F.Store=S.Store
WHERE Avg_WS<50000

-- Right join

-- Find the Right Join of #Avg_F and #Avg_S where Average weekly sales is less then 50000
SELECT * 
FROM #Avg_F F
RIGHT JOIN #Avg_S S
ON F.Store=S.Store
WHERE Avg_WS<50000

-- Full Join

-- Find the store, Average CPI, Average fuel price and Average weekly sales using full Join on #Avg_F and #Avg_S where average Weekly sales is between 10000 to 40000
SELECT S.Store, F.Avg_CPI, F.Avg_Fuel_P, S.Avg_WS 
FROM #Avg_F F
FULL JOIN #Avg_S S
ON F.Store=S.Store
WHERE Avg_WS BETWEEN 10000 AND 40000

-- Cross Join

-- Fetch Store, Average CPI, Average fuel price and Average weekly sales using Cross Join on #Avg_F and #Avg_S where average Weekly sales is between 10000 to 40000
SELECT S.Store, F.Avg_CPI, F.Avg_Fuel_P, S.Avg_WS 
FROM #Avg_F F, #Avg_S S
WHERE Avg_WS BETWEEN 10000 AND 40000


-- Case Expression
-- SQL Server CASE expression evaluates a list of conditions and returns one of the multiple specified results. 

-- Using Case expression display a indicator column which indicates as 'High' if the Fuel Price is more then 4 dollors, 'Low' if the Fuel Price is less then 3 dollors else as 'Midium' for the table Features.
SELECT Store, Fuel_Price, 
CASE 
WHEN Fuel_Price < 3.0 THEN 'LOW'
WHEN Fuel_Price > 4.0 THEN 'HIGH'
ELSE 'MIDIUM'
END as Indicator FROM Features
GROUP BY Store, Fuel_Price

-- Delete & Update using Joins

-- Delete the rows in #Avg_S where Average weekly sales is more then 50000 using Delete with joins
DELETE #Avg_S
FROM #Avg_S S
JOIN #Avg_F F
ON S.Store = F.Store
WHERE Avg_WS>50000

-- Increment average weekly sales with 500 in #Avg_S where Average weekly sales is less then 30000 using Update with joins
UPDATE #Avg_S
SET Avg_WS= Avg_WS+500
FROM #Avg_S S
JOIN #Avg_F F
ON S.Store = F.Store
WHERE Avg_WS<30000

DECLARE 
    @local_time DATETIME,
    @utc_time DATETIME;

SET @local_time = GETDATE();
SET @utc_time = GETUTCDATE();

SELECT 
    CONVERT(VARCHAR(40), @local_time) 
        AS 'Server local time';
SELECT 
    CONVERT(VARCHAR(40), @utc_time) 
        AS 'Server UTC time'
SELECT 
    CONVERT(VARCHAR(40), DATEDIFF(hour, @utc_time, @local_time)) 
        AS 'Server time zone';




