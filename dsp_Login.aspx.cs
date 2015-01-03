using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Secure_Login : System.Web.UI.Page
{
     #region "Functions"
        
        public void setProjectYear()
        {
		
              using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
              {
                  SqlCommand command = connection.CreateCommand();
                  connection.Open();
                  SqlDataReader dataReader;
                  command.CommandText = "SELECT TOP 1 ProjectYear FROM dbo.ProjectYear WITH (NOLOCK) WHERE IsCurrent = 1 ORDER BY ProjectYear DESC ";
                  command.CommandType = CommandType.Text;
                  dataReader = command.ExecuteReader();
                  if (dataReader.HasRows)
                  {
                      while (dataReader.Read())
                      {
                          Session.Add("PROJECTYEAR", dataReader["ProjectYear"].ToString());
                          dataReader.NextResult();
                      }
                     
                  }
                  {
                      DateTime currentDte = DateTime.Now;

                      Session.Add("PROJECTYEAR",currentDte.Year.ToString());
                  }
                  dataReader.Close();
              }
        }

        public bool GetUserInformation(string UserID, string UserPassword)
        {
            bool isResult = false;
            using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
            {
                SqlCommand command = connection.CreateCommand();

                command.CommandText = "SELECT UserIDNumber, RoleCode,USERID,USERPASSWORD,centerID,firstname,lastname,centerName FROM USERMASTER WITH (NOLOCK) WHERE upper(USERID)=upper(@USERID)" +
                                      " AND USERPASSWORD=@USERPASSWORD AND ISACTIVE='True'";
                command.CommandType = CommandType.Text; 
                SqlParameter parameter = new SqlParameter();
                parameter.ParameterName = "@USERID";
                parameter.Value = UserID;
                command.Parameters.Add(parameter);

                parameter = new SqlParameter();
                parameter.ParameterName = "@USERPASSWORD";
                parameter.Value = UserPassword;
                command.Parameters.Add(parameter);

                connection.Open();
                SqlDataReader dataReader = command.ExecuteReader();
                if (dataReader.HasRows)
                {
                    while (dataReader.Read())
                    {
                        Session.Add("ROLECODE", dataReader["ROLECODE"].ToString());
                        Session.Add("USERID", dataReader["USERID"].ToString());
                        Session.Add("ISLOGIN", "YES");
                        Session.Add("CENTERID", dataReader["CENTERID"].ToString());
                        Session.Add("firstname", dataReader["firstname"].ToString());
                        Session.Add("lastname", dataReader["lastname"].ToString());
                        Session.Add("centerName", dataReader["centerName"].ToString());
                        Session.Add("UserIDNumber", dataReader["UserIDNumber"].ToString());

                        Session.Add("Name", dataReader["firstname"].ToString().Trim() + " " + dataReader["lastname"].ToString());


                        isResult = true;
                        dataReader.NextResult();
                    }
                }
            }
            return isResult;
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Add("firstname", "");
           // ltmsg.Text = HttpContext.Current.Request.IsSecureConnection.ToString();

            if (HttpContext.Current.Request.IsSecureConnection.Equals(false))
                Response.Redirect("https://calendar.na.aksharpith.org", true);

            if (!Page.IsPostBack)
                txtUserID.Text = GetCookie().Trim();

            //read cookie
            //txtUserID
           
        }

        public void btnLogin_Click(object sender, EventArgs e)
        {

            if (GetUserInformation(txtUserID.Text.Trim(), txtPassword.Text.Trim()))
            {
                int roleCode;
                // set current active project year.
                setProjectYear();

                roleCode = int.Parse(Session["ROLECODE"].ToString());

                int centerID = Convert.ToInt16(Session["CENTERID"]);

                //see if he wants to be remembered
                if (chkRememberMe.Checked)
                {
                    //set the cookies
                    SetCookie( txtUserID.Text.Trim() );
                }
                else
                {
                    DeleteCookie();
                }

                // Multiple Case Decision
                if (roleCode == 10)
                {
                    Response.Redirect("~/admin/default.aspx", true);
                }
                else if (roleCode == 30)
                {
                    Response.Redirect("~/Designer/default.aspx", true);
                }
                else
                {
                    Response.Redirect("~/Secure/OrderView.aspx", true);
                }
            }
        }

        //How to Read
        public string GetCookie()
        {
            string str = "";

            if (Request.Cookies["UserID"] != null)
            {
                str = Request.Cookies["UserID"].Value;
            }
            return str;
        }

        // set cookie
        public void SetCookie(string UserID)
        {
            HttpCookie cookieUserID = new HttpCookie("UserID");
            cookieUserID.Value = UserID;
            cookieUserID.Expires = DateTime.Now.AddDays(30);
            Response.Cookies.Add(cookieUserID);
        }

        //How to delete
        public void DeleteCookie()
        {
            if (Request.Cookies["UserID"] != null)
            {
                // cookies will be expiry immediatly
                Response.Cookies["UserID"].Expires = DateTime.Now.AddMinutes(-1);
            }
        }
        
        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/forgotPassword.aspx", true);
        }
}

