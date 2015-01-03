ALTER TABLE OrderStatus DROP COLUMN StatusDescription
go

ALTER TABLE OrderStatus ADD OrderID int NOT NULL
go

ALTER TABLE OrderStatus ADD StatusCode int NOT NULL
go

ALTER TABLE OrderStatus ADD RoleCode int NOT NULL
go

ALTER TABLE OrderStatus ADD CreatedBy varchar(100) NULL
go

ALTER TABLE OrderStatus ADD Created datetime NULL
go

ALTER TABLE OrderStatus ADD Modifiedby varchar(100) NULL
go

ALTER TABLE OrderStatus ADD Modified datetime NULL
go

