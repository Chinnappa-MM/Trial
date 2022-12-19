-- DateTime Func

-- 1. Returning the current date and time
-- GETDATE() & CURRENT_TIMESTAMP    DONE!!
-- GETUTCDATE()      
-- SYSDATETIME()
-- SYSUTCDATETIME()
-- SYSDATETIMEOFFSET()              

-- 2.Returning the date and time Parts
-- DAY()    DONE!!
-- MONTH()    DONE!!
-- YEAR()    DONE!!
-- DATEPART()    DONE!!
-- DATENAME()

-- 3.Returning a difference between two dates
-- DATEDIFF()    DONE!!

-- 4.Modifying dates
-- DATEADD()    DONE!!
-- EOMONTH()
-- SWITCHOFFSET()
-- TODATETIMEOFFSET()	

-- 5.Validating date and time values
-- ISDATE()

-- 6.Constructing date and time from their parts
--   MISSING!!

-- Write a query to display the current Date and time
SELECT GETDATE() as Current_date_time
-- or
SELECT CURRENT_TIMESTAMP as Current_date_time

-- Display Days, Month, Year from Date column in features table
SELECT Day([date])as Day, MONTH(date)as Month, YEAR(date)as Year from features
-- or
-- Display Quater, Day of the year from Date column in features table using Datepart function
SELECT DATEPART(QQ,[date])as Quater, DATEPART(DY,[date])as Day_of_the_Year from features

--Display a column which calculates how many months its been for each of the date given in the Sales table
SELECT [Date],DATEDIFF(MONTH,[Date],GETDATE()) as Days_ago FROM Sales

--Display 2 columns which shows the exact date before and after 3 months of each record in Date column from Sales table
SELECT [Date],DATEADD(MM,-3,[Date])as Before_3_Months, DATEADD(MM,3,[Date])as After_3_Months from Features 