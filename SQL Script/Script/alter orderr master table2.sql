
ALTER TABLE OrderMaster
ADD PaymentReceived bit
CONSTRAINT DF_OrderMaster_PaymentReceived DEFAULT 0 NOT NULL
GO