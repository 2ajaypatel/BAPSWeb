USE [BAPS_CALENDAR]
GO

/****** Object:  Table [dbo].[OrderMaster]    Script Date: 02/15/2012 20:55:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OrderMasterHistory](
	ID [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] ,
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
	[PaymentTypeID] [int] NULL,
	[PaymentReceived] [bit] NOT NULL,
	[ProjectYear] [int] NULL,
	[CreatedBy] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[Modifiedby] [varchar](100) NULL,
	[Modified] [datetime] NULL,
 CONSTRAINT [PK_OrderMasterHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



