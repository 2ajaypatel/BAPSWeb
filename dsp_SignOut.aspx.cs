using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class signOut : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Add("firstname", "");

        Response.CacheControl = "private";
        Response.Expires = 0;
        Response.AddHeader("pragma", "no-cache");

        //string RedirectURL = "../dsp_Login.aspx";

        Session.Clear();
        Session.Abandon();

        Response.Redirect("~/dsp_Login.aspx", true);

        //Response.AddHeader("REFRESH", "1; URL=" + RedirectURL);

        //ClientScriptManager cs = Page.ClientScript;
        //cs.RegisterClientScriptBlock(GetType(), Guid.NewGuid().ToString(), "top.location.href='" + RedirectURL + "';", true);


    }
}