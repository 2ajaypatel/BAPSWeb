using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Collections.ObjectModel;
using System.Web.Services.Protocols;
using System.Web.Script.Services;
using System.Collections.Generic;
using System.Linq;
using System.Collections.Specialized;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ProjectYears
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 

[System.Web.Script.Services.ScriptService]
public class ProjectYears : System.Web.Services.WebService {

    public ProjectYears () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String getProjectYears()
    {

        ProjectYearDO projectYearDO = new ProjectYearDO();

        DataTable dt = new DataTable();

        dt = projectYearDO.getProjectYears();

        return Utility.DataTableToJSON(dt);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String getYears()
    {

        ProjectYearDO projectYearDO = new ProjectYearDO();

        DataTable dt = new DataTable();

        dt = projectYearDO.getYears();

        return Utility.DataTableToJSON(dt);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String ProcessEditData()
    {

        string op = "";
       
        NameValueCollection nvc = System.Web.HttpContext.Current.Request.Form;

        if (!string.IsNullOrEmpty(nvc["oper"]))
        {
            op = nvc["oper"].ToString().Trim();
        }

        ProjectYearDO projectYearDO = new ProjectYearDO();

        if (op == "edit")
        {
        
            Int16 id = Convert.ToInt16((nvc["id"]));
            Int16 ProjectYear = Convert.ToInt16((nvc["ProjectYear"]));
            Int16 isCurrent = Convert.ToInt16((nvc["IsCurrent"]));

            projectYearDO.UpdateProjectYear(id, ProjectYear, isCurrent);

        }

        if (op == "add")
        {
            Int16 ProjectYear = Convert.ToInt16( (nvc["ProjectYear"]));
            Int16 isCurrent = Convert.ToInt16((nvc["IsCurrent"]));

            projectYearDO.InsertProjectYear(ProjectYear, isCurrent);
        }

        return "";

    }
    
}
