
select * 
from [kirillclassSQL].[dbo].[P12-ListOfOrders] lo
left join [kirillclassSQL].[dbo].[P12-OrderBreakdown] ob
	on lo.[Order ID] = ob.[Order ID]
order by lo.[Order ID]