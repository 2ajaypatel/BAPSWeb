USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_SEL_UserRole]    Script Date: 04/18/2012 21:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_SEL_CentersByOrderRegion]

	-- Add the parameters for the stored procedure here
	@RegionID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- SELECT statements for procedure here
	SELECT 
		CenterID, CenterName 
	FROM 
		Center (NOLOCK)
	WHERE
		RegionID = @RegionID
	ORDER BY 
		CenterName
	
		
END
