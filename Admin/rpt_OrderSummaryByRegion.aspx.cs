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
using System.Collections.Generic;
using System.Web.UI.DataVisualization.Charting;


using Color = System.Drawing.Color;
using Font = System.Drawing.Font;

public partial class Admin_rpt_OrderSummaryByRegion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // chartRegion.Series["Series1"]["PointWidth"] = "0.3";
       // chartRegion.Series["Series2"]["PointWidth"] = "0.3";

        
    }

    public void BindData()
    {


        // need get data
        int selectedRegionID;
        
        selectedRegionID = Convert.ToInt32(ddlbRegion.SelectedValue);

        var projectYear = Convert.ToInt16(Session["PROJECTYEAR"]).ToString();

        chartRegion.Titles[0].Text = string.Format("Swaminarayan Aksharpith, Inc.\nCalendar Sponsership {0}\n\n Customer Order Count By {1}",projectYear, ddlbRegion.SelectedItem.Text);  

        // formulate a string containing the details of the
        // database connection
        string connectionString = DBCommon.ConnectionString;

        // create a SqlvConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(connectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "getOrderCountByRegion";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(
        mySqlCommand.Parameters.Add(new SqlParameter("@Region", selectedRegionID));
        
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
        mySqlDataAdapter.Fill(myDataSet, "OrderCountByRegion");

        
        // display the rows in the Products DataTable
        DataTable orderDetailDT = myDataSet.Tables["OrderCountByRegion"];
        chartRegion.DataSource = orderDetailDT;

        // here i am displaying the legend title. i mean blur color of line is displaying the marks average
        //chartRegion.Legends.Add("average_marks").Title = "Average";
        
        // here i am giving the title of the x-axis
        //chartRegion.ChartAreas["ChartArea1"].AxisX.Title = "Count";
        
        // here i am giving the title of the y-axis
        //chartRegion.ChartAreas["ChartArea1"].AxisY.Title = "Mandir";

        // here i am binding the x-axisvalue with the chart control   CenterName
        chartRegion.Series["Series1"].YValueMembers = "ML";
        chartRegion.Series["Series2"].YValueMembers = "SL";
        
        // here i am binding the y-axisvalue with the chart control
        chartRegion.Series["Series1"].XValueMember = "CenterName";
        chartRegion.Series["Series2"].XValueMember = "CenterName";
       

       
        //chartRegion.DataBindTable(orderDetailDT, "CenterName");

        chartRegion.DataBind();

        chartRegion.ChartAreas["ChartArea1"].AxisX.Interval = 1;
        chartRegion.ChartAreas["ChartArea1"].AxisX.TextOrientation = TextOrientation.Rotated90;

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();

    }
    protected void ddlbRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        BindData();
    }

    void ExportToPdf()
    {
    //Load the chart control as you normally do whenever you load it.

        BindData();

    chartRegion.SaveImage(Server.MapPath( "~/chartImages/chart.png"), ChartImageFormat.Png);
    Document document = new Document(PageSize.LETTER, 72, 72, 82, 72);
    MemoryStream msReport = new MemoryStream();

    try
    {

        PdfWriter writer = PdfWriter.GetInstance(document, msReport);
        document.AddAuthor("Test");
        document.AddSubject("Export to PDF");
        document.Open();
        Chunk c = new Chunk("Export chart to PDF", FontFactory.GetFont("VERDANA", 15));
        Paragraph p = new Paragraph();
        p.Alignment = Element.ALIGN_CENTER;
        iTextSharp.text.Image hImage;
        hImage = iTextSharp.text.Image.GetInstance(MapPath("~/chartImages/chart.png"));

        float NewWidth = 500;
        float MaxHeight = 400;

        if (hImage.Width <= NewWidth) { NewWidth = hImage.Width; } float NewHeight = hImage.Height * NewWidth / hImage.Width; if (NewHeight > MaxHeight)
        {
        NewWidth = hImage.Width * MaxHeight / hImage.Height;
        NewHeight = MaxHeight;
        }

        float ratio = hImage.Width / hImage.Height;
        hImage.ScaleAbsolute(NewWidth, NewHeight);
        document.Add(p);
        document.Add(hImage);
        document.Close();

        Response.AddHeader("Content-type", "application/pdf");
        Response.AddHeader("Content-Disposition", "attachment; filename=chart.pdf");
        Response.OutputStream.Write(msReport.GetBuffer(), 0, msReport.GetBuffer().Length);

    }
    catch (System.Threading.ThreadAbortException ex)
        {
        throw new Exception("Error occured: " + ex);
        }

    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        ExportToPdf();
    }


    protected void export_Click(object sender, System.EventArgs e)
    {
        ExportToPdf();
    }
}