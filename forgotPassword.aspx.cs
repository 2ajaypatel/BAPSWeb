using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Text;
using System.Web.Configuration;

public partial class Secure_forgotPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { 
        ddlbCenter.Items.Insert(0, "--Select--");
        ddlbCenter.SelectedIndex = 0;
        }
    }

    public bool CheckUser(string UserID, int CenterID)
    {
        bool isResult = false;
        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();

            command.CommandText =   "   SELECT TOP 1 us.firstname,us.lastname,us.userpassword,c.centername " + 
                                    "   FROM USERMASTER us WITH (NOLOCK)   " + 
		                            "          JOIN CENTER c WITH (NOLOCK)  " + 
			                        "   	        ON us.centerid = c.centerid  " + 
                                    "       WHERE upper(us.USERID) = upper(@USERID)  " +
                                    "               AND us.centerid = @CenterID  " +
                                    "               AND us.ISACTIVE = 1  ";

          
            command.CommandType = CommandType.Text;
            SqlParameter parameter = new SqlParameter();
            parameter.ParameterName = "@USERID";
            parameter.Value = UserID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter();
            parameter.ParameterName = "@CenterID";
            parameter.Value = CenterID;
            command.Parameters.Add(parameter);

            connection.Open();
            SqlDataReader dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                while (dataReader.Read())
                {
                    Session.Add("USERID", dataReader["USERID"].ToString());
                    Session.Add("ISLOGIN", "YES");
                    Session.Add("CENTERID", dataReader["CENTERID"].ToString());
                    Session.Add("firstname", dataReader["firstname"].ToString());
                    Session.Add("lastname", dataReader["lastname"].ToString());
                    Session.Add("centerName", dataReader["centerName"].ToString());
                    isResult = true;
                    dataReader.NextResult();
                }
            }
        }
        return isResult;
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        // check for valid userid and center

        Int32 centerid = Convert.ToInt32(ddlbCenter.SelectedValue);
        string userID = txtUserID.Text.Trim();
        string firtName = "";
        string lastName = "";
        string centerName = "";
        string userpassword = "";
        bool isResult = false;

        lbErrorMessage.Text = "";


        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();

            command.CommandText = "   SELECT TOP 1 us.firstname,us.lastname,us.userpassword,c.centername " +
                                    "   FROM USERMASTER us WITH (NOLOCK)   " +
                                    "          JOIN CENTER c WITH (NOLOCK)  " +
                                    "   	        ON us.centerid = c.centerid  " +
                                    "       WHERE upper(us.USERID) = upper(@USERID)  " +
                                    "               AND us.centerid = @CenterID  " +
                                    "               AND us.ISACTIVE = 1  ";


            command.CommandType = CommandType.Text;
            SqlParameter parameter = new SqlParameter();
            parameter.ParameterName = "@USERID";
            parameter.Value = userID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter();
            parameter.ParameterName = "@CenterID";
            parameter.Value = centerid;
            command.Parameters.Add(parameter);

            connection.Open();
            SqlDataReader dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                while (dataReader.Read())
                {
                    firtName = dataReader["firstname"].ToString();
                    lastName = dataReader["lastname"].ToString();
                    centerName = dataReader["centerName"].ToString();
                    userpassword = dataReader["userpassword"].ToString();
                    isResult = true;
                    dataReader.NextResult();
                }
            }
        }
            
        if (isResult == false)
        {
            lbErrorMessage.Text = "Your user id and center name NOT found in our system. Please contact admin at National Office.";
            return;

        }
       
        // redirect the page
        var smtpClient = new SmtpClient();
        var message = new MailMessage("no-reply@gmail.com", "2ajaypatel@gmail.com");

        message.IsBodyHtml = true;
        message.Subject = string.Format("Swaminarayan Aksharpith, Inc. Password - Calendar Application");
       
        StringBuilder builder = new StringBuilder();

        builder.Append("<html><head></head><body>");
        builder.Append("<b>Swaminarayan Aksharpith, Inc. - Password Resend</b><br><br>").AppendLine().AppendLine();
        builder.Append(firtName + " " + lastName + ", your password is: <b>" + userpassword + "!</b>").AppendLine().AppendLine();
        builder.Append("</body></html>");

        message.Body = builder.ToString();

        smtpClient.Send(message);

        Response.Redirect("~/dsp_Login.aspx", true);
          
    }
}