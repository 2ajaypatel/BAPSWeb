USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_UPD_UserRole]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_UPD_UserRole]

	-- Add the parameters for the stored procedure here
	@RoleID int,
	@RoleCode int,
	@RoleName varchar(50),
	@RoleDescription varchar(255)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE UserRoles
		SET RoleName = @RoleName,
				RoleDescription=@RoleDescription
	WHERE RoleID = @RoleID
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_UPD_ProjectYear]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_UPD_ProjectYear]

	-- Add the parameters for the stored procedure here
	@ProjectYearID int,
	@ProjectYear int,
	@IsCurrent bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		-- set all project year to inactive
		UPDATE ProjectYear
		SET IsCurrent = 0
		
    -- Insert statements for procedure here
	UPDATE ProjectYear
		SET ProjectYear = @ProjectYear
				,IsCurrent = @IsCurrent
		WHERE
				ProjectYearID = @ProjectYearID
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_SEL_UserRole]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_SEL_UserRole]

	-- Add the parameters for the stored procedure here
	@RoleID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- SELECT statements for procedure here
	SELECT *
	FROM
		UserRoles
	WHERE
		RoleID = COALESCE (@RoleID, RoleID ) 
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_SEL_ProjectYear]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_SEL_ProjectYear]

	-- Add the parameters for the stored procedure here
	@ProjectYearID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM
		ProjectYear
	WHERE
		ProjectYearID = COALESCE (@ProjectYearID, ProjectYearID ) 
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_INS_UserRole]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_INS_UserRole]

	-- Add the parameters for the stored procedure here
	@RoleCode int,
	@RoleName varchar(50),
	@RoleDescription varchar(255)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

    -- Insert statements for procedure here
	INSERT INTO UserRoles
           (RoleCode
           ,RoleName
           ,RoleDescription)
     VALUES
           (@RoleCode
           ,@RoleName 
           ,@RoleDescription )
	


		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_INS_ProjectYear]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_INS_ProjectYear]

	-- Add the parameters for the stored procedure here
	@ProjectYear int,
	@IsCurrent bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		IF (@IsCurrent > 0)
		-- set all project year to inactive
		UPDATE ProjectYear 
		SET IsCurrent = 0

    -- Insert statements for procedure here
	INSERT INTO ProjectYear
		( ProjectYear, IsCurrent)
	VALUES ( @ProjectYear, @IsCurrent)
	


		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_DEL_UserRole]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_DEL_UserRole]

	-- Add the parameters for the stored procedure here
	@RoleID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- SELECT statements for procedure here
	DELETE FROM UserRoles
	WHERE
		RoleID = @RoleID
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_DEL_ProjectYear]    Script Date: 04/05/2012 10:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAL_DEL_ProjectYear]

	-- Add the parameters for the stored procedure here
	@ProjectYearID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM
		ProjectYear
	WHERE
		ProjectYearID = @ProjectYearID

		
END
GO
