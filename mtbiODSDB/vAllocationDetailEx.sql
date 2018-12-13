USE [mtbiODS]
GO

/****** Object:  View [dbo].[vAllocationDetailEx]    Script Date: 12/13/2018 1:54:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





































































































CREATE VIEW [dbo].[vAllocationDetailEx]
AS

SELECT	a.applyno,
		a.creditapplyno,
		a.id AS allocationid,
		a.cashcreditid,
		a.allocationtypeid,
		a.ordertypeid,
		a.account,
		a.importance,
		a.city,
		a.statename,
		a.country,
		a.zip,
		a.service,
		a.entdate,
		a.enttime,
		CAST(DATEADD(DAY,-1,DATEADD(wk, DATEDIFF(wk, 0, a.entdate), 0))AS DATE) AS entweek,
		CAST(DATEADD(month, DATEDIFF(month, 0, a.entdate), 0) AS DATE) AS entmonth,
		CAST(FORMAT(a.entdate,'yyyyMMdd') AS INT) AS datekey,
		a.invno,
		a.payno,
		a.voidtran,
		a.orderid,
		a.orderserviceid,
		a.invordertype,
		a.invorderid,
		a.servicechangeno,
		ISNULL(a.servicechangetypeid,1) AS servicechangetypeid,
		ISNULL(IIF(a.isnew = 1 AND a.servicechangetypeid != 2, ' No Change', sct.descr), 'No Change') as servicechangetype,
		ISNULL(a.servicechangeperc,0) AS servicechangeperc,
		ISNULL(sct.bonus_eligible,1) AS bonus_eligible,
		a.servdef,
		IIF(a.isnew = 1,'New','Renewal') AS newrenewal,
		a.isfirstorder,
		a.isfirstclassorder,
		a.firstorderdate,
		a.isfirstserviceorder,
		a.firstserviceorderdate,
		CASE WHEN a.servdef = 0 AND inv.descr LIKE '%GPU%' THEN 'Shared'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%ProCDN%' THEN 'CloudTech'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%' THEN 'VPS'
			 WHEN a.servdef = 0 THEN 'Other'
			 ELSE ISNULL(sdm.Product_Category,'Unknown')
		END AS Product_Category,
		CASE WHEN a.servdef = 0 AND inv.descr LIKE '%GPU%' THEN 'Grid'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%ProCDN%' THEN 'CloudTech'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%' THEN 'DV/VE'
			 WHEN a.servdef = 0 THEN 'Other'
			 ELSE ISNULL(sdm.Product_Group,'Unknown') 
		END AS Product_Group,
		CASE WHEN a.servdef = 0 AND inv.descr LIKE '%GPU%' THEN 'GPU'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%ProCDN%' THEN 'CDN'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%' THEN 'Bandwidth'
			 WHEN a.servdef = 0 THEN 'Other'
			 ELSE ISNULL(sdm.Product_Class,'Unknown')
		END AS Product_Class,
		CASE WHEN a.servdef = 0 AND inv.descr LIKE '%GPU%' THEN 'GPU Overage'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%ProCDN%' THEN 'CDN Overage'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%' THEN 'Bandwidth Overage'
			 WHEN a.servdef = 0 THEN 'Misc Fee'
			 ELSE ISNULL(sdm.Product_Line,'Unknown')
		END AS Product_Line,
		ISNULL(IIF(a.servdef=0,'Active',sdm.Product_Status),'Unknown') AS Product_Status,
		ISNULL(sdm.pclass,'Other') AS pclass,
		CASE WHEN a.servdef = 0 AND inv.descr LIKE '%GPU%' THEN 'GPU'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%ProCDN%' THEN 'CDN'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%' THEN 'Bandwidth'
			 WHEN a.servdef = 0 THEN 'Other'
			 ELSE ISNULL(sdm.class,'Other')
		END AS class,
		CASE WHEN a.servdef = 0 AND inv.descr LIKE '%GPU%' THEN 'GPU Overage'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%ProCDN%' THEN 'CDN Overage'
			 WHEN a.servdef = 0 AND inv.descr LIKE '%Netflow Overage%' THEN 'Bandwidth Overage'
			 WHEN a.servdef = 0 THEN 'Misc Fee'
			 ELSE ISNULL(sdm.name,'')
		END AS name,
		ISNULL(sdm.PnL_Category,'Unknown') AS PnL_Category,
		ISNULL(sdm.PnL_Revenue_Description,'Unknown') AS PnL_Revenue_Description,
		IIF(a.servdef=0,0,sdm.addon) AS addon,
		IIF(a.servdef=0,0,sdm.duration) AS servdefduration,
		IIF(a.servdef=0,'One-Time',sdm.term) AS term,
		REPLACE(inv.descr, CHAR(9), '') AS invdescr,
		inv.startdate,
		inv.enddate,
		a.empl,
		ad.dept as ad_dept,
		pop.default_dept as pop_default_dept,
		COALESCE(ad.dept,pop.default_dept,'Unk') AS dept_org,
		COALESCE(md.newdept,ad.dept,ISNULL(pop.default_dept,'Unk')) as dept_ex,
		IIF(ad.dept is null, -- is it null, then check the pop_default_dept
    	 IIF(pop.default_dept is not null and pop.default_dept <> 'Other' and pop.default_dept <> 'Unk',pop.default_dept,COALESCE(md.newdept,ad.dept,ISNULL(pop.default_dept,'Unk'))),
		 IIF(ad.dept <> 'Other' and ad.dept <> 'Unk' , ad.dept , COALESCE(md.newdept,ad.dept,ISNULL(pop.default_dept,'Unk'))) )  as dept,
		ISNULL(pop.pointofpurchase,'Unk') AS pointofpurchase,
		IIF(pop.pointofpurchase='Web',COALESCE(pap.pchannel,ga.pchannel,'Unk'),IIF(COALESCE(ad.dept,pop.default_dept,'Unk') IN ('Other',''),'ES',IIF(COALESCE(ad.dept,pop.default_dept,'Unk') ='CT','CS',COALESCE(ad.dept,pop.default_dept,'Unk')))) AS pchannel,
		IIF(pop.pointofpurchase='Web',COALESCE(pap.channel,ga.channel,'Unk'),IIF(COALESCE(ad.dept,pop.default_dept,'Unk') IN ('Other',''),'ES',IIF(COALESCE(ad.dept,pop.default_dept,'Unk') ='CT','CS',COALESCE(ad.dept,pop.default_dept,'Unk')))) AS channel,
		ISNULL(ga.ga_channel,'Unk') AS ga_channel,
		ISNULL(ga.ga_medium,'Unk') AS ga_medium,
		ISNULL(ga.ga_campaign,'Unk') AS ga_campaign,
		ISNULL(ga.ga_landingpage,'Unk') AS ga_landingpage,
		ISNULL(ga.ga_source,'Unk') AS ga_source,
		a.offercoderaw,
		IIF(a.ordertypeid=1,a.bookings,0) AS bookings,
		IIF(a.ordertypeid=2,a.bookings,0) AS refunds,
		a.bookings AS total,
		a.taxliability,
		a.tax,
		a.quantity AS quantity,
		a.duration AS duration,
		a.mrr,
		ISNULL(ofr.currentofferstart,'2099-01-01') AS currentofferstart,
		ISNULL(ofr.currentoffercode,'') AS currentoffercode
FROM	dbo.allocation a
LEFT JOIN dbo.vGaTransaction ga ON ga.transactionid = a.orderid
LEFT JOIN dbo.vPostAffiliatePro pap ON pap.orderid = a.orderid
LEFT JOIN [HostOps].dbo.vInvoice inv ON inv.number = a.invno
LEFT JOIN dbo.servicechangetype sct ON sct.id = a.servicechangetypeid
LEFT JOIN dbo.vServDefMap sdm ON sdm.servdef = a.servdef 
LEFT JOIN dbo.agentdepartment ad ON ad.username = a.empl
LEFT JOIN dbo.pointofpurchase pop ON pop.id = a.pointofpurchaseid
LEFT JOIN [stage].[currentappliedoffers] ofr ON ofr.service = a.service
LEFT JOIN [dbo].[missingDepartments] md on a.account = md.account and a.service = md.service







GO


