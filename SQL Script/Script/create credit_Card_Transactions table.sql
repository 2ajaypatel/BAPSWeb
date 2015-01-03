USE [BAPS_CALENDAR]
GO

/****** Object:  Table [dbo].[Credit_Card_Transactions]    Script Date: 02/11/2012 20:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Credit_Card_Transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Response_Code] [int] NOT NULL,
	[Response_Subcode] [varchar](50) NULL,
	[Response_Reason_Code] [int] NULL,
	[Response_Reason_Text] [varchar](255) NULL,
	[Authorization_Code] [varchar](6) NULL,
	[AVS_Reponse] [char](1) NULL,
	[Transaction_ID] [varchar](20) NULL,
	[Invoice_Number] [varchar](20) NULL,
	[Description] [char](255) NULL,
	[Amount] [money] NULL,
	[Method] [char](10) NULL,
	[Transaction_Type] [varchar](20) NULL,
	[CustomerID] [char](20) NULL,
	[FirstName] [char](50) NULL,
	[LastName] [char](50) NULL,
	[Company] [char](50) NULL,
	[Address] [char](50) NULL,
	[City] [char](40) NULL,
	[State] [char](40) NULL,
	[Zip_Code] [char](20) NULL,
	[Country] [char](60) NULL,
	[Phone] [char](25) NULL,
	[Fax] [char](25) NULL,
	[Email] [char](255) NULL,
	[ShipTo_FirstName] [char](50) NULL,
	[ShipTo_LastName] [char](50) NULL,
	[ShipTo_Company] [char](60) NULL,
	[ShipTo_Address] [char](60) NULL,
	[ShipTo_City] [char](40) NULL,
	[ShipTo_State] [char](40) NULL,
	[ShipTo_Zip_Code] [char](20) NULL,
	[ShipTo_Country] [char](60) NULL,
	[Tax] [money] NULL,
	[Duty] [money] NULL,
	[Freight] [money] NULL,
	[Tax_Exempt] [char](6) NULL,
	[PO_Number] [char](25) NULL,
	[MD5_Hash] [char](100) NULL,
	[Card_Code_Reponse] [char](1) NULL,
	[Cardholder_AVR] [char](1) NULL,
	[Account_Number] [char](22) NULL,
	[Card_Type] [char](10) NULL,
	[Split_Tender_ID] [char](20) NULL,
	[Requested_Amount] [money] NULL,
	[Balance_On_Card] [money] NULL,
	[Transaction_Request_Date] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


Grant SELECT,UPDATE,INSERT ON dbo.Credit_Card_Transactions TO PUBLIC