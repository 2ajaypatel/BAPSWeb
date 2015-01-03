CREATE PROCEDURE Insert_Credit_Card_Transactions

@Response_Code int,
@Response_Subcode varchar(50),
@Response_Reason_Code int,
@Response_Reason_Text varchar(255),
@Authorization_Code varchar(6),
@AVS_Reponse char(1),
@Transaction_ID varchar(20),
@Invoice_Number varchar(20),
@Description char(255),
@Amount money,
@Method char(10),
@Transaction_Type varchar(20),
@CustomerID char(20),
@FirstName char(50),
@LastName char(50),
@Company char(50),
@Address char(50),
@City char(40),
@State char(40),
@Zip_Code char(20),
@Country char(60),
@Phone char(25),
@Fax char(25),
@Email char(255),
@ShipTo_FirstName char(50),
@ShipTo_LastName char(50),
@ShipTo_Company char(60),
@ShipTo_Address char(60),
@ShipTo_City char(40),
@ShipTo_State char(40),
@ShipTo_Zip_Code char(20),
@ShipTo_Country char(60),
@Tax money,
@Duty money,
@Freight money,
@Tax_Exempt char(6),
@PO_Number char(25),
@MD5_Hash char(100),
@Card_Code_Reponse char(1),
@Cardholder_AVR char(1),
@Account_Number char(22),
@Card_Type char(10),
@Split_Tender_ID char(20),
@Requested_Amount money,
@Balance_On_Card money

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    INSERT INTO Credit_Card_Transactions
           (Response_Code
           ,Response_Subcode
           ,Response_Reason_Code
           ,Response_Reason_Text
           ,Authorization_Code
           ,AVS_Reponse
           ,Transaction_ID
           ,Invoice_Number
           ,Description
           ,Amount
           ,Method
           ,Transaction_Type
           ,CustomerID
           ,FirstName
           ,LastName
           ,Company
           ,Address
           ,City
           ,State
           ,Zip_Code
           ,Country
           ,Phone
           ,Fax
           ,Email
           ,ShipTo_FirstName
           ,ShipTo_LastName
           ,ShipTo_Company
           ,ShipTo_Address
           ,ShipTo_City
           ,ShipTo_State
           ,ShipTo_Zip_Code
           ,ShipTo_Country
           ,Tax
           ,Duty
           ,Freight
           ,Tax_Exempt
           ,PO_Number
           ,MD5_Hash
           ,Card_Code_Reponse
           ,Cardholder_AVR
           ,Account_Number
           ,Card_Type
           ,Split_Tender_ID
           ,Requested_Amount
           ,Balance_On_Card
           ,Transaction_Request_Date)
     VALUES
           (@Response_Code
           ,@Response_Subcode
           ,@Response_Reason_Code
           ,@Response_Reason_Text
           ,@Authorization_Code
           ,@AVS_Reponse
           ,@Transaction_ID
           ,@Invoice_Number
           ,@Description
           ,@Amount
           ,@Method
           ,@Transaction_Type
           ,@CustomerID
           ,@FirstName
           ,@LastName
           ,@Company
           ,@Address
           ,@City
           ,@State
           ,@Zip_Code
           ,@Country
           ,@Phone
           ,@Fax
           ,@Email
           ,@ShipTo_FirstName
           ,@ShipTo_LastName
           ,@ShipTo_Company
           ,@ShipTo_Address
           ,@ShipTo_City
           ,@ShipTo_State
           ,@ShipTo_Zip_Code
           ,@ShipTo_Country
           ,@Tax
           ,@Duty
           ,@Freight
           ,@Tax_Exempt
           ,@PO_Number
           ,@MD5_Hash
           ,@Card_Code_Reponse
           ,@Cardholder_AVR
           ,@Account_Number
           ,@Card_Type
           ,@Split_Tender_ID
           ,@Requested_Amount
           ,@Balance_On_Card
           ,GETDATE())
	
END

