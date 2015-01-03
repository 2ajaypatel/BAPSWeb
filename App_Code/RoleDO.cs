using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for RoleDO
/// </summary>
public class RoleDO
{
	public RoleDO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int isUserRoleCodeExists(int RoleCode)
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_SEL_isUserRoleCodeExists";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RoleCode", SqlDbType.Int).Value = RoleCode;

                    conn.Open();
                    //Process results

                    int recordsAffected = cmd.ExecuteNonQuery();

                    if (recordsAffected > 0)
                        return RoleCode;
                    else
                        return RoleCode;
                }
            }
        }
        catch (Exception e)
        {
            return -1;
            throw e;
            
        }
    }

    public void UpdateRegion(int RoleID,int RoleCode, string RoleName, string RoleDescription)
    {
        try
        {
            // formulate a string containing the details of the
            // database connection
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_UPD_UserRole";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RoleID", SqlDbType.Int).Value = RoleID;
                    cmd.Parameters.Add("@RoleCode", SqlDbType.Int).Value = RoleCode;
                    cmd.Parameters.Add("@RoleName", SqlDbType.VarChar, 50).Value = RoleName;
                    cmd.Parameters.Add("@RoleDescription", SqlDbType.VarChar, 500).Value = RoleDescription;
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

    public DataTable getRoles()
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_getRoles";

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
                    sda.Fill(ds, "Roles");

                    // display the rows in the Products DataTable
                    DataTable dtRegions = ds.Tables["Roles"];

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