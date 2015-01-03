using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

    public static class DBCommon
    {                                                                   
        private static string _connectionString = ConfigurationManager.ConnectionStrings["BAPS_CALENDARConnectionString"].ToString();
        public static string ConnectionString
        {
            get
            {
                return _connectionString;
            }

            set
            {
                _connectionString = value;
            }
        }
    }
