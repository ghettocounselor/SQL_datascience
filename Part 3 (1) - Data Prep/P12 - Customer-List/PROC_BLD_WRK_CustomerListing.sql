USE [kirillclassSQL]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_CustomerListing]    Script Date: 4/2/2019 5:08:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_CustomerListing] -- naming is basically indicative of what you are doing BLD to WRK and the table you are hitting

-- ============================================= keep notes here so it is saved with altered proc process
-- Author:	Mark Loessi	
-- Create date: April 2019
-- Description:	Datascience A-Z 
-- Lecture 160 on with Stored Procedures
-- =============================================

AS
BEGIN
-- =============================================
-- LECTURE 165 DROP TABLE
-- =============================================
IF OBJECT_ID('WRK_CustomerListing') IS NOT NULL
DROP TABLE [WRK_CustomerListing]

-- =============================================
-- LECTURE 163 CREATE TABLE
-- =============================================
CREATE TABLE [WRK_CustomerListing]
(		
	[RowNumber]		INT IDENTITY(1,1)
	,[Customer ID]	VARCHAR(100)		
	,[City]			VARCHAR(1000)		
	,[ZipCode]		VARCHAR(5)			
	,[Gender]		VARCHAR(1)			
	,[Age]			FLOAT				
)
-- =============================================
-- LECTURE 165 TRUNCATE TABLE TO CLEAN UP
-- =============================================
TRUNCATE TABLE [WRK_CustomerListing]
-- =============================================
-- LECTURE 164 INSERT DATA INTO OUR NEW TABLE
-- =============================================
INSERT INTO [WRK_CustomerListing]
(
	[Customer ID]			
	,[City]				
	,[ZipCode]					
	,[Gender]					
	,[Age]	
)
SELECT 
	RIGHT('0000000'+[Customer ID],7)	-- THIS WILL CREATE A 7 DIGIT CUSTOMER ID WITH LEADING ZEROS TO MATCH TXN DATA	
	,[City]				
	,[ZipCode]					
	,[Gender]					
	,[Age] 
FROM [RAW_CustomerListing]		
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
