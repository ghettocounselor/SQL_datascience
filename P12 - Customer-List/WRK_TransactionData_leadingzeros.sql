/****** 
Notice the leading zeros on the Customer ID
  ******/
SELECT TOP (1000) [RowNumber]
      ,[Order ID]
      ,[Order Date]
      ,[Customer ID]
      ,[Region]
      ,[Rep]
      ,[Item]
      ,[Units]
      ,[Unit Price]
  FROM [kirillclassSQL].[dbo].[RAW_TransactionData]