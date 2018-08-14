select
	top 1
	/*ds not null*/
	orderid,  
	/* nullable  ????  what to do?  */
	startdate,  
	/*ds not null*/
	account,  
	/*ds not null*/
	country,  
	/*ds not null*/
	ordertypeid, 
	/*ds not null*/
	tax, 
	/*ds not null*/
	total 
from [dbo].[vAllocationDetail]
	where ordertypeid in (1,2,3) and orderid > 0
	and entdate = '2018-06-01'
/*  and entdate = DATEADD(day,-61,getdate()) */