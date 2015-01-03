using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Calendar_Calendar : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["CENTERID"] == null || Session["CENTERID"].ToString() == "")
        {
            Response.Redirect("~/dsp_Login.aspx", true);
        }
          
        
    }
}
