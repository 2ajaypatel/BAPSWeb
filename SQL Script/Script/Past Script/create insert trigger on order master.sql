USE [BAPS_CALENDAR]
GO
/****** Object:  Trigger [dbo].[OrderMaster_Insert]    Script Date: 01/17/2012 15:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[OrderMaster_Delete]
   ON   [dbo].[OrderMaster]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    SELECT getdate()

END
