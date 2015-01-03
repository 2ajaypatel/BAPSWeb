UPDATE
	Center 
	SET IS_ACTIVE = 'I'
WHERE
	CENTERID IN 
		(
		87,
		91,
		92,
		89,
		93,
		86,
		90,
		97
		)
		
Update Center
	set CenterName = 'BAPS San Diego'
where
	centerid = 73
	
	
UPDATE
	Center 
	SET 
		IS_ACTIVE = 'A'
WHERE 
	IS_ACTIVE IS NULL
