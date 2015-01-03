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

public partial class Admin_rpt_OrderAdvanceSummary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            RegionDO regionDAO = new RegionDO();

            DataTable dtRegion = regionDAO.getRegions();


            ddlbRegion.DataSource = dtRegion;
            ddlbRegion.DataTextField = "regionname";
            ddlbRegion.DataValueField = "regionid";
            ddlbRegion.DataBind();
        }
    }


    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;
        BindData(0, 0);
    }

    protected void ddlbRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        // need to write
        ddlbCenter.Items.Clear();
        ddlbCenter.Items.Add(new System.Web.UI.WebControls.ListItem("- - - Select Center Name - - -", "-1"));
        ddlbCenter.Items.Add(new System.Web.UI.WebControls.ListItem("ALL", "0"));


        ddlbCenter.AppendDataBoundItems = true;

        CenterDAO centerDAO = new CenterDAO();

        int selectedRegionID = 0;
       

        selectedRegionID = Convert.ToInt32(ddlbRegion.SelectedValue);


        DataTable dtCenter = centerDAO.getCentersByRegion(selectedRegionID);

        ddlbCenter.DataSource = dtCenter;
        ddlbCenter.DataTextField = "centername";
        ddlbCenter.DataValueField = "centerid";
        ddlbCenter.DataBind();
        if (ddlbCenter.Items.Count > 1)
        {
            ddlbCenter.Enabled = true;
        }
        else
        {
            ddlbCenter.Enabled = false;
            ddlbCenter.Enabled = false;
        }
       
    }

    public void BindData(int regionID, int centerID)
    {

        // need get data
        int selectedRegionID = 0;
        int selectedCenterID = 0;

        selectedRegionID = Convert.ToInt32(ddlbRegion.SelectedValue);
        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);


        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "usp_CAL_SEL_OrdersBalanceSummaryByCenterIDRegionID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(
        mySqlCommand.Parameters.Add(new SqlParameter("@regionID", selectedRegionID));
        mySqlCommand.Parameters.Add(new SqlParameter("@centerID", selectedCenterID));

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
        mySqlDataAdapter.Fill(myDataSet, "OrderAdvance");

        // display the rows in the Products DataTable
        DataTable orderDetailDT = myDataSet.Tables["OrderAdvance"];


        gv.AllowPaging = true;

        gv.DataSource = orderDetailDT;

        gv.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

    }

    protected void run_Click(object sender, EventArgs e)
    {
        // need get data
        int selectedRegionID;
        int selectedCenterID;

        selectedRegionID = Convert.ToInt32(ddlbRegion.SelectedValue);
        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData(selectedRegionID, selectedCenterID);
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int sortOrder = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "sortOrder"));
            
            if (sortOrder == 2)
            {
                //FFFFCC
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFCC");  
                //System.Drawing.Color
            }

            if (sortOrder == 3)
            {
                //FFFFCC
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#CCFFFF");  
                //System.Drawing.Color
            }
            
        }
    }

    public void btnExcel_Click(object sender, EventArgs e)
    {

        // need get data
        int selectedRegionID;
        int selectedCenterID;

        selectedRegionID = Convert.ToInt32(ddlbRegion.SelectedValue);
        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData(selectedRegionID, selectedCenterID);


        GridViewExportUtil.Export("Order And Advance Summary.xls", gv);

    }

}