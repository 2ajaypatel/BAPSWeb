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
/// Summary description for Roles
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[ScriptService]
public class Roles : System.Web.Services.WebService {

    public Roles () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int isUserRoleCodeExists(int RoleCode)
    {
        //string RoleCode = "";
        //NameValueCollection nvc = System.Web.HttpContext.Current.Request.Form;


        //if (!string.IsNullOrEmpty(nvc["RoleCode"]))
        //{
        //    RoleCode = nvc["RoleCode"].ToString().Trim();

        //}

        //int RoleCode2;

        RoleDO RoleDO = new RoleDO();
   
        //int.TryParse(RoleCode, out RoleCode2);

        return RoleDO.isUserRoleCodeExists(RoleCode);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String getRoles()
    {
        RoleDO RoleDO = new RoleDO();

        DataTable dt = new DataTable();

        dt = RoleDO.getRoles();

        return Utility.DataTableToJSON(dt);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String ProcessEditData()
    {

        string op = "";
        string RoleID = "";
        NameValueCollection nvc = System.Web.HttpContext.Current.Request.Form;

        if (!string.IsNullOrEmpty(nvc["oper"]))
        {
            op = nvc["oper"].ToString().Trim();
        }

        if (!string.IsNullOrEmpty(nvc["Id"]))
        {
            RoleID = nvc["Id"].ToString().Trim();

        }


        if (op == "edit")
        {
            Int32 RoleID2;
            string RoleCode;
            Int32 RoleCode2;

            RoleDO RoleDO = new RoleDO();

            RoleCode = nvc["RoleCode"].ToString().Trim();

            int.TryParse(RoleID, out RoleID2);
            int.TryParse(RoleCode, out RoleCode2);

            RoleDO.UpdateRegion(RoleID2,
                                        RoleID2,
                                        nvc["RoleName"].ToString().Trim(),
                                        nvc["RoleDescription"].ToString().Trim());

        }


        return "";

    }
    
}
