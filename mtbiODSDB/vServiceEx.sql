USE [mtbiODS]
GO

/****** Object:  View [dbo].[vServiceEx]    Script Date: 12/13/2018 1:54:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










































































































CREATE VIEW [dbo].[vServiceEx]
AS
        SELECT
            s.service,
			s.state,
			s.startdate,
			CAST(DATEADD(month, DATEDIFF(month, 0, s.startdate), 0) AS DATE) AS cohort,
			s.enddate,
			s.invdate,
			s.servdef,
			ISNULL(sdm.Product_Category,'Unknown') AS Product_Category,
			ISNULL(sdm.Product_Group,'Unknown') AS Product_Group,
			ISNULL(sdm.Product_Class,'Unknown') AS Product_Class,
			ISNULL(sdm.Product_Line,'Unknown') AS Product_Line,
			ISNULL(sdm.Product_Status,'Unknown') AS Product_Status,
			ISNULL(sdm.pclass,'Unknown') AS pclass,
			ISNULL(sdm.class,'Unknown') AS class,
			sdm.name,
			ISNULL(sdm.PnL_Category,'Unknown') AS PnL_Category,
			ISNULL(sdm.PnL_Revenue_Description,'Unknown') AS PnL_Revenue_Description,
			sdm.term,
			sdm.duration,
			sdm.addon,
			s.free,
			s.iprice,
			s.price,
			IIF(s.free=0 AND sdm.class!='CT-OT',(IIF(s.price=0,s.iprice,s.price)*s.quantity)/sdm.duration,0.000) AS mrr,
			IIF(s.free=0 AND sdm.class!='CT-OT',(IIF(s.price=0,s.iprice,s.price)*s.quantity)/sdm.duration,0.000) * 12 AS annualized_mrr,
			s.quantity,
			s.invorderid,
			s.invordertype,
			s.orderserviceid,
			ISNULL(invo.empl,'Unk') AS empl,
			COALESCE(ad.dept,pop.default_dept,'Unk') AS dept_org,
		    COALESCE(md.newdept,ad.dept,ISNULL(pop.default_dept,'Unk')) as dept_ex,
			IIF(ad.dept is null, -- is it null, then check the pop_default_dept
    		 IIF(pop.default_dept is not null and pop.default_dept <> 'Other' and pop.default_dept <> 'Unk',pop.default_dept,COALESCE(md.newdept,ad.dept,ISNULL(pop.default_dept,'Unk'))),
			 IIF(ad.dept <> 'Other' and ad.dept <> 'Unk' , ad.dept , COALESCE(md.newdept,ad.dept,ISNULL(pop.default_dept,'Unk'))) )  as dept,
			ISNULL(pop.id,0) AS pointofpurchaseid,
			ISNULL(pop.pointofpurchase,'Unk') AS pointofpurchase,
			IIF(pop.pointofpurchase='Web',COALESCE(pap.pchannel,ga.pchannel,'Unk'),IIF(COALESCE(ad.dept,pop.default_dept,'Unk') IN ('Other',''),'ES',IIF(COALESCE(ad.dept,pop.default_dept,'Unk') ='CT','CS',COALESCE(ad.dept,pop.default_dept,'Unk')))) AS pchannel,
			IIF(pop.pointofpurchase='Web',COALESCE(pap.channel,ga.channel,'Unk'),IIF(COALESCE(ad.dept,pop.default_dept,'Unk') IN ('Other',''),'ES',IIF(COALESCE(ad.dept,pop.default_dept,'Unk') ='CT','CS',COALESCE(ad.dept,pop.default_dept,'Unk')))) AS channel,
			ISNULL(ga.ga_channel,'Unk') AS ga_channel,
			ISNULL(ga.ga_medium,'Unk') AS ga_medium,
			ISNULL(ga.ga_campaign,'Unk') AS ga_campaign,
			ISNULL(ga.ga_landingpage,'Unk') AS ga_landingpage,
			ISNULL(ga.ga_source,'Unk') AS ga_source,
			ISNULL(invo.offercoderaw,'') AS offercoderaw,
			s.iservdef,
			ISNULL(isdm.Product_Category,'Unknown') AS iProduct_Category,
			ISNULL(isdm.Product_Group,'Unknown') AS iProduct_Group,
			ISNULL(isdm.Product_Class,'Unknown') AS iProduct_Class,
			ISNULL(isdm.Product_Line,'Unknown') AS iProduct_Line,
			ISNULL(isdm.Product_Status,'Unknown') AS iProduct_Status,
			ISNULL(isdm.pclass,'Unknown') AS ipclass,
			ISNULL(isdm.class,'Unknown') AS iclass,
			ISNULL(isdm.name,'Unknown') AS iname,
			ISNULL(isdm.PnL_Category,'Unknown') AS iPnL_Category,
			ISNULL(isdm.PnL_Revenue_Description,'Unknown') AS iPnL_Revenue_Description,
			ISNULL(isdm.term,'Unknown') AS iterm,
			ISNULL(isdm.duration,0) AS iduration,
			ISNULL(isdm.addon,0) AS iaddon,
			s.migrated_from,
			s.migrated_to,
			s.migrated_host,
			s.d03,
			s.d05,
			s.d06,
			s.d09,
			s.d10,
			s.reason,
			ISNULL(cr.descr,'N/A') AS reasondescr,
			s.lastcancelid,
			ISNULL(c.reason,-1) AS lastreason,
			ISNULL(lcr.descr,'N/A') AS lastreasondescr,
			ISNULL(REPLACE(REPLACE(REPLACE(c.comment, CHAR(13), '<br>'), CHAR(10), '<br>'), char(9), '<tab>'),'N/A') AS lastreasoncomment,
			s.account,
			COALESCE(invo.importance,ap.importance) AS importance,
			COALESCE(invo.city,ap.city) AS city,
			COALESCE(invo.statename,ap.statename) AS statename,
			COALESCE(invo.country,ap.country) AS country,
			COALESCE(invo.zip,ap.zip) AS zip,
			ISNULL(ofr.currentofferstart,'2099-01-01') AS currentofferstart,
		    ISNULL(ofr.currentoffercode,'') AS currentoffercode
        FROM
		   dbo.service s 
		   LEFT JOIN dbo.invorder invo ON invo.invorderid = s.invorderid
		   LEFT JOIN dbo.vGaTransaction ga ON ga.invorderid = invo.invorderid
		   LEFT JOIN dbo.vPostAffiliatePro pap ON pap.invorderid = invo.invorderid
		   LEFT JOIN dbo.agentdepartment ad ON ad.username = invo.empl
		   LEFT JOIN dbo.pointofpurchase pop ON pop.id = invo.pointofpurchaseid
		   LEFT JOIN dbo.vServDefMap sdm ON sdm.servdef = s.servdef
		   LEFT JOIN dbo.vServDefMap isdm ON isdm.servdef = s.iservdef
		   LEFT JOIN [HostOps].dbo.ordersCancellation c ON c.id = s.lastcancelid
		   LEFT JOIN [HostOps].dbo.billingLists lcr ON CONVERT(INT,lcr.value) = c.reason AND lcr.list = 'reasons'
		   LEFT JOIN [HostOps].dbo.billingLists cr ON CONVERT(INT,cr.value) = s.reason AND cr.list = 'reasons'
		   LEFT JOIN [HostOps].dbo.vAccount ap ON ap.account = s.account
		   LEFT JOIN [stage].[currentappliedoffers] ofr ON ofr.service = s.service
		   LEFT JOIN [dbo].[missingDepartments] md on s.account = md.account and s.service = md.service







GO


