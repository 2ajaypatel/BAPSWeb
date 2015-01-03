USE BAPS_CALENDAR
GO

ALTER TABLE OrderDetails
ADD CreatedBy varchar(100)

ALTER TABLE OrderDetails
ADD Created datetime

ALTER TABLE OrderDetails
ADD Modifiedby varchar(100)

ALTER TABLE OrderDetails
ADD Modified datetime