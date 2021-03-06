﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class dsp_AuditNotes : System.Web.UI.Page
{

    int orderID;
    

    SqlConnection sqlcon = new SqlConnection(DBCommon.ConnectionString);
    SqlCommand sqlcmd = new SqlCommand();
    SqlDataAdapter da = new SqlDataAdapter();
    DataTable dt = new DataTable();

    private void Initialize()
    {
        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            connection.Open();
            SqlDataReader dataReader;
            command.CommandText = "SELECT NoteTypeID,NoteTypeName,NoteTypeDescription FROM AuditNoteTypes WITH (NOLOCK)";
            command.CommandType = CommandType.Text;
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlAuditNoteType.DataSource = dataReader;
                ddlAuditNoteType.DataTextField = "NoteTypeName";
                ddlAuditNoteType.DataValueField = "NoteTypeID";
                ddlAuditNoteType.DataBind();
            }
            dataReader.Close();
           
            command.CommandText = "select convert(char(2),statuscode)+'-'+'10' as statuscode,statusname " + 
                                  "  from Statuses WHERE StatusCode = 20 " + 
                                   " UNION " +
                                   " select convert(char(2),statuscode)+'-'+'30' as statuscode,statusname " +
                                   " from Statuses WHERE StatusCode = 50";
                                   
            command.CommandType = CommandType.Text;
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {

           
                ddlOrderStatus.DataSource = dataReader;
                ddlOrderStatus.DataTextField = "statusname";
                ddlOrderStatus.DataValueField = "statuscode";
                ddlOrderStatus.DataBind();
            }
            dataReader.Close();

            litEnterBy.Text = Session["Name"].ToString();
            litEnterDate.Text = String.Format("{0:dddd, MMMM d, yyyy}", DateTime.Now);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["id"] != null)
        {
            try
            {
                orderID = int.Parse(Request.QueryString["id"]);
                if (!IsPostBack)
                {

                    Initialize();
                    LoadAuditNotesGrid();
                }


            }
            catch
            {
                // deal with it
            }
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //
        UpdateOrderStatus();
        SaveAuditNotesDetail();
        LoadAuditNotesGrid();
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        //
        LoadAuditNotesGrid();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //
        Response.Redirect("~/Secure/OrderView.aspx", true);
    }

    void UpdateOrderStatus()
    {

        string selectedValue = ddlOrderStatus.SelectedValue;

        string[] result = selectedValue.Split('-');

        string statusCode = result[0];
        string roleCode = result[1];

        

        using (SqlConnection con = new SqlConnection(DBCommon.ConnectionString))
        {
            con.Open();
            try
            {
                string sqlString = "";

                sqlString = "Update orderstatus " +
	                         "   SET StatusCode = @StatusCode, " +
		                     "       Modifiedby = @Modifiedby, " +
		                     "       Modified = @Modified " +
                             " WHERE " +
	                         "   OrderID = @OrderID " +
                             "   AND RoleCode = @RoleCode";

                using (SqlCommand command = new SqlCommand(sqlString, con))
                {
                    // Use a shorthand syntax to add the id parameter.
                    command.Parameters.Add("@StatusCode", SqlDbType.Int).Value = int.Parse(statusCode);
                    command.Parameters.Add("@Modifiedby", SqlDbType.VarChar, 100).Value = Session["UserID"].ToString();
                    command.Parameters.Add("@Modified", SqlDbType.DateTime).Value = DateTime.Now;
                    command.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
                    command.Parameters.Add("@RoleCode", SqlDbType.Int).Value = int.Parse(roleCode);
                    command.ExecuteNonQuery();

                    con.Close();

                    Response.Redirect(Request.Url.ToString(), false);
                }
            }
            catch
            {
                Console.WriteLine("Could not insert.");
            }
        }
    }

    void LoadAuditNotesGrid()
    {

       
        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getAuditNotesByOrderID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@OrderID", orderID));

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
        mySqlDataAdapter.Fill(myDataSet, "AuditNotesSummary");

        // display the rows in the Products DataTable
        DataTable AuditNotesDetailDT = myDataSet.Tables["AuditNotesSummary"];


        gvAuditNotes.AllowPaging = true;

        gvAuditNotes.DataSource = AuditNotesDetailDT;

        gvAuditNotes.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();
       
    }

    void SaveAuditNotesDetail()
    {
        string selectedValue = ddlOrderStatus.SelectedValue;

        string[] result = selectedValue.Split('-');

        string statusCode = result[0];
        string roleCode = result[1];

        

        using (SqlConnection con = new SqlConnection(DBCommon.ConnectionString))
        {
            con.Open();
            try
            {
                      using (SqlCommand command = new SqlCommand(
                 " INSERT INTO AuditNotes (EnterBy ,Notes,EnterDate,OrderID ,StatusCode ,NoteTypeID) " +
                " VALUES (@EnterBy, @Notes, @EnterDate, @OrderID, @StatusCode, @NoteTypeID) ", con))
                {
                    // Use a shorthand syntax to add the id parameter.
                    command.Parameters.Add("@EnterBy", SqlDbType.VarChar, 100).Value = Session["Name"].ToString();
                    command.Parameters.Add("@Notes", SqlDbType.VarChar, 2000).Value =  txtNotes.Text.Trim();
                    command.Parameters.Add("@EnterDate", SqlDbType.DateTime).Value = DateTime.Now;
                    command.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
                    command.Parameters.Add("@StatusCode", SqlDbType.Int).Value = int.Parse(statusCode);
                    command.Parameters.Add("@NoteTypeID", SqlDbType.Int).Value = int.Parse(ddlAuditNoteType.SelectedValue);
                    command.ExecuteNonQuery();

                    con.Close();

                    Response.Redirect(Request.Url.ToString(), false);
                }
            }
            catch
            {
                Console.WriteLine("Could not insert.");
            }
        }


        // LoadGrid();
    }
}