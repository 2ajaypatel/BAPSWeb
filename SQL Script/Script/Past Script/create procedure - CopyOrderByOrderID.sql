USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[CopyOrderByOrderID]    Script Date: 12/29/2011 16:13:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[CopyOrderByOrderID]
	-- Add the parameters for the stored procedure here
	@orderID int
AS
BEGIN
	
	-- INSERT from order master table first
		INSERT ordermaster 
       (orderdate, 
        orderamount, 
        clientid, 
        memberid, 
        orderstatus, 
        centerid, 
        bankname, 
        checkno, 
        checkdate, 
        bankamount,
        ponumber,
        paymenttypeid,
        paymentreceived
        ) 
    SELECT
				getdate(),
				orderamount, 
        clientid, 
        memberid, 
        orderstatus, 
        centerid, 
        bankname, 
        checkno, 
        checkdate, 
        bankamount,
        poNumber,
        1,
        0
		FROM 
				ordermaster
		WHERE
				OrderID = @orderID
	
	-- delete from order details table
	INSERT INTO orderdetails 
            (orderid, 
             productid, 
             productrateid, 
             productqty, 
             rate, 
             orderamount, 
             productadditionalrateid, 
             orderadditionalamount) 
 SELECT orderid, 
             productid, 
             productrateid, 
             productqty, 
             rate, 
             orderamount, 
             productadditionalrateid, 
             orderadditionalamount
 FROM 
				orderdetails
		WHERE
				OrderID = @orderID
		
    
END
