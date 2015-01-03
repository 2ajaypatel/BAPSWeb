USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_getCenters]    Script Date: 10/08/2012 11:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getCentersByRegion]

	-- Add the parameters for the stored procedure here
	@RegionID INT
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT 
		*
	FROM
		Center (NOLOCK)
	WHERE
		CenterID NOT IN ( 54,1,52,53,55,56 )
		AND RegionID = @RegionID
	ORDER BY 
		CenterName
		
END
