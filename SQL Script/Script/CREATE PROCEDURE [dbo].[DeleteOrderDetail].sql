USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 02/15/2012 22:05:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteOrderDetail]
	-- Add the parameters for the stored procedure here
	@orderID int
AS
BEGIN
	
	-- delete from order table first
	DELETE FROM
				OrderDetails
	WHERE
		OrderID = @orderID
	
    
END
