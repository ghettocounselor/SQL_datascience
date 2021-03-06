USE [kirillclassSQL]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_TransactionData]    Script Date: 4/2/2019 5:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_TransactionData] -- naming is basically indicative of what you are doing BLD to WRK and the table you are hitting

-- ============================================= keep notes here so it is saved with altered proc process
-- Author:	Mark Loessi	
-- Create date: April 2019
-- Description:	Datascience A-Z 
-- Lecture 160 on with Stored Procedures
-- =============================================

AS
BEGIN
-- =============================================
-- LECTURE 7 DROP TABLE
-- =============================================
IF OBJECT_ID('WRK_CustomerListing') IS NOT NULL
DROP TABLE [WRK_TransactionData]

-- =============================================
-- LECTURE 163 CREATE TABLE
-- =============================================
CREATE TABLE [WRK_TransactionData]
(		
	[RowNumber]		INT IDENTITY(1,1)
    ,[Order ID]		VARCHAR(100)	-- LITTLE TRICKY IF YOU WANTED TO SORT BUT VARCHAR IS GENERALLY BEST
    ,[Order Date]	DATE
    ,[Customer ID]	VARCHAR(100)
    ,[Region]		VARCHAR(1)
    ,[Rep]			VARCHAR(100)
    ,[Item]			VARCHAR(1000)
    ,[Units]		INT
    ,[Unit Price]	FLOAT			
)
-- =============================================
-- LECTURE 165 TRUNCATE TABLE TO CLEAN UP
-- =============================================
TRUNCATE TABLE [WRK_TransactionData]
-- =============================================
-- LECTURE 164 INSERT DATA INTO OUR NEW TABLE
-- =============================================
INSERT INTO [WRK_TransactionData]
(
    [Order ID]
    ,[Order Date] 
    ,[Customer ID]
    ,[Region]
    ,[Rep]
    ,[Item]
    ,[Units]
    ,[Unit Price]
)
SELECT		-- IF YOU NEED TO CONVERT OR CAST OR CHANGE DATA YOU DO IT HEREE      
    [Order ID]
    ,[Order Date]
	--,CONVERT(DATE,[Order Date],111)
    ,[Customer ID]
    ,[Region]
    ,[Rep]
    ,[Item]
    ,[Units]
    ,[Unit Price]
FROM [RAW_TransactionData]		
-- (43 row(s) affected)  GOOD DOCUMENTATION

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
