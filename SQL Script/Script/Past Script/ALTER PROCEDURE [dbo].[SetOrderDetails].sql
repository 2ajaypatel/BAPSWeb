USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[SetOrderDetails]    Script Date: 02/15/2012 21:31:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SetOrderDetails]
	@OrderDetailsID BigInt,
	@OrderID BigInt,
	@ProductID BigInt,
	@ProductRateID BigInt,
	@ProductQty	Float,
	@Rate Money,
	@OrderAmount Money,
	@ProductAdditionalRateID BigInt,
	@OrderAdditionalAmount Money ,
	@UserID varchar(100)
	/*@BankName varchar(50),
	@CheckNo varchar(20),
	@CheckDate DateTime*/
AS
	/* SET NOCOUNT ON */
BEGIN
	
	IF (@ORDERID > 0 AND @OrderDetailsID > 0)
	BEGIN
		UPDATE
			ORDERDETAILS
		SET
			ProductID = @PRODUCTID,
			ProductRateID = @PRODUCTRATEID,
			ProductQty = @PRODUCTQTY,
			Rate = @RATE,
			OrderAmount = @ORDERAMOUNT,
			ProductAdditionalRateID = @PRODUCTADDITIONALRATEID,
			OrderAdditionalAmount = @ORDERADDITIONALAMOUNT,
			ModifiedBy = @UserID,
			Modified = getdate()
		WHERE
			OrderID = @ORDERID
			AND OrderDetailID = @OrderDetailsID
		
		RETURN @OrderID
		
	END
	ELSE
	BEGIN
		INSERT INTO ORDERDETAILS(OrderID,ProductID,ProductRateID,ProductQty, Rate,
			OrderAmount, ProductAdditionalRateID, OrderAdditionalAmount,
			CreatedBy,Created,Modifiedby,Modified )
			VALUES(@ORDERID,@PRODUCTID,@PRODUCTRATEID,@PRODUCTQTY, @RATE,
				@ORDERAMOUNT,@PRODUCTADDITIONALRATEID,@ORDERADDITIONALAMOUNT,
				@UserID,getdate(),@UserID,getdate())
		
		SELECT @OrderID = SCOPE_IDENTITY();
	END

	RETURN @OrderID
END
