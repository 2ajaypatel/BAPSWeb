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



public partial class Admin_rpt_unpaidOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ddlbRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        // need to write
        ddlbCenter.Items.Clear();
        ddlbCenter.Items.Add(new System.Web.UI.WebControls.ListItem("- - - Select Center Name - - -", "-1"));
        ddlbCenter.Items.Add(new System.Web.UI.WebControls.ListItem("ALL", "0"));


        ddlbCenter.AppendDataBoundItems = true;

        string connectionString = DBCommon.ConnectionString;

        String strQuery = "SELECT centername,centerid FROM CENTER where regionid = @regionid";

        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand();

        cmd.Parameters.AddWithValue("@regionid", ddlbRegion.SelectedItem.Value);

        cmd.CommandType = CommandType.Text;
        cmd.CommandText = strQuery;
        cmd.Connection = con;

         try
            {
                con.Open();
                ddlbCenter.DataSource = cmd.ExecuteReader();
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
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
    }


    public void BindData(int regionID, int centerID)
    {

        // need get data
        int selectedRegionID;
        int selectedCenterID;

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
        string procedureString = "select_unpaidOrdersByCenterID";

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
        mySqlDataAdapter.Fill(myDataSet, "OrderSummarybyCenter");

        // display the rows in the Products DataTable
        DataTable orderDetailDT = myDataSet.Tables["OrderSummarybyCenter"];


        gv.AllowPaging = true;

        gv.DataSource = orderDetailDT;

        gv.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

    }

    public void btnExcel_Click(object sender, EventArgs e)
    {

        // refresh order view
        BindData(0, 0);

       
        GridViewExportUtil.Export("Order Summary.xls", gv);

    }

    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;

        // refresh order view
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

       // BindData(selectedCenterID);

    }

    protected void gv_DataBound(object sender, EventArgs e)
    {
        if (gv.Rows.Count > 0)
        {

            ((Label)gv.FooterRow.FindControl("lblTotalOrderQty")).Text =
                String.Format("{0}", gv.Rows.Cast<GridViewRow>().Select(a => Int32.Parse(((Label)a.FindControl("lblOrderQty")).Text)).Sum());

             ((Label)gv.FooterRow.FindControl("lblTotalOrder_Amount")).Text =
              String.Format("{0:c}", gv.Rows.Cast<GridViewRow>().Select(a => Decimal.Parse(((Label)a.FindControl("lblOrder_Amount")).Text.ToString(), System.Globalization.NumberStyles.Any)).Sum());


            //((Label)gv.FooterRow.FindControl("lblTotalOrder")).Text =
            //    String.Format("{0}", gv.Rows.Cast<GridViewRow>().Select(a => Int32.Parse(((Label)a.FindControl("lblOrder")).Text)).Sum());

            //((Label)gv.FooterRow.FindControl("lblTotalCost")).Text =
            //    String.Format("{0:C}", gv.Rows.Cast<GridViewRow>().Select(a => Double.Parse(((Label)a.FindControl("lblCost")).Text)).Sum());

            //((Label)gv.FooterRow.FindControl("lbltotalAdditionalCost")).Text =
            //    String.Format("{0:C}", gv.Rows.Cast<GridViewRow>().Select(a => Double.Parse(((Label)a.FindControl("lblAdditionalCost")).Text)).Sum());

        }


    }

    protected void run_Click(object sender, EventArgs e)
    {
        // need get data
        int selectedRegionID;
        int selectedCenterID;

        selectedRegionID = Convert.ToInt32(ddlbRegion.SelectedValue);
        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData(selectedRegionID,selectedCenterID);
    }
}