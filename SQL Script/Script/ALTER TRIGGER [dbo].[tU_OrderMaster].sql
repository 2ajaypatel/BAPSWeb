USE [BAPS_CALENDAR]
GO
/****** Object:  Trigger [dbo].[tU_OrderMaster]    Script Date: 02/18/2012 12:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[tU_OrderMaster]
   ON  [dbo].[OrderMaster]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    		INSERT INTO OrderMasterHistory
			(orderID
			,OrderDate
           ,InvoiceNo
           ,OrderAmount
           ,ClientID
           ,MemberID
           ,OrderStatus
           ,CenterID
           ,BankName
           ,CheckNo
           ,CheckDate
           ,BankAmount
           ,poNumber
           ,PaymentTypeID
           ,PaymentReceived
           ,ProjectYear
           ,CreatedBy
           ,Created
           ,Modifiedby
           ,Modified
           ,AmountPaid
			)
		SELECT orderID
           ,OrderDate
           ,InvoiceNo
           ,OrderAmount
           ,ClientID
           ,MemberID
           ,OrderStatus
           ,CenterID
           ,BankName
           ,CheckNo
           ,CheckDate
           ,BankAmount
           ,poNumber
           ,PaymentTypeID
           ,PaymentReceived
           ,ProjectYear
           ,CreatedBy
           ,Created
           ,Modifiedby
           ,Modified
           ,AmountPaid
        FROM 
			inserted

END
