USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailByOrderID]    Script Date: 02/11/2012 14:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getClientDetailByOrderID]
	-- Add the parameters for the stored procedure here
	@orderID int
AS
BEGIN
	
	SELECT TOP 1 om.MemberID, om.OrderID,cm.ClientID, cm.FirstName,cm.LastName,isnull(a.Address1,'') as Address1,isnull(a.Address2,'') as Address2 ,a.City,a.StateID,a.ZipCode,cm.BusinessName,cm.BusinessPhone,cm.BusinessEmail,cm.AddressID,cm.BusinessFax,cm.HomePhone,cm.IsActive,cm.FirstName,cm.LastName
			FROM dbo.OrderMaster om
				JOIN ClientMaster cm
					ON om.clientid = cm.clientid
				JOIN Address a
					ON cm.AddressID = a.AddressID
			WHERE om.OrderID = @orderID

    
END

-- GRAND execute permission to public
GRANT EXECUTE ON getClientDetailByOrderID to public
