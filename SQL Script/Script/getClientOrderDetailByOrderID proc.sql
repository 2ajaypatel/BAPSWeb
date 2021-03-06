USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailByOrderID]    Script Date: 02/14/2012 21:48:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getClientOrderDetailByOrderID]
	-- Add the parameters for the stored procedure here
	@orderID int
AS
BEGIN
SELECT
od.OrderDetailID,
od.ProductID,
od.ProductRateID,
od.ProductAdditionalRateID,
pm.ProductDescription,
od.Rate as ProductRate,
0  as ProductAdditionalRate,
od.ProductQty as Quantity ,
od.OrderAmount as Amount,
productTypeID = 
CASE pr.productTypeID
	WHEN 0 THEN 2
	ELSE pr.productTypeID
END 
INTO #odetail
FROM OrderDetails od 
	JOIN ProductMaster pm
		ON od.ProductID = pm.ProductID
	JOIN ProductRate pr
		ON od.ProductRateID = pr.ProductRateID
WHERE
	od.OrderID = @orderID
	
SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS 'OrderProductID',
ROW_NUMBER() OVER (ORDER BY ProductID) AS 'SequenceNo',
 o.*,pt.ProductTypeDesc as ProductTypeDescription
FROM #odetail o
	JOIN ProductType pt
		ON o.productTypeID = pt.ProductTypeID

DROP TABLE #odetail
    
END

GRANT EXECUTE ON getClientOrderDetailByOrderID to PUBLIC