using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Secure_dsp_Transaction_Confirmation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["PONumber"] != null)
        {
            try
            {
                string PONumber = Request.QueryString["PONumber"].ToString().Trim();

                if (!IsPostBack)
                {

                    getCreditCardTransactionDetail(PONumber);

                }


            }
            catch
            {
                // deal with it
            }
        }
    }

    protected void getCreditCardTransactionDetail(string PONumber)
    {
        CreditCardTransactionsDO cctObject = new CreditCardTransactionsDO();

        DataTable dt = cctObject.getCreditCardTransactionByPONumber(PONumber);

        populateCreditCardTransactionDetail(dt);
    }

    protected void populateCreditCardTransactionDetail(DataTable dt)
    {
        if (dt.Rows.Count > 0)
        {
            lbTransaction_Request_Date.Text = dt.Rows[0]["Transaction_Request_Date"].ToString();
            lbInvoice_Number.Text = dt.Rows[0]["Invoice_Number"].ToString();
            lbPO_Number.Text = dt.Rows[0]["PO_Number"].ToString();
            lbDescription.Text = dt.Rows[0]["Description"].ToString();
            lbAmount.Text = dt.Rows[0]["Amount"].ToString();
            lbMethod.Text = dt.Rows[0]["Method"].ToString();
            lbTransaction_Type.Text = dt.Rows[0]["Transaction_Type"].ToString();

            lbResponse_Reason_Text.Text = dt.Rows[0]["Response_Reason_Text"].ToString();
            lbAuthorization_Code.Text = dt.Rows[0]["Authorization_Code"].ToString();
            lbTransaction_ID.Text = dt.Rows[0]["Transaction_ID"].ToString();

            lbCustomerID.Text = dt.Rows[0]["CustomerID"].ToString();
            lbFirstName.Text = dt.Rows[0]["FirstName"].ToString();
            lbLastName.Text = dt.Rows[0]["LastName"].ToString();
            lbCompany.Text = dt.Rows[0]["Company"].ToString();
            lbAddress.Text = dt.Rows[0]["Address"].ToString();
            lbCity.Text = dt.Rows[0]["City"].ToString();
            lbState.Text = dt.Rows[0]["State"].ToString();
            lbZip_Code.Text = dt.Rows[0]["Zip_Code"].ToString();
            lbPhone.Text = dt.Rows[0]["Phone"].ToString();
            lbEmail.Text = dt.Rows[0]["Email"].ToString();

        }

    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/OrderView.aspx", true);
    }
}