USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderQuantityCountByRegion]    Script Date: 04/25/2012 21:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getOrderQuantityCountByRegion]
	-- Add the parameters for the stored procedure here
	@Region INT
AS
BEGIN
	
declare @ProjectYear INT;
	
	SET @ProjectYear  = year(getdate());
	
	select TOP 1 @ProjectYear =  ProjectYear FROM ProjectYear
	where iscurrent = 1
	order BY ProjectYear desc

SELECT	
			
			c.centername ,
			om.ClientID, 
			om.MemberID, 
			pm.ProductID,
			pm.ProductDescription AS product ,
			od.ProductQty,
		--	CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS "Calendar Type", 
		--	od.ProductQty as "Product Quantity", 
		--	om.OrderID, 
			om.CenterID ,
			c.RegionID
	INTO #tempOrderDetail
	FROM 
		OrderDetails  od , ProductMaster pm ,OrderMaster om,ClientMaster cm ,Center c
	WHERE 
		od.ProductID = pm.ProductID AND
		od.OrderID = om.OrderID AND
		om.ClientID = cm.ClientID AND
		om.centerid = c.centerid AND
		om.ProjectYear = @ProjectYear AND
		c.RegionID = @Region AND
		c.RegionID IS NOT NULL
		
	ORDER BY 1

CREATE TABLE #od
	(
		centername VARCHAR(100),
		ML INT,
		SL INT,
		regionid INT
	)

INSERT INTO #od ( centername,ML,SL,regionid )
	SELECT CenterName,NULL,NULL,RegionID
	FROM Center
	WHERE RegionID is not null
	--SELECT DISTINCT CenterName,0,0 
	--FROM #tempOrderDetail
	
SELECT centerid,CenterName,product,productID,SUM(ProductQty) AS total 
INTO #t2
FROM #tempOrderDetail
GROUP BY centerid,CenterName,product,productID

--SELECT CenterName,COUNT(productID) as total 
--FROM #tempOrderDetail
--GROUP BY CenterName

UPDATE o
	SET o.SL = t.total
FROM #od o
	INNER JOIN #t2 t
		ON o.centername = t.CenterName
WHERE t.ProductID = 1

UPDATE o
	SET o.ML = t.total
FROM #od o
	INNER JOIN #t2 t
		ON o.centername = t.CenterName
WHERE t.ProductID = 2

SELECT * FROM #od WHERE regionid = @Region
		
DROP TABLE 	#tempOrderDetail
DROP TABLE 	#od
DROP TABLE 	#t2
    
END
