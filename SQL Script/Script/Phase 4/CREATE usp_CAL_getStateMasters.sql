USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_getRegions]    Script Date: 10/05/2012 09:42:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getStateMasters]

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
    -- Insert statements for procedure here
	SELECT 
		*
	FROM
		StateMaster (NOLOCK)
	
		
END
