using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["CENTERID"] == null || Session["CENTERID"].ToString() == "")
        {
            Response.Redirect("~/dsp_Login.aspx", true);
        }

        if (Session["ROLECODE"] != null && Session["ROLECODE"].ToString() != "10")
        {
            Response.Redirect("~/dsp_Unauthorized.aspx", true);
        }

       
    }
}
