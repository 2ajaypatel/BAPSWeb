using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;


public partial class Admin_dsp_ProjectYear : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if ( !Page.IsPostBack)
        {
            

            if (!Page.IsPostBack)
            {
                BindData();

            }
           
        }
    }

    protected void BindData()
    {
        ProjectYearDO pyObject = new ProjectYearDO();

        DataTable dt = pyObject.getProjectYears();

        gv.DataSource = dt;

        gv.DataBind();

        Session["ProjectYearsDt"] = null;
        Session["ProjectYearsDt"] = dt;
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       
       
        //Edit Project Year
        if (e.CommandName == "EditProjectYear")
        {
            // get selected project year

            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });

            string ProjectYearID = commandArgs[0];
            string ProjectYear = commandArgs[1];
            string IsCurrent = commandArgs[2];

            hfProjectYearID.Value = ProjectYearID ;
            hfProjectYear.Value = ProjectYear;

           // litmsg.Text = ProjectYear;

            int startYear = DateTime.Today.Year - 2;

                for (int i = 0; i <= 10; i++)
                {
                    String year = startYear.ToString();
                    ListItem li = new ListItem(year, year);
                    ddlProjectYear.Items.Add(li);
                    startYear++;
                    
                }
                
                ddlProjectYear.Items.Insert(0, new ListItem("-- Select --", "0" ,true));

                //ddlProjectYear.Items[0].Selected = true;
                ddlProjectYear.ClearSelection();

                ListItem itmSelected = ddlProjectYear.Items.FindByText(ProjectYear);

                if (itmSelected != null)
                {
                    ddlProjectYear.SelectedItem.Selected = false;
                    itmSelected.Selected = true;
                    ddlProjectYear.Enabled = false;
                    chkIsCurrent.Checked = Convert.ToBoolean(IsCurrent);
                 }
                
                upProjectYear.Update();

        }

        //Edit Project Year
        if (e.CommandName == "AddProjectYear")
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });

            string ProjectYearID = commandArgs[0];
            string ProjectYear = commandArgs[1];
            string IsCurrent = commandArgs[2];

            hfProjectYearID.Value = ProjectYearID;
            hfProjectYear.Value = ProjectYear;

            // litmsg.Text = ProjectYear;
            
            DataTable dtProjectYears = (DataTable)Session["ProjectYearsDt"];

            int startYear = DateTime.Today.Year - 2;

            for (int i = 0; i <= 10; i++)
            {
                String year = startYear.ToString();

                // query datatable
                DataRow[] matches = dtProjectYears.Select(String.Format("ProjectYear = '{0}'", year));

                // you could do a lot of other things here, but lets just handle the first result
                if (matches.Length > 0)
                {
                  // litmsg.Text = matches[0]["ProjectYear"].ToString();
                                     
                }
                else
                {
                    ListItem li = new ListItem(year, year);
                    ddlProjectYear.Items.Add(li);
                }
                startYear++;

            }

            ddlProjectYear.Items.Insert(0, new ListItem("-- Select --", "0", true));
            ddlProjectYear.Enabled = true;
            //ddlProjectYear.Items[0].Selected = true;
            ddlProjectYear.ClearSelection();
            chkIsCurrent.Checked = false;
            upProjectYear.Update();

             
        }
    }

    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;
        gv.DataBind();
    }

    protected void btnViewNoteClose_Click(object sender, EventArgs e)
    {

        CloseViewAuditDialog("ViewProjectYear");

        //reset
        ddlProjectYear.Items.Clear();
        ddlProjectYear.ClearSelection();
        chkIsCurrent.Checked = false;

        //refresh grid
        upProjectYear.Update();

    }

    protected void CloseViewAuditDialog(string dialogId)
    {
        ddlProjectYear.Items.Clear();  
        string sr = string.Format(@"CloseProjectYearDialog('{0}')", dialogId);
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), UniqueID, sr, true);
    }

    protected void gv_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsCurrent")) == "True")
            {
                e.Row.BackColor = ColorTranslator.FromHtml("#946098");
                e.Row.ForeColor = Color.White;
                
            }
            else
            {
                e.Row.ForeColor = Color.Black;
            }

        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        // check any valid order existing by project year by project year id
        Int32 ProjectYearID  = Convert.ToInt32( hfProjectYearID.Value);
        Int32 ProjectYear = Convert.ToInt32(hfProjectYear.Value);

        ProjectYearDO prObject = new ProjectYearDO();

        if (ProjectYearID > 0)
        {
            // update only IsCurrent Year or no
            
            if (chkIsCurrent.Checked)
                prObject.UpdateProjectYear(projectYearID: ProjectYearID, projectYear: ProjectYear, isCurrent: 1);
            else
            {
                prObject.UpdateProjectYear(projectYear: ProjectYearID, projectYearID: ProjectYear, isCurrent: 0);
            }

        }
        else
        {
            string ProjectYearSelected = ddlProjectYear.SelectedValue.ToString();

            if (chkIsCurrent.Checked)
                // insert new project Year
                prObject.InsertProjectYear(projectYear: Convert.ToInt32(ProjectYearSelected) , isCurrent: 1);
            else
            {
                // insert new project Year
                prObject.InsertProjectYear(projectYear: Convert.ToInt32(ProjectYearSelected), isCurrent: 0);
            }

           
        }

        
        // close pop up window
        BindData();
        upGrid.Update();
        CloseViewAuditDialog("ViewProjectYear");
    }
}