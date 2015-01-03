USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[SetOrder]    Script Date: 02/18/2012 11:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAL_UPD_OrderPayment]
	@OrderID		BigInt,
	@AmountPaid		Money,
	@PaymentTypeID	int	,
	@UserID			varchar(100)
	
AS
	/* SET NOCOUNT ON */
BEGIN	


			UPDATE ORDERMASTER 
				SET AmountPaid = @AmountPaid,
				PaymentTypeID = @PaymentTypeID,
				PaymentReceived = 1,
				ModifiedBy = @UserID,
				Modified = getdate()
			WHERE ORDERID=@OrderID
		
END
	
