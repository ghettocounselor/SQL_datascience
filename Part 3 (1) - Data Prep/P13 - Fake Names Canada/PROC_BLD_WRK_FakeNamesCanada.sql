USE [kirillclassSQL]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_FakeNamesCanada]    Script Date: 4/8/2019 5:08:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_FakeNamesCanada] 
-- naming is basically indicative of what you are doing BLD to WRK and the table you are hitting

-- ============================================= keep notes here so it is saved with altered proc process
-- Author:	Mark Loessi	
-- Create date: April 2019
-- Description:	Datascience A-Z 
-- Lecture 176 
-- working with the FakeNamesCanada datafile
-- =============================================

AS
BEGIN
-- =============================================
-- LECTURE 7 DROP TABLE see more here: https://docs.microsoft.com/en-us/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-2017
-- =============================================
IF OBJECT_ID('WRK_FakeNamesCanada') IS NOT NULL
BEGIN
DROP TABLE [WRK_FakeNamesCanada]
END
-- =============================================
-- LECTURE 176 CREATE TABLE
-- =============================================
CREATE TABLE [WRK_FakeNamesCanada]
(		
	[RowNumber]		INT IDENTITY(1,1)
	,[Number]			VARCHAR(100)
	,[Gender]			VARCHAR(10)
	,[GivenName]		VARCHAR(1000)
	,[Surname]			VARCHAR(1000)
	,[StreetAddress]	VARCHAR(1000)
	,[City]				VARCHAR(1000)
	,[ZipCode]			VARCHAR(7)
	,[CountryFull]		VARCHAR(100)
	,[Birthday]			DATE
	,[Balance]			FLOAT
	,[InterestRate]		FLOAT
	/*    EXAMPLE TYPES
    ,[Order ID]		VARCHAR(100)	-- LITTLE TRICKY IF YOU WANTED TO SORT BUT VARCHAR IS GENERALLY BEST
    ,[Order Date]	DATE
    ,[Customer ID]	VARCHAR(100)
    ,[Region]		VARCHAR(1)
    ,[Rep]			VARCHAR(100)
    ,[Item]			VARCHAR(1000)
    ,[Units]		INT
    ,[Unit Price]	FLOAT	
	*/		
)
-- =============================================
-- LECTURE 176 TRUNCATE TABLE TO CLEAN UP
-- =============================================
TRUNCATE TABLE [WRK_FakeNamesCanada]
-- =============================================
-- LECTURE 176 INSERT DATA INTO OUR NEW TABLE
-- =============================================
INSERT INTO [WRK_FakeNamesCanada]
(
	[Number]
	,[Gender]
	,[GivenName]
	,[Surname]
	,[StreetAddress]
	,[City]
	,[ZipCode]
	,[CountryFull]
	,[Birthday]
	,[Balance]
	,[InterestRate]
)
SELECT -- CAST OR CONVERT DONE BELOW IF NEEDED
	[Number]
	,[Gender]
	,[GivenName]
	,[Surname]
	,[StreetAddress]
	,[City]
	,[ZipCode]
	,[CountryFull]
	,[Birthday]
	,[Balance]
	,[InterestRate]
FROM [RAW_FakeNamesCanada]		
-- (199987 row(s) affected)  GOOD DOCUMENTATION
-- filters Lecture 177, 178, 179
WHERE ISNUMERIC([BALANCE]) = 1	-- 10 bad rows with text in column
AND LEN([ZipCode]) <= 7			-- 2 ROWS HAVE EXTRA CHARACTER
AND ISDATE([BIRTHDAY]) = 1		-- 1 ROW HAS NONE DATE IN ROW
-- =============================================
-- additional exclusions based on irregular data 
-- Lectures 180, 181, 182
-- =============================================
-- YOU COULD ALSO DELETE THE ROW FROM THE DATA WITH THE DELETE PROCESS
DELETE
FROM [WRK_FakeNamesCanada]
WHERE [Balance] < 0						-- DELETED 1 ROW HERE
-- COULD HAVE DONE THIS ABOVE IN THE INSERT STATEMENT LIKE THIS
-- and ISNUMERIC([BALANCE]) = 1 AND CAST([BALANCE] AS FLOAT) > 0

DELETE  -- good example of checking the structure of a column's data
FROM [WRK_FakeNamesCanada]	-- we expect zip to be 3 char spac 3 char those that aren't should be removed
WHERE [ZipCode] Not like '___ ___'		-- DELETED 4 ROWs HERE

DELETE  -- good example of checking for anomalies
-- NOTE: Kirill in class handled this differently, interestingly enough MAC XLS appt translated data differently
FROM [WRK_FakeNamesCanada]	-- BIRTHDAY IS MESSED UP
WHERE [Number]  in ('65537','23077')	-- DELETED 2 ROWs HERE with peculiar date of birth verified in original data to be missing year


END

/*
  SELECT * FROM [kirillclassSQL].[dbo].[RAW_CustomerListing]

  DISCUSS WHY THESE VARIABLE TYPES
  	[RowNumber]		INT IDENTITY(1,1)
	,[Customer ID]	VARCHAR(100)		-- LIKE ZIP CODE THIS ISN'T A NUMBER WE'D DO ANY MATHMATICS WITH THIS
	,[City]			VARCHAR(1000)		-- VARCHAR AND DEFAULT 1000 FOR TEXT STUFF
	,[ZipCode]		VARCHAR(5)			-- ZIP CODE IS A CATEGORICAL VARIABLE IT'S NOT A REAL NUMBER, WE WON'T ADD, ETC...
	,[Gender]		VARCHAR(1)			-- HERE WE KNOW THERE IS ONLY 1 CHARACTER
	,[Age]			FLOAT				-- FLOAT BECAUSE THERE ARE DECIMALS IN OUR NUMBERS

  */
