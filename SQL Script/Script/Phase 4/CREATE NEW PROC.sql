USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_UPD_Region]    Script Date: 10/05/2012 08:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_UPD_Region]

	-- Add the parameters for the stored procedure here
	@RegionID int,
	@RegionName varchar(50),
	@RegionDescription varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		
    -- Insert statements for procedure here
	UPDATE RegionMaster
		SET 
			RegionName = LTRIM(rtrim(@RegionName)),
			RegionDescription = LTRIM(rtrim(@RegionDescription))
	WHERE
		RegionID = @RegionID
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_SEL_isUserRoleCodeExists]    Script Date: 10/05/2012 08:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_SEL_isUserRoleCodeExists]

	-- Add the parameters for the stored procedure here
	@RoleCode int
AS
BEGIN
	
	-- SELECT statements for procedure here
	SELECT *
	FROM
		UserRoles
	WHERE
		RoleCode = @RoleCode 
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_getRoles]    Script Date: 10/05/2012 08:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getRoles]

	-- Add the parameters for the stored procedure here
	@ProjectYearID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		*
	FROM
		UserRoles (NOLOCK)
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_getRegions]    Script Date: 10/05/2012 08:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getRegions]

	-- Add the parameters for the stored procedure here
	@ProjectYearID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		*
	FROM
		RegionMaster (NOLOCK)
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[select_OrdersBalanceSummaryByCenterIDRegionID]    Script Date: 10/05/2012 08:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[select_OrdersBalanceSummaryByCenterIDRegionID]
	-- Add the parameters for the stored procedure here
	@regionID int,
	@centerID int
AS
BEGIN


DECLARE @projectYear INT

if ( @centerID <= 0 )
	SET @centerID = NULL

if ( @regionID <= 0 )
	SET @regionID = NULL
	
CREATE TABLE #orderDetail
	(sortOrder INT,
	paymentreceived INT,
	regionid INT,
	region varchar(255),
	centername varchar(255),
	BusinessName char(50),
	StateID	INT,
	StateDescription CHAR(50),
	LastName CHAR(50),
	FirstName CHAR(50),
	ClientID INT,
	ProductDescription CHAR(100),
	Calendar_Type CHAR(50),
	sorderedQty INT,
	morderedQty INT,
	orderedQty INT,
	Additional_Cost MONEY,
	OrderID INT,
	Invoice_Amount MONEY,
	Received_Amount MONEY,
	balance MONEY,
	CheckNo CHAR(50),
	CheckDate DATETIME,
	CenterID INT
	)
	
	INSERT INTO #orderDetail
		(sortOrder,
		paymentreceived,
		regionid,
		region ,
		centername ,
		BusinessName ,
		StateID	,
		StateDescription ,
		LastName ,
		FirstName ,
		ClientID ,
		ProductDescription ,
		Calendar_Type ,
		sorderedQty ,
		morderedQty ,
		orderedQty ,
		Additional_Cost ,
		OrderID ,
		Invoice_Amount ,
		Received_Amount ,
		balance ,
		CheckNo ,
		CheckDate ,
		CenterID 
	)
		
	SELECT	1 as sortOrder,
			om.paymentreceived,
			c.regionid,
			c.Region,
			c.centername ,
			cm.BusinessName ,
			ad.StateID,
			sm.StateDescription, 
			cm.LastName, 
			cm.FirstName, 
		--	cm.IsActive  as "Client Active Status" ,
			om.ClientID, 
			pm.ProductDescription , 
			CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS Calendar_Type, 
			CASE pm.ProductID WHEN 1 THEN od.ProductQty ELSE 0 END AS sorderedQty,
			CASE pm.ProductID WHEN 2 THEN od.ProductQty ELSE 0 END AS morderedQty,
			od.ProductQty, 
			od.OrderAmount - od.ProductQty * od.Rate AS Additional_Cost, 
			om.OrderID, 
			om.OrderAmount as Invoice_Amount, 
			om.amountpaid as Received_Amount,
			( om.OrderAmount - om.amountpaid ) as balance,
		--	om.BankName as "Bank Name", 
		--	om.OrderStatus, 
		--	om.BankAmount as "Bank Amount", 
			om.CheckNo, 
			om.CheckDate, 
			om.CenterID 
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
		om.ProjectYear = @projectYear
		AND om.centerID = COALESCE(@centerID,om.centerID)
		AND c.regionid = COALESCE(@regionID,c.regionid)
	ORDER BY
		sortOrder,c.regionid,om.centerID
	
--	SELECT * FROM #orderDetail
		
	INSERT INTO #orderDetail
		(CenterID ,
		centername,
		Region,
		regionid,
		orderedQty,
		sorderedQty,
		morderedQty,
		Invoice_Amount,
		Received_Amount,
		balance
	)
		
	SELECT 
		CenterID,
		centername,
		Region, 
		regionid,
        SUM(orderedQty),
        SUM(sorderedQty),
        SUM(morderedQty),
		SUM(Invoice_Amount),
		SUM(Received_Amount),
		SUM(balance)
	FROM	
		#orderDetail
	GROUP BY CenterID, centername	,Region,regionid
	
	UPDATE
		od
		SET od.BusinessName = upper('Total of ' + c.CenterName + ' Center ')
	FROM
		#orderDetail od
			JOIN Center c
				ON od.CenterID = c.CenterID
	WHERE
		od.sortOrder IS NULL
			
	
	UPDATE
		#orderDetail
		SET
			sortOrder = 2
	WHERE
		sortOrder IS NULL
	
	
	INSERT INTO #orderDetail
		(regionid ,
		Region,
		CenterID,
		orderedQty,
		sorderedQty,
		morderedQty,
		Invoice_Amount,
		Received_Amount,
		balance
	)	
	SELECT 
		regionid,
		Region, 
		regionid,
        SUM(orderedQty),
        SUM(sorderedQty),
        SUM(morderedQty),
		SUM(Invoice_Amount),
		SUM(Received_Amount),
		SUM(balance)
	FROM	
		#orderDetail
	GROUP BY regionid,Region
			
	UPDATE
		#orderDetail
		SET
			sortOrder = 3,
			CenterID = regionid + 5000,
			BusinessName = upper('Total of ' + Region + ' Center ')
	WHERE
		sortOrder IS NULL
		
		
	SELECT 
		sortOrder,
		OrderID,
		centername,
		region,
		StateDescription,
		BusinessName,
		orderedQty,
		sorderedQty,
		morderedQty,
		Additional_Cost,
		Invoice_Amount,
		Received_Amount,
		balance,
		CheckNo,
		--CheckDate,
		CONVERT(VARCHAR(10), CheckDate, 101) AS CheckDate,
		regionid,
		StateID,
		ClientID,
		CenterID
		--sortOrder,
		--paymentreceived,
		--regionid,
		--region ,
		--centername ,
		--BusinessName ,
		--StateID	,
		--StateDescription ,
		--LastName ,
		--FirstName ,
		--ClientID ,
		--ProductDescription ,
		--Calendar_Type ,
		--orderedQty ,
		--Additional_Cost ,
		-- ,
		--Invoice_Amount ,
		--Received_Amount ,
		--balance ,
		--CheckNo ,
		--CheckDate ,
		--CenterID 
	FROM
		#orderDetail
	ORDER BY
		regionid,CenterID,sortOrder
	
	DROP table #orderDetail


    
END
GO
