USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_SEL_RegionsByOrder]    Script Date: 04/18/2012 21:22:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_SEL_RegionsByOrder]

	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @ProjectYear INT;
		
	SET @ProjectYear  = year(getdate());
	
	SELECT
		TOP 1 @ProjectYear =  ProjectYear 
	FROM 
		ProjectYear (NOLOCK)
	WHERE 
		iscurrent = 1
	ORDER BY 
		ProjectYear desc

    -- SELECT statements for procedure here
	SELECT 
		regionid,
		ltrim(rtrim(regiondescription)) as regionname 
	FROM 
		regionmaster (NOLOCK)
	WHERE 
		regionid < 7
		AND RegionID in (
			SELECT 
				DISTINCT c.RegionID
			FROM OrderMaster om (NOLOCK)
				JOIN Center c (NOLOCK)
					ON om.CenterID = c.CenterID
			WHERE 
				om.ProjectYear = @ProjectYear
				)
	
		
END
