/****** 
Kirill going through various basic SQL syntax
WILDCARDS
  ******/
SELECT [Order ID]
      ,[Order Date]
      ,[Customer Name]
      ,[Country]
  FROM [kirillclassSQL].[dbo].[P12-ListOfOrders]
 WHERE [Customer Name] LIKE '____E%' -- THE UNDERSCORE ALLOWS YOU TO SAY _ A CHARACTER OR ____ FOUR CHARACTERS IN ....
 
 -- WHERE [ORDER ID] LIKE 'ES%'