USE BAPS_CALENDAR
GO

ALTER TABLE OrderMaster
ADD CreatedBy varchar(100)

ALTER TABLE OrderMaster
ADD Created datetime

ALTER TABLE OrderMaster
ADD Modifiedby varchar(100)

ALTER TABLE OrderMaster
ADD Modified datetime