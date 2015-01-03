USE BAPS_CALENDAR
GO

-- Create table with Primary Key:
CREATE TABLE PaymentTypes (
PaymentTypeID int NOT NULL IDENTITY(1, 1),
PaymentType_Description varchar(20) NULL
)
GO

--Alter table with Primary Key
ALTER TABLE PaymentTypes
ADD CONSTRAINT pk_PaymentTypes_PaymentTypeID PRIMARY KEY (PaymentTypeID)
GO

-- INSERT payment types
INSERT INTO PaymentTypes ( PaymentType_Description ) Values ('Not Assigned')
go

INSERT INTO PaymentTypes ( PaymentType_Description ) Values ('Cash')
go

INSERT INTO PaymentTypes ( PaymentType_Description ) Values ('Check')
go

INSERT INTO PaymentTypes ( PaymentType_Description ) Values ('Credit Card')
go

