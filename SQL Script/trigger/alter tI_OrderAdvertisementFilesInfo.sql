USE [BAPS_CALENDAR_5152012]
GO
/****** Object:  Trigger [dbo].[tI_OrderAdvertisementFilesInfo]    Script Date: 05/15/2012 21:42:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[tI_OrderAdvertisementFilesInfo]
   ON  [dbo].[OrderAdvertisementFilesInfo]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @ProjectYear INT;
	
	SET @ProjectYear  = year(getdate());
	
	select TOP 1 @ProjectYear =  ProjectYear FROM ProjectYear
	where iscurrent = 1
	order BY ProjectYear desc
	
	update oa
		SET oa.CenterID = om.CenterID
	FROM OrderMaster om
		JOIN OrderAdvertisementFilesInfo oa
			ON om.OrderID = oa.OrderID
		JOIN inserted i
			ON om.OrderID = i.OrderID
	WHERE
		om.projectYear = @ProjectYear

    -- Insert statements for trigger here
    		INSERT INTO OrderAdvertisementFilesInfoHistory
				   (id
					,CenterID
				   ,OrderID
				   ,FileName
				   ,FilePath
				   ,UploadedDate
				   ,UserIDNumber
				   ,Status
				   ,fileSize
				   ,FileExtension
				   ,Modified
				   ,Created
				   ,CreatedBy
				   ,EnteredDate
				   ,SelectedTemplate
				 )
   
			SELECT 
					id
					,CenterID
				   ,OrderID
				   ,FileName
				   ,FilePath
				   ,UploadedDate
				   ,UserIDNumber
				   ,Status
				   ,fileSize
				   ,FileExtension
				   ,Modified
				   ,Created
				   ,CreatedBy
				 ,GETDATE()
				,SelectedTemplate
			FROM inserted

END
