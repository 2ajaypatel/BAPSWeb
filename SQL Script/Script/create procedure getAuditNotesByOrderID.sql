USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getAuditNotesByOrderID]    Script Date: 04/03/2012 16:32:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getAuditNotesByOrderID]
	-- Add the parameters for the stored procedure here
	@orderID int
AS
BEGIN

if (@orderID < 0)
	SET @orderID = NULL
	
SELECT 
	an.NoteID, 
	an.OrderID, 
	an.EnterDate, 
	an.EnterBy, 
	ant.NoteTypeName, 
	an.StatusCode, 
	an.Notes ,
	ISNULL(s.StatusName,'N/A') as statusname 
FROM AuditNotes an 	
	JOIN AuditNoteTypes ant 
		ON an.NoteTypeID = ant.NoteTypeID 	
	LEFT JOIN Statuses s 		
		ON an.StatusCode = s.StatusCode 
WHERE 
	an.orderID = coalesce(@orderID  ,an.orderID)
	ORDER BY an.EnterDate desc

    
END


