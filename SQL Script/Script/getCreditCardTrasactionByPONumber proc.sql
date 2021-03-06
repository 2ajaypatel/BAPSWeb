USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailByCenter]    Script Date: 02/12/2012 23:23:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getCreditCardTransactionByPONumber]
	-- Add the parameters for the stored procedure here
	@PO_Number char(25)
AS
BEGIN
	
	SELECT Transaction_Request_Date
Invoice_Number,
PO_Number,
Description,
Amount,
Method,
Transaction_Type,
Response_Reason_Text,
Authorization_Code,
Transaction_ID,
CustomerID,
FirstName,
LastName,
Company,
Address,
City,
State,
Zip_Code,
Phone,
Email
FROM Credit_Card_Transactions
WHERE ltrim(rtrim(PO_Number)) = @PO_Number


    
END


GRANT EXECUTE ON getCreditCardTransactionByPONumber TO public