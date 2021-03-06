USE [BAPS_CALENDAR]
GO
/****** Object:  Trigger [dbo].[tI_OrderMaster]    Script Date: 02/15/2012 21:14:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[tU_OrderMaster]
   ON  [dbo].[OrderMaster]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    		INSERT INTO OrderMasterHistory
			(
			OrderDate
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
			)
		SELECT 
           OrderDate
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
        FROM 
			inserted

END
