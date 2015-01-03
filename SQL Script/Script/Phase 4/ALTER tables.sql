ALTER TABLE OrderAdvertisementFilesInfoHistory
ALTER COLUMN [FileName] [varchar](500) NOT NULL
GO

ALTER TABLE OrderAdvertisementFilesInfoHistory
ALTER COLUMN [FilePath] [varchar](1000) NOT NULL
GO

ALTER TABLE OrderAdvertisementFilesInfo
ALTER COLUMN [FileName] [varchar](500) NOT NULL
GO

ALTER TABLE OrderAdvertisementFilesInfo
ALTER COLUMN [FilePath] [varchar](1000) NOT NULL
GO

ALTER TABLE StateMaster
	ADD StateTaxRate MONEY
CONSTRAINT DF_StateMaster_StateTaxRate  DEFAULT 1.0 NOT NULL
GO

ALTER TABLE [dbo].RegionMaster
DROP CONSTRAINT PK_RegionMaster
GO

ALTER TABLE RegionMaster
ALTER COLUMN RegionID INT
GO

ALTER TABLE RegionMaster 
	ADD  CONSTRAINT [PK_RegionID] PRIMARY KEY CLUSTERED (RegionID ASC)
GO

ALTER TABLE Center
ADD CONSTRAINT FK_Center_RegionID_RegionMaster_RegionID FOREIGN KEY(RegionID)REFERENCES RegionMaster(RegionID)
GO


ALTER TABLE Center
ADD Is_Active char(1) NULL
GO