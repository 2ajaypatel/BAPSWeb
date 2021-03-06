USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[searchClientDetail]    Script Date: 12/08/2011 15:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [dbo].[searchClientDetail]
	-- Add the parameters for the stored procedure here
	@userid					varchar(100),
	@businessname		varchar(50),
	@firstname			varchar(50),
  @lastname				varchar(50)
AS
BEGIN
	
--SELECT @userid = '2ajaypatel@gmail.com'
if @userid is not null
			SET @userid = @userid + '%'

--SELECT @businessname = 'sd'
if @businessname is not null
			SET @businessname = @businessname + '%'
			
--SELECT @firstname = 'a'
if @firstname is not null
			SET @firstname = @firstname + '%'
			
--SELECT @lastname = 'a'
if @lastname is not null
			SET @lastname = @lastname + '%'

SELECT cm.clientid,
cm.addressid,
cm.businessname,
ltrim(rtrim(isnull(a.address1,''))) + ltrim(rtrim(isnull(a.address2,''))) as businessaddress  ,
a.address1,
a.address2,
a.city,
a.zipcode,
cm.businessphone,
cm.businessfax,
cm.businessemail,
cm.firstname,
cm.lastname
FROM ClientMaster cm (NOLOCK)
		JOIN ordermaster om (NOLOCK)
				ON cm.clientid = om.clientid
		JOIN usermaster um (NOLOCK)
				ON om.centerid = um.centerid
		JOIN address a (NOLOCK)
				ON  cm.addressid = a.addressid
WHERE
		um.userid LIKE COALESCE(@userid ,um.userid) 
		AND ltrim(rtrim(cm.businessname)) like COALESCE(@businessname ,cm.businessname) 
		AND ltrim(rtrim(cm.firstname)) like COALESCE(@firstname ,cm.firstname) 
		AND ltrim(rtrim(cm.lastname)) like COALESCE(@lastname ,cm.lastname) 
    
END
