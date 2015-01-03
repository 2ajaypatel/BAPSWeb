ALTER TABLE OrderMaster
ADD PaymentTypeID int NULL
CONSTRAINT [DF_OrderMaster_PaymentTypeID] DEFAULT ((1))
go

ALTER TABLE OrderMaster
ADD CONSTRAINT fk_OrderMaster_PaymentTypeID  FOREIGN KEY(PaymentTypeID )REFERENCES PaymentTypes(PaymentTypeID)
GO

