/****** 
TRANSLATE ALL CRAZINESS DISCVOERED INTO FILTERS
 ******/

DROP TABLE [#tmp_WRK_VehicleServiceHWv3]

SELECT 
	[CustomerID]
    ,[CustomerSince]
    ,[Vehicle]
    ,[2014]
    ,[2015]
    ,[2016E]
	INTO #tmp_WRK_VehicleServiceHWv3
  FROM [WRK_VehicleServiceHWv3]
  	
  WHERE 1 = 1 
  --AND CUSTOMERID NOT LIKE '3490750'	-- TWO DIF CARS ??
  --AND CustomerSince > '1965-01-01'	-- DUH
  --AND CUSTOMERID NOT LIKE '3437651'	-- FAT FINGER 2014 COST

  SELECT * FROM #tmp_WRK_VehicleServiceHWv3

 SELECT SUM([2016E]) 
	+ 175.80 /* EXCLUDED IN SQL */  -- EXCLUDING ROW 676802
	+ 725.89 /* EXCLUDED IN SSIS */
  AS SUM2016E FROM #tmp_WRK_VehicleServiceHWv3
  -- EXCLUDING ROW 676802
