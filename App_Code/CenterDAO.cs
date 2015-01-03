using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for CenterDAO
/// </summary>
public class CenterDAO
{
	public CenterDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable getCenters()
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_getCenters";

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
                    sda.Fill(ds, "Centers");

                    // display the rows in the Products DataTable
                    DataTable dtCenters = ds.Tables["Centers"];

                    return dtCenters;

                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public DataTable getCentersByRegion(int RegionID)
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_getCentersByRegion";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@RegionID", RegionID));

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
                    sda.Fill(ds, "Centers");

                    // display the rows in the Products DataTable
                    DataTable dtCenters = ds.Tables["Centers"];

                    return dtCenters;

                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }
}