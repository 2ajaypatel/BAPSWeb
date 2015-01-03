<%@ Page Title="Order Summary By Center" Language="C#" MasterPageFile="~/Designer/Designer.master" AutoEventWireup="true" CodeFile="dsp_ViewOrders.aspx.cs" Inherits="Designer_SearchOrderByCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            height: 28px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">

<table style="width:100%" >
   
    <tr>
        <td style="text-align:center; vertical-align:top">
          <h1>Order Summary</h1>
        </td>
    </tr>
     <tr>
        <td  >
            

             <table align="center"  style="width:100%">
                <tr>
                    <td width="30%" style="text-align:left; vertical-align:top" align="left" nowrap="nowrap" valign="top" class="style1">
                        Select Center Name: &nbsp; 
                        <asp:DropDownList 
                            ID="ddlbCenter" 
                            runat="server" 
                            Font-Size="Smaller" 
                            AppendDataBoundItems="True" 
                            AutoPostBack="True"
                            DataSourceID="sdCenterList" 
                            DataTextField="CenterName" 
                            DataValueField="CenterID" 
                            onselectedindexchanged="ddlbCenter_SelectedIndexChanged">
                            <asp:ListItem Value="-1">- - - Select Center Name - - -</asp:ListItem>
                            <asp:ListItem Value="0">All</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right" style="vertical-align:top">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/excel.png" onclick="imgBtnExcel_Click" ToolTip="Click here to download order detail..." />
                    </td>
                </tr>
            </table>
         
            </td>
            
    </tr>
     <tr>
        <td style="text-align:center; vertical-align:top" align="center" valign="top">

            <asp:GridView ID="gv" 
                        runat="server" 
                        BackColor="White" 
                        CellPadding="5" 
                        AutoGenerateColumns="False"
                         BorderColor="#2E2842" 
                        BorderStyle="Solid" 
                        BorderWidth="1px"
                        Width="100%"
                        OnRowCommand="gv_RowCommand" 
                        OnRowDeleting="gv_RowDeleting"
                        OnRowDeleted="gv_RowDeleted"
                        DataKeyNames="orderID,ClientID"
                        CssClass="mGrid" 
                        emptydatatext="No data in the data source."
                        AllowPaging="True" 
                        onpageindexchanging="gv_PageIndexChanging" 
                        OnRowDataBound="gv_RowDataBound"
                        OnSorting="gv_Sorting" 
                        AllowSorting="True" PageSize="25">

                <emptydatarowstyle backcolor="LightBlue" forecolor="Red"/>

                 <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                
                 <Columns>
                    <asp:CommandField ShowSelectButton="True" 
                        SelectText="<img src='../Images/detail.png' border=0 title='Click here to see detail orders.'>">
                    </asp:CommandField>
                     
                      <asp:HyperLinkField 
                                DataNavigateUrlFields="OrderID" 
                                DataNavigateUrlFormatString="dsp_UploadAdvertisement.aspx?id={0}"
                            
                               Text="<img src='../Images/uploaddownload.png' border='0' title='Click here to upload advertisement.' />" 
                            />

                     <asp:HyperLinkField 
                                DataNavigateUrlFields="OrderID" 
                                DataNavigateUrlFormatString="dsp_AuditNotes.aspx?id={0}"
                                Text="<img src='../Images/notes.png' border='0' title='Click here to add/edit Audit Notes.' />" 
                            />
  
                     <asp:HyperLinkField DataNavigateUrlFields="OrderID" DataNavigateUrlFormatString="dsp_ChangeOrderStatus.aspx?id={0}"
                            Text="<img src='../Images/status.png' border='0' title='Click here to change order status.' />" />
                   <asp:BoundField DataField="OrderID" HeaderText="Order ID" SortExpression="OrderID"/>
                   <asp:BoundField DataField="centerid" HeaderText="Center ID" SortExpression="centerid" Visible="false" />
                   <asp:BoundField DataField="centername" HeaderText="Center Name" SortExpression="centername" />
                   <asp:BoundField DataField="BusinessName" HeaderText="Sponser Business Name" SortExpression="BusinessName" />
                   
                    <asp:TemplateField HeaderText="Product">
                            <ItemTemplate>
                                <%#Eval("product") + " "%>
                                <%#Eval("calendarType") + "</br>" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                   <asp:BoundField DataField="template" HeaderText="Template"   />
                   <asp:BoundField DataField="ClientID" HeaderText="Client ID" Visible="false"  />
                   <asp:BoundField DataField="MemberID" HeaderText="Member ID" Visible="false"  />
                   <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" />
                   <asp:BoundField DataField="OrderAmount" HeaderText="Order Amount" DataFormatString="{0:c}" SortExpression="OrderAmount" Visible="false" />
                   <asp:BoundField DataField="adminstatus" HeaderText="Admin Status" SortExpression="adminstatus" />
                   <asp:BoundField DataField="designstatus" HeaderText="Design Status" SortExpression="designstatus" />
                   
                   <asp:TemplateField HeaderText="Order Collecting Karyakar" SortExpression="firstname">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%#Eval("firstname")+ " " + Eval("lastname")%>' ></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                  </Columns>
              
            </asp:GridView>
         </td>
    </tr>
    <tr>
        <td style="text-align:center; vertical-align:top">&nbsp;</td>
    </tr>

    <tr>
        <td style="text-align:center; vertical-align:top">
            <table width="100%" border="0">
                <tr>
                    <td width="50%" height="50%" valign=top>
                        <asp:DetailsView ID="dvClient" runat="server"  Width="100%" 
                            AutoGenerateRows="False" BackColor="white" BorderColor="#2E2842" 
                            BorderWidth="1px" CellPadding="2" DataKeyNames="ClientID" 
                            DataSourceID="sdClientDetail" ForeColor="Black" GridLines="None" 
                            HeaderText="Client Details"  Font-Bold="False" CssClass="mGrid">

                             <AlternatingRowStyle BackColor="#E8E8E8" />

                            <CommandRowStyle HorizontalAlign="Center" />

                            <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue" 
                                HorizontalAlign="Right" />

                            <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />

                            <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />

                            <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#2E2842"  
                                HorizontalAlign="Center"  
                                Font-Size="Larger"
                                Font-Bold="true"  
                                />  

                            <RowStyle Height="25" /> 

                            <Fields>
                                 <asp:BoundField DataField="BusinessName" HeaderText="Business Name : " 
                                    SortExpression="BusinessName" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="LastName" HeaderText="Last Name : " 
                                    SortExpression="LastName" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="FirstName" HeaderText="First Name : " 
                                    SortExpression="FirstName" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="BusinessPhone" HeaderText="Business Phone : " 
                                    SortExpression="BusinessPhone" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="BusinessFax" HeaderText="Business Fax : " 
                                    SortExpression="BusinessFax" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="BusinessEmail" HeaderText="Business Email : " 
                                    SortExpression="BusinessEmail" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="HomePhone" HeaderText="Home Phone : " 
                                    SortExpression="HomePhone" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="Address1" HeaderText="Address1 : " 
                                    SortExpression="Address1" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="Address2" HeaderText="Address2 : " 
                                    SortExpression="Address2" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="City" HeaderText="City : " 
                                    SortExpression="City" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="ZipCode" HeaderText="Zip : " 
                                    SortExpression="ZipCode" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="StateDescription" HeaderText="State : " 
                                    SortExpression="StateDescription" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="ClientID" HeaderText="ClientID : " 
                                    SortExpression="ClientID" InsertVisible="False" ReadOnly="True" >
                                <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                
                            </Fields>
                            
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="sdClientDetail" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                            SelectCommand="SELECT Address.Address1,Address.Address2,Address.City,Address.StateID,Address.ZipCode,StateMaster.StateDescription,ClientMaster.ClientID, [BusinessName], ClientMaster.AddressID, [BusinessPhone], [BusinessFax], [BusinessEmail], [HomePhone], [LastName], [FirstName], [IsActive]  FROM [ClientMaster] ,[Address],[StateMaster] ,[OrderMaster]  WHERE OrderMaster.OrderID = @OrderID AND Address.AddressID = ClientMaster.AddressID AND Address.StateID = StateMaster.StateID AND OrderMaster.ClientID = ClientMaster.ClientID ">
                        
                            <SelectParameters>
                                 <asp:ControlParameter ControlID="gv" 
                                                    DefaultValue="-1" 
                                                    Name="OrderID" 
                                                    PropertyName="SelectedValue" 
                                                    Type="Int32" />
                             </SelectParameters>
                        </asp:SqlDataSource>


                    </td>
                     <td width="50%" height="50%" valign=top>


                        <asp:DetailsView ID="dvMemberDetail" runat="server" AutoGenerateRows="False" 
                            DataKeyNames="MemberID" DataSourceID="sdMemberDetail" 
                             Width="100%" 
                            BackColor="white" BorderColor="#2E2842" 
                            BorderWidth="1px" CellPadding="1"  
                            ForeColor="Black" GridLines="None" 
                            CssClass="mGrid"
                            HeaderText="Karyakar Details"  Font-Bold="False">

                            <AlternatingRowStyle BackColor="#E8E8E8" />
                            <CommandRowStyle HorizontalAlign="Center" />
                            <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                            <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />

                            <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#2E2842"  
                                HorizontalAlign="Center"  
                                Font-Size="Larger" 
                                Font-Bold="true"  
                                />  

                            <RowStyle Height="25" /> 

                            <Fields>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name :" 
                                    SortExpression="FirstName" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="LastName" HeaderText="Last Name : " 
                                    SortExpression="LastName" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="HomePhone" HeaderText="Home Phone : " 
                                    SortExpression="HomePhone" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="CellPhone" HeaderText="Cell Phone" 
                                    SortExpression="CellPhone" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="Fax" HeaderText="Fax : " SortExpression="Fax" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Email : " SortExpression="Email" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="Address1" HeaderText="Address1 : " 
                                    SortExpression="Address1" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>


                                <asp:BoundField DataField="Address2" HeaderText="Address2 : " 
                                    SortExpression="Address2" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="City" HeaderText="City : " SortExpression="City" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="StateDescription" HeaderText="State : " 
                                    SortExpression="StateDescription" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="ZipCode" HeaderText="Zip : " 
                                    SortExpression="ZipCode" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                               
                            </Fields>
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="sdMemberDetail" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                            SelectCommand="SELECT MemberMaster.FirstName, MemberMaster.LastName, MemberMaster.HomePhone, MemberMaster.CellPhone, MemberMaster.Fax, MemberMaster.Email, Address.Address1, Address.Address2, Address.City, StateMaster.StateDescription, Address.ZipCode, MemberMaster.MemberID, MemberMaster.AddressID, Address.StateID FROM Address , MemberMaster ,StateMaster, OrderMaster WHERE Address.AddressID = MemberMaster.AddressID AND Address.StateID = StateMaster.StateID AND OrderMaster.MemberID = MemberMaster.MemberID AND OrderMaster.orderid = @OrderID">

                            <SelectParameters>
                                 <asp:ControlParameter ControlID="gv" 
                                                    DefaultValue="-1" 
                                                    Name="OrderID" 
                                                    PropertyName="SelectedValue" 
                                                    Type="Int32" />
                             </SelectParameters>

                        </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdCenterList" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                SelectCommand="SELECT CenterID, CenterName FROM Center AS c WHERE (CenterID IN (SELECT DISTINCT CenterID FROM OrderMaster WITH (nolock))) ORDER BY CenterName">
            </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td width="50%" height="50%" valign=top>
                        <asp:DetailsView ID="dvOrderMaster" runat="server" AutoGenerateRows="False" 
                            DataKeyNames="OrderID" DataSourceID="sdOrderMaster" 
                            CssClass="mGrid"
                            Width="100%" 
                            Height="50px"
                            BackColor="white" BorderColor="#2E2842" 
                            BorderWidth="1px" CellPadding="2"  
                            ForeColor="Black" GridLines="None" 
                            HeaderText="Order Master"  Font-Bold="False">
                            <AlternatingRowStyle BackColor="#E8E8E8" />

                            <CommandRowStyle HorizontalAlign="Center" />

                            <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue" 
                                HorizontalAlign="Right" />

                            <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />

                            <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />

                            <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#2E2842"  
                                HorizontalAlign="Center"  
                                 Font-Size="Larger"
                                Font-Bold="true"  
                                />  

                            <RowStyle Height="25" /> 
                        
                            <Fields>
                                <asp:BoundField DataField="OrderDate" HeaderText="Order Date : " 
                                    SortExpression="OrderDate" DataFormatString="{0:d}" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="OrderAmount" HeaderText="Total Order Amount : " 
                                    SortExpression="OrderAmount" DataFormatString="{0:c}" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="BankName" HeaderText="Bank Name : " 
                                    SortExpression="BankName" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                  <asp:BoundField DataField="BankAmount" HeaderText="Bank Check Amount : " 
                                    SortExpression="BankAmount" DataFormatString="{0:c}" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="CheckDate" HeaderText="Check Date : " 
                                    SortExpression="CheckDate" DataFormatString="{0:d}" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="CheckNo" HeaderText="Check No : " 
                                    SortExpression="CheckNo" >
                                    <ControlStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                               
                            </Fields>
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="sdOrderMaster" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                            SelectCommand="SELECT [OrderID], [OrderDate], [OrderAmount], [BankName], [ClientID], [MemberID], [OrderStatus], [BankAmount], [CheckDate], [CheckNo], [CenterID] FROM [OrderMaster] WHERE OrderID = @OrderID ">
                        
                             <SelectParameters>
                                 <asp:ControlParameter ControlID="gv" 
                                                    DefaultValue="-1" 
                                                    Name="OrderID" 
                                                    PropertyName="SelectedValue" 
                                                    Type="Int32" />
                             </SelectParameters>
                        
                        </asp:SqlDataSource>
                    </td>
                    <td width="50%" height="50%" valign=top>
                         <asp:GridView ID="gvOrderDetail" 
                            runat="server" 
                            BackColor="White" 
                            BorderColor="#2E2842" 
                            BorderStyle="Solid" 
                            BorderWidth="1px" 
                            CellPadding="4" 
                            AutoGenerateColumns="False"
                            Width="100%"
                            CssClass="mGrid"
                            HeaderText="Order Detail" 
                            DataSourceID="sdOrderDetail">

                            <AlternatingRowStyle BackColor="#E8E8E8" />

                            <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                             <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#2E2842"  
                                HorizontalAlign="Center"  
                                 Font-Size="Larger"
                                Font-Bold="true"  
                                />  

                            <RowStyle Height="25" />

                        
                            <Columns>
                                <asp:BoundField DataField="ProductDescription" HeaderText="Product" 
                                    SortExpression="ProductDescription" />

                                <asp:BoundField DataField="ColorType" HeaderText="Type" ReadOnly="True" 
                                    SortExpression="ColorType" />

                                <asp:BoundField DataField="ProductQty" HeaderText="Qty" 
                                    SortExpression="ProductQty" />

                                <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" DataFormatString="{0:c}" />

                                <asp:BoundField DataField="cost" HeaderText="Cost" ReadOnly="True" 
                                    SortExpression="cost" DataFormatString="{0:c}" />

                                <asp:BoundField DataField="additionalCost" HeaderText="Addtional" 
                                    ReadOnly="True" SortExpression="additionalCost" DataFormatString="{0:c}" />

                                <asp:BoundField DataField="OrderAmount" HeaderText="Amount" 
                                    SortExpression="OrderAmount" DataFormatString="{0:c}" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdOrderDetail" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                            SelectCommand="SELECT pm.ProductDescription, CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS ColorType, od.ProductQty, od.Rate, od.ProductQty * od.Rate AS cost, od.OrderAmount - od.ProductQty * od.Rate AS additionalCost, od.OrderAmount FROM OrderDetails AS od INNER JOIN ProductMaster AS pm ON od.ProductID = pm.ProductID WHERE (od.OrderID = @OrderID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gv" DefaultValue="-1" Name="OrderID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                         <br />
                    </td>
                </tr>
            </table>
        
        </td>
    </tr>

</table>

</asp:Content>

