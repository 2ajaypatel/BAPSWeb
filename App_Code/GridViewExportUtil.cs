using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using System.Drawing;

/// <summary>
/// Summary description for GridViewExportUtil
/// </summary>
public class GridViewExportUtil
{
	public GridViewExportUtil()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void Export2(string fileName, GridView gv)
    {
        HttpContext.Current.Response.Clear();
        
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Buffer = true;

        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=summaryReport.xls");
        HttpContext.Current.Response.Charset = "";
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";

        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
 
        gv.AllowPaging = false;
        gv.DataBind();
 
        //Change the Header Row back to white color
        gv.HeaderRow.Style.Add("background-color", "#FFFFFF");

        for ( int j = 0; j < gv.HeaderRow.Cells.Count ; j++ )
        {
            gv.HeaderRow.Cells[j].Style.Add("background-color", "#FF9900");
            gv.HeaderRow.Cells[j].Style.Add("ForeColor", "#FFFFCC");
        }

        for (int j = 0; j < gv.FooterRow.Cells.Count; j++)
        {
            gv.HeaderRow.Cells[j].Style.Add("background-color", "#FF9900");
            gv.HeaderRow.Cells[j].Style.Add("ForeColor", "#FFFFCC");
        }

        for (int i = 0; i < gv.Rows.Count; i++)
        {
            GridViewRow row = gv.Rows[i];
 
            //Change Color back to white
            row.BackColor = System.Drawing.Color.White;
 
            //Apply text style to each Row
            row.Attributes.Add("class", "textmode");

 
            //Apply style to Individual Cells of Alternating Row
            if (i % 2 != 0)
            {
                for (int j = 0; j < gv.HeaderRow.Cells.Count; j++)
                {
                    row.Cells[j].Style.Add("background-color", "#E8E8E8");
                }
            }
        }

        gv.RenderControl(hw);
 
        //style to format numbers to string
        string style = @"<style> .textmode { mso-number-format:\@; } </style>";
        HttpContext.Current.Response.Write(style);
        HttpContext.Current.Response.Output.Write(sw.ToString());
        HttpContext.Current.Response.Flush();
        HttpContext.Current.Response.End();

      }




    public static void Export(string fileName, GridView gv)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader(
        "content-disposition", string.Format("attachment; filename={0}", fileName));
        HttpContext.Current.Response.ContentType = "application/ms-excel";

        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                //  Create a form to contain the grid
                Table table = new Table();

                table.CellPadding = 5;

                table.CellSpacing = 2 ;
                table.GridLines = GridLines.Both;
                table.BorderWidth = 1;
                table.BorderColor = Color.Black;
                table.BorderStyle = BorderStyle.Solid;

                //  add the header row to the table
                if (gv.HeaderRow != null)
                {
                    GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);
                    table.Rows.Add(gv.HeaderRow);
                }

                //  add each of the data rows to the table
                foreach (GridViewRow row in gv.Rows)
                {
                    GridViewExportUtil.PrepareControlForExport(row);
                    table.Rows.Add(row);
                }

                //  add the footer row to the table
                if (gv.FooterRow != null)
                {
                    GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                    table.Rows.Add(gv.FooterRow);
                }

                //  render the table into the htmlwriter
                table.RenderControl(htw);

                //  render the htmlwriter into the response
                HttpContext.Current.Response.Write(sw.ToString());
                HttpContext.Current.Response.End();
            }
        }
    }

    //Export Gridview Data to Excel File and Save Excel file to Server Folder Rather than
    //allowing user to Open or Save it.
    public static void ExportToFolder(string fileName, GridView gv)
    {

        System.Text.StringBuilder sb = new System.Text.StringBuilder();

        using (StringWriter sw = new StringWriter(sb))
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                //  Create a form to contain the grid
                Table table = new Table();

                //  add the header row to the table
                if (gv.HeaderRow != null)
                {
                    GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);
                    table.Rows.Add(gv.HeaderRow);
                }

                //  add each of the data rows to the table
                foreach (GridViewRow row in gv.Rows)
                {
                    GridViewExportUtil.PrepareControlForExport(row);
                    table.Rows.Add(row);
                }

                //  add the footer row to the table
                if (gv.FooterRow != null)
                {
                    GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                    table.Rows.Add(gv.FooterRow);
                }

                //  render the table into the htmlwriter
                table.RenderControl(htw);

                //Create file
                System.IO.TextWriter w = new System.IO.StreamWriter(HttpContext.Current.Server.MapPath("~") + "\\" + fileName);
                w.Write(sb.ToString());
                w.Flush();
                w.Close();

            }
        }
    }

    private static void PrepareControlForExport(Control control)
    {
        for (int i = 0; i < control.Controls.Count; i++)
        {
            Control current = control.Controls[i];
            if (current is LinkButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
            }
            else if (current is ImageButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
            }
            else if (current is HyperLink)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
            }
            else if (current is DropDownList)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedItem.Text));
            }
            else if (current is CheckBox)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
            }

            if (current.HasControls())
            {
                GridViewExportUtil.PrepareControlForExport(current);
            }
        }
    }
}