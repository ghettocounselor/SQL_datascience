USE [kirillclassSQL]
GO
/****** Object:  StoredProcedure [dbo].[__TMPL__BLD_WRK_TableName]    Script Date: 4/6/2019 4:34:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[__TMPL__BLD_WRK_TableName] 
-- naming is basically indicative of what you are doing BLD to WRK and the table you are hitting

-- ============================================= keep notes here so it is saved with altered proc process
-- Author:	Mark Loessi	
-- Create date: April 2019
-- Description:	Datascience A-Z 
-- Lecture 160 on with Stored Procedures
-- =============================================

AS
BEGIN
-- =============================================
-- LECTURE 7 DROP TABLE see more here: https://docs.microsoft.com/en-us/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-2017
-- =============================================
IF OBJECT_ID('WRK_TableName') IS NOT NULL
BEGIN
DROP TABLE [WRK_TableName]
END
-- =============================================
-- LECTURE 163 CREATE TABLE
-- =============================================
CREATE TABLE [WRK_TableName]
(		
	[RowNumber]		INT IDENTITY(1,1)
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
-- LECTURE 165 TRUNCATE TABLE TO CLEAN UP
-- =============================================
TRUNCATE TABLE [WRK_TableName]
-- =============================================
-- LECTURE 164 INSERT DATA INTO OUR NEW TABLE
-- note you 'really' only need to use the columns that you need
-- but that's not what you generally want to do because you might
-- find that the other data helps you spot things in the data ;) 
-- =============================================
INSERT INTO [WRK_TableName]
(
    [AAAA]
    ,[BBBB]
    ,[DDDD]
    ,[EEEE]
    ,[FFFF]

) -- !! NOTE: in the insert process is where we'll see issues
-- between the data we are importing and the data types we defined above
SELECT -- CAST OR CONVERT DONE BELOW IF NEEDED
    [XAAAA]
    ,[XBBBB]
    ,[XDDDD]
    ,[XEEEE]
    ,[XFFFF]
FROM [BLD_TableName]		
-- (X row(s) affected)  GOOD DOCUMENTATION

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
