using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class Secure_OrderView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CENTERID"] == null || Session["CENTERID"].ToString() == "")
        {
            Response.Redirect("~/dsp_Login.aspx", true);
        }

        if (!Page.IsPostBack)
        {
            ViewState["sortOrder"] = "";
            BindData("", "");

        }
        //else

        //BindData();
    }

    protected void gv_Sorting(object sender, GridViewSortEventArgs e)
    {

        BindData(e.SortExpression, sortOrder);

    }

    public string sortOrder
    {
        get
        {
            if (ViewState["sortOrder"].ToString() == "desc")
            {
                ViewState["sortOrder"] = "asc";
            }
            else
            {
                ViewState["sortOrder"] = "desc";
            }

            return ViewState["sortOrder"].ToString();
        }
        set
        {
            ViewState["sortOrder"] = value;
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int orderID;

        if (e.CommandName == "viewaudit")
        {
            // get the orderID of the clicked row

            orderID = Convert.ToInt32(e.CommandArgument);

           LoadAuditNotesGrid(orderID);

           

           dvClient.Visible = false;
           dvMemberDetail.Visible = false;
           dvOrderMaster.Visible = false;
           gvOrderDetail.Visible = false;

           gvAuditNotes.Visible = true;



        }
    }

   public void LoadAuditNotesGrid(int orderID)
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

    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {



        gv.PageIndex = e.NewPageIndex;



        BindData("", "");


    }

    public int GetColumnIndexByName(GridViewRow row, string SearchColumnName)
    {
        int columnIndex = 0;
        foreach (DataControlFieldCell cell in row.Cells)
        {
            if (cell.ContainingField is BoundField)
            {
                if (((BoundField)cell.ContainingField).DataField.Equals(SearchColumnName))
                {
                    break;
                }
            }
            columnIndex++;
        }
        return columnIndex;
    }

    protected void gv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int adminedit = Int32.Parse(gv.Rows[e.RowIndex].Cells[17].Text);

        // int intex = Int32.Parse(gv.Rows[e.RowIndex].Cells[GetColumnIndexByName(gv.Rows[e.RowIndex], "adminedit")].Text);
        

       // int design = Int32.Parse(gv.Rows[e.RowIndex].Cells[GetColumnIndexByName(gv.Rows[e.RowIndex], "designedit")].Text);


        //HiddenField hf = (HiddenField)gv.Rows[e.RowIndex].Cells[0].FindControl("hfAdminEdit");

        //int adminedit = Convert.ToInt32(hf.Value);


        if (adminedit != null)
        {
            if (adminedit == 0)
            {
                // don't do anything
            }
            else
            {
                int orderID = Convert.ToInt16(gv.DataKeys[e.RowIndex].Value);

                DeleteRecordByOrderID(orderID);

                // refresh order view
                BindData("", "");
            }
        }
    }

    protected void gv_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {

    }

    public void CopyOrderByOrderID(int tempOrderID)
    {
        if (tempOrderID > 0)
        {

            SqlConnection con = new SqlConnection(DBCommon.ConnectionString);

            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "CopyOrderByOrderID";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.Parameters.Add(new SqlParameter("@orderID", SqlDbType.Int, 4));

            cmd.Parameters["@orderID"].Value = tempOrderID;

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

    public void DeleteRecordByOrderID(int tempOrderID)
    {
        if (tempOrderID > 0)
        {

            SqlConnection con = new SqlConnection(DBCommon.ConnectionString);

            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DeleteOrder";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.Parameters.Add(new SqlParameter("@orderID", SqlDbType.Int, 4));

            cmd.Parameters["@orderID"].Value = tempOrderID;

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

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            

            LinkButton l = (LinkButton)e.Row.FindControl("lbtnDelete");

            //l.Attributes.Add("onclick", "javascript:return " +
            //"confirm('Are you sure you want to delete this record order ID: ( " +
            //DataBinder.Eval(e.Row.DataItem, "orderid") + " )')");

            if (e.Row.DataItem != null)
            {
                //e.Row.
                //int iAddressId = (int)gvAddress.Rows[iRow].Cells[1].Text;
                int adminedit = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "adminedit"));

                if (adminedit == 0)
                {
                    Image img = (Image)e.Row.FindControl("imgDelete");

                    img.ImageUrl = "~/Images/alert.png";
                    img.ToolTip = "Not allowed to delete. Check order status.";
                    

                }
                else
                {

                    e.Row.Cells[13].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[14].ForeColor = System.Drawing.Color.Red;
                    
                    l.Attributes.Add("onclick", "javascript:return " +
                    "confirm('Are you sure you want to delete this record order ID: ( " +
                    DataBinder.Eval(e.Row.DataItem, "orderid") + " )')");
                }
            }
            else
            {

                l.Attributes.Add("onclick", "javascript:return " +
                "confirm('Are you sure you want to delete this record order ID: ( " +
                DataBinder.Eval(e.Row.DataItem, "orderid") + " )')");
            }

        }
    }

    protected void btnNewOrder_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/OrderForm.aspx", true);
    }

    public void BindData(string sortExp, string sortDir)
    {

        SqlConnection connection = new SqlConnection(DBCommon.ConnectionString);

        SqlCommand command = connection.CreateCommand();

        connection.Open();


        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getOrderSummaryByCenterIDProjectYear";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        int selectedCenterID = Convert.ToInt32(Session["CENTERID"]);
        int projectYear = Convert.ToInt32(Session["PROJECTYEAR"]);

        mySqlCommand.Parameters.Add(new SqlParameter("@centerID", selectedCenterID));
        mySqlCommand.Parameters.Add(new SqlParameter("@projectyear", projectYear));

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
        mySqlDataAdapter.Fill(myDataSet, "OrderSummarybyCenterProjectYear");

        // display the rows in the Products DataTable
        DataView myDataView = new DataView();
        //DataTable orderDetailDT = myDataSet.Tables["OrderSummarybyCenterProjectYear"].DefaultView;
        myDataView = myDataSet.Tables["OrderSummarybyCenterProjectYear"].DefaultView;

        if (sortExp != string.Empty)
        {
            myDataView.Sort = string.Format("{0} {1}", sortExp, sortDir);
        }

        gv.DataSource = myDataView;

        gv.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

    }

    public void btnExcel_Click(object sender, EventArgs e)
    {
        // refresh order view
        int selectedCenterID = -1;

        selectedCenterID = Convert.ToInt16(Session["CENTERID"]);

        if (selectedCenterID < 0)
            return;

        // formulate a string containing the details of the
        // database connection
        string connectionString = ConfigurationManager.ConnectionStrings["BAPS_CALENDARConnectionString"].ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getOrderDetailByCenterID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@centerID", selectedCenterID));

        //mySqlCommand.Parameters.Add("@centerID", SqlDbType.Int,selectedCenterID);


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

        GridView gvOrderDetial = new GridView();

        gvOrderDetial.AllowPaging = false;

        gvOrderDetial.DataSource = orderDetailDT;

        gvOrderDetial.DataBind();

        GridViewExportUtil.Export2("Order Detail.xls", gvOrderDetial);

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();
    }

    public void imgBtnExcel_Click(object sender, EventArgs e)
    {
        // refresh order view
        int selectedCenterID = -1;
        int projectYear = 0;

        selectedCenterID = Convert.ToInt16(Session["CENTERID"]);
        projectYear = Convert.ToInt16(Session["PROJECTYEAR"]);

        if (selectedCenterID < 0)
            return;

        // formulate a string containing the details of the
        // database connection
        string connectionString = ConfigurationManager.ConnectionStrings["BAPS_CALENDARConnectionString"].ConnectionString;

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getOrderDetailByCenterID";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(

        mySqlCommand.Parameters.Add(new SqlParameter("@centerID", selectedCenterID));
        mySqlCommand.Parameters.Add(new SqlParameter("@ProjectYear", projectYear));

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

        GridView gvOrderDetial = new GridView();

        gvOrderDetial.AllowPaging = false;

        gvOrderDetial.DataSource = orderDetailDT;

        gvOrderDetial.DataBind();

        GridViewExportUtil.Export2("Order Detail.xls", gvOrderDetial);

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();
    }
    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        //
        gvAuditNotes.Visible = false;

        dvClient.Visible = true;
        dvMemberDetail.Visible = true;
        dvOrderMaster.Visible = true;
        gvOrderDetail.Visible = false;
    }
}
