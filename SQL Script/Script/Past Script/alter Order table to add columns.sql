ALTER TABLE OrderMaster
ADD
    IsAccepted bit NOT NULL DEFAULT 0
GO

ALTER TABLE OrderMasterHistory
ADD
    IsAccepted bit NOT NULL DEFAULT 0