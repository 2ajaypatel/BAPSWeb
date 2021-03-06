USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[SetOrder]    Script Date: 03/24/2012 20:51:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SetOrder]
	@OrderID		BigInt,
	@OrderDate		DateTime,
	@OrderAmount	Money,
	@ClientID		BigInt,
	@MemberID		BigInt,
	@OrderStatus	varchar(50),
	@CenterID		BigInt,
	@BankName		varchar(50),
	@CheckNo		varchar(20),
	@CheckDate		DateTime,
	@BankAmount		Money,
	@Year			BigInt,
	@UserID			varchar(100)
AS
	/* SET NOCOUNT ON */
	
	IF (@ORDERID > 0)
		BEGIN
			UPDATE ORDERMASTER SET
				ORDERDATE = @ORDERDATE,
				OrderAmount = @OrderAmount,
				ClientID	= @ClientID,
				MemberID	= @MemberID,
				OrderStatus = @OrderStatus,
				CenterID	= @CenterID,
				BANKNAME	= @BANKNAME,
				CHECKNO	= @CHECKNO,
				CHECKDATE	= @CHECKDATE,
				BankAmount	= @BankAmount,
				ProjectYear = @Year,
				ModifiedBy = @UserID,
				Modified = getdate()
				WHERE ORDERID=@OrderID
		END
	ELSE
		BEGIN
			DECLARE @poNumber varchar(20)
			
			SET @ORDERID=0
			
			INSERT ORDERMASTER(ORDERDATE,OrderAmount,ClientID,MemberID,OrderStatus,
					CenterID,BankName,CheckNo, CheckDate,BankAmount,ProjectYear,CreatedBy,Created,Modifiedby,Modified )
				VALUES(@OrderDate,@OrderAmount,@ClientID,@MemberID,@OrderStatus,@CenterID,
				  @BANKNAME,@CHECKNO, @CHECKDATE,@BankAmount,@Year,@UserID,getdate(),@UserID,getdate())
				
			SELECT @ORDERID = SCOPE_IDENTITY();
			
			SELECT @poNumber = ( dbo.generatePONumber(@CenterID) + RIGHT('0000'+ CONVERT(VARCHAR,@ORDERID),5))  
			
			UPDATE
				ORDERMASTER
			SET
				poNumber = @poNumber
			WHERE 
				OrderID = @ORDERID
				
			INSERT INTO OrderStatus
				   (OrderID
				   ,StatusCode
				   ,RoleCode
				   ,CreatedBy
				   ,Created
				   ,Modifiedby
				   ,Modified)
			 VALUES
				   (@ORDERID
				   ,10
				   ,10
				   ,@UserID
				   ,getdate()
				   ,@UserID
				   ,getdate())
				   
			 INSERT INTO OrderStatus
				   (OrderID
				   ,StatusCode
				   ,RoleCode
				   ,CreatedBy
				   ,Created
				   ,Modifiedby
				   ,Modified)
			 VALUES
				   (@ORDERID
				   ,10
				   ,30
				   ,@UserID
				   ,getdate()
				   ,@UserID
				   ,getdate())

			
		END
		
	RETURN @ORDERID
