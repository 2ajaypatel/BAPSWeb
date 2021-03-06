USE [BAPS_CALENDAR]
GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 01/17/2012 15:03:01 ******/

CREATE TABLE [dbo].[OrderMaster_History](
	CreateDate datetime NOT NULL,
	OrderHistoryID [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint]  NULL,
	[OrderDate] [datetime] NULL,
	[InvoiceNo] [varchar](50) NULL,
	[OrderAmount] [money] NULL,
	[ClientID] [bigint] NULL,
	[MemberID] [bigint] NULL,
	[OrderStatus] [varchar](50) NULL,
	[CenterID] [bigint] NULL,
	[BankName] [varchar](50) NULL,
	[CheckNo] [varchar](50) NULL,
	[CheckDate] [datetime] NULL,
	[BankAmount] [money] NULL,
	[poNumber] [varchar](20) NULL,
	[PaymentTypeID] [int] NULL ,
	[PaymentReceived] [bit]  NULL ,
	[ProjectYear] [int] NULL,
	ActionTaken char(3) NULL
) 

GO
