		
update c
	set c.regionid = rm.regionid
FROM CENTER c ,regionmaster rm
WHERE
		c.region = rm.regionname