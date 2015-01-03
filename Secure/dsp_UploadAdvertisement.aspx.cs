using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Threading;

public partial class Secure_dsp_UploadAdvertisement : System.Web.UI.Page
{
    String fname;
    String  filePath;
    String  spath;
    String  fileExt;
    String  fileNameWithoutExt;
    String  orderIDPostFix;
    String  FileFullPath;
    int orderID;

    SqlConnection sqlcon = new SqlConnection(DBCommon.ConnectionString);
    SqlCommand sqlcmd = new SqlCommand();
    SqlDataAdapter da = new SqlDataAdapter();
    DataTable dt = new DataTable();

   

    protected void Page_Load(object sender, EventArgs e)
    {
         filePath = ConfigurationManager.AppSettings["adPath"].ToString();
         FileFullPath = Server.MapPath("..") + @"\" + filePath + @"\" ;
              

        if (Request.QueryString["id"] != null)
        {
            try
            {
                orderID = int.Parse(Request.QueryString["id"]);
                orderIDPostFix = "_" + orderID.ToString();
                if (!IsPostBack)
                {

                    LoadGrid();
                }
               

            }
            catch
            {
                // deal with it
            }
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (fileupload.HasFile)
        {
            
            
            fname = fileupload.FileName; // get file name
            spath = @"~\Uploaded\" + fileupload.FileName;
            fileExt = Path.GetExtension(fname);
            fileNameWithoutExt = Path.GetFileNameWithoutExtension(fname);

            String newFileName = fileNameWithoutExt + orderIDPostFix + fileExt;
            String newFileFullPath = FileFullPath + newFileName;
            

            if (System.IO.File.Exists(newFileFullPath))
            {
                // Notify the user that their file was successfully uploaded.
                lbMessage.Text = "</br>Your file (<b>" + fname + "</b>) already exists on server. Rename your file.</br></br>";
                return;
            }
            else
            {
                fileupload.SaveAs(newFileFullPath);
                FileInfo file = new FileInfo(newFileFullPath);
                //litFileInfo.Text = "Location :" + file.FullName + "<BR/>" + "Size :" + file.Length + "<BR/>" + "Created :" + file.CreationTime + "<BR/>" + "Modified :" + file.LastWriteTime + "<BR/>" + "Accessed :" + file.LastAccessTime + "<BR/>" + "Attributes :" + file.Attributes + "<BR/>" + "Extension :" + file.Extension + "<BR>";
            }

            //Store details in the SQL Server table
            SaveAdvertisementDetails(newFileName, FileFullPath);
            LoadGrid();
        }
        else
        {
            lbMessage.Text = "<b>Please select file!</b>";
        }
    }

    void LoadGrid()
    {
        SqlConnection sqlcon = new SqlConnection(DBCommon.ConnectionString);
        sqlcon.Open();
        sqlcmd = new SqlCommand("select (FilePath + FileName ) as filewithfullpath,* from OrderAdvertisementFilesInfo WHERE orderID = @orderID", sqlcon);
        sqlcmd.Parameters.AddWithValue("@orderID", orderID); 
        da = new SqlDataAdapter(sqlcmd);
        dt.Clear();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            gvFile.DataSource = dt;
            gvFile.DataBind();
        }
        else
        {
            gvFile.DataBind();
        }
        sqlcon.Close();
    }

    protected void gvFile_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvFile.EditIndex = -1;
        LoadGrid();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //
        Response.Redirect("~/Secure/OrderView.aspx", true);
    }

    protected void gvFile_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        String ID;
        ID = gvFile.DataKeys[e.RowIndex].Value.ToString();
        sqlcmd = new SqlCommand("select (FilePath + FileName ) as filewithfullpath, * from dbo.OrderAdvertisementFilesInfo where ID='" + ID + "'", sqlcon);
        sqlcon.Open();
        da = new SqlDataAdapter(sqlcmd);
        da.Fill(dt);

        filePath = dt.Rows[0][0].ToString();

        if (dt.Rows.Count > 0)
        {
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
                sqlcmd = new SqlCommand("delete from OrderAdvertisementFilesInfo where ID='" + ID + "'", sqlcon);
                sqlcmd.ExecuteNonQuery();
               // sqlcon.Close();
            }
            else
              //  System.IO.File.Delete(filePath);
                sqlcmd = new SqlCommand("delete from OrderAdvertisementFilesInfo where ID='" + ID + "'", sqlcon);
                sqlcmd.ExecuteNonQuery();
                //sqlcon.Close();

                //ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('File does not exist!');", true);
        }
        
        LoadGrid();
    }

    protected void gvFile_RowEditing(object sender, GridViewEditEventArgs e)
     {
         //gvFile.EditIndex = e.NewEditIndex;
         //LoadGrid();
     }

     protected void gvFile_RowUpdating(object sender, GridViewUpdateEventArgs e)
     {
      //  LoadGrid();
     }

     public string GetSize(object size)
     {
         double s = Convert.ToDouble(size);

         string[] format = new string[] { "{0} bytes", "{0} KB", "{0} MB", "{0} GB", "{0} TB", "{0} PB", "{0} EB" };

         int i = 0;
         while (i < format.Length && s >= 1024)
         {
             s = (int)(100 * s / 1024) / 100.0;
             i++;
         }

         return string.Format(format[i], s);

     }

    void SaveAdvertisementDetails(string FileName,string FilePath)
    {
        FileInfo file = new FileInfo(FilePath+FileName);
        string userID = Session["USERID"].ToString();

        string SelectedTemplate = "";

        SelectedTemplate = ddlTemplate.SelectedValue.Trim();

        using (SqlConnection con = new SqlConnection(DBCommon.ConnectionString))
        {
            con.Open();
            try
            {
                using (SqlCommand command = new SqlCommand(
                "INSERT INTO OrderAdvertisementFilesInfo (CenterID,OrderID,FileName,FilePath,UploadedDate,UserIDNumber,Status,fileSize,FileExtension,Modified,Created,CreatedBy,SelectedTemplate)" +
                " VALUES (@CenterID,@OrderID, @FileName,@FilePath,@UploadedDate, @UserIDNumber, @Status,@fileSize, @FileExtension, @Modified,@Created,@CreatedBy,@SelectedTemplate)", con))
                {
                    // Use a shorthand syntax to add the id parameter.
                    command.Parameters.Add("@CenterID", SqlDbType.Int).Value = int.Parse(Session["CENTERID"].ToString());
                    command.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
                    command.Parameters.Add("@FileName", SqlDbType.VarChar, 60).Value = FileName;
                    command.Parameters.Add("@FilePath", SqlDbType.VarChar, 200).Value = FilePath;
                    command.Parameters.Add("@UploadedDate", SqlDbType.DateTime).Value = DateTime.Now;
                    command.Parameters.Add("@UserIDNumber", SqlDbType.Int).Value = int.Parse(Session["UserIDNumber"].ToString());
                    command.Parameters.Add("@Status", SqlDbType.Char).Value = "U";
                    command.Parameters.Add("@fileSize", SqlDbType.BigInt).Value = file.Length;
                    command.Parameters.Add("@FileExtension", SqlDbType.VarChar).Value = file.Extension;
                    command.Parameters.Add("@Modified", SqlDbType.DateTime).Value = file.LastWriteTime;
                    command.Parameters.Add("@Created", SqlDbType.DateTime).Value = DateTime.Now; 
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 100).Value = userID;
                    command.Parameters.Add("@SelectedTemplate", SqlDbType.VarChar, 100).Value = SelectedTemplate;

                    command.ExecuteNonQuery();

                    con.Close();

                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
            catch
            {
                Console.WriteLine("Count not insert.");
            }
        }

    
       // LoadGrid();
    }

    

}