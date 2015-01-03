USE [BAPS_CALENDAR]
GO

/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/15/2012 20:58:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OrderDetailsHistory](
	ID bigint IDENTITY(1,1),
	[OrderDetailID] [bigint] ,
	[OrderID] [bigint] NULL,
	[ProductID] [bigint] NULL,
	[ProductRateID] [bigint] NULL,
	[ProductQty] [float] NULL,
	[Rate] [money] NULL,
	[OrderAmount] [money] NULL,
	[ProductAdditionalRateID] [bigint] NULL,
	[OrderAdditionalAmount] [money] NULL,
	[BankName] [varchar](50) NULL,
	[CheckNo] [varchar](50) NULL,
	[CheckDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[Modifiedby] [varchar](100) NULL,
	[Modified] [datetime] NULL,
 CONSTRAINT [PK_OrderDetailsHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


