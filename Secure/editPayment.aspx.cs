using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Secure_editPayment : System.Web.UI.Page
{
    int id = -1;

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

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            connection.Open();
            SqlDataReader dataReader;
            command.CommandText = "SELECT BankName,CheckNo,CheckDate,BankAmount FROM OrderMaster WITH (NOLOCK) WHERE" +
                                        " orderid  = " + orderID 
                                        ;

            command.CommandType = CommandType.Text;

            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                while (dataReader.Read())
                {
                   
                    txtBankName.Text    = dataReader["BankName"].ToString();
                    txtCheckNo.Text     = dataReader["CheckNo"].ToString();
                    txtCheckDate.Text   = String.Format("{0:MM/dd/yyyy}",dataReader["CheckDate"]);
                    txtBankAmount.Text = String.Format("{0:C}", dataReader["BankAmount"].ToString());

                    

                    

                   
                }
            }
            dataReader.Close();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string bankName = "";
        string checkNo = "";
        DateTime checkDate;
        double bankAmount;
        int orderId;

        SqlConnection connection = null;
        SqlDataReader reader = null;

        if (txtBankAmount.Text != "")
        {
            bankAmount = double.Parse(txtBankAmount.Text);
        }
        else
            bankAmount = 0.0;

        bankName = txtBankName.Text;
        checkNo = txtCheckNo.Text;
        checkDate = Convert.ToDateTime(txtCheckDate.Text);
        orderId = Convert.ToInt16(txtOrderID.Text);

        try
		{
            // update payment data
            using ( connection = new SqlConnection(DBCommon.ConnectionString))
            {
                SqlCommand command = connection.CreateCommand();

                command.CommandText = "Update OrderMaster SET BankName = @bankname, CheckNo = @checkno, CheckDate = @checkdate, BankAmount = @bankamount WHERE OrderID = @orderId ";

                command.CommandType = CommandType.Text;

                connection.Open();

                //Create a SqlParameter object to hold the output parameter value
                SqlParameter sqlParam;

                sqlParam = new SqlParameter("@bankname", bankName);
                command.Parameters.Add(sqlParam);

                sqlParam = new SqlParameter("@checkno", checkNo);
                command.Parameters.Add(sqlParam);

                sqlParam = new SqlParameter("@checkdate", checkDate);
                command.Parameters.Add(sqlParam);

                sqlParam = new SqlParameter("@bankamount", bankAmount);
                command.Parameters.Add(sqlParam);

                sqlParam = new SqlParameter("@orderId", orderId);
                command.Parameters.Add(sqlParam);

                //'Call the sproc...
                reader = command.ExecuteReader();
            }
        }
        finally
        {
            // close reader
            if (reader != null)
            {
                reader.Close();
            }

            // close connection
            if (connection != null)
            {
                connection.Close();
            }
        }

        Response.Redirect("~/Secure/OrderView.aspx", true);
    }

    protected void btnEditSave_Click(object sender, EventArgs e)
    {
        

        if (Page.IsValid)
        {
            var bankName = "";

            bankName = txtEditName.Text.Trim();
            //upEditUpdatePanel.Update();
            CloseDialog("editBusInfo", bankName);

            //reset
             txtEditName.Text = string.Empty;
        }
    }

    /// <summary>
    /// Registers client script to close the dialog
    /// </summary>
    /// <param name="dialogId"></param>
    private void CloseDialog(string dialogId, string bankName)
    {
        string script = string.Format(@"closeDialog('{0}','{1}')", dialogId, bankName);
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), UniqueID, script, true);
    }

    protected void btnCC_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/secure/dsp_payment.aspx", true);
    }
}