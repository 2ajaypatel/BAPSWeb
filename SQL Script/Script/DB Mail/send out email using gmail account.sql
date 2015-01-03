USE msdb
GO

DECLARE @tableHTML NVARCHAR(MAX) ; 
    SET @tableHTML = '';
    SET @tableHTML = @tableHTML + '<html><body><h1>Database eMail Alert - Calendar Sponsership 2012</h1>' + 
    '<table border="1" width="100%">' + 
    '<tr bgcolor="gray"><td>ID</td><td>CustomerName</td><td>Amount</td></tr></table>' 
    
EXEC sp_send_dbmail @profile_name='GMAIL',
@recipients='2ajaypatel@gmail.com;mitul.sevak@gmail.com ;123mda@gmail.com ',
@subject='Test message',
@body=@tableHTML,
  @body_format = 'HTML'


SELECT *
FROM sysmail_mailitems
GO
SELECT *
FROM sysmail_log
GO