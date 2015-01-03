using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


/// <summary>
/// Summary description for RegionDO
/// </summary>
public class RegionDO
{
	public RegionDO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void UpdateRegion(int RegionID, string RegionName, string RegionDescription)
    {
        try
        {
            // formulate a string containing the details of the
            // database connection
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_UPD_Region";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RegionID", SqlDbType.Int).Value = RegionID;
                    cmd.Parameters.Add("@RegionName", SqlDbType.VarChar,50).Value = RegionName;
                    cmd.Parameters.Add("@RegionDescription", SqlDbType.VarChar,500).Value = RegionDescription;
                    conn.Open();
                    //Process results

                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }

    }

    public DataTable getRegions()
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_getRegions";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();
                    //Process results

                    cmd.ExecuteNonQuery();

                    // create a  object
                    SqlDataAdapter sda = new SqlDataAdapter();

                    // set the SelectCommand property of the SqlAdapter object
                    // to the SqlCommand object
                    sda.SelectCommand = cmd;

                    // create a DataSet object to store the results of
                    // the stored procedure call
                    DataSet ds = new DataSet();

                    // use the Fill() method of the SqlDataAdapter object to
                    // retrieve the rows from the stored procedure call,
                    // storing the rows in a DataTable named Products
                    sda.Fill(ds, "Regions");

                    // display the rows in the Products DataTable
                    DataTable dtRegions = ds.Tables["Regions"];

                    return dtRegions;

                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }
}