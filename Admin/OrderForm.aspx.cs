using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;


public partial class Secure_OrderForm : System.Web.UI.Page
{
    List<ProductOrder> productOrderList = new List<ProductOrder>();

    #region "Functions"

    private void Initialize()
    {
        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            connection.Open();
            SqlDataReader dataReader;
            command.CommandText = "SELECT STATECODE, STATEID,StateDescription FROM STATEMASTER WITH (NOLOCK)";
            command.CommandType = CommandType.Text;
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlBusinessState.DataSource = dataReader;
                ddlBusinessState.DataTextField = "StateDescription";
                ddlBusinessState.DataValueField = "STATEID";
                ddlBusinessState.DataBind();
            }
            dataReader.Close();

            command.CommandText = "SELECT STATECODE, STATEID,StateDescription FROM STATEMASTER WITH (NOLOCK)";
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlState.DataSource = dataReader;
                ddlState.DataTextField = "StateDescription";
                ddlState.DataValueField = "STATEID";
                ddlState.DataBind();
            }
            dataReader.Close();

            string centerID;

            centerID = Session["CENTERID"].ToString();

            command.CommandText = "SELECT CENTERNAME, CENTERID FROM CENTER WITH (NOLOCK) WHERE " +
                                    " centerID = " + centerID;

            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlCenter.DataSource = dataReader;
                ddlCenter.DataTextField = "CENTERNAME";
                ddlCenter.DataValueField = "CENTERID";
                ddlCenter.DataBind();
            }
            dataReader.Close();

            command.CommandText = "SELECT PRODUCTID, PRODUCTDESCRIPTION FROM PRODUCTMASTER WITH (NOLOCK)";
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlProduct.DataSource = dataReader;
                ddlProduct.DataTextField = "PRODUCTDESCRIPTION";
                ddlProduct.DataValueField = "PRODUCTID";
                ddlProduct.DataBind();
            }
            ddlProduct.Items.Insert(0, new ListItem("-- Select --", "0"));
            dataReader.Close();

            command.CommandText = "SELECT ProductTypeID, PRODUCTTYPEDESC FROM PRODUCTTYPE WITH (NOLOCK)";
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                ddlProductType.DataSource = dataReader;
                ddlProductType.DataTextField = "PRODUCTTYPEDESC";
                ddlProductType.DataValueField = "ProductTypeID";
                ddlProductType.DataBind();
            }
            ddlProductType.Items.Insert(0, new ListItem("-- Select --", "0"));
            dataReader.Close();

            txtDate.Text = String.Format("{0:MM/dd/yyyy}", (DateTime.Now));


        }
    }

    private void GetProductPrice()
    {
        string productID = "0";
        string unitID = "0";
        string productTypeID = "0";
        string rate = "0";
        string additionalRate = "0";
        string quantity = "0";
        string totalAmount = "0";
        string productRateID = "0";

        if (txtQuantity.Text != "")
        {
            quantity = txtQuantity.Text;
        }

        if (ddlProduct.SelectedValue != null)
        {
            productID = ddlProduct.SelectedValue.ToString();
        }

        if (ddlProductType.SelectedValue != null)
        {
            productTypeID = ddlProductType.SelectedValue.ToString();
        }

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            connection.Open();
            SqlDataReader dataReader;
            command.CommandText = "SELECT ISNULL(Rate,0) as 'RATE',ProductRateID FROM ProductRate WITH (NOLOCK) WHERE" +
                                        " PRODUCTID=" + productID + " AND " +
                                        " MinUnit <= '" + quantity + "' AND MAXUNIT >= '" + quantity + "'" +
                                        " AND PRODUCTTYPEID=0";

            command.CommandType = CommandType.Text;
            dataReader = command.ExecuteReader();
            if (dataReader.HasRows)
            {
                while (dataReader.Read())
                {
                    rate = dataReader["Rate"].ToString();
                    productRateID = dataReader["ProductRateID"].ToString();
                }
            }
            dataReader.Close();

            if (int.Parse(productTypeID) > 0)
            {
                command.CommandText = "SELECT ISNULL(Rate,0) as 'RATE',ProductRateID FROM ProductRate WITH (NOLOCK) WHERE" +
                                        " PRODUCTID=" + productID + " AND " +
                                        " MinUnit <= '" + quantity + "' AND MAXUNIT >= '" + quantity + "'" +
                                        " AND PRODUCTTYPEID=" + productTypeID;
                command.CommandType = CommandType.Text;
                dataReader = command.ExecuteReader();
                if (dataReader.HasRows)
                {
                    while (dataReader.Read())
                    {
                        additionalRate = dataReader["Rate"].ToString();
                        productRateID = dataReader["ProductRateID"].ToString();
                    }
                }
            }
            dataReader.Close();
            txtRate.Text = rate;
            txtAdditionalRate.Text = additionalRate;
            txtRateID.Text = productRateID;
            //txtRateID.Text = productID;

            decimal ldtempValue1;

            decimal ldtempValue;

            ldtempValue1 = (Decimal.Parse(rate) * Decimal.Parse(quantity));

            ldtempValue = ldtempValue1 + Decimal.Parse(additionalRate);



            txtAmount.Text = ldtempValue.ToString();

        }


    }

    private int SaveAddress(Address oAdd)
    {
        int AddressID = 0;
        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = "SetAddress";
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();
            //Create a SqlParameter object to hold the output parameter value
            SqlParameter sqlParam;
            sqlParam = new SqlParameter("@AddressID", oAdd.AddressID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@Address1", oAdd.Address1);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@Address2", oAdd.Address2);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@City", oAdd.City);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@StateID", oAdd.StateID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@ZipCOde", oAdd.ZipCode);
            command.Parameters.Add(sqlParam);
            //Create a SqlParameter object to hold the output parameter value
            SqlParameter retValParam = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
            //'IMPORTANT - must set Direction as ReturnValue
            retValParam.Direction = ParameterDirection.ReturnValue;

            //'Finally, add the parameter to the Command's Parameters collection
            command.Parameters.Add(retValParam);

            //'Call the sproc...
            SqlDataReader reader = command.ExecuteReader();

            //'Now you can grab the output parameter's value...
            int retVal = 0;
            int.TryParse(retValParam.Value.ToString(), out retVal);
            AddressID = retVal;


        }
        return AddressID;
    }

    private int SaveMember(Member oMember)
    {
        int MemberID = 0;

        if (Convert.ToInt16(hdfMemberID.Value) > 0)
            MemberID = Convert.ToInt16(hdfMemberID.Value);

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = "SetMember";
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();
            //Create a SqlParameter object to hold the output parameter value
            SqlParameter sqlParam;
            sqlParam = new SqlParameter("@MemberID", MemberID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@FirstName", oMember.FirstName);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@LastName", oMember.LastName);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@AddressID", oMember.AddressID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@HomePhone", oMember.HomePhone);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@CellPhone", oMember.CellPhone);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@Fax", oMember.Fax);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@Email", oMember.Email);
            command.Parameters.Add(sqlParam);

            //Create a SqlParameter object to hold the output parameter value
            SqlParameter retValParam = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
            //'IMPORTANT - must set Direction as ReturnValue
            retValParam.Direction = ParameterDirection.ReturnValue;

            //'Finally, add the parameter to the Command's Parameters collection
            command.Parameters.Add(retValParam);

            //'Call the sproc...
            SqlDataReader reader = command.ExecuteReader();

            //'Now you can grab the output parameter's value...
            int retVal = 0;
            int.TryParse(retValParam.Value.ToString(), out retVal);
            MemberID = retVal;
        }
        return MemberID;
    }

    private int SaveClient(Client oClient)
    {
        int ClientID = 0;
        
        

        if (Convert.ToInt16(hdfClientID.Value) > 0)
            ClientID = Convert.ToInt16(hdfClientID.Value);

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = "SetClient";
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();
            //Create a SqlParameter object to hold the output parameter value
            SqlParameter sqlParam;
            sqlParam = new SqlParameter("@ClientID", ClientID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@BusinessName", oClient.BusinessName);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@AddressID", oClient.AddressID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@BusinessPhone", oClient.BusinessPhone);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@BusinessFax", oClient.BusinessFax);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@BusinessEmail", oClient.BusinessEmail);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@HomePhone", oClient.HomePhone);
            command.Parameters.Add(sqlParam);

            sqlParam = new SqlParameter("@FirstName", oClient.FirstName);
            command.Parameters.Add(sqlParam);

            sqlParam = new SqlParameter("@LastName", oClient.LastName);
            command.Parameters.Add(sqlParam);

            //Create a SqlParameter object to hold the output parameter value
            SqlParameter retValParam = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
            //'IMPORTANT - must set Direction as ReturnValue
            retValParam.Direction = ParameterDirection.ReturnValue;

            //'Finally, add the parameter to the Command's Parameters collection
            command.Parameters.Add(retValParam);

            //'Call the sproc...
            SqlDataReader reader = command.ExecuteReader();

            //'Now you can grab the output parameter's value...
            int retVal = 0;
            int.TryParse(retValParam.Value.ToString(), out retVal);
            ClientID = retVal;
        }
        return ClientID;
    }

    private int SaveOrder(Order ord)
    {
        int OrderID = 0;
        int CenterID = 0;

        string userID = Session["USERID"].ToString();

        if (string.IsNullOrEmpty(hdfOrderID.Value.ToString().Trim()))
        {
            OrderID = 0;
        }
        else
        {
            if (Convert.ToInt16(hdfOrderID.Value) > 0)
                OrderID = Convert.ToInt16(hdfOrderID.Value);
            else
                OrderID = 0;
        }

        
        if (string.IsNullOrEmpty(hdfCenterID.Value.ToString().Trim()))
        {
            CenterID = 0;
        }
        else
        {
            if (Convert.ToInt16(hdfCenterID.Value) > 0)
                CenterID = Convert.ToInt16(hdfCenterID.Value);
            else
                CenterID = 0;
        }

        if (CenterID <= 0)
            CenterID = ord.ClientID;

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = "SetOrder";
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();

            //Create a SqlParameter object to hold the output parameter value
            SqlParameter sqlParam;
            sqlParam = new SqlParameter("@OrderID", OrderID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@OrderDate", ord.OrderDate);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@OrderAmount", ord.OrderAmount);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@ClientID", CenterID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@MemberID", ord.MemberID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@OrderStatus", "PENDING");
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@CenterID", ord.CenterID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@BankName", ord.BankName);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@CheckNo ", ord.CheckNo);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@CheckDate ", ord.CheckDate);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@BankAmount", ord.BankAmount);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@Year", ord.ProjectYear);
            command.Parameters.Add(sqlParam);

            sqlParam = new SqlParameter("@UserID", userID);
            command.Parameters.Add(sqlParam);
            
            //Create a SqlParameter object to hold the output parameter value
            SqlParameter retValParam = new SqlParameter("RETURN_VALUE", SqlDbType.Int);

            //'IMPORTANT - must set Direction as ReturnValue
            retValParam.Direction = ParameterDirection.ReturnValue;

            //'Finally, add the parameter to the Command's Parameters collection
            command.Parameters.Add(retValParam);

            //'Call the sproc...
            SqlDataReader reader = command.ExecuteReader();

            //'Now you can grab the output parameter's value...
            int retVal = 0;
            int.TryParse(retValParam.Value.ToString(), out retVal);
            OrderID = retVal;
        }
        return OrderID;
    }

    private int SaveOrderDetails(OrderDetails ord)
    {
        int OrderID = 0;

        string userID = Session["USERID"].ToString();

        //if (Convert.ToInt16(hdfOrderID.Value) > 0)
        //    OrderID = Convert.ToInt16(hdfOrderID.Value);

        if (string.IsNullOrEmpty(hdfOrderID.Value.ToString().Trim()))
        {
            OrderID = 0;
        }
        else
        {
            if (Convert.ToInt16(hdfOrderID.Value) > 0)
                OrderID = Convert.ToInt16(hdfOrderID.Value);
            else
                OrderID = 0;
        }

        using (SqlConnection connection = new SqlConnection(DBCommon.ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = "SetOrderDetails";
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();

            //Create a SqlParameter object to hold the output parameter value
            SqlParameter sqlParam;
            sqlParam = new SqlParameter("@OrderID", ord.OrderID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@OrderDetailsID", ord.OrderDetailID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@ProductID", ord.ProductID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@ProductRateID", ord.ProductRateID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@ProductQty", ord.ProductQty);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@Rate", ord.Rate);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@OrderAmount", ord.OrderAmount);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@ProductAdditionalRateID", ord.ProductAdditionalRateID);
            command.Parameters.Add(sqlParam);
            sqlParam = new SqlParameter("@OrderAdditionalAmount", ord.OrderAmount);
            command.Parameters.Add(sqlParam);

            sqlParam = new SqlParameter("@UserID", userID);
            command.Parameters.Add(sqlParam);

            //Create a SqlParameter object to hold the output parameter value
            SqlParameter retValParam = new SqlParameter("RETURN_VALUE", SqlDbType.Int);

            //'IMPORTANT - must set Direction as ReturnValue
            retValParam.Direction = ParameterDirection.ReturnValue;

            //'Finally, add the parameter to the Command's Parameters collection
            command.Parameters.Add(retValParam);

            //'Call the sproc...
            SqlDataReader reader = command.ExecuteReader();

            //'Now you can grab the output parameter's value...
            int retVal = 0;

            int.TryParse(retValParam.Value.ToString(), out retVal);
            OrderID = retVal;
        }
        return OrderID;
    }

    private bool SetRecord()
    {
        int memberAddressID = 0;
        int clientAddressID = 0;
        int clientID = 0;
        int memberID = 0;
        int OrderID = 0;
        double totalAmount = 0;


        if (Session["PRODUCTLIST"] != null)
        {
            productOrderList = (List<ProductOrder>)Session["PRODUCTLIST"];
            foreach (ProductOrder pr in productOrderList)
            {
                totalAmount += pr.Amount;
            }
        }
        else
        {
            lbMessage.Text = "You haven't enter any order details. please enter calendar order before proceed.";
            return false;
        }

        //Client Address

        if (Convert.ToInt16(hdfClientAddressID.Value) > 0)
            clientAddressID = Convert.ToInt16(hdfClientAddressID.Value);

        Address oAdd = new Address();
        oAdd.AddressID = clientAddressID;
        oAdd.Address1 = txtBusinessAddress1.Text;
        oAdd.Address2 = txtBusinessAddress2.Text;
        oAdd.City = txtBusinessCity.Text;
        oAdd.ZipCode = txtBusinessZipCode.Text;
        oAdd.StateID = int.Parse(ddlBusinessState.SelectedValue);
        clientAddressID = SaveAddress(oAdd);

        if (Convert.ToInt16(hdfMemberAddressID.Value) > 0)
            memberAddressID = Convert.ToInt16(hdfMemberAddressID.Value);

        oAdd = new Address();
        oAdd.AddressID = memberAddressID;
        oAdd.Address1 = txtAddress1.Text;
        oAdd.Address2 = txtAddress2.Text;
        oAdd.City = txtCity.Text;
        oAdd.ZipCode = txtZipCode.Text;
        oAdd.StateID = int.Parse(ddlState.SelectedValue);
        memberAddressID = SaveAddress(oAdd);

        Client _client = new Client();
        _client.BusinessName = txtBusinessName.Text;
        _client.BusinessPhone = txtBusinessPhone.Text;
        _client.AddressID = clientAddressID;
        _client.BusinessEmail = txtBusinessEmail.Text;
        _client.BusinessFax = txtBusinessFax.Text;
        _client.HomePhone = txtBusinessHomePhone.Text;
        _client.FirstName = txtCoFirstName.Text;
        _client.LastName = txtCoLastName.Text;
        clientID = SaveClient(_client);

        Member _member = new Member();
        _member.FirstName = txtFirstName.Text;
        _member.LastName = txtLastName.Text;
        _member.AddressID = memberAddressID;
        _member.CellPhone = txtCellPhone.Text;
        _member.HomePhone = txtHomePhone.Text;
        _member.Fax = txtFax.Text;
        _member.Email = txtEmail.Text;
        memberID = SaveMember(_member);

        Order _order = new Order();
        _order.ClientID = clientID;
        _order.MemberID = memberID;
        _order.OrderDate = DateTime.Now;
        _order.CenterID = int.Parse(ddlCenter.SelectedValue);
        _order.OrderID = 0;
        _order.OrderAmount = totalAmount;
        _order.BankName = txtBankName.Text;
        _order.CheckDate = DateTime.Now;
        _order.CheckNo = txtCheckNo.Text;

        _order.ProjectYear = int.Parse(Session["PROJECTYEAR"].ToString());

        if (txtBankAmount.Text != "")
        {
            _order.BankAmount = double.Parse(txtBankAmount.Text);
        }
        else
            _order.BankAmount = 0.0;


        int orderID = SaveOrder(_order);

        //_order.OrderStatusID = "PENDING";

        // remove any order detail first before adding new ones.
        OrderDetails odObject = new OrderDetails();

        odObject.DeleteOrderDetailByOrderID(orderID);

        if (totalAmount > 0)
        {
            foreach (ProductOrder pr in productOrderList)
            {
                OrderDetails _orderDetails = new OrderDetails();
                //_orderDetails.OrderDetailID = pr.OrderDetailID;
                _orderDetails.OrderDetailID = -1;
                _orderDetails.OrderID = orderID;
                _orderDetails.ProductID = pr.ProductID;
                _orderDetails.Rate = pr.ProductRate;
                _orderDetails.ProductAdditionalRateID = pr.ProductAdditionalRateID;
                _orderDetails.OrderAdditionalAmount = pr.ProductAdditionalRate;
                _orderDetails.ProductQty = pr.Quantity;
                _orderDetails.OrderAmount = pr.Amount;
                _orderDetails.ProductRateID = pr.ProductRateID;

                OrderID = SaveOrderDetails(_orderDetails);
            }

        }

        return true;

    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Session.Remove("PRODUCTLIST");

            //Session["PRODUCTLIST"] = null;
            Initialize();
        }

        if (Request.QueryString["id"] != null)
        {
            try
            {
                int orderID = Convert.ToInt16(Request.QueryString["id"].ToString());

                if (!IsPostBack)
                {
                    // pre-populate data - client data
                    OrderDetails odObject = new OrderDetails();
                    DataTable dtClient = odObject.getClientDetailByOrderID(orderID);

                    Page.Title = string.Format("Edit Order");

                    if (dtClient.Rows.Count > 0)
                    {
                        txtBusinessName.Text = dtClient.Rows[0]["BusinessName"].ToString().Trim();
                        txtCoFirstName.Text = dtClient.Rows[0]["FirstName"].ToString().Trim();
                        txtCoLastName.Text = dtClient.Rows[0]["LastName"].ToString().Trim();
                        txtBusinessAddress1.Text = dtClient.Rows[0]["Address1"].ToString().Trim();
                        txtBusinessAddress2.Text = dtClient.Rows[0]["Address2"].ToString().Trim();
                        txtBusinessCity.Text = dtClient.Rows[0]["City"].ToString().Trim();
                        ddlBusinessState.Text = dtClient.Rows[0]["StateID"].ToString().Trim();
                        txtBusinessZipCode.Text = dtClient.Rows[0]["ZipCode"].ToString().Trim();
                        txtBusinessHomePhone.Text = dtClient.Rows[0]["HomePhone"].ToString().Trim();
                        txtBusinessPhone.Text = dtClient.Rows[0]["BusinessPhone"].ToString().Trim();
                        txtBusinessFax.Text = dtClient.Rows[0]["BusinessFax"].ToString().Trim();
                        txtBusinessEmail.Text = dtClient.Rows[0]["BusinessEmail"].ToString().Trim();
                        hdfClientID.Value = dtClient.Rows[0]["ClientID"].ToString().Trim();
                        hdfOrderID.Value = dtClient.Rows[0]["OrderID"].ToString().Trim();
                        hdfMemberID.Value = dtClient.Rows[0]["MemberID"].ToString().Trim();
                        
                       hdfClientAddressID.Value = dtClient.Rows[0]["AddressID"].ToString().Trim();
                        
                        
                        //AddressID
                    }

                    // pre-populate data - Member/Kayakar data
                    DataTable dtMember = odObject.getMemberDetailByOrderID(orderID);

                    if (dtMember.Rows.Count > 0)
                    {
                        txtFirstName.Text = dtMember.Rows[0]["FirstName"].ToString().Trim();
                        txtLastName.Text = dtMember.Rows[0]["LastName"].ToString().Trim();
                        txtAddress1.Text = dtMember.Rows[0]["Address1"].ToString().Trim();
                        txtAddress2.Text = dtMember.Rows[0]["Address2"].ToString().Trim();

                        txtCity.Text = dtMember.Rows[0]["City"].ToString().Trim();
                        ddlState.Text = dtMember.Rows[0]["StateID"].ToString().Trim();
                        txtZipCode.Text = dtMember.Rows[0]["ZipCode"].ToString().Trim();

                        txtHomePhone.Text = dtMember.Rows[0]["HomePhone"].ToString().Trim();
                        txtCellPhone.Text = dtMember.Rows[0]["CellPhone"].ToString().Trim();
                        txtFax.Text = dtMember.Rows[0]["Fax"].ToString().Trim();
                        txtEmail.Text = dtMember.Rows[0]["Email"].ToString().Trim();
                        hdfMemberAddressID.Value = dtMember.Rows[0]["AddressID"].ToString().Trim();
                    }

                    // pre-populate data - order detail data
                    DataTable dtClientOrderDT = odObject.getClientOrderDetailByOrderID(orderID);

                    if (dtClientOrderDT.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dtClientOrderDT.Rows)
                        {
                            ProductOrder po = new ProductOrder();
                            po.OrderDetailID = Convert.ToInt16(dr["OrderDetailID"].ToString());
                            po.SequenceNo = Convert.ToInt16(dr["SequenceNo"].ToString());
                            po.OrderProductID = Convert.ToInt16(dr["OrderProductID"].ToString());
                            po.ProductID = Convert.ToInt16(dr["ProductID"].ToString());
                            po.ProductDescription = dr["ProductDescription"].ToString();
                            po.ProductRateID = Convert.ToInt16(dr["ProductRateID"].ToString());
                            po.ProductRate = Convert.ToDouble(dr["ProductRate"].ToString());
                            po.ProductTypeID = Convert.ToInt16(dr["ProductTypeID"].ToString());
                            po.ProductTypeDescription = dr["ProductTypeDescription"].ToString();
                            po.Quantity = Convert.ToDouble(dr["Quantity"].ToString());
                            po.Amount = Convert.ToDouble(dr["Amount"].ToString());
                            productOrderList.Add(po);
                        }
                        Session.Add("PRODUCTLIST", productOrderList);
                        grdPendingOrder.DataSource = productOrderList;
                        grdPendingOrder.DataBind();
                    }
                    else
                    {
                        Session.Add("PRODUCTLIST", null);
                    }

                    // pre-populate data - order detail infomation
                    DataTable dtOrderDetails = odObject.getOrderDetailByOrderID(orderID);

                    if (dtOrderDetails.Rows.Count > 0)
                    {
                        txtBankName.Text = dtOrderDetails.Rows[0]["BankName"].ToString().Trim();
                        txtBankAmount.Text = dtOrderDetails.Rows[0]["BankAmount"].ToString().Trim();
                        txtCheckNo.Text = dtOrderDetails.Rows[0]["CheckNo"].ToString().Trim();
                    }
                    
                }

            }
            catch
            {
                // deal with it
            }
        }
    }

    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetProductPrice();
    }

    protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetProductPrice();
    }

    protected void txtQuantity_TextChanged(object sender, EventArgs e)
    {
        GetProductPrice();
    }

    protected void btnCheckOut_Click(object sender, EventArgs e)
    {
        bool flag = false;

        flag = SetRecord();

        if (flag)
            Response.Redirect("dsp_ViewOrders.aspx", true);


    }

    protected void btnAddOrder_Click(object sender, EventArgs e)
    {
        int tempValue = 0;
        int productID = 0;
        int productSubTypeID = 0;
        double tempBankAmount = 0;
        double tempRes = 0;
        double productQTY = 0;
        int seqNo = 0;

        int.TryParse(txtSeqNo.Text, out seqNo);

        // validate for product id > 0
        int.TryParse(ddlProduct.SelectedValue, out productID);

        // validate for product sub type id > 0
        int.TryParse(ddlProductType.SelectedValue, out productSubTypeID);

        // validate for product qty > 0
        double.TryParse(txtQuantity.Text, out productQTY);

        if (productID <= 0)
        {
            lbMessage.Text = "Please select product.";
            return;
        }

        if (productSubTypeID <= 0)
        {
            lbMessage.Text = "Please select product sub type.";
            return;
        }

        if (productQTY <= 0)
        {
            lbMessage.Text = "Please enter product quantity.";
            return;
        }

        lbMessage.Text = "";


        if (Session["PRODUCTLIST"] != null)
        {
            productOrderList = (List<ProductOrder>)Session["PRODUCTLIST"];
        }

        if (seqNo > 0)
        {
            //ProductOrder po = new ProductOrder();
            foreach (ProductOrder po in productOrderList)
            {
                if (po.SequenceNo == seqNo)
                {
                    po.SequenceNo = seqNo;
                    po.OrderProductID = productOrderList.Count() + 1;
                    int.TryParse(ddlProduct.SelectedValue, out tempValue);
                    po.ProductID = tempValue;
                    po.ProductDescription = ddlProduct.SelectedItem.Text;
                    int.TryParse(txtRateID.Text, out tempValue);
                    po.ProductRateID = tempValue;
                    double.TryParse(txtRate.Text, out tempRes);
                    po.ProductRate = tempRes;
                    int.TryParse(ddlProductType.SelectedValue, out tempValue);
                    po.ProductTypeID = tempValue;
                    po.ProductTypeDescription = ddlProductType.SelectedItem.Text;
                    double.TryParse(txtQuantity.Text, out tempRes);
                    po.Quantity = tempRes;
                    double.TryParse(txtAmount.Text, out tempRes);
                    po.Amount = tempRes;
                    double.TryParse(txtBankAmount.Text, out tempBankAmount);
                    po.OrderDetailID = 0;
                    break;
                }
            }
        }
        else
        {
            ProductOrder po = new ProductOrder();
            po.SequenceNo = productOrderList.Count() + 1;
            po.OrderProductID = productOrderList.Count() + 1;
            int.TryParse(ddlProduct.SelectedValue, out tempValue);
            po.ProductID = tempValue;
            po.ProductDescription = ddlProduct.SelectedItem.Text;
            int.TryParse(txtRateID.Text, out tempValue);
            po.ProductRateID = tempValue;
            double.TryParse(txtRate.Text, out tempRes);
            po.ProductRate = tempRes;
            int.TryParse(ddlProductType.SelectedValue, out tempValue);
            po.ProductTypeID = tempValue;
            po.ProductTypeDescription = ddlProductType.SelectedItem.Text;
            double.TryParse(txtQuantity.Text, out tempRes);
            po.Quantity = tempRes;
            double.TryParse(txtAmount.Text, out tempRes);
            po.Amount = tempRes;
            double.TryParse(txtBankAmount.Text, out tempBankAmount);
            po.OrderDetailID = 0;

            productOrderList.Add(po);
        }

        // auto populate bank amount field
        if (tempBankAmount > 0)
        {
            tempBankAmount = tempBankAmount + tempRes;
        }
        else
        {
            tempBankAmount = tempRes;
        }

        lblTotalPayment.Text = tempBankAmount.ToString();

        Session.Add("PRODUCTLIST", productOrderList);
        grdPendingOrder.DataSource = productOrderList;
        grdPendingOrder.DataBind();

        //clear product details controls
        ClearControls();

    }

    private void ClearControls()
    {
        //Clear controls
        ddlProduct.SelectedIndex = 0;
        txtRateID.Text = string.Empty;
        txtRate.Text = string.Empty;
        ddlProductType.SelectedIndex = 0;
        txtQuantity.Text = string.Empty;
        txtAmount.Text = string.Empty;
        txtSeqNo.Text = string.Empty;
        txtAdditionRateID.Text = string.Empty;
    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        LinkButton lnkButton = (LinkButton)sender;
        TableCell tc = (TableCell)lnkButton.Parent;
        GridViewRow tr = (GridViewRow)tc.Parent;
        int seqNo = int.Parse(grdPendingOrder.DataKeys[tr.RowIndex]["SequenceNo"].ToString());
        List<ProductOrder> newProductList = new List<ProductOrder>();
        int counter = 0;
        if (Session["PRODUCTLIST"] != null)
        {
            productOrderList = (List<ProductOrder>)Session["PRODUCTLIST"];
        }
        foreach (ProductOrder po in productOrderList)
        {

            if (po.SequenceNo == seqNo)
            {
                //counter += 1;
                //po.SequenceNo = counter;
                newProductList.Add(po);
                //productOrderList.Remove(po);

            }
        }

        foreach (ProductOrder po in newProductList)
        {

            productOrderList.Remove(po);

        }

        Session.Remove("PRODUCTLIST");

        //     Session.Add("PRODUCTLIST", newProductList);
       // Session.Remove("PRODUCTLIST");
        Session.Add("PRODUCTLIST", productOrderList);

        if (productOrderList.Count <= 0)
        {
            Session["PRODUCTLIST"] = null;
        }

        grdPendingOrder.DataSource = productOrderList;
        grdPendingOrder.DataBind();
    }

    

    protected void grdPendingOrder_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            // get the orderID of the clicked row

            int productID = Convert.ToInt32(e.CommandArgument);

            // Delete the record 
            //DeleteRecordByOrderID(productID);


        }
    }

    protected void grdPendingOrder_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        int productID = Convert.ToInt16(grdPendingOrder.DataKeys[e.RowIndex].Value);

        //DeleteRecordByOrderID(productID);

        // refresh order view
        // BindData();
    }

    protected void grdPendingOrder_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {

    }

    public void DeleteRecordByProductID(int tempproductID)
    {
        if (tempproductID > 0)
        {
            Session.Remove("PRODUCTLIST");


        }
    }

    protected void grdPendingOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton l = (LinkButton)e.Row.FindControl("LinkButton1");
            l.Attributes.Add("onclick", "javascript:return " +
            "confirm('Are you sure you want to delete this record product ID: ( " +
            DataBinder.Eval(e.Row.DataItem, "productID") + " )')");
        }
    }

    //protected void btnEditSave_Click(object sender, EventArgs e)
    //{
    //    var businessName = "";

    //    //upEditUpdatePanel.Update();
    //    CloseDialog("editBusInfo", businessName);
    //}

    protected void btnCancelClient_Click(object sender, EventArgs e)
    {
        CancelDialog("editBusInfo");
    }

    protected void btnCancelKaryakar_Click(object sender, EventArgs e)
    {
        CancelKaryakarDialog("searchKaryakar");
    }


    private void CancelDialog(string dialogId)
    {
        string script = string.Format(@"closeDialog('{0}')", dialogId);
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), UniqueID, script, true);
    }

    private void CancelKaryakarDialog(string dialogId)
    {
        string script = string.Format(@"closeKaryakarDialog('{0}')", dialogId);
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), UniqueID, script, true);
    }

    /// <summary>
    /// Registers client script to close the dialog
    /// </summary>
    /// <param name="dialogId"></param>
    private void CloseDialog(string dialogId, string businessName)
    {
        string script = string.Format(@"closeDialog('{0}','{1}')", dialogId, businessName);
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), UniqueID, script, true);
    }

    private void closeKaryakarDialog(string dialogId)
    {
        string script = string.Format(@"closeKaryakarDialog('{0}')", dialogId);
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), UniqueID, script, true);
    }

    private void ClearCheckBoxes()
    {

        foreach (GridViewRow row in gvClientData.Rows)
        {

            CheckBox ch = (CheckBox)row.FindControl("chkClientID");

            ch.Checked = false;

            row.BackColor = System.Drawing.Color.Transparent;

        }

    }

    private void ClearKaryakarCheckBoxes()
    {

        foreach (GridViewRow row in gvKaryakarData.Rows)
        {

            CheckBox ch = (CheckBox)row.FindControl("chkMemberID");

            ch.Checked = false;

            row.BackColor = System.Drawing.Color.Transparent;

        }

    }

    protected void chkSelectClient_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkbox = (CheckBox)sender;
        GridViewRow gdrow = (GridViewRow)checkbox.NamingContainer;

        ClearCheckBoxes();

        checkbox.Checked = true;

        GridViewRow row = (GridViewRow)checkbox.NamingContainer;


        if (((CheckBox)gdrow.FindControl("chkClientID")).Checked)
        {
            gdrow.BackColor = System.Drawing.Color.Yellow;

            populateClientInformation();
        }
        else
        {
            gdrow.BackColor = System.Drawing.Color.Transparent;
        }
    }

    protected void chkSelectKaryakar_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkbox = (CheckBox)sender;
        GridViewRow gdrow = (GridViewRow)checkbox.NamingContainer;

        ClearKaryakarCheckBoxes();

        checkbox.Checked = true;

        GridViewRow row = (GridViewRow)checkbox.NamingContainer;


        if (((CheckBox)gdrow.FindControl("chkMemberID")).Checked)
        {
            gdrow.BackColor = System.Drawing.Color.Yellow;

            populateKaryakarInformation();
        }
        else
        {
            gdrow.BackColor = System.Drawing.Color.Transparent;
        }
    }

    protected void gvClientData_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
        {

            // when mouse is over the row, save original color to new attribute, and change it to highlight color
            e.Row.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#BF8630';this.style.cursor='pointer';");

            // when mouse leaves the row, change the bg color to its original value  
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.originalstyle;");


        }
    }

    protected void gvKaryakarData_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
        {

            // when mouse is over the row, save original color to new attribute, and change it to highlight color
            e.Row.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#BF8630';this.style.cursor='pointer';");

            // when mouse leaves the row, change the bg color to its original value  
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.originalstyle;");


        }
    }

    public void BindClientData()
    {

        string businessName = "";
        string firstname = "";
        string lastname = "";
        string cityname = "";


        businessName = txtBusName.Text.ToString().Trim();
        firstname = txtContactFirstName.Text.ToString().Trim();
        lastname = txtContactLastName.Text.ToString().Trim();
        cityname = txtCityName.Text.ToString().Trim();

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(DBCommon.ConnectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "searchClientDetail";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(
        mySqlCommand.Parameters.Add("@userid", SqlDbType.VarChar, 100).Value = Session["USERID"];
        mySqlCommand.Parameters.Add("@businessname", SqlDbType.VarChar, 50).Value = ((businessName.Length == 0) ? DBNull.Value.ToString() : businessName.ToString());
        mySqlCommand.Parameters.Add("@firstname", SqlDbType.VarChar, 50).Value = ((firstname.Length == 0) ? DBNull.Value.ToString() : firstname.ToString());
        mySqlCommand.Parameters.Add("@lastname", SqlDbType.VarChar, 50).Value = ((lastname.Length == 0) ? DBNull.Value.ToString() : lastname.ToString());
        mySqlCommand.Parameters.Add("@cityname", SqlDbType.VarChar, 50).Value = ((cityname.Length == 0) ? DBNull.Value.ToString() : cityname.ToString());

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        // create a SqlDataAdapter object
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();

        // set the SelectCommand property of the SqlAdapter object
        // to the SqlCommand object
        mySqlDataAdapter.SelectCommand = mySqlCommand;

        // create a DataSet object to store the results of
        // the stored procedure call
        DataSet myDataSet = new DataSet();

        // use the Fill() method of the SqlDataAdapter object to
        // retrieve the rows from the stored procedure call,
        // storing the rows in a DataTable named Products
        mySqlDataAdapter.Fill(myDataSet, "clientDetail");

        // display the rows in the Products DataTable
        DataTable clientDetialDT = myDataSet.Tables["clientDetail"];


        gvClientData.DataSource = clientDetialDT;

        gvClientData.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();
    }

    public void BindKaryakarData()
    {

        string firstname = "";
        string lastname = "";
        string cityname = "";
        string email = "";

        firstname = txtKaryakarFirstName.Text.ToString().Trim();
        lastname = txtKaryakarLastName.Text.ToString().Trim();
        cityname = txtKaryakarCityName.Text.ToString().Trim();
        email = txtKaryakarEmail.Text.ToString().Trim();

        // create a SqlConnection object to connect to the
        // database, passing the connection string to the constructor
        SqlConnection mySqlConnection = new SqlConnection(DBCommon.ConnectionString);

        // formulate a string containing the name of the
        // stored procedure
        string procedureString = "searchMemberDetail";

        // create a SqlCommand object to hold the SQL statement
        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();

        // set the CommandText property of the SqlCommand object to
        // procedureString
        mySqlCommand.CommandText = procedureString;

        // set the CommandType property of the SqlCommand object
        // to CommandType.StoredProcedure
        mySqlCommand.CommandType = CommandType.StoredProcedure;

        // SqlParameter mySQLParameter = new SqlParameter(
        mySqlCommand.Parameters.Add("@userid", SqlDbType.VarChar, 100).Value = Session["USERID"];
        mySqlCommand.Parameters.Add("@firstname", SqlDbType.VarChar, 50).Value = ((firstname.Length == 0) ? DBNull.Value.ToString() : firstname.ToString());
        mySqlCommand.Parameters.Add("@lastname", SqlDbType.VarChar, 50).Value = ((lastname.Length == 0) ? DBNull.Value.ToString() : lastname.ToString());
        mySqlCommand.Parameters.Add("@cityname", SqlDbType.VarChar, 50).Value = ((cityname.Length == 0) ? DBNull.Value.ToString() : cityname.ToString());
        mySqlCommand.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = ((email.Length == 0) ? DBNull.Value.ToString() : email.ToString());

        // open the database connection using the
        // Open() method of the SqlConnection object
        mySqlConnection.Open();

        // run the stored procedure
        mySqlCommand.ExecuteNonQuery();

        // create a SqlDataAdapter object
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();

        // set the SelectCommand property of the SqlAdapter object
        // to the SqlCommand object
        mySqlDataAdapter.SelectCommand = mySqlCommand;

        // create a DataSet object to store the results of
        // the stored procedure call
        DataSet myDataSet = new DataSet();

        // use the Fill() method of the SqlDataAdapter object to
        // retrieve the rows from the stored procedure call,
        // storing the rows in a DataTable named Products
        mySqlDataAdapter.Fill(myDataSet, "MemberDetail");

        // display the rows in the Products DataTable
        DataTable MemberDetialDT = myDataSet.Tables["MemberDetail"];


        gvKaryakarData.DataSource = MemberDetialDT;

        gvKaryakarData.DataBind();

        // close the database connection using the Close() method
        // of the SqlConnection object
        mySqlConnection.Close();
    }


    protected void btnSearchClient_Click(object sender, EventArgs e)
    {

        BindClientData();

    }

    protected void btnSearchKaryakar_Click(object sender, EventArgs e)
    {

        BindKaryakarData();

    }

    protected void btnCloseClient_Click(object sender, EventArgs e)
    {

        populateClientInformation();
    }

    protected void btnCloseKaryakar_Click(object sender, EventArgs e)
    {

        populateKaryakarInformation();
    }

    protected void populateClientInformation()
    {
        //
        foreach (GridViewRow dr in gvClientData.Rows)
        {
            CheckBox chk = dr.Cells[0].FindControl("chkClientID") as CheckBox;
            if (chk.Checked)
            {

                Label lblAddressId = dr.Cells[0].FindControl("lblAddressId") as Label;
                Label lblClientId = dr.Cells[0].FindControl("lblClientId") as Label;

                if (lblAddressId != null)
                {

                    Label lblStateID = dr.Cells[0].FindControl("StateID") as Label;

                    txtBusinessName.Text = dr.Cells[1].Text; // business name
                    txtCoFirstName.Text = dr.Cells[2].Text; // first name
                    txtCoLastName.Text = dr.Cells[3].Text;   // last name

                    //txtBusinessAddress1.Text = dr.Cells[6].Text; // businessaddress
                    txtBusinessAddress1.Text = dr.Cells[4].Text; // address1
                    txtBusinessAddress2.Text = dr.Cells[5].Text; // address2

                    // ddlBusinessState
                    txtBusinessCity.Text = dr.Cells[6].Text; // city
                    ddlBusinessState.Text = lblStateID.Text; // state code
                    txtBusinessZipCode.Text = dr.Cells[7].Text; // zipcode
                    txtBusinessPhone.Text = dr.Cells[8].Text; // business phone

                    txtBusinessHomePhone.Text = dr.Cells[9].Text; // home phone

                    txtBusinessFax.Text = dr.Cells[10].Text; // business fax
                    txtBusinessEmail.Text = dr.Cells[11].Text; // business emai

                    hdfClientID.Value = lblClientId.Text;
                    hdfAddressID.Value = lblAddressId.Text;
                    hdfClientAddressID.Value = lblAddressId.Text;

                    var addressID = "";
                    addressID = lblAddressId.Text;

                    // update panel
                    upBusinessInfo.Update();

                    //reset
                    txtBusName.Text = string.Empty;
                    txtCityName.Text = string.Empty;
                    txtContactFirstName.Text = string.Empty;
                    txtContactLastName.Text = string.Empty;
                    gvClientData.DataSource = null;
                    gvClientData.DataBind();
                }



            }
        }

        CloseDialog("editBusInfo", "");
    }

    protected void populateKaryakarInformation()
    {
        //
        foreach (GridViewRow dr in gvKaryakarData.Rows)
        {
            CheckBox chk = dr.Cells[0].FindControl("chkMemberID") as CheckBox;
            if (chk.Checked)
            {

                Label lblAddressId = dr.Cells[0].FindControl("lblAddressId") as Label;
                Label lblMemberID = dr.Cells[0].FindControl("lblMemberID") as Label;

                if (lblAddressId != null && lblMemberID != null)
                {

                    Label lblStateID = dr.Cells[0].FindControl("StateID") as Label;

                    txtFirstName.Text = dr.Cells[1].Text; // first name
                    txtLastName.Text = dr.Cells[2].Text;   // last name
                    txtAddress1.Text = dr.Cells[3].Text; // address1
                    txtAddress2.Text = dr.Cells[4].Text; // address2
                    txtCity.Text = dr.Cells[5].Text; // city
                    ddlState.Text = lblStateID.Text; // state code
                    txtZipCode.Text = dr.Cells[6].Text; // zipcode
                    txtHomePhone.Text = dr.Cells[7].Text; // business phone
                    txtCellPhone.Text = dr.Cells[8].Text; // business fax
                    txtFax.Text = dr.Cells[9].Text; // business fax
                    txtEmail.Text = dr.Cells[10].Text; // business emai

                    hdfMemberID.Value = lblMemberID.Text;
                    hdfMemberAddressID.Value = lblAddressId.Text;

                    var addressID = "";
                    addressID = lblAddressId.Text;

                    // update panel
                    upBusinessInfo.Update();

                    //reset
                    txtKaryakarFirstName.Text = string.Empty;
                    txtKaryakarLastName.Text = string.Empty;
                    txtKaryakarCityName.Text = string.Empty;
                    

                    gvKaryakarData.DataSource = null;
                    gvKaryakarData.DataBind();
                }



            }
        }

        closeKaryakarDialog("searchKaryakar");
    }

    protected void gvClientData_PageIndexChanging(Object sender, GridViewPageEventArgs e)
    {
        gvClientData.PageIndex = e.NewPageIndex;
        BindClientData();
    }

    protected void gvKaryakarData_PageIndexChanging(Object sender, GridViewPageEventArgs e)
    {
        gvKaryakarData.PageIndex = e.NewPageIndex;
        BindKaryakarData();
    }

    protected void gvClientData_OnSorting(object sender, GridViewSortEventArgs e)
    {

        DataTable dataTable = gvClientData.DataSource as DataTable;

        if (dataTable != null)
        {
            DataView dataView = new DataView(dataTable);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvClientData.DataSource = dataView;
            BindClientData();
        }
    }

    protected void gvKaryakarData_OnSorting(object sender, GridViewSortEventArgs e)
    {

        DataTable dataTable = gvKaryakarData.DataSource as DataTable;

        if (dataTable != null)
        {
            DataView dataView = new DataView(dataTable);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvKaryakarData.DataSource = dataView;
            BindKaryakarData();
        }
    }

    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }

        return newSortDirection;
    }
    protected void txtBusName_TextChanged(object sender, EventArgs e)
    {
        BindClientData();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("dsp_ViewOrders.aspx", true);
    }
}




