USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_UPD_Region]    Script Date: 10/05/2012 09:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_UPD_StateMaster]

	-- Add the parameters for the stored procedure here
	@StateID int,
	@StateTaxRate MONEY
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		
    -- Insert statements for procedure here
	UPDATE StateMaster
		SET 
			StateTaxRate = @StateTaxRate
	WHERE
		StateID = @StateID
		
END
