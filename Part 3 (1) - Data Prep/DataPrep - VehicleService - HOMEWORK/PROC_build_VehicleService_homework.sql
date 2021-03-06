USE [kirillclassSQL]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_VehicleServiceHWv3]    Script Date: 4/7/2019 6:15:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_VehicleServiceHWv3] 
-- naming is basically indicative of what you are doing BLD to WRK and the table you are hitting

-- ============================================= keep notes here so it is saved with altered proc process
-- Author:	Mark Loessi	
-- Create date: April 2019
-- Description:	Datascience A-Z 
-- Lecture 208, 209, 210 HOMEWORK 
-- =============================================

AS
BEGIN
-- =============================================
-- LECTURE 7 DROP TABLE see more here: https://docs.microsoft.com/en-us/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-2017
-- =============================================
IF OBJECT_ID('WRK_VehicleServiceHWv3') IS NOT NULL
BEGIN
DROP TABLE [WRK_VehicleServiceHWv3]
END
-- =============================================
-- LECTURE 163 CREATE TABLE
-- =============================================
CREATE TABLE [WRK_VehicleServiceHWv3]
(		
	[RowNumber]			INT IDENTITY(1,1)
	,[CustomerID]		VARCHAR(100)
    ,[CustomerSince]	DATE
    ,[Vehicle]			VARCHAR(1000)
    ,[2014]				FLOAT
    ,[2015]				FLOAT
    ,[2016E]			FLOAT
	-- CONFIRMED IN SQL THAT COLUMN 6 IS EMPTY
	
)
-- =============================================
-- LECTURE 165 TRUNCATE TABLE TO CLEAN UP
-- =============================================
TRUNCATE TABLE [WRK_VehicleServiceHWv3]
-- =============================================
-- LECTURE 164 INSERT DATA INTO OUR NEW TABLE
-- note you 'really' only need to use the columns that you need
-- but that's not what you generally want to do because you might
-- find that the other data helps you spot things in the data ;) 
-- =============================================
INSERT INTO [WRK_VehicleServiceHWv3]
(
    [CustomerID]
    ,[CustomerSince]
    ,[Vehicle]
    ,[2014]
    ,[2015]
    ,[2016E]

)
SELECT -- CAST OR CONVERT DONE BELOW IF NEEDED
    [CustomerID]
    ,[CustomerSince]
    ,[Vehicle]
	,[2014]
    ,[2015]
    ,[2016E]
FROM [RAW_VehicleServiceHWv3]	-- !!!!!!!!!!!!! if you run don't forget bit below !!!!!!!!!!!!!!!!!!!!!11
-- EXCLUSIONS
--- 5 ERROR ISSUES discovered
-- 1 --- one row 2738818 in data had a ; instead of a decimal place which gave us an extra column - was excluded in SSIS package
-- 2 --- one row 676802 in data had a $ instead of a decimal place so we pulled this in SQL 
-- 3 --- one customer number was duplicaed (with two dif cars) 
-- CustomerID	CustomerSince	Vehicle	2014	2015	2016E
-- 3490750	2006-05-17	2007 Tata Sumo	349.88	340.62	517.2
-- 3490750	2006-01-22	2004 Volkswagen Touran	735.77	741.23	314.09
-- 4 --- one customer is a customer since 1899 :D 2942833 SINCE 1899-04-30
-- 5 --- one customer had a 2014 of 20000 as in 20,000 :)  

-- Work through 
-- ERROR EXCLUSION #1 of 5 handled in SSIS package see BadRecords file
-- ERROR EXCLUSION #2 OF 5 -- handled here in SQL of Proc
WHERE ISNUMERIC([2015]) = 1 OR [2015] = '' -- EXCLUDING ROW 676802 WHERE DECIMAL WAS REPLACED WITH A $
-- (1049998 row(s) affected)  GOOD DOCUMENTATION
--AND CUSTOMERID LIKE '3437651' -- 2014 IS 2014
END

-- ADDITIONAL CHECKS
-- CHECK THE ORGINAL SUGGESTIONS 
-- ERROR #3 OF 5
-- 1. NO DUPS OF CUSTOMER ID stated in our documentation - NOT TRUE
/*
SELECT -- WE HAVE ONE DUP 3490750 - TWO DIF CARS ??
CUSTOMERID
,COUNT(CUSTOMERID) AS COUNTOFCUSID
--SUM(2016e) AS SUM2016E
FROM WRK_VehicleServiceHWv3
GROUP BY CUSTOMERID
HAVING COUNT(CUSTOMERID) > 1
*/
-- ERROR #4 OF 5
/*
-- 2. really old records, lets check back 50 years
SELECT -- WE HAVE ONE  2942833 SINCE 1899-04-30 :) excluded
CUSTOMERID, CustomerSince
FROM WRK_VehicleServiceHWv3
WHERE CustomerSince < '1965-01-01'
*/
-- ERROR #5 OF 5
/*
-- 3. really high numbers - fat finger
SELECT AVG([2014]) -- 388.33
FROM WRK_VehicleServiceHWv3
SELECT max([2014]) -- 20,000 :) customer id 3437651 excluded
FROM WRK_VehicleServiceHWv3
SELECT AVG([2015]) -- 399.94
FROM WRK_VehicleServiceHWv3
SELECT max([2015]) -- 800.00
FROM WRK_VehicleServiceHWv3
SELECT AVG([2016E]) -- 399.90
FROM WRK_VehicleServiceHWv3
SELECT max([2016E]) -- 800
FROM WRK_VehicleServiceHWv3
*/
/*
-- 3. CHECK THE SUM -- 419895286.179999
-- EXCLUDED IN SQL IS 175.80  -- EXCLUDING ROW 676802 because of $ in 2015 number
-- EXCLUDED IN SSIS IS 725.89 -- EXCLUDING CUSTOMER ID 2738818 because of ; in 2014 number
-- EXPECTED TOTAL IS 429896187.87
-- THEY MATCH!
*/

