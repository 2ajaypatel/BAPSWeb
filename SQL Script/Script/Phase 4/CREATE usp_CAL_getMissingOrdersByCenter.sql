USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailByCenterID]    Script Date: 10/08/2012 14:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_getMissingOrdersByCenter]
	-- Add the parameters for the stored procedure here
	@ProjectYear int
AS
BEGIN
	
	SELECT rcv.RegionDescription,
	um.*
	FROM
		UserMaster um (NOLOCK)
			JOIN vw_RegionCenter rcv (NOLOCK)
				ON um.centerID = rcv.centerid
	where um.centerID NOT IN 
			(
				SELECT DISTINCT 
					CenterID
				FROM 
					OrderMaster (NOLOCK)
				WHERE 
					ProjectYear = @ProjectYear
				)
		AND
			um.CenterID NOT IN (52,53,54,55,56,1 )
		AND 
			rcv.Is_active = 'A'
		AND
			um.RoleCode = 20
	ORDER by rcv.RegionDescription,um.centerName

    
END
