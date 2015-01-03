<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        

    }

    //protected void Application_BeginRequest(Object sender, EventArgs e)
    //{
    //    if (HttpContext.Current.Request.IsSecureConnection.Equals(false))
    //    {
    //        var hhp = Request.ServerVariables["HTTP_HOST"];
    //        var rawurl = HttpContext.Current.Request.RawUrl;
    //        var mainurl = "https://";
    //        var final = mainurl + hhp + rawurl;


    //        Response.Redirect(final);
    //    }
    //} 
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        if (HttpContext.Current.Request.IsSecureConnection.Equals(false))
                Response.Redirect("https://calendar.na.aksharpith.org", true);
        
        // Code that runs when a new session is started
        if (Session.IsNewSession && Session["SessionExpire"] == null)
        {
            Session["SessionExpire"] = true;
            Response.Redirect("~/dsp_Login.aspx", true);
        }

        Session["OrderCancelDate"] = ConfigurationManager.AppSettings.Get("OrderCancelDate");

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
