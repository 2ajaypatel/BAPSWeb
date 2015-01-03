using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;
using System.Configuration;

/// <summary>
/// Summary description for OrderDetail
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[ScriptService]
public class OrderDetail : System.Web.Services.WebService
{

    public OrderDetail()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string[] GetBankName(string mail)
    {
        //int count = 10;
        string sql;
        sql = "SELECT DISTINCT bankname FROM  ordermaster (NOLOCK) WHERE bankname IS NOT NULL AND len(ltrim(rtrim(bankname))) > 0 AND bankname LIKE '" + mail + "' + '%'" + " ORDER BY bankname ";

        SqlDataAdapter da = new SqlDataAdapter(sql, ConfigurationManager.ConnectionStrings["BAPS_CALENDARConnectionString"].ConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);
        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr[0].ToString(), i);
            i++;
        }

        return items;
    }

}


