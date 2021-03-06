USE [kirillclassSQL]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BLD_DRV_CustomerTransactionListGenderRev] 
-- naming is basically indicative of what you are doing BLD to WRK and the table you are hitting

-- ============================================= keep notes here so it is saved with altered proc process
-- Author:	Mark Loessi	
-- Create date: April 2019
-- Description:	Datascience A-Z - work to a drv table (drive table he calls this)
-- Lecture 160 on with Stored Procedures
-- =============================================

AS
BEGIN

/*
DROP TABLE [dbo].[BLD_DRV_CustomerTransactionListGenderRev]
*/

/****** 
creating table for some future analysis
  ******/
SELECT 
	cl.[Customer ID]
	,cl.[Gender]
	,td.Units * td.[Unit Price] AS [Revenue]
  INTO [dbo].[BLD_DRV_CustomerTransactionListGenderRev]
  FROM [kirillclassSQL].[dbo].[WRK_CustomerListing] cl
  LEFT JOIN [kirillclassSQL].[dbo].[WRK_TransactionData] td
	ON cl.[Customer ID] = td.[Customer ID]

END

-- (43 row(s) affected)