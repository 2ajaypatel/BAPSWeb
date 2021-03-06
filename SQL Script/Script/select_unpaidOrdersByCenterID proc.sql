USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[select_unpaidOrdersByCenterID]    Script Date: 11/28/2011 15:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[select_unpaidOrdersByCenterID]
	-- Add the parameters for the stored procedure here
	@centerID int
AS
BEGIN
	
	SELECT	
			--om.MemberID,
			--c.centerID,
			c.centername ,
			cm.BusinessName as "Client Business Name",
			ad.Address1 as "Client Address 1",
			ad.Address2 as "Client Address 2",
			ad.City as "Client City",
			ad.StateID,
			ad.ZipCode as "Client Zip",
			sm.StateDescription as "Client State", 
			--cm.AddressID, 
			cm.BusinessPhone as "Client Business Phone", 
			cm.BusinessFax as "Client Business Fax", 
			cm.BusinessEmail as "Client Business Email", 
			cm.HomePhone as "Client Home Phone", 
			cm.LastName as "Client Last Name", 
			cm.FirstName as "Client First Name", 
			cm.IsActive  as "Client Active Status" ,
			om.ClientID, 
			om.MemberID, 
			pm.ProductDescription as "Product Description", 
			CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS "Calendar Type", 
			od.ProductQty as "Product Quantity", 
			od.Rate, 
			od.ProductQty * od.Rate AS cost, 
			od.OrderAmount - od.ProductQty * od.Rate AS "Additional Cost", 
			--od.OrderAmount ,
			om.OrderID, 
			om.OrderDate as "OrderDate", 
			om.OrderAmount as "Order Amount", 
			om.BankName as "Bank Name", 
			om.OrderStatus, 
			om.BankAmount as "Bank Amount", 
			om.CheckDate as "Check Date", 
			om.CheckNo as "Check No", 
			om.CenterID 
			
			
	INTO #tempOrderDetail
	FROM 
		OrderDetails  od
				JOIN ProductMaster pm
						ON od.ProductID = pm.ProductID 
				JOIN OrderMaster om
						ON od.OrderID = om.OrderID
				JOIN ClientMaster cm
						ON om.ClientID = cm.ClientID
				JOIN Address ad
						ON ad.AddressID = cm.AddressID
				JOIN StateMaster sm
						ON ad.StateID = sm.StateID
				JOIN Center c
						ON om.centerid = c.centerid
	WHERE
		om.paymentreceived = 1
		
		
	SELECT 
		tod.*,
		mm.FirstName as "Karaykar First Name", 
		mm.LastName as "Karaykar Last Name", 
		mm.HomePhone as "Karaykar Home Phone", 
		mm.CellPhone as "Karaykar Cell Phone", 
		mm.Fax as "Karaykar Fax", 
		mm.Email as "Karaykar Email", 
		mad.Address1 as "Karaykar Address 1", 
		mad.Address2 as "Karaykar Address 2", 
		mad.City as "Karaykar City", 
		sm.StateDescription as "Karaykar State", 
		mad.ZipCode as "Karaykar Zip"
		
	INTO
		#tempFinal
	FROM 
		Address mad 
				JOIN MemberMaster mm
						ON mad.AddressID = mm.AddressID
				JOIN StateMaster sm
						ON mad.StateID = sm.StateID
				JOIN #tempOrderDetail tod
						ON tod.MemberID = mm.MemberID 
	

	if (@centerID > 0)

		SELECT 
			* 
		FROM 
			#tempFinal 
		WHERE 
			centerID = @centerID
		ORDER BY 
			CenterName ,OrderDate
	ELSE
		SELECT 
			* 
		FROM 
			#tempFinal 
		ORDER BY 
			CenterName ,OrderDate
		
	DROP table #tempOrderDetail
	DROP table #tempFinal

    
END
