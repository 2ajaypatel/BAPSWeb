using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;

public partial class Secure_dsp_payment : System.Web.UI.Page
{
    public String error;
    int id = -1;

    private string IpAddress()
    {
        string strIpAddress = "";

        strIpAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (strIpAddress == null)
            strIpAddress = Request.ServerVariables["REMOTE_ADDR"];

        return strIpAddress;
    }

    private void Initialize()
    {
        

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            connection.Open();
            SqlDataReader dataReader;
            command.CommandText = "SELECT STATECODE, STATEID,StateDescription FROM STATEMASTER WITH (NOLOCK)";
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlState.DataSource = dataReader;
                ddlState.DataTextField = "StateDescription";
                ddlState.DataValueField = "STATECODE";
                ddlState.DataBind();
            }
            ddlState.Items.Insert(0, new ListItem("-- Select --", "0"));
            dataReader.Close();
        }

        OrderDetails odObject = new OrderDetails();
        DataTable dt = odObject.getClientDetailByOrderID(id);

        if ( dt.Rows.Count > 0 )
        {
            txtCompanyName.Text = dt.Rows[0]["BusinessName"].ToString().Trim();
            txtFirstName.Text = dt.Rows[0]["FirstName"].ToString().Trim();
            txtLastName.Text = dt.Rows[0]["LastName"].ToString().Trim();
            txtAddress.Text = dt.Rows[0]["Address1"].ToString().Trim() + " " + dt.Rows[0]["Address2"].ToString().Trim();
            txtCity.Text = dt.Rows[0]["City"].ToString().Trim();
            ddlState.Text = dt.Rows[0]["StateID"].ToString().Trim();
            txtZip.Text = dt.Rows[0]["ZipCode"].ToString().Trim();
            txtPhone.Text = dt.Rows[0]["BusinessPhone"].ToString().Trim();
            txtEmail.Text = dt.Rows[0]["BusinessEmail"].ToString().Trim();
            hfCutomerID.Value = dt.Rows[0]["ClientID"].ToString().Trim();
            hfOrderID.Value = dt.Rows[0]["OrderID"].ToString().Trim();
            hfMemberID.Value = dt.Rows[0]["MemberID"].ToString().Trim();
        }

        //Populate the credit card expiration month drop down 
        for (int i = 1; i <= 12; i++)
        {
            DateTime month = new DateTime(2000, i, 1);
            ListItem li = new ListItem(month.ToString("MMM (M)"), month.ToString("MM"));
            ddlExpireMonth.Items.Add(li);
        }

        //Populate the credit card expiration year drop down (go out 12 years)  
        for (int i = 0; i <= 11; i++)
        {
            String year = (DateTime.Today.Year + i).ToString();
            ListItem li = new ListItem(year, year);
            ddlExpireYear.Items.Add(li);
        }

        // allow only number
        txtCreditCardNumber.Attributes.Add("onkeypress", "return ((window.event.keyCode >= 48 && window.event.keyCode <= 58))");
        txtZip.Attributes.Add("onkeypress", "return ((window.event.keyCode >= 48 && window.event.keyCode <= 58))");
        txtPhone.Attributes.Add("onkeypress", "return ((window.event.keyCode >= 48 && window.event.keyCode <= 58))");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            try
            {
                id = int.Parse(Request.QueryString["id"]);
                if (!IsPostBack)
                {
                    txtOrderID.Text = id.ToString();
                    getPaymentDetail(id);

                    Initialize();

                }

            }
            catch
            {
                // deal with it
            }
        }
    }

    public void getPaymentDetail(int orderID)
    {

        Decimal amount = 0;

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            connection.Open();
            SqlDataReader dataReader;
            command.CommandText = "SELECT OrderAmount, BankName,CheckNo,CheckDate,BankAmount FROM OrderMaster WITH (NOLOCK) WHERE" +
                                        " orderid  = " + orderID
                                        ;

            command.CommandType = CommandType.Text;

            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                while (dataReader.Read())
                {
                   

                    txtBankName.Text = dataReader["BankName"].ToString();
                    txtCheckNo.Text = dataReader["CheckNo"].ToString();
                    txtCheckDate.Text = String.Format("{0:MM/dd/yyyy}", dataReader["CheckDate"]);

                    amount = Convert.ToDecimal( dataReader["BankAmount"].ToString());

                    if ( amount <= 0   )
                        amount = Convert.ToDecimal( dataReader["OrderAmount"].ToString());

                    //String.Format("{0:f2}", value);
                    txtBankAmount.Text = String.Format("{0:f2}", amount);

                }
            }
            dataReader.Close();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string BankName = "";
        string CheckNo = "";
        DateTime CheckDate;
        Decimal BankAmount;
        int orderID;

        if (txtBankAmount.Text != "")
        {
            BankAmount = Convert.ToDecimal(txtBankAmount.Text);
        }
        else
            BankAmount = 0;

        BankName = txtBankName.Text;
        CheckNo = txtCheckNo.Text;
        CheckDate = Convert.ToDateTime(txtCheckDate.Text);
        orderID = Convert.ToInt16(txtOrderID.Text);

        OrderDetails odObject = new OrderDetails();
                
        odObject.UpdateOrderPaymentByCheck(orderID,BankName,CheckNo,CheckDate,BankAmount,AmountPaid: BankAmount,PaymentTypeID: 3,UserID:Session["UserID"].ToString() );

        //try
        //{
        //    // update payment data
        //    using (connection = new SqlConnection(DBCommon.ConnectionString))
        //    {
        //        SqlCommand command = connection.CreateCommand();

        //        command.CommandText = "Update OrderMaster SET BankName = @bankname, CheckNo = @checkno, CheckDate = @checkdate, BankAmount = @bankamount, AmountPaid = @bankamount  WHERE OrderID = @orderId ";

        //        command.CommandType = CommandType.Text;

        //        connection.Open();

        //        //Create a SqlParameter object to hold the output parameter value
        //        SqlParameter sqlParam;

        //        sqlParam = new SqlParameter("@bankname", bankName);
        //        command.Parameters.Add(sqlParam);

        //        sqlParam = new SqlParameter("@checkno", checkNo);
        //        command.Parameters.Add(sqlParam);

        //        sqlParam = new SqlParameter("@checkdate", checkDate);
        //        command.Parameters.Add(sqlParam);

        //        sqlParam = new SqlParameter("@bankamount", bankAmount);
        //        command.Parameters.Add(sqlParam);

        //        sqlParam = new SqlParameter("@orderId", orderId);
        //        command.Parameters.Add(sqlParam);

        //        //'Call the sproc...
        //        reader = command.ExecuteReader();
        //    }
        //}
        //finally
        //{
        //    // close reader
        //    if (reader != null)
        //    {
        //        reader.Close();
        //    }

        //    // close connection
        //    if (connection != null)
        //    {
        //        connection.Close();
        //    }
        //}

        Response.Redirect("~/Secure/OrderView.aspx", true);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/OrderView.aspx", true);
    }

    protected void btnCancel2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/OrderView.aspx", true);
    }

    protected void btnPayNow_Click(object sender, EventArgs e)
    {

        

        // validate all input fields
        string company = txtCompanyName.Text.Trim();
        string firstName = txtFirstName.Text.Trim();
        string lastName = txtLastName.Text.Trim();
        string address = txtAddress.Text.Trim();
        string city = txtCity.Text.Trim();
        string state = ddlState.Text.Trim();
        string zip = txtZip.Text.Trim();
        string phone = txtPhone.Text.Trim();
        string email = txtEmail.Text.Trim();
        string cardType = ddlCardType.Text.Trim();
        string creditCardNumber  = txtCreditCardNumber.Text.Trim();
        string expireMonth = ddlExpireMonth.Text.Trim();
        string expireYear = ddlExpireYear.Text.Trim();
        string amount = txtAmount.Text.Trim();
        string clientID = hfCutomerID.Value.Trim();
        string orderID = hfOrderID.Value.Trim();
        string memberID = hfMemberID.Value.Trim();

        string expireDate = expireMonth + expireYear;

        Dictionary<string, string> TransactionRequestParameters = new Dictionary<string, string>();

        // get all form posted variables
        TransactionRequestParameters.Add("x_company", company);
        TransactionRequestParameters.Add("x_first_name", firstName);
        TransactionRequestParameters.Add("x_last_name", lastName);
        TransactionRequestParameters.Add("x_address", address);
        TransactionRequestParameters.Add("x_city", city);
        TransactionRequestParameters.Add("x_state", state);
        TransactionRequestParameters.Add("x_zip", zip);
        TransactionRequestParameters.Add("x_phone", phone);
        TransactionRequestParameters.Add("x_email", email);
        TransactionRequestParameters.Add("x_cust_id", clientID);
        TransactionRequestParameters.Add("x_customer_ip", IpAddress());

        Guid guid = Guid.NewGuid();
         
        // order detail information
        TransactionRequestParameters.Add("x_po_num", guid.ToString());
        TransactionRequestParameters.Add("x_invoice_num", orderID);
        TransactionRequestParameters.Add("x_description", "Single/Multi Page Calendar");

        // credit card detail
        TransactionRequestParameters.Add("x_type", "AUTH_CAPTURE");
        TransactionRequestParameters.Add("x_method", "CC");
        TransactionRequestParameters.Add("x_card_num", creditCardNumber);
        TransactionRequestParameters.Add("x_exp_date", expireDate);
        TransactionRequestParameters.Add("x_amount", amount);
            
        // post request to authorize.net
        AuthorizeNet authorizeNet = new AuthorizeNet();

        string[] response = authorizeNet.SendTransactionRequest(TransactionRequestParameters);

        // process requested response from authorize.net
        if (response[0].ToString() == "1")
        {
            litmsg.Text = "Success";

            // Save transaction into database
            CreditCardTransactionsDO cctObject = new CreditCardTransactionsDO();

            // insert into credit card transaction table.
            cctObject.InsertCreditCardTransaction(response);

            OrderDetails odObject = new OrderDetails();

            // update payment information into order master
            odObject.UpdateOrderPaymentByCreditCard(Convert.ToInt16(orderID),  AmountPaid: Convert.ToDecimal(amount), PaymentTypeID: 4, UserID: Session["UserID"].ToString());

            // display message/redirect web page
            Response.Redirect("~/Secure/dsp_Transaction_Confirmation.aspx?PONumber=" + guid.ToString().Trim(), true);

        }
        else
        {
            // save failed response
            // Save transaction into database
            CreditCardTransactionsDO cctObject = new CreditCardTransactionsDO();

            cctObject.InsertCreditCardTransaction(response);
                        
            string msg = "";

            msg = msg + "<p style='color:red;'><b>Response Reason Code :</b>" + response[2].ToString() + "</br>";
            msg = msg + "<b>Response Reason :</b>" + response[3].ToString() + "</br>";
            msg = msg + "<b>Please correct the issue and try again.</b></p></br>";
            litmsg.Text = msg.ToString();
            
        }
    }
}