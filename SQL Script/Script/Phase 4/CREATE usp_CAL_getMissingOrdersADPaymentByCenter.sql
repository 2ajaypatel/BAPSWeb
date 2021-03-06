USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailByCenterID]    Script Date: 10/08/2012 14:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getMissingOrdersADPaymentByCenter]
	-- Add the parameters for the stored procedure here
	@ProjectYear int
AS
BEGIN
	
	SELECT 
		CenterID,OrderID,min(Created) AS Created
	INTO #oa
	FROM 
		OrderAdvertisementFilesInfo
	WHERE
		Created IS NOT NULL
	GROUP BY 
		CenterID,OrderID
		
	SELECT 
		mum.firstname as cc_firstname,
		mum.lastname as cc_lastname,
		mum.HomePhone cc_HomePhone,
		mum.MobilePhone cc_MobilePhone,
		mum.BusinessPhone cc_BusinessPhone,
		mum.UserID as cc_email,
		mum.centerID
	INTO #um
	FROM
		UserMaster mum (NOLOCK)
	WHERE 
		mum.UserIDNumber = 
				(
				SELECT min(um.UserIDNumber)
				FROM 
					UserMaster um (NOLOCK)
				WHERE
					um.IsActive = 1
					AND um.centerID = mum.centerID
				GROUP BY
					um.centerID
					
				)

SELECT 
		om.CenterID,
		om.OrderID,
		om.ClientID,
		cm.BusinessName,
		cm.BusinessPhone,
		cm.HomePhone,
		cm.FirstName,
		cm.LastName,
		CASE 
			WHEN om.PaymentReceived = 0 THEN 'NO'
			ELSE 'YES'
		END AS PaymentReceived,
		CASE 
			WHEN oa.Created IS NULL THEN 'NO'
			ELSE 'YES'
		END AS ADReceived,
		rc.CenterName,
		rc.RegionDescription,
		rc.regionid,
		rc.centerid,
		um.*,
		pm.ProductDescription ,
		CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS Calendar_Type, 
		od.ProductQty,
		om.OrderAmount as Invoice_Amount
	FROM
		OrderMaster om (NOLOCK)
			JOIN OrderDetails  od (NOLOCK)
				ON od.OrderID = om.OrderID
			JOIN ProductMaster pm
				ON od.ProductID = pm.ProductID 
			LEFT JOIN #oa	oa (NOLOCK)
				ON om.OrderID = oa.OrderID 
					AND om.CenterID = oa.CenterID
			JOIN dbo.ClientMaster cm (NOLOCK)
				ON om.ClientID = cm.ClientID
			LEFT JOIN vw_RegionCenter rc (NOLOCK)
				ON om.CenterID = rc.centerid
			LEFT JOIN #um um (NOLOCK)
				ON om.CenterID = um.centerID
	WHERE
		ProjectYear = @ProjectYear
	ORDER BY
		rc.regionid,om.CenterID,om.OrderID



	DROP TABLE #oa
	DROP TABLE #um


    
END
