update ProjectYear
		set iscurrent = 0
where
		projectyear = 2010

INSERT INTO [BAPS_CALENDAR].[dbo].[ProjectYear]
           ([ProjectYear]
           ,[IsCurrent])
     VALUES
           (2011
           ,0)
           
           
INSERT INTO [BAPS_CALENDAR].[dbo].[ProjectYear]
           ([ProjectYear]
           ,[IsCurrent])
     VALUES
           (2012
           ,1)