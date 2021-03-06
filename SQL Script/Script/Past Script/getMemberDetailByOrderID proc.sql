USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getClientDetailByOrderID]    Script Date: 02/13/2012 22:00:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getMemberDetailByOrderID]
	-- Add the parameters for the stored procedure here
	@orderID int
AS
BEGIN
	
SELECT TOP 1 om.MemberID, om.OrderID,
	mm.FirstName,
	mm.LastName,
	mm.AddressID,
	mm.HomePhone,
	mm.CellPhone,
	mm.Fax,
	mm.Email,	
	isnull(a.Address1,'') as Address1,
	isnull(a.Address2,'') as Address2 ,
	a.City,
	a.StateID,
	a.ZipCode
			FROM dbo.OrderMaster om
				JOIN MemberMaster mm
					ON om.MemberID = mm.MemberID
				JOIN Address a
					ON mm.AddressID = a.AddressID
			WHERE om.OrderID = @orderID

    
END


GRANT EXECUTE ON getMemberDetailByOrderID to public