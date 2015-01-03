using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for CreditCardTransactionsDO
/// </summary>
public class CreditCardTransactionsDO
{
	public CreditCardTransactionsDO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void InsertCreditCardTransaction(string[] response)

    {
        SqlConnection con = new SqlConnection(DBCommon.ConnectionString);

        SqlCommand cmd = new SqlCommand();

        cmd.CommandText = "Insert_Credit_Card_Transactions";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Connection = con;

        cmd.Parameters.Add("@Response_Code", SqlDbType.Int).Value =  int.Parse(response[0].ToString());
        cmd.Parameters.Add("@Response_Subcode", SqlDbType.VarChar).Value = response[1].ToString();

        cmd.Parameters.Add("@Response_Reason_Code", SqlDbType.Int).Value = int.Parse(response[2].ToString());
        
        cmd.Parameters.Add("@Response_Reason_Text", SqlDbType.VarChar).Value = response[3].ToString();
        cmd.Parameters.Add("@Authorization_Code", SqlDbType.VarChar).Value = response[4].ToString();
        cmd.Parameters.Add("@AVS_Reponse", SqlDbType.Char, 1).Value = response[5].ToString();
        cmd.Parameters.Add("@Transaction_ID", SqlDbType.VarChar).Value = response[6].ToString();
        cmd.Parameters.Add("@Invoice_Number", SqlDbType.VarChar).Value = response[7].ToString();
        cmd.Parameters.Add("@Description", SqlDbType.Char, 255).Value = response[8].ToString();

        cmd.Parameters.Add("@Amount", SqlDbType.Money).Value = String.IsNullOrEmpty(response[9].ToString()) ? 0.0 : Convert.ToDouble(response[9].ToString());
        
        cmd.Parameters.Add("@Method", SqlDbType.Char,10).Value = response[10].ToString();
        cmd.Parameters.Add("@Transaction_Type", SqlDbType.VarChar).Value = response[11].ToString();
        cmd.Parameters.Add("@CustomerID", SqlDbType.Char, 20).Value = response[12].ToString();
        cmd.Parameters.Add("@FirstName", SqlDbType.Char, 50).Value = response[13].ToString();

        cmd.Parameters.Add("@LastName", SqlDbType.Char, 50).Value = response[14].ToString();
        cmd.Parameters.Add("@Company", SqlDbType.Char, 50).Value = response[15].ToString();
        cmd.Parameters.Add("@Address", SqlDbType.Char, 50).Value = response[16].ToString();
        cmd.Parameters.Add("@City", SqlDbType.Char, 40).Value = response[17].ToString();
        cmd.Parameters.Add("@State", SqlDbType.Char, 40).Value = response[18].ToString();
        cmd.Parameters.Add("@Zip_Code", SqlDbType.Char, 20).Value = response[19].ToString();
        cmd.Parameters.Add("@Country", SqlDbType.Char, 60).Value = response[20].ToString();
        cmd.Parameters.Add("@Phone", SqlDbType.Char, 25).Value = response[21].ToString();
        cmd.Parameters.Add("@Fax", SqlDbType.Char, 25).Value = response[22].ToString();
        cmd.Parameters.Add("@Email", SqlDbType.Char, 255).Value = response[23].ToString();
        cmd.Parameters.Add("@ShipTo_FirstName", SqlDbType.Char, 50).Value = response[24].ToString();
        cmd.Parameters.Add("@ShipTo_LastName", SqlDbType.Char, 50).Value = response[25].ToString();
        cmd.Parameters.Add("@ShipTo_Company", SqlDbType.Char, 60).Value = response[26].ToString();
        cmd.Parameters.Add("@ShipTo_Address", SqlDbType.Char, 60).Value = response[27].ToString();
        cmd.Parameters.Add("@ShipTo_City", SqlDbType.Char, 40).Value = response[28].ToString();
        cmd.Parameters.Add("@ShipTo_State", SqlDbType.Char, 40).Value = response[29].ToString();
        cmd.Parameters.Add("@ShipTo_Zip_Code", SqlDbType.Char, 20).Value = response[30].ToString();
        cmd.Parameters.Add("@ShipTo_Country", SqlDbType.Char, 60).Value = response[31].ToString();

        cmd.Parameters.Add("@Tax", SqlDbType.Money).Value = String.IsNullOrEmpty( response[32].ToString() ) ? 0.0 : Convert.ToDouble(response[32].ToString());
        cmd.Parameters.Add("@Duty", SqlDbType.Money).Value = String.IsNullOrEmpty(response[33].ToString()) ? 0.0 : Convert.ToDouble(response[33].ToString());
        cmd.Parameters.Add("@Freight", SqlDbType.Money).Value = String.IsNullOrEmpty(response[34].ToString()) ? 0.0 : Convert.ToDouble(response[34].ToString());
        
        cmd.Parameters.Add("@Tax_Exempt", SqlDbType.Char, 6).Value = response[35].ToString();
        cmd.Parameters.Add("@PO_Number", SqlDbType.Char, 25).Value = response[36].ToString();
        cmd.Parameters.Add("@MD5_Hash", SqlDbType.Char, 100).Value = response[37].ToString();
        cmd.Parameters.Add("@Card_Code_Reponse", SqlDbType.Char, 1).Value = response[38].ToString();
        cmd.Parameters.Add("@Cardholder_AVR", SqlDbType.Char, 1).Value = response[39].ToString();
        cmd.Parameters.Add("@Account_Number", SqlDbType.Char, 22).Value = response[50].ToString();
        cmd.Parameters.Add("@Card_Type", SqlDbType.Char, 10).Value = response[51].ToString();
        cmd.Parameters.Add("@Split_Tender_ID", SqlDbType.Char, 20).Value = response[52].ToString();

        cmd.Parameters.Add("@Requested_Amount", SqlDbType.Money).Value = String.IsNullOrEmpty(response[53].ToString()) ? 0.0 : Convert.ToDouble(response[53].ToString());
        cmd.Parameters.Add("@Balance_On_Card", SqlDbType.Money).Value = String.IsNullOrEmpty(response[54].ToString()) ? 0.0 : Convert.ToDouble(response[54].ToString());

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

    public DataTable getCreditCardTransactionByPONumber(string PONumber)
    {

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getCreditCardTransactionByPONumber";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@PO_Number", PONumber));

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
        mySqlDataAdapter.Fill(myDataSet, "TransactionDetail");

        // display the rows in the Products DataTable
        DataTable TransactionDetaildt = myDataSet.Tables["TransactionDetail"];

        return TransactionDetaildt;
    }

}
