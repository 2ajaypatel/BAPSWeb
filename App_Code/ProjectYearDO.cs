using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


/// <summary>
/// Summary description for ProjectYearDO
/// </summary>
public class ProjectYearDO
{
    public ProjectYearDO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public void InsertProjectYear(int projectYear, int isCurrent)
    {
        try
        {
            // formulate a string containing the details of the
            // database connection
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_INS_ProjectYear";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ProjectYear", SqlDbType.Int).Value = projectYear;
                    cmd.Parameters.Add("@IsCurrent", SqlDbType.Bit).Value = isCurrent;
                    conn.Open();
                    //Process results

                    cmd.ExecuteNonQuery();

                    conn.Close();
                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public void UpdateProjectYear(int projectYearID, int projectYear, int isCurrent)
    {
        try
        {
            // formulate a string containing the details of the
            // database connection
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_UPD_ProjectYear";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ProjectYearID", SqlDbType.Int).Value = projectYearID;
                    cmd.Parameters.Add("@ProjectYear", SqlDbType.Int).Value = projectYear;
                    cmd.Parameters.Add("@IsCurrent", SqlDbType.Bit).Value = isCurrent;
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

    public void DeleteProjectYear(int projectYearID)
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_DEL_ProjectYear";

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand(procedureString, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ProjectYearID", SqlDbType.Int).Value = projectYearID;

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

    public DataTable getProjectYears()
    {

        // formulate a string containing the details of the
        // database connection

        try
        {
            string connectionString = DBCommon.ConnectionString;

            var procedureString = "usp_CAL_SEL_ProjectYear";

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
                    sda.Fill(ds, "ProjectYears");

                    // display the rows in the Products DataTable
                    DataTable dtProjectYearDetail = ds.Tables["ProjectYears"];

                    return dtProjectYearDetail;

                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public DataTable getYears()
    {
        int year = DateTime.Now.Year - 2;
        DataTable dt = new DataTable();

        dt.Columns.Add("ProjectYear", typeof(int)); // Add  column

        for (var i = year; i <= 2020; i++)
        {
            dt.Rows.Add(i);
        }

        return dt;

    }

}