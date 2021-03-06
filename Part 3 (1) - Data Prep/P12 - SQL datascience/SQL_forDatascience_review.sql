/****** Kirill goes through very basic SQL tactics
  ******/


SELECT [Order ID]
      ,[Product Name]
      ,[Discount]
      ,[Sales]
      ,[Quantity]
      ,[Category]
  FROM [kirillclassSQL].[dbo].[P12-OrderBreakdown]
  where [Category] = 'Furniture'
  and Convert(Float,[Sales]) > 100
  order by cast([Sales] as float) desc