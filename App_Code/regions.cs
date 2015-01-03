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
/// Summary description for regions
/// </summary>
/// 
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 

[ScriptService]
public class regions : System.Web.Services.WebService {

    public regions () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String getRegions()
    {
        RegionDO regionObject = new RegionDO();
       
        DataTable dt = new DataTable();

        dt = regionObject.getRegions();

        return Utility.DataTableToJSON(dt);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String ProcessEditData()
    {

        string op = "";
        string RegionID = "";
        NameValueCollection nvc = System.Web.HttpContext.Current.Request.Form;

        if (!string.IsNullOrEmpty(nvc["oper"]))
        {
            op = nvc["oper"].ToString().Trim();
        }

        if (!string.IsNullOrEmpty(nvc["Id"]))
        {
            RegionID = nvc["Id"].ToString().Trim();

        }
              
       
        if (op == "edit")
        {
            Int32 RegionID2;

            RegionDO regionObject = new RegionDO();

            int.TryParse(RegionID, out RegionID2);
            regionObject.UpdateRegion(RegionID2, nvc["RegionName"].ToString().Trim(), nvc["RegionDescription"].ToString().Trim());
            
        }


        return "";

    }
    
}
