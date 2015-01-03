USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_getRegions]    Script Date: 10/08/2012 11:37:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getCenters]

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
    -- Insert statements for procedure here
	SELECT 
		*
	FROM
		Center (NOLOCK)
	WHERE
		CenterID NOT IN ( 54,
							1,
							52,
							53,
							55,
							56
							)
	ORDER BY CenterName
		
END
