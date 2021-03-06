USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[SetOrderDetails]    Script Date: 02/14/2012 22:41:54 ******/
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
	@OrderAdditionalAmount Money --,
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
			OrderAdditionalAmount = @ORDERADDITIONALAMOUNT
		WHERE
			OrderID = @ORDERID
			AND OrderDetailID = @OrderDetailsID
		
		RETURN @OrderID
		
	END
	ELSE
	BEGIN
		INSERT INTO ORDERDETAILS(OrderID,ProductID,ProductRateID,ProductQty, Rate,
			OrderAmount, ProductAdditionalRateID, OrderAdditionalAmount)
			--, BankName,		CheckNo, CheckDate)
			VALUES(@ORDERID,@PRODUCTID,@PRODUCTRATEID,@PRODUCTQTY, @RATE,
				@ORDERAMOUNT,@PRODUCTADDITIONALRATEID,@ORDERADDITIONALAMOUNT)
				---,@BANKNAME,@CHECKNO, @CHECKDATE)
		
		SELECT @OrderID = SCOPE_IDENTITY();
	END

	RETURN @OrderID
END
