IF ( OBJECT_ID('dbo.vw_RegionCenter') IS NOT NULL ) 
   DROP VIEW dbo.vw_RegionCenter 
GO

CREATE VIEW dbo.vw_RegionCenter 
AS
  SELECT 
	c.centerid,
	c.regionid,
	c.state,
	c.CenterName,
	c.Street,
	c.City,
	c.Zip,
	c.Phone,
	c.poCode,
	Is_Active,
	sm.statetaxrate,
	sm.StateDescription,
	rm.RegionName,
	rm.RegionDescription,
	sm.StateID,
	sm.StateCode
FROM Center c 
	LEFT JOIN StateMaster sm
		ON c.state = sm.statecode
	JOIN RegionMaster rm
		ON c.RegionID = rm.RegionID
    

	
	