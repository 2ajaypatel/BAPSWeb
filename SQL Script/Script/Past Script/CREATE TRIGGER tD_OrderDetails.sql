USE [BAPS_CALENDAR]
GO
/****** Object:  Trigger [dbo].[tI_OrderDetails]    Script Date: 02/15/2012 21:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER tD_OrderDetails
   ON  [dbo].[OrderDetails]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    INSERT INTO OrderDetailsHistory
		(
		OrderDetailID
      ,OrderID
      ,ProductID
      ,ProductRateID
      ,ProductQty
      ,Rate
      ,OrderAmount
      ,ProductAdditionalRateID
      ,OrderAdditionalAmount
      ,BankName
      ,CheckNo
      ,CheckDate
      ,CreatedBy
      ,Created
      ,Modifiedby
      ,Modified
		)
	SELECT OrderDetailID
      ,OrderID
      ,ProductID
      ,ProductRateID
      ,ProductQty
      ,Rate
      ,OrderAmount
      ,ProductAdditionalRateID
      ,OrderAdditionalAmount
      ,BankName
      ,CheckNo
      ,CheckDate
      ,CreatedBy
      ,Created
      ,Modifiedby
      ,Modified
  FROM deleted

END
