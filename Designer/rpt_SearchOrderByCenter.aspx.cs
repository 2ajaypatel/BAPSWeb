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

public partial class Admin_SearchOrderByCenter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            // get the orderID of the clicked row
            int orderID = Convert.ToInt32(e.CommandArgument);

            // Delete the record 
            //DeleteRecordByOrderID(orderID);
        }

        if (e.CommandName == "Invoice")
        {
            // get the orderID of the clicked row
            int orderID = Convert.ToInt32(e.CommandArgument);

            // generate PDF file
            GeneratePDF(orderID);
        }
    }

    public void GeneratePDF( int orderID )
    {
        //Get the data from database into datatable
        string fileName = "";
        string strReport = "";

        Literal ltStr = new Literal();
        StringBuilder sb = new StringBuilder();

        Response.ContentType = "application/pdf";

        fileName = "attachment;filename=" + "Calendar_Invoice_" + orderID.ToString() + "_" + DateTime.Now.ToString("m_d_yyyy_hh_mm_ss") + ".pdf";
       // Response.AddHeader(fileName);

        Response.AddHeader("content-disposition", fileName);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        string imageFilePath = Server.MapPath("..") + "/Images/header.jpg";
        iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(imageFilePath);


        StringWriter sw = new StringWriter();

        HtmlTextWriter hw = new HtmlTextWriter(sw);

        strReport = BuildOrderDetailReport(orderID);

        ltStr.Text = strReport;

        ltStr.RenderControl(hw);

        StringReader sr = new StringReader(sw.ToString());

        Document pdfDoc = new Document(PageSize.LETTER,36,36,36,36);

        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

        pdfDoc.Open();
        pdfDoc.Add(jpg);
        jpg.SetAbsolutePosition(25, 25);
        jpg.Alignment = iTextSharp.text.Image.TEXTWRAP;
                
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End(); 
    }

    public string BuildOrderDetailReport(int orderID)
    {
        string strRegion = "";
        string strCenter = "";
        string strClientBusinessName = "";
        string strClientFirstName = "";
        string strClientLastName = "";
        string strClientAddress1 = "";
        string strClientAddress2 = "";
        string strClientCity = "";
        string strClientState = "";
        string strClientZip = "";

        DataTable       dtOrderDetail   = new DataTable();
        OrderDetails    odObject        = new OrderDetails();

        dtOrderDetail = odObject.getOrderDetailByOrderID(orderID);

        if (dtOrderDetail.Rows.Count <= 0 )
            return "No records found.";

        strRegion = dtOrderDetail.Rows[0]["region"].ToString().Trim();
        strCenter = dtOrderDetail.Rows[0]["centerName"].ToString().Trim();

        strClientBusinessName = dtOrderDetail.Rows[0]["ClientBusinessName"].ToString().Trim();
        strClientFirstName = dtOrderDetail.Rows[0]["ClientFirstName"].ToString().Trim();
        strClientLastName = dtOrderDetail.Rows[0]["ClientLastName"].ToString().Trim();
        strClientAddress1 = dtOrderDetail.Rows[0]["ClientAddress1"].ToString().Trim();
        strClientAddress2 = dtOrderDetail.Rows[0]["ClientAddress1"].ToString().Trim();
        strClientCity = dtOrderDetail.Rows[0]["ClientCity"].ToString().Trim();
        strClientState = dtOrderDetail.Rows[0]["ClientState"].ToString().Trim();
        strClientZip = dtOrderDetail.Rows[0]["ClientZip"].ToString().Trim();

        StringBuilder sb = new StringBuilder();

        sb.Append("");
        //sb.Append("<h1><span STYLE='font: 36px;color: #FF9900; text-align:center;'>Swaminarayan Aksharpith</span></h1><br />");
        //sb.Append("<h4 align='center'>81 Suttons Lane, Piscataway, New Jersery 08854 | Tel: (732) 777-1414 | Fax: (732) 777-1616</h4>");
        
        //for (var i=1;i<80;i++)
        //{
        //    sb.Append("_");
        //}
        
        sb.Append("<br />");
        sb.Append("<h3 align='center'>Proforma Invoice</h3><br /><br />");

        sb.Append("<Table width='100%'  STYLE='font-size:8pt;color: #000000; text-align:center;' Border='0'>");

        sb.Append("<tr>");
        sb.AppendFormat("<td><b>Region:</b> {0}</td>", strRegion);
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td><b>Center:</b> {0}</td>", strCenter);
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td><b>Invoice #:</b> {0}</td>", orderID.ToString());
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td><b>Invoice Date:</b> {0}</td>", DateTime.Now.ToString("d"));
        sb.Append("</tr>");

        sb.Append("<tr><td><br /></td></tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td><b>{0}</b> - {1} {2} </td>",strClientBusinessName,strClientFirstName,strClientLastName );
        sb.AppendFormat("<td>{0}</td>",strClientAddress1);
        sb.AppendFormat("<td>{0}</td>", strClientAddress2);
        sb.AppendFormat("<td>{0}, {1} {2} </td>", strClientCity, strClientState, strClientZip);
        sb.Append("</tr>");

        sb.Append("<tr><td><br /><br /></td></tr>");
                
        sb.Append("</Table>");

        sb.Append("<br /><br />");

        sb.Append("<Table width='100%' STYLE='font-size:7pt;color: #000000; text-align:center;' Border='0'>");
        
        sb.Append("<tr>"); 
        sb.Append("<td><b>ITEM</b></td>");
        sb.Append("<td nowrap><b>DESCRIPTION</b></td>");
        sb.Append("<td align='center'><b>PROJECT</b></td>");
        sb.Append("<td align='right'><b>QTY</b></td>");
        sb.Append("<td align='right'><b>RATE ($)</b></td>");
        sb.Append("<td align='right'><b>AMOUNT ($)</b></td>");
        sb.Append("</tr>");

        // For each row, print the values of each column.
        decimal dtotal = 0;

        foreach (DataRow row in dtOrderDetail.Rows)
        {
            sb.Append("<tr>");
            sb.AppendFormat("<td>{0}/{1}</td>", row["CalendarType"].ToString().Trim(), row["CalendarItem"].ToString().Trim());
            sb.AppendFormat("<td>Calendar Sales<br />({0}/{1})</td>", row["CalendarType1"].ToString().Trim(), row["CalendarItem1"].ToString().Trim());
            sb.Append("<td align='center'>Calendar</td>");
            sb.AppendFormat("<td align='right'>{0}</td>",   row["ProductQuantity"].ToString().Trim());
            sb.AppendFormat("<td align='right'>{0:C}</td>", Convert.ToDecimal(row["Rate"].ToString().Trim()).ToString("C")   );
            sb.AppendFormat("<td align='right'>{0:C}</td>", Convert.ToDecimal(row["OrderAmount2"].ToString().Trim()).ToString("C")  );
            sb.Append("</tr>");

            dtotal = dtotal + Convert.ToDecimal(row["OrderAmount2"]); 
        }

        sb.Append("<tr>");
        sb.Append("<td colspan='6'>");
        for (var i = 1; i < 138; i++)
        {
            sb.Append("_");
        }
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td></td>");
        sb.Append("<td></td>");
        sb.Append("<td></td>");
        sb.Append("<td><b>Total Amount:</b></td>");
        sb.Append("<td></td>");
        sb.AppendFormat("<td align='right'>{0}</td>", dtotal.ToString("C"));
        sb.Append("</tr>");

        sb.Append("<tr><td colspan='6'><br /><br /></td></tr>");
        sb.Append("<tr><td colspan='6'><br /><br /></td></tr>");
        sb.Append("<tr><td colspan='6'><br /><br /></td></tr>");
        sb.Append("<tr><td colspan='6'><br /><br /></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td colspan='6'><b><ul>");
        sb.Append("<li>This is a pro forma invoice against draft orders received. Final invoice will be issued only after order confirmation and once full payment is received.<br /></li>");
        sb.Append("<li>Checks / Drafts and Electronic transfer to be made in favor of 'Swaminarayan Aksharpith Inc'.<br /></li>");
        sb.Append("<li>All applicable taxes are included in sales price.<br /></li>");
        sb.Append("</b></ol></td>");
        sb.Append("</tr>");

        sb.Append("</Table>");

        return sb.ToString(); 
    }

    protected void gv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        int orderID = Convert.ToInt16(gv.DataKeys[e.RowIndex].Value);

        DeleteRecordByOrderID(orderID);

        // refresh order view
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData(selectedCenterID);
    }

    protected void gv_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {

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

    //protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        LinkButton l = (LinkButton)e.Row.FindControl("LinkButton1");
    //        l.Attributes.Add("onclick", "javascript:return " +
    //        "confirm('Are you sure you want to delete this record order ID: ( " +
    //        DataBinder.Eval(e.Row.DataItem, "orderid") + " )')");
    //    }
    //}

    public void BindData(int centerID)
    {

        SqlConnection conn = new SqlConnection("Data source=localhost;user id=user;password=pass;database=ClassProject");
       
        SqlConnection connection = new SqlConnection(DBCommon.ConnectionString);

        SqlCommand command = connection.CreateCommand();

        connection.Open();

        if (centerID > 1)
        {

            command.CommandText = " SELECT c.centerid,c.centername,om.MemberID,om.ClientID,om.OrderID,om.OrderDate, om.OrderAmount, mm.FirstName, mm.LastName, cm.BusinessName " +
                                  " FROM    OrderMaster AS om INNER JOIN  " +
                                  "         MemberMaster AS mm ON om.MemberID = mm.MemberID INNER JOIN  " +
                                  "         ClientMaster AS cm ON om.ClientID = cm.ClientID  INNER JOIN  " +
                                  "         Center AS c ON om.centerid = c.centerid    " +
                                  " WHERE   om.CenterID = " + centerID.ToString() +
                                  " ORDER BY om.OrderDate";
        }
        else
        {
            command.CommandText = " SELECT c.centerid,c.centername,om.MemberID,om.ClientID,om.OrderID,om.OrderDate, om.OrderAmount, mm.FirstName, mm.LastName, cm.BusinessName " +
                                 " FROM    OrderMaster AS om INNER JOIN  " +
                                 "         MemberMaster AS mm ON om.MemberID = mm.MemberID INNER JOIN  " +
                                 "         ClientMaster AS cm ON om.ClientID = cm.ClientID  INNER JOIN  " +
                                 "         Center AS c ON om.centerid = c.centerid    " +
                                 " ORDER BY om.OrderDate ";
        }

        SqlDataAdapter adap = new SqlDataAdapter(command.CommandText, connection);

        DataTable dt = new DataTable();

        adap.Fill(dt);

        if (dt.Rows.Count > 0)
        {

            gv.DataSource = dt;
            gv.DataBind();
        }
        else
        {
            gv.DataSource = null;
            gv.DataBind();
        }

        connection.Close();

    }

    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;

        // refresh order view
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData(selectedCenterID);


       
    }
    
    protected void ddlbCenter_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData( selectedCenterID );
    }
    
    protected void btnExcel_Click(object sender, EventArgs e)
    {

        // refresh order view
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

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
}