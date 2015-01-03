using System;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Linq;

public partial class Admin_rpt_MissingOrdersByCenter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            ProjectYearDO projectYearDAO = new ProjectYearDO();

            DataTable dtProjectYear = projectYearDAO.getProjectYears();


            ddlbProjectYear.DataSource = dtProjectYear;
            ddlbProjectYear.DataTextField = "ProjectYear";
            ddlbProjectYear.DataValueField = "ProjectYear";
            ddlbProjectYear.DataBind();

            ddlbProjectYear.SelectedValue = DateTime.Now.Year.ToString();
            
        }

    }

    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void ddlbProjectYear_SelectedIndexChanged(object sender, EventArgs e)
    {


        BindData();

    }

    public void BindData()
    {

        // refresh order view
        int selectedProjectYear;

        selectedProjectYear = Convert.ToInt32(ddlbProjectYear.SelectedValue);


        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "usp_CAL_getMissingOrdersByCenter";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@ProjectYear", selectedProjectYear));

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
        mySqlDataAdapter.Fill(myDataSet, "MissingOrders");

        // display the rows in the Products DataTable
        DataTable missingOrdersdt = myDataSet.Tables["MissingOrders"];


        gv.AllowPaging = true;

        gv.DataSource = missingOrdersdt;

        gv.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

    }

    protected void run_Click(object sender, EventArgs e)
    {
       
        BindData();
    }

    public void imgBtnExcel_Click(object sender, EventArgs e)
    {

        BindData();


        GridViewExportUtil.Export("Missing Orders.xls", gv);

    }

}