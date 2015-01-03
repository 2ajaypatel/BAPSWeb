USE BAPS_CALENDAR
go

ALTER TABLE ORDERMASTER
	ADD  AmountPaid money
	
	
GO

ALTER TABLE OrderMasterHistory
	ADD  AmountPaid money