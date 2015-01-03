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
/// Summary description for StateMasters
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 

[System.Web.Script.Services.ScriptService]
public class StateMasters : System.Web.Services.WebService {

    public StateMasters () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String getStateMasters()
    {

        StateMasterDO stateMasterDO = new StateMasterDO();

        DataTable dt = new DataTable();

        dt = stateMasterDO.getStateMasters();

        return Utility.DataTableToJSON(dt);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String ProcessEditData()
    {

        string op = "";
        string StateID = "";
        NameValueCollection nvc = System.Web.HttpContext.Current.Request.Form;

        if (!string.IsNullOrEmpty(nvc["oper"]))
        {
            op = nvc["oper"].ToString().Trim();
        }

        if (!string.IsNullOrEmpty(nvc["id"]))
        {
            StateID = nvc["id"].ToString().Trim();
        }


        if (op == "edit")
        {
            Int32 StateID2;


            StateMasterDO StateMasterDO = new StateMasterDO();

            Decimal StateTaxRate = Convert.ToDecimal( nvc["StateTaxRate"]);

            int.TryParse(StateID, out StateID2);


            StateMasterDO.UpdateStateMaster(StateID2, StateTaxRate);

        }


        return "";

    }
    
    
}
