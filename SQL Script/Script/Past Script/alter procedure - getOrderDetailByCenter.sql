USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailByCenter]    Script Date: 04/17/2012 20:49:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[getOrderDetailByCenter]
	-- Add the parameters for the stored procedure here
	@centerID int
AS
BEGIN
	
	declare @ProjectYear INT;
		
	SET @ProjectYear  = year(getdate());
	
	select TOP 1 @ProjectYear =  ProjectYear FROM ProjectYear
	where iscurrent = 1
	order BY ProjectYear desc
	
	if (@centerID <= 0)
		SET @centerID = NULL
	
	SELECT	
			--om.MemberID,
			--c.centerID,
			c.Region,
			c.centername ,
			pm.ProductDescription as "ProductDescription",
			CASE od.ProductID WHEN 1 THEN 'CAL-SL' WHEN 2 THEN 'CAL-ML' END AS "CalendarType",
			CASE od.ProductRateID WHEN 5 THEN 'MC' WHEN 6 THEN 'MC' ELSE 'SC' END AS "CalendarItem", 
			CASE od.ProductID WHEN 1 THEN 'Single Leaf' WHEN 2 THEN 'Multi Leaf' END AS "CalendarType1",
			CASE od.ProductRateID WHEN 5 THEN 'Multi Color' WHEN 6 THEN 'Multi Color' ELSE 'Single Color' END AS "CalendarItem1",
			od.ProductQty as "ProductQuantity", 
			od.Rate, 
			od.ProductQty * od.Rate AS cost, 
			od.OrderAmount - od.ProductQty * od.Rate AS "AdditionalCost", 
			od.OrderAmount as orderAmount2 ,
			om.OrderID, 
			om.OrderDate as "OrderDate", 
			om.OrderAmount as "OrderAmount", 
			om.BankName as "BankName", 
			om.ClientID, 
			om.MemberID, 
			om.OrderStatus, 
			om.BankAmount as "BankAmount", 
			om.CheckDate as "CheckDate", 
			om.CheckNo as "CheckNo", 
			om.CenterID ,
			ad.Address1 as "ClientAddress1",
			ad.Address2 as "ClientAddress2",
			ad.City as "ClientCity",
			ad.StateID,
			ad.ZipCode as "ClientZip",
			sm.StateDescription as "ClientState",
			cm.BusinessName as "ClientBusinessName", 
			cm.AddressID, 
			cm.BusinessPhone as "ClientBusinessPhone", 
			cm.BusinessFax as "ClientBusinessFax", 
			cm.BusinessEmail as "ClientBusinessEmail", 
			cm.HomePhone as "ClientHomePhone", 
			cm.LastName as "ClientLastName", 
			cm.FirstName as "ClientFirstName", 
			cm.IsActive  as "ClientActiveStatus" 
	INTO #tempOrderDetail
	FROM 
		OrderDetails  od , ProductMaster pm ,OrderMaster om,ClientMaster cm ,Address ad,StateMaster sm,Center c
	WHERE 
		od.ProductID = pm.ProductID AND
		od.OrderID = om.OrderID AND
		ad.AddressID = cm.AddressID AND 
		ad.StateID = sm.StateID AND 
		om.ClientID = cm.ClientID AND
		om.centerid = c.centerid AND
		om.ProjectYear = @ProjectYear AND
		om.centerid = coalesce(@centerID,om.centerid)
		
	SELECT 
		Region,
		CenterName,
		CenterID,
		ProductDescription,
		CalendarType1, 
		CalendarItem1,
		Rate,
		COUNT(ProductDescription) as orderCount,
		SUM(ProductQuantity) as totalQTY,
		SUM(cost) AS totalCOST,
		SUM(orderAmount2) AS totalorderAmount2,
		SUM(AdditionalCost) AS totalAdditionalCost
	INTO
		#tempFinal
	FROM 
		#tempOrderDetail 
	GROUP BY 
		Region, centername , CenterID, ProductDescription,CalendarType1, CalendarItem1,Rate
	

		SELECT *
		FROM
			#tempFinal
		ORDER BY Region, centername , ProductDescription, CalendarItem1

		

	DROP table #tempOrderDetail
	DROP table #tempFinal

    
END
