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
    public void BindData()
    {
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        if ( selectedCenterID <= 0)
            selectedCenterID = 0;

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
        DataTable orderDetailDT = myDataSet.Tables["OrderSummarybyCenterProjectYear"];

        gv.DataSource = orderDetailDT;

        gv.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

    }

    protected void Page_Load(object sender, EventArgs e)
    {

        int selectedCenterID;

        selectedCenterID = 1;

        if (Session["CENTERID"] == null || Session["CENTERID"].ToString() == "")
        {
            Response.Redirect("~/dsp_Login.aspx", true);
        }

        if (!Page.IsPostBack)
            BindData();
        
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

        string imageFilePath = Server.MapPath("..") + "/Images/aksharpith.jpg";
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
        strClientAddress2 = dtOrderDetail.Rows[0]["ClientAddress2"].ToString().Trim();
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

        sb.Append("<Table STYLE='background-color:#F8F8F8 ;font-size:7pt;color: #000000;' Border='0'>");

        sb.Append("<tr>");
        sb.AppendFormat("<td align='left' ><b>To:</b> {0} {1}</td><td></td>", strClientFirstName, strClientLastName);
        sb.AppendFormat("<td align='left' ><b>Region:</b> {0}</td>", strRegion);
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td align='left'><b>Billing Name:</b> {0}</td><td></td>", strClientBusinessName);
        sb.AppendFormat("<td align='left'><b>Center Name:</b> {0}</td>", strCenter);
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td align='left' nowrap width='40%' vertical-align:top;><b>Address:</b> ");
        sb.AppendFormat("{0}, ", strClientAddress1);
        sb.AppendFormat("{0},", strClientAddress2);
        sb.AppendFormat("{0}, {1}, {2}", strClientCity, strClientState, strClientZip);
        sb.Append("</td><td></td>");
        sb.AppendFormat("<td align='left'><b>Invoice #:</b> {0}</td>", orderID.ToString());
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.AppendFormat("<td align='left'><b>Project:</b> Calendar</td>><td></td>");
        sb.AppendFormat("<td align='left'><b>Invoice Date:</b> {0}</td", DateTime.Now.ToString("d"));
        sb.Append("</tr>");

        //sb.AppendFormat("<br><b>Center:</b> {0}", strCenter);
        //sb.AppendFormat("<br><b>Invoice #:</b> {0}", orderID.ToString());
        //sb.AppendFormat("<br><b>Invoice Date:</b> {0}", DateTime.Now.ToString("d"));
        //sb.Append("</td></tr>");
        

       
        //sb.Append("<tr>");
        //sb.AppendFormat("<td><b>{0}</b> - {1} {2}",strClientBusinessName,strClientFirstName,strClientLastName );
        //sb.AppendFormat("<br>{0}", strClientAddress1);
        //sb.AppendFormat("<br>{0}", strClientAddress2);
        //sb.AppendFormat("<br>{0}, {1} {2}", strClientCity, strClientState, strClientZip);
        //sb.Append(" </td></tr>");

       
                
        sb.Append("</Table>");

        sb.Append("<br />");

        sb.Append("<Table width='100%' STYLE='font-size:7pt;color: #000000; text-align:center;' Border='1'>");
        
        sb.Append("<tr>"); 
        sb.Append("<td><b>ITEM</b></td>");
        sb.Append("<td nowrap><b>DESCRIPTION</b></td>");
        //sb.Append("<td align='center'><b>PROJECT</b></td>");
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
            //sb.Append("<td align='center'>Calendar</td>");
            sb.AppendFormat("<td align='right'>{0}</td>",   row["ProductQuantity"].ToString().Trim());
            sb.AppendFormat("<td align='right'>{0:C}</td>", Convert.ToDecimal(row["Rate"].ToString().Trim()).ToString("C")   );
            sb.AppendFormat("<td align='right'>{0:C}</td>", Convert.ToDecimal(row["OrderAmount2"].ToString().Trim()).ToString("C")  );
            sb.Append("</tr>");

            dtotal = dtotal + Convert.ToDecimal(row["OrderAmount2"]); 
        }

        //sb.Append("<tr>");
        //sb.Append("<td colspan='5'>");
        //for (var i = 1; i < 138; i++)
        //{
        //    sb.Append("_");
        //}
        //sb.Append("</td>");
        //sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td></td>");
        sb.Append("<td></td>");
        sb.Append("<td></td>");
        sb.Append("<td><b>Total Amount:</b></td>");
        //sb.Append("<td></td>");
        sb.AppendFormat("<td align='right'>{0}</td>", dtotal.ToString("c"));
        sb.Append("</tr>");

        sb.Append("</Table>");

        sb.Append("<br />");
        sb.Append("<br />");

        sb.Append("<Table width='100%' STYLE='font-size:10pt;color: #000000; text-align:center;' Border='0'>");
        sb.Append("<tr>");
        sb.Append("<td colspan='5' align='left'><b>");
        sb.Append("<br><h2>Payment Policy</h2>");
        sb.Append("<br>(a). Payment will be accepted through Credit card & Check only.");
        sb.Append("<br>(b). Payment is required to complete the order by set deadline.");
        sb.Append("<br>(c). All applicable taxes are included in sale price.");
        sb.Append("<br>(d). This is a pro forma invoice against draft orders received. Final invoice will be issued only after order confirmation and once full payment is received. Checks and Electronic transfer to be made in favor of 'Swaminarayan Aksharpith Inc'");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append("</Table>");

        //sb.Append("<br>2. SWAMINARAYAN AKSHARPITH INC CONSIDERS ORDER INCOMPLETE IF");
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. ORDER IS NOT SIGNED BY SPONSOR/CUSTOMER AND ORDER RECEIVING KARYAKAR");
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. ADVERTISEMENT MATERIAL IS NOT RECEIVED BY SWAMINARAYAN AKHARPITH INC, AS PER SET DEADLINE	");
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. ADVERTISEMENT PROOF IS NOT CONFIRMED BY SET DEADLINE");
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d. PAYMENT IS NOT RECEIVED");

        //sb.Append("<br>3. IF ORDERS RECEIVED REMAINED INCOMPLETE (REFER “B”) BY DEAD LINE SET BY SWAMINARAYAN AKSHARPITH, INC. SWAMINARAYA AKSHARPITH, INC CAN NOT BE HELD LIABLE IF DELIVERIES ARE DELAYED FOR ANY REASON/S");

        
        //DateTime OrderCancelDate = Convert.ToDateTime( Session["OrderCancelDate"].ToString());

        //sb.Append("<br>4. CANCELLATION POLICY:");

        //sb.AppendFormat("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. ORDERS CANNOT BE CANCELLED AFTER {0}", String.Format("{0:dddd, MMMM d, yyyy}", OrderCancelDate).ToUpper());

       
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. IF ORDERS REMAINS INCOMPLETE BY THE SET DEADLINE, IT WILL BE TREATED AS CANCELLED");

        //sb.Append("<br>5. PAYMENT POLICY:");
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. PAYMENT WILL BE ACCEPTED THROUGH CHECK, MONEY ORDER AND CREDIT CARD");
        //sb.Append("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. PAYMENT IS REQUIRED TO COMPLETE ORDER BY SET DEAD LINE");

        //sb.Append("<br>6. ORDERS ARE NON REFUNDABLE");

        //sb.Append("<br>7. SWAMINARAYAN AKSHARPITH, INC WILL NOT BE RESPONSIBLE FOR THE LOSS AND/OR DELAYS AND/OR DAMAGES IN TRANSIT DUE TO FORSEEN/UNFORSEEN CIRCUMSTANCES SUCH AS NATURAL DISASTER, CUSTOMS EXAMS/HOLDS, CARGO THEFT/LOSS ETC");
		
        //sb.Append("</b></td>");
        //sb.Append("</tr>");
        
        //sb.Append("<tr>");
        //sb.Append("<td colspan='6'><b>");
        //sb.Append("<br>This is a pro forma invoice against draft orders received. Final invoice will be issued only after order confirmation and once full payment is received.");
        //sb.Append("<br>Checks / Drafts and Electronic transfer to be made in favor of 'Swaminarayan Aksharpith Inc'.");
        //sb.Append("<br>All applicable taxes are included in sales price.");
        
        //sb.Append("</b></td>");
        //sb.Append("</tr>");

        //sb.Append("</Table>");

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
        int ProjectYear = Convert.ToInt16( Session["PROJECTYEAR"]);

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
                                  " WHERE   om.CenterID = " + centerID.ToString() + " AND " +
                                  "         om.ProjectYear = " + ProjectYear.ToString() + 
                                  " ORDER BY om.OrderDate";
        }
        else
        {
            command.CommandText = " SELECT c.centerid,c.centername,om.MemberID,om.ClientID,om.OrderID,om.OrderDate, om.OrderAmount, mm.FirstName, mm.LastName, cm.BusinessName " +
                                 " FROM    OrderMaster AS om INNER JOIN  " +
                                 "         MemberMaster AS mm ON om.MemberID = mm.MemberID INNER JOIN  " +
                                 "         ClientMaster AS cm ON om.ClientID = cm.ClientID  INNER JOIN  " +
                                 "         Center AS c ON om.centerid = c.centerid    " + " AND " +
                                 "         om.ProjectYear = " + ProjectYear.ToString() + 
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
        //int selectedCenterID;

        //selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData();


       
    }
    
    protected void ddlbCenter_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedCenterID;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        BindData(  );
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected GridView getExportData()
    {
        GridView gv = new GridView();
        // refresh order view
        int selectedCenterID = 0;

        selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);
        int ProjectYear = Convert.ToInt16(Session["PROJECTYEAR"]);

        // ClientScript.RegisterStartupScript(typeof(Page), "test", "<script>alert('Hello');return false;</script>"); 

        if (selectedCenterID < 0)
            return gv;

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
        mySqlCommand.Parameters.Add(new SqlParameter("@ProjectYear", ProjectYear));

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

        GridView gvOrderDetail = new GridView();

        gvOrderDetail.AllowPaging = false;

        gvOrderDetail.DataSource = orderDetailDT;

        gvOrderDetail.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

        return gvOrderDetail;
    }
    
    protected void imgBtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        int selectedCenterID = Convert.ToInt32(ddlbCenter.SelectedValue);

        if (selectedCenterID < 0)
        {
           return;
        }

        GridView gvOrderDetail = new GridView();

        gvOrderDetail = getExportData();

        int rowCount = gvOrderDetail.Rows.Count;

        if (rowCount <= 0)
        {
            gv = gvOrderDetail;
            return;
        }

        gvOrderDetail.AllowPaging = false;
        GridViewExportUtil.Export2("Order Detail.xls", gvOrderDetail);

       
    }

    protected void imgBtnPdf_Click(object sender, EventArgs e)
    {
        GridView gvOrderDetail = new GridView();

        gvOrderDetail = getExportData();
        gvOrderDetail.AllowPaging = false;
       // gvOrderDetail.DataBind();

        //Create a table
        

        iTextSharp.text.Table table = new iTextSharp.text.Table(gvOrderDetail.Columns.Count);
        table.Cellpadding = 5;

        //Set the column widths
        int[] widths = new int[gvOrderDetail.Columns.Count];
        for (int x = 0; x < gvOrderDetail.Columns.Count; x++)
        {
            widths[x] = (int)gvOrderDetail.Columns[x].ItemStyle.Width.Value;
            string cellText = Server.HtmlDecode(gvOrderDetail.HeaderRow.Cells[x].Text);
            iTextSharp.text.Cell cell = new iTextSharp.text.Cell(cellText);

            cell.BackgroundColor = new Color(System.Drawing.ColorTranslator.FromHtml("#008000"));
            table.AddCell(cell);
        }
        table.SetWidths(widths);

        //Transfer rows from GridView to table
        for (int i = 0; i < gvOrderDetail.Rows.Count; i++)
        {
            if (gvOrderDetail.Rows[i].RowType == DataControlRowType.DataRow)
            {
                for (int j = 0; j < gvOrderDetail.Columns.Count; j++)
                {
                    string cellText = Server.HtmlDecode(gvOrderDetail.Rows[i].Cells[j].Text);
                    iTextSharp.text.Cell cell = new iTextSharp.text.Cell(cellText);

                    //Set Color of Alternating row
                    if (i % 2 != 0)
                    {
                        cell.BackgroundColor = new Color(System.Drawing.ColorTranslator.FromHtml("#C2D69B"));
                    }
                    table.AddCell(cell);
                }
            }
        }

        //Create the PDF Document
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        pdfDoc.Add(table);
        pdfDoc.Close();
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;" + "filename=OrderDetail.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Write(pdfDoc);
        Response.End();
    }

}