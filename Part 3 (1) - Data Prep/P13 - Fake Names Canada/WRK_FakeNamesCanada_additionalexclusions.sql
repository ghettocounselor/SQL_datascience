/****** 
looking at additional exclusions
  ******/
SELECT *
	FROM [kirillclassSQL].[dbo].[RAW_FakeNamesCanada]
	--FROM [kirillclassSQL].[dbo].[WRK_FakeNamesCanada]
  where 1 = 1
	and ISNUMERIC([BALANCE]) = 1 AND CAST([BALANCE] AS FLOAT) > 0
 
 -- and [balance] > 0
  --AND [ZipCode] not like '___ ___'
  --or [ZipCode] like 'joym2j10'
	--AND ISDATE([BIRTHDAY]) = 0
  --and [Birthday] > '2005-08-13'
  --AND GivenName LIKE 'MELVIN'
  --AND Surname LIKE 'MORRIS'