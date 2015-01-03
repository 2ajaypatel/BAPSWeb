USE [master]
GO
CREATE DATABASE [BAPS_CALENDAR] ON 
( FILENAME = N'F:\projects\BAPSWeb\SQL Script\DB\BAPS_CALENDAR.mdf' ),
( FILENAME = N'F:\projects\BAPSWeb\SQL Script\DB\BAPS_CALENDAR_1.ldf' )
 FOR ATTACH
GO


USE [master]
GO
EXEC master.dbo.sp_detach_db 
	@dbname = N'BAPS_CALENDAR',
	@keepfulltextindexfile = N'true'
GO