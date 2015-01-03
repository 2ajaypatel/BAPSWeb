<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="rpt_SearchOrderByCenter.aspx.cs" Inherits="Admin_SearchOrderByCenter" %>

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
         <td style="text-align:center; vertical-align:top">&nbsp;</td>
    </tr>
    <tr>
        <td style="text-align:left; vertical-align:top" align="left" nowrap="nowrap" 
            valign="top" class="style1" >
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
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp
             &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Button ID="btnExcel" runat="server" onclick="btnExcel_Click" 
                     Text="Export to Excel" CssClass="btn" />
            </td>
            <td>
    </tr>
    <tr>
        <td style="text-align:center; vertical-align:top" 
                        align="center" valign="top">
            <b>Order Summary</b></td>
    </tr>
   
     <tr>
        <td style="text-align:center; vertical-align:top" align="center" valign="top">



            <asp:GridView ID="gv" 
                        runat="server" 
                        BackColor="White" 
                        BorderColor="#CC9966" 
                        BorderStyle="Solid" 
                        BorderWidth="1px" 
                        CellPadding="4" 
                        AutoGenerateColumns="False"
                        Width="100%"
                        OnRowCommand="gv_RowCommand" 
                        OnRowDeleting="gv_RowDeleting"
                        OnRowDeleted="gv_RowDeleted"
                        DataKeyNames="orderID,ClientID"
                        CssClass="mGrid" 
                        AllowPaging="True" 
                        onpageindexchanging="gv_PageIndexChanging" AllowSorting="True">

                <AlternatingRowStyle BackColor="#E8E8E8" />

                <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />
                <HeaderStyle BackColor="#FF9900" Font-Bold="True" ForeColor="#FFFFCC" />
                
                 <Columns>
                    <asp:CommandField ShowSelectButton="True" 
                        SelectText="<img src='../Images/cubes.1.gif' border=0 title='Click here to see detail orders.'>">
                    </asp:CommandField>
                     
                      <asp:HyperLinkField 
                                DataNavigateUrlFields="OrderID" 
                                DataNavigateUrlFormatString="editAd.aspx?id={0}"
                                Target="_blank"
                                Text="<img src='../Images/color_wheel.png' border='0' title='Click here to add/edit advertisement.' />" 
                            />

                     <asp:TemplateField >
                         <ItemTemplate>
                           <asp:LinkButton  ID="LinkButton1" 
                                            CommandArgument='<%# Eval("OrderID") %>' 
                                            CommandName="Invoice" 
                                            runat="server">
                                            <asp:Image ID="Image1" src='../Images/invoice.jpg' runat="server" border='0' title='Click here to view invoice.' />
                             </asp:LinkButton>
                         </ItemTemplate>
                     </asp:TemplateField>

                    
                   
                   
                    <%--
                    <asp:HyperLinkField 
                       HeaderText="Edit Payment"
                       DataNavigateUrlFormatString="editPayment.aspx?id={0}"
                       DataNavigateUrlFields="OrderID"
                       Text="Edit Payment">
                    </asp:HyperLinkField>--%>

                   <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                   <asp:BoundField DataField="centerid" HeaderText="Center ID" />
                   <asp:BoundField DataField="centername" HeaderText="Center Name" />
                   <asp:BoundField DataField="ClientID" HeaderText="Client ID" Visible="false" />
                   <asp:BoundField DataField="MemberID" HeaderText="Member ID" Visible="false" />
                   <asp:BoundField DataField="OrderDate" HeaderText="Order Date" />
                   <asp:BoundField DataField="OrderAmount" HeaderText="Order Amount" DataFormatString="{0:c}" />
                   <asp:BoundField DataField="BusinessName" HeaderText="Sponser Business Name" />
                   <asp:TemplateField HeaderText="Order Collecting Karyakar">
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
                            AutoGenerateRows="False" BackColor="white" BorderColor="Tan" 
                            BorderWidth="1px" CellPadding="2" DataKeyNames="ClientID" 
                            DataSourceID="sdClientDetail" ForeColor="Black" GridLines="None" 
                            HeaderText="Client Details"  Font-Bold="False">

                             <AlternatingRowStyle BackColor="#E8E8E8" />

                            <CommandRowStyle HorizontalAlign="Center" />

                            <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue" 
                                HorizontalAlign="Right" />

                            <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />

                            <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />

                            <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#FF9900"  
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

                                <asp:BoundField DataField="ClientID" HeaderText="ClientID" 
                                    SortExpression="ClientID" InsertVisible="False" ReadOnly="True" />

                                
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
                            BackColor="white" BorderColor="Tan" 
                            BorderWidth="1px" CellPadding="1"  
                            ForeColor="Black" GridLines="None" 
                            HeaderText="Karyakar Details"  Font-Bold="False">

                            <AlternatingRowStyle BackColor="#E8E8E8" />

                            <CommandRowStyle HorizontalAlign="Center" />

                            <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue" 
                                HorizontalAlign="Right" />

                            <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />

                            <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />

                            <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#FF9900"  
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
                            Width="100%" 
                            Height="50px"
                            BackColor="white" BorderColor="Tan" 
                            BorderWidth="1px" CellPadding="2"  
                            ForeColor="Black" GridLines="None" 
                            HeaderText="Order Master"  Font-Bold="False">
                            <AlternatingRowStyle BackColor="#E8E8E8" />

                            <CommandRowStyle HorizontalAlign="Center" />

                            <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue" 
                                HorizontalAlign="Right" />

                            <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />

                            <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />

                            <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#FF9900"  
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
                            BorderColor="#CC9966" 
                            BorderStyle="Solid" 
                            BorderWidth="1px" 
                            CellPadding="4" 
                            AutoGenerateColumns="False"
                            Width="100%"
                            CssClass="mGrid"
                            HeaderText="Order Detail" 
                            DataSourceID="sdOrderDetail">

                            <AlternatingRowStyle BackColor="#E8E8E8" />

                            <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />
                             <HeaderStyle   
                                ForeColor="#FFFFCC"  
                                BackColor="#FF9900"  
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

