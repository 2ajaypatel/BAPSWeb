USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAL_UPD_OrderPayment]    Script Date: 02/18/2012 12:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAL_UPD_OrderPaymentByCheck]
	@OrderID		BigInt,
	@BankName		varchar(50),
	@CheckNo		varchar(50),
	@CheckDate		DateTime,
	@BankAmount		money,
	@AmountPaid		Money,
	@PaymentTypeID	int	,
	@UserID			varchar(100)
	
	
AS
	/* SET NOCOUNT ON */
BEGIN	


			UPDATE ORDERMASTER 
				SET 
					BankName = @BankName,
					CheckNo = @CheckNo,
					CheckDate = @CheckDate,
					BankAmount = @BankAmount,
					AmountPaid = @AmountPaid,
					PaymentTypeID = @PaymentTypeID,
					PaymentReceived = 1,
					ModifiedBy = @UserID,
					Modified = getdate()
			WHERE ORDERID=@OrderID
		
END
	
