using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public class OrderDetails
{
    public int OrderDetailID { get; set; }
    public int OrderID { get; set; }
    public int ProductID { get; set; }
    public int ProductRateID { get; set; }
    public double ProductQty { get; set; }
    public double Rate { get; set; }
    public double OrderAmount { get; set; }
    public int ProductAdditionalRateID { get; set; }
    public double OrderAdditionalAmount { get; set; }
    //public string BankName { get; set; }
    //public string CheckNo { get; set; }
    //public DateTime CheckDate { get; set; }



    public DataTable getOrderDetailByOrderID(int orderID)
    {

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getOrderDetailByOrderID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@orderID", orderID));

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        // create a SqlDataAdapter object
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();

        // set the SelectCommand property of the SqlAdapter object
        // to the SqlCommand object
        mySqlDataAdapter.SelectCommand = mySqlCommand;

        // create a DataSet object to store the results of
        // the stored procedure call
        DataSet myDataSet = new DataSet();

        // use the Fill() method of the SqlDataAdapter object to
        // retrieve the rows from the stored procedure call,
        // storing the rows in a DataTable named Products
        mySqlDataAdapter.Fill(myDataSet, "OrderDetail");

        // display the rows in the Products DataTable
        DataTable orderDetailDT = myDataSet.Tables["OrderDetail"];

        return orderDetailDT;
    }

    public DataTable getClientDetailByOrderID(int orderID)
    {

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getClientDetailByOrderID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@orderID", orderID));

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        // create a SqlDataAdapter object
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();

        // set the SelectCommand property of the SqlAdapter object
        // to the SqlCommand object
        mySqlDataAdapter.SelectCommand = mySqlCommand;

        // create a DataSet object to store the results of
        // the stored procedure call
        DataSet myDataSet = new DataSet();

        // use the Fill() method of the SqlDataAdapter object to
        // retrieve the rows from the stored procedure call,
        // storing the rows in a DataTable named Products
        mySqlDataAdapter.Fill(myDataSet, "ClientDetail");

        // display the rows in the Products DataTable
        DataTable dtClientDetail = myDataSet.Tables["ClientDetail"];

        return dtClientDetail;
    }

    public DataTable getMemberDetailByOrderID(int orderID)
    {

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getMemberDetailByOrderID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@orderID", orderID));

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        // create a SqlDataAdapter object
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();

        // set the SelectCommand property of the SqlAdapter object
        // to the SqlCommand object
        mySqlDataAdapter.SelectCommand = mySqlCommand;

        // create a DataSet object to store the results of
        // the stored procedure call
        DataSet myDataSet = new DataSet();

        // use the Fill() method of the SqlDataAdapter object to
        // retrieve the rows from the stored procedure call,
        // storing the rows in a DataTable named Products
        mySqlDataAdapter.Fill(myDataSet, "MemberDetail");

        // display the rows in the Products DataTable
        DataTable dtMemberDetail = myDataSet.Tables["MemberDetail"];

        return dtMemberDetail;
    }

    public DataTable getClientOrderDetailByOrderID(int orderID)
    {

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getClientOrderDetailByOrderID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@orderID", orderID));

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        // create a SqlDataAdapter object
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();

        // set the SelectCommand property of the SqlAdapter object
        // to the SqlCommand object
        mySqlDataAdapter.SelectCommand = mySqlCommand;

        // create a DataSet object to store the results of
        // the stored procedure call
        DataSet myDataSet = new DataSet();

        // use the Fill() method of the SqlDataAdapter object to
        // retrieve the rows from the stored procedure call,
        // storing the rows in a DataTable named Products
        mySqlDataAdapter.Fill(myDataSet, "ClientOrderDetail");

        // display the rows in the Products DataTable
        DataTable dtClientOrderDetail = myDataSet.Tables["ClientOrderDetail"];

        return dtClientOrderDetail;
    }

    public void DeleteOrderDetailByOrderID(int orderID)
    {

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "DeleteOrderDetail";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@orderID", orderID));

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        mySqlConnection.Close();
    }

    public void UpdateOrderPaymentByCreditCard(int orderID, Decimal AmountPaid , int PaymentTypeID, string UserID)
    {

        SqlConnection con = new SqlConnection(DBCommon.ConnectionString);

        SqlCommand cmd = new SqlCommand();

        cmd.CommandText = "usp_CAL_UPD_OrderPayment";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Connection = con;

        cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
        cmd.Parameters.Add("@AmountPaid", SqlDbType.Money).Value = AmountPaid;
        cmd.Parameters.Add("@PaymentTypeID", SqlDbType.Int).Value = PaymentTypeID;
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar, 100).Value = UserID;

        con.Open();

        try
        {
            cmd.ExecuteNonQuery();
        }
        catch
        {
            throw;
        }
        finally
        {
            con.Close();
        }

       
    }

    public void UpdateOrderPaymentByCheck(int orderID, string BankName , string CheckNo , DateTime CheckDate,Decimal BankAmount,   Decimal AmountPaid, int PaymentTypeID, string UserID)
    {

        SqlConnection con = new SqlConnection(DBCommon.ConnectionString);

        SqlCommand cmd = new SqlCommand();

        cmd.CommandText = "usp_CAL_UPD_OrderPaymentByCheck";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Connection = con;

        cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
        cmd.Parameters.Add("@BankName",SqlDbType.VarChar, 50).Value = BankName;
        cmd.Parameters.Add("@CheckNo",SqlDbType.VarChar, 50).Value = CheckNo;
        cmd.Parameters.Add("@CheckDate", SqlDbType.VarChar, 50).Value = CheckDate;
        cmd.Parameters.Add("@BankAmount", SqlDbType.Money).Value = BankAmount;
        cmd.Parameters.Add("@AmountPaid", SqlDbType.Money).Value = AmountPaid;
        cmd.Parameters.Add("@PaymentTypeID", SqlDbType.Int).Value = PaymentTypeID;
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar, 100).Value = UserID;

         con.Open();

        try
        {
            cmd.ExecuteNonQuery();
        }
        catch
        {
            throw;
        }
        finally
        {
            con.Close();
        }


    }

}


