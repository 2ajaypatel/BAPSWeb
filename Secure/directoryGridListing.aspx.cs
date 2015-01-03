using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Secure_directoryGridListing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loadData();
    }

    protected void UploadButton_Click(object sender, EventArgs e)
    {
        // Specify the path on the server to
        // save the uploaded file to.

        string savePath = @"c:\temp\uploads\";

        // Before attempting to save the file, verify
        // that the FileUpload control contains a file.
        if (FileUpload1.HasFile)
        {
            // Get the name of the file to upload.
            string fileName = Server.HtmlEncode(FileUpload1.FileName);

            // Get the extension of the uploaded file.
            string extension = System.IO.Path.GetExtension(fileName);

            // Append the name of the file to upload to the path.
            savePath += fileName;


            // check to see if file exists
            bool fileExists = System.IO.File.Exists(savePath);

            if (fileExists)
            {
                // Notify the user that their file was successfully uploaded.
                UploadStatusLabel.Text = "Your file <b>" + fileName + "</b> already exists on server.";
                return;
            }


            // Get the size in bytes of the file to upload.
            int fileSize = FileUpload1.PostedFile.ContentLength;

            // Allow only files less than 4,100,000 bytes (approximately 2 MB) to be uploaded.
            if (fileSize < 4100000)
            {

                // Allow only files with .doc or .xls extensions
                // to be uploaded.
                if ((extension == ".doc") || (extension == ".pdf") || (extension == ".jpg") || (extension == ".jpeg"))
                {

                    // Call the SaveAs method to save the 
                    // uploaded file to the specified path.
                    // This example does not perform all
                    // the necessary error checking.               
                    // If a file with the same name
                    // already exists in the specified path,  
                    // the uploaded file overwrites it.
                    FileUpload1.SaveAs(savePath);

                    // Notify the user that their file was successfully uploaded.
                    UploadStatusLabel.Text = "Your file was uploaded successfully.";

                    // load file
                    loadData();
                }
                else
                {
                    // Notify the user why their file was not uploaded.
                    UploadStatusLabel.Text = "Your file was not uploaded because " +
                                             "it does not have a .doc or .pdf extension.";
                }
            }
            else
            {
                // Notify the user why their file was not uploaded.
                UploadStatusLabel.Text = "Your file was not uploaded because " +
                                         "it exceeds the 2 MB size limit.";
            }
        }
        else
        {
            // Notify the user that a file was not uploaded.
            UploadStatusLabel.Text = "You did not specify a file to upload.";
        }
    }

    public void loadData()
    {
        DataTable dt = new DataTable("datatable1");
        DataColumn dc;
        DataRow dr;
        dr = dt.NewRow();

        dc = new DataColumn();
        dc.DataType = System.Type.GetType("System.String");
        dc.ColumnName = "Name";
        dt.Columns.Add(dc);

        dc = new DataColumn();
        dc.DataType = System.Type.GetType("System.Int32");
        dc.ColumnName = "Size";
        dt.Columns.Add(dc);

        dc = new DataColumn();
        dc.DataType = System.Type.GetType("System.DateTime");
        dc.ColumnName = "CreationTime";
        dt.Columns.Add(dc);

        dc = new DataColumn();
        dc.DataType = System.Type.GetType("System.String");
        dc.ColumnName = "Type";
        dt.Columns.Add(dc);

        dc = new DataColumn();
        dc.DataType = System.Type.GetType("System.String");
        dc.ColumnName = "FileIcon";
        dt.Columns.Add(dc);

        //dir list
        string[] subdirectoryEntries = Directory.GetDirectories(@"C:\temp\uploads\");
        foreach (string directoryName in subdirectoryEntries)
        {

            dr = dt.NewRow();
            DirectoryInfo di = new DirectoryInfo(directoryName);

            dr[0] = di.Name;
            dr[1] = 1000; //(dirSize(di) / 1000) + 1;
            dr[2] = di.CreationTime;
            dr[3] = "D";
            dr[4] = "images/folder.jpg";
            dt.Rows.Add(dr);

        }

        //files list
        string[] files = Directory.GetFiles(@"C:\temp\uploads\");
        foreach (string fileName in files)
        {
            dr = dt.NewRow();

            FileInfo fi = new FileInfo(fileName);
            dr[0] = fi.Name;
            dr[1] = (fi.Length / 1000 + 1);
            dr[2] = fi.CreationTime;
            dr[3] = "F";
            dr[4] = "images/file.jpg";
            dt.Rows.Add(dr);

        }
        DataView dv = new DataView(dt);
        DataGridFile.DataSource = dv;
        DataGridFile.DataBind();

    }

    public void DataGridFile_Command(Object sender, DataGridCommandEventArgs e)
    {

        switch (((LinkButton)e.CommandSource).CommandName)
        {

            case "Delete":
                DeleteItem(e);
                break;

            // Add other cases here, if there are multiple ButtonColumns in 
            // the DataGrid control.

            default:
                // Do nothing.
                break;

        }

    }

    public void DeleteItem(DataGridCommandEventArgs e)
    {

        string filePath = @"C:\temp\uploads\";

        // e.Item is the table row where the command is raised. For bound
        // columns, the value is stored in the Text property of a TableCell.
        TableCell itemCell = e.Item.Cells[3];

        string item = itemCell.Text;

        try
        {
            FileInfo TheFile = new FileInfo(filePath + "\\" + item);
            if (TheFile.Exists)
            {
                File.Delete(filePath + "\\" + item);

                loadData();
            }
            else
            {
                throw new FileNotFoundException();
            }
        }

        catch (FileNotFoundException ex)
        {
            LitMessage.Text += ex.Message;
        }
        catch (Exception ex)
        {
            LitMessage.Text += ex.Message;
        }




    }
}