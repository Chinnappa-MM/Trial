Create Database pp;
use AdventureWorks2012;
Select * from HumanResources.Department
use New_HandsOn;

Drop table sales;
Drop table stores

Drop DATABASE New_HandsOn

UPDATE Features SET IsHoliday = Is_Holiday;

Select * from Sales
Select * from Stores

alter table Features
alter column IsHoliday Varchar(10)

alter table Stores
alter column [Type] Char(1)

alter table Stores
alter column Size int

alter table Sales
alter column Weekly_Sales Decimal(18,2)

alter table Features
alter column Fuel_Price Decimal(18,2)

alter table Features
alter column Temperature Decimal(18,2);

alter table Features
alter column IsHoliday Bit;

Update Features
Set CPI = null
Where CPI= 'NA'

alter table Features
alter column CPI Decimal(18,2)

Update Features
Set Unemployment = null
Where Unemployment=0

alter table Features
alter column Unemployment Decimal(18,2)

--VarCHar to DAte
UPDATE Features
SET [Date] = right([Date],4) + '-' + left([Date],2) + '-' + left(right([Date],7),2);

UPDATE Features
SET [Date]=trim([Date])

UPDATE Features
    SET [Date] = TRY_CONVERT(Date, [Date], 101);

select [Date]
from Features
where try_convert(date, [Date], 101) is null and
      [Date] is not null;

Declare @d date;
Declare @d1 varchar(20);
set @d1 = '2022-01-22'
set @d=@d1;
print Year(@d)

-- Actual Hands On 

--Mathametical Func

--1
Select Count(*) as Row_Count from Features where Temperature>50.00 and Unemployment>8.00

--2
Select AVG(Unemployment) as AVG_Unemploymet from Features where Temperature>60 and Fuel_Price>3

--3
Alter table Features
Add Logtemp as log10(Temperature)

--4
Select Square(Temperature) as S_Temp from Features

--5
Select Count(*) as Count_FP_Below_Avg from Features Where Fuel_Price < 
(Select Avg(Fuel_Price) from Features)
