<%@ Page Title="Order View Details By Center" Language="C#" MasterPageFile="~/Secure/Calendar.master"
    AutoEventWireup="true" CodeFile="OrderView.aspx.cs" Inherits="Secure_OrderView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/js/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
    
 <style type='text/css'>
    .hideGridColumn
    {
        display:none;
    }
 </style>

   <script type="text/javascript">
       $(document).ready(function () {

           $('a[id$=hlEditOrder]').qtip({
               content: 'Click here to edit order',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('img[id$=imgAuditNotes]').qtip({
               content: ' Click here view order audit notes history',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('img[id$=viewDetail]').qtip({
               content: ' Click here view order detail.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('img[id$=imgDelete]').qtip({
               content: ' Click here to delete order.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('a[id$=hlDesignEdit]').qtip({
               content: 'Click here to upload advertisement.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('img[id$=imgEditPayment]').qtip({
               content: ' Click here to edit order payment.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('img[id$=imgEditAuditNotes]').qtip({
               content: ' Click here to edit order audit notes.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('img[id$=imgChangeStatus]').qtip({
               content: ' Click here to change order status.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           
           
           
           
          


       });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <table style="width: 100%" align="center">
        <tr>
            <td style="text-align: center; vertical-align: top">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top">
                <b>Jay Swaminarayan Calendar Coordinator!</b><br />
                <%--<asp:Label ID="msgtemp             " runat="server" Text="Label"></asp:Label>--%>
            </td>
        </tr>
   
        <tr>
            <td style="text-align: center; vertical-align: top">
                <table align="center" style="width: 100%">
                    <tr>
                        <td width="30%" align="left" class="labelBoldRed">
                            <asp:HyperLink Target="_blank" Text='<img src="../Images/pdf1.png" border="0"  />'
                                runat="server" ID="HyperLink3" NavigateUrl="~/templateimg/Calendar Order Collection Form.pdf"></asp:HyperLink>
                            <br />
                            Click above to download Order Form
                            <br />
                        </td>
                        <td width="30%">
                            <h1>
                                Order Summary</h1>
                        </td>
                        <td align="right" width="30%" style="vertical-align: middle">
                            <%--  onclick="imgBtnPdf_Click" --%>
                            <asp:ImageButton ID="imgBtnExcel" runat="server" ImageUrl="~/Images/excel.png" OnClick="imgBtnExcel_Click"
                                ToolTip="Click here to download order detail..." />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <asp:GridView ID="gv" runat="server" BackColor="White" BorderColor="#2E2842" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False" Width="100%" OnRowDataBound="gv_RowDataBound"
                    OnRowCommand="gv_RowCommand" OnRowDeleting="gv_RowDeleting" OnRowDeleted="gv_RowDeleted"
                    DataKeyNames="orderID,ClientID" OnPageIndexChanging="gv_PageIndexChanging" OnSorting="gv_Sorting"
                    CssClass="mGrid" AllowPaging="True" AllowSorting="True" PageSize="15" 
                    onselectedindexchanged="gv_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="hlEditOrder" 
                                    runat="server" 
                                    Enabled='<%# (Eval("adminedit").Equals(1) ? true : false)%>'
                                    NavigateUrl='<%# Eval("OrderID", "OrderForm.aspx?id={0}") %>' 
                                    Text='<img src="../Images/write.png" border="0"  />'
                                    title='<%# (Eval("adminedit").Equals(1) ? "Click here to edit order"  : "Order edit not allowed. Check Status." )%>'
                                     >
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField  ShowSelectButton="True" SelectText="<img id='viewDetail' src='../Images/detail.png' border=0 title='Click here to see order detail .'>">
                        </asp:CommandField>

                        <asp:TemplateField ShowHeader="False">
                          <ItemTemplate>
                                <asp:LinkButton 
                                    ID="lnkButtonAuditNotes" 
                                    runat="server" 
                                    CausesValidation="False" 
                                    CommandName="viewaudit" 
                                    CommandArgument='<%# Eval("OrderID") %>' 
                                      >
                                    <asp:Image ID="imgAuditNotes" ImageUrl="../Images/report.gif" 
                                         runat="server" />
                            </asp:LinkButton>
                          </ItemTemplate>
                         </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnDelete" CommandArgument='<%# Eval("OrderID") %>' CommandName="Delete"
                                    runat="server">
                                    <asp:Image ID="imgDelete" ImageUrl='../Images/delete.gif' runat="server" border='0'
                                        title='Click here to delete order.' />
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="hlDesignEdit" runat="server" Enabled='<%# (Eval("designedit").Equals(1) ? true : false)%>'
                                    NavigateUrl='<%# Eval("OrderID", "dsp_UploadAdvertisement.aspx?id={0}") %>' Text='<img src="../Images/Upload-icon.png" border="0"  />'
                                    title='<%# (Eval("designedit").Equals(1) ? "Click here to upload advertisement."  : "Ad Upload is not allowed. Check Status." )%>'>

                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:HyperLinkField  DataNavigateUrlFields="OrderID" DataNavigateUrlFormatString="dsp_payment.aspx?id={0}"
                            Text="<img id='imgEditPayment' src='../Images/payment.png' border=0  >" >
                        </asp:HyperLinkField>
                        
                        <asp:HyperLinkField DataNavigateUrlFields="OrderID" DataNavigateUrlFormatString="../dsp_AuditNotes.aspx?id={0}"
                            Text="<img id='imgEditAuditNotes' src='../Images/notes.png' border='0' title='Click here to add/edit Audit Notes.' />" >
                        </asp:HyperLinkField>
                        
                        <asp:HyperLinkField DataNavigateUrlFields="OrderID" DataNavigateUrlFormatString="dsp_ChangeOrderStatus.aspx?id={0}"
                            Text="<img  id='imgChangeStatus' src='../Images/status.png' border='0' title='Click here to change order status.' />" >
                        </asp:HyperLinkField>

                        <asp:BoundField DataField="OrderID" HeaderText="Order ID" SortExpression="OrderID" />
                        <asp:BoundField DataField="ClientID" HeaderText="Client ID" Visible="false" />
                        <asp:BoundField DataField="MemberID" HeaderText="Member ID" Visible="false" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" />
                        <asp:BoundField DataField="OrderAmount" HeaderText="Order Amount" DataFormatString="{0:c}"
                            SortExpression="OrderAmount" />
                        <asp:BoundField DataField="adminstatus" HeaderText="Admin Status" SortExpression="adminstatus" />
                        <asp:BoundField DataField="designstatus" HeaderText="Design Status" SortExpression="designstatus" />
                        <asp:BoundField DataField="BusinessName" HeaderText="Sponser Business Name" SortExpression="BusinessName" />
                        <asp:TemplateField HeaderText="Order Collecting Karyakar" SortExpression="firstname">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("firstname")+ " " + Eval("lastname")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                       <%-- <asp:TemplateField >
                            <ItemTemplate>
                                <asp:HiddenField ID="hfAdminEdit" runat="server" Value='<%# Eval("adminedit") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hfDesignEdit" runat="server" Value='<%# Eval("designedit") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>--%>

                        <asp:BoundField DataField="adminedit" HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn" /> <%--column index 19 --%>
                        <asp:BoundField DataField="designedit" HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn" /> <%--column index 20 --%>
                        
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top">
                &nbsp;
            </td>
        </tr>
         <tr>
            <td style="text-align: center; vertical-align: top">
                <table width="100%" border="0">
                    <tr>
                        <td width="100%" valign="top">
                            <asp:GridView 
                                ID="gvAuditNotes" 
                                runat="server" 
                                BackColor="White" 
                                BorderColor="#2E2842" 
                                BorderStyle="Solid" 
                                CssClass="mGrid"
                                BorderWidth="1px" 
                                CellPadding="4" 
                                DataKeyNames="NoteID" 
                                AutoGenerateColumns="false" 

                                Width="100%" EmptyDataText="No record found.">

                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                                    <RowStyle Wrap="true" />  

                                <emptydatarowstyle backcolor="LightBlue" forecolor="Red"/>
                            <Columns>
            
                               <asp:BoundField DataField="NoteID" HeaderText="Note ID"  ItemStyle-Width="10" ItemStyle-HorizontalAlign="Center" />
                               <asp:BoundField DataField="OrderID" HeaderText="Order ID" ItemStyle-Width="10" ItemStyle-HorizontalAlign="Center" />
                               <asp:BoundField DataField="EnterDate" HeaderText="Enter Date" dataformatstring="{0:f}"   />
                                <asp:BoundField DataField="EnterBy" HeaderText="Enter By" />
                                <asp:BoundField DataField="statusname" HeaderText="Status" />
                                <asp:BoundField DataField="NoteTypeName" HeaderText="Note Type"  />
                
                              <asp:TemplateField HeaderText="Notes" SortExpression="Notes" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <div style="width: 240px; overflow: auto; word-break: break-all; word-wrap: break-word;
                                        height: 45px;">
                                        <%# Eval("Notes")%>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
             
                            </Columns>
                        </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top">
                <table width="100%" border="0">
                    <tr>
                        <td width="50%" height="50%" valign="top">
                            <asp:DetailsView ID="dvClient" runat="server" Width="100%" AutoGenerateRows="False"
                                BackColor="white" BorderColor="#2E2842" BorderWidth="1px" CellPadding="2" DataKeyNames="ClientID"
                                DataSourceID="sdClientDetail" ForeColor="Black" GridLines="None" HeaderText="Client Details"
                                Font-Bold="False" CssClass="mGrid">
                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                <CommandRowStyle HorizontalAlign="Center" />
                                <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue"
                                    HorizontalAlign="Right" />
                                <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                                <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                <HeaderStyle ForeColor="#FFFFCC" BackColor="#2E2842" HorizontalAlign="Center" Font-Size="Larger"
                                    Font-Bold="true" />
                                <RowStyle Height="25" />
                                <Fields>
                                    <asp:BoundField DataField="BusinessName" HeaderText="Business Name : " SortExpression="BusinessName">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name : " SortExpression="LastName">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name : " SortExpression="FirstName">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BusinessPhone" HeaderText="Business Phone : " SortExpression="BusinessPhone">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BusinessFax" HeaderText="Business Fax : " SortExpression="BusinessFax">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BusinessEmail" HeaderText="Business Email : " SortExpression="BusinessEmail">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="HomePhone" HeaderText="Home Phone : " SortExpression="HomePhone">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Address1" HeaderText="Address1 : " SortExpression="Address1">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Address2" HeaderText="Address2 : " SortExpression="Address2">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="City" HeaderText="City : " SortExpression="City">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ZipCode" HeaderText="Zip : " SortExpression="ZipCode">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StateDescription" HeaderText="State : " SortExpression="StateDescription">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ClientID" HeaderText="ClientID : " SortExpression="ClientID"
                                        InsertVisible="False" ReadOnly="True">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Fields>
                            </asp:DetailsView>
                            <asp:SqlDataSource ID="sdClientDetail" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
                                SelectCommand="SELECT Address.Address1,Address.Address2,Address.City,Address.StateID,Address.ZipCode,StateMaster.StateDescription,ClientMaster.ClientID, [BusinessName], ClientMaster.AddressID, [BusinessPhone], [BusinessFax], [BusinessEmail], [HomePhone], [LastName], [FirstName], [IsActive]  FROM [ClientMaster] ,[Address],[StateMaster] ,[OrderMaster]  WHERE OrderMaster.OrderID = @OrderID AND Address.AddressID = ClientMaster.AddressID AND Address.StateID = StateMaster.StateID AND OrderMaster.ClientID = ClientMaster.ClientID ">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" DefaultValue="-1" Name="OrderID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td width="50%" height="50%" valign="top">
                            <asp:DetailsView ID="dvMemberDetail" runat="server" AutoGenerateRows="False" DataKeyNames="MemberID"
                                DataSourceID="sdMemberDetail" Width="100%" BackColor="white" BorderColor="#2E2842"
                                CssClass="mGrid" BorderWidth="1px" CellPadding="1" ForeColor="Black" GridLines="None"
                                HeaderText="Karyakar Details" Font-Bold="False">
                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                <CommandRowStyle HorizontalAlign="Center" />
                                <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue"
                                    HorizontalAlign="Right" />
                                <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                                <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                <HeaderStyle ForeColor="#FFFFCC" BackColor="#2E2842" HorizontalAlign="Center" Font-Size="Larger"
                                    Font-Bold="true" />
                                <RowStyle Height="25" />
                                <Fields>
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name :" SortExpression="FirstName">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name : " SortExpression="LastName">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="HomePhone" HeaderText="Home Phone : " SortExpression="HomePhone">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CellPhone" HeaderText="Cell Phone" SortExpression="CellPhone">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Fax" HeaderText="Fax : " SortExpression="Fax">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Email" HeaderText="Email : " SortExpression="Email">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Address1" HeaderText="Address1 : " SortExpression="Address1">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Address2" HeaderText="Address2 : " SortExpression="Address2">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="City" HeaderText="City : " SortExpression="City">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StateDescription" HeaderText="State : " SortExpression="StateDescription">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ZipCode" HeaderText="Zip : " SortExpression="ZipCode">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Fields>
                            </asp:DetailsView>
                            <asp:SqlDataSource ID="sdMemberDetail" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
                                SelectCommand="SELECT MemberMaster.FirstName, MemberMaster.LastName, MemberMaster.HomePhone, MemberMaster.CellPhone, MemberMaster.Fax, MemberMaster.Email, Address.Address1, Address.Address2, Address.City, StateMaster.StateDescription, Address.ZipCode, MemberMaster.MemberID, MemberMaster.AddressID, Address.StateID FROM Address , MemberMaster ,StateMaster, OrderMaster WHERE Address.AddressID = MemberMaster.AddressID AND Address.StateID = StateMaster.StateID AND OrderMaster.MemberID = MemberMaster.MemberID AND OrderMaster.orderid = @OrderID">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" DefaultValue="-1" Name="OrderID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td width="50%" height="50%" valign="top">
                            <asp:DetailsView ID="dvOrderMaster" runat="server" AutoGenerateRows="False" DataKeyNames="OrderID"
                                DataSourceID="sdOrderMaster" Width="100%" Height="50px" BackColor="white" BorderColor="#2E2842"
                                BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" HeaderText="Order Master"
                                CssClass="mGrid" Font-Bold="False">
                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                <CommandRowStyle HorizontalAlign="Center" />
                                <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue"
                                    HorizontalAlign="Right" />
                                <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                                <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                <HeaderStyle ForeColor="#FFFFCC" BackColor="#2E2842" HorizontalAlign="Center" Font-Size="Larger"
                                    Font-Bold="true" />
                                <RowStyle Height="25" />
                                <Fields>
                                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date : " SortExpression="OrderDate"
                                        DataFormatString="{0:d}">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderAmount" HeaderText="Total Order Amount : " SortExpression="OrderAmount"
                                        DataFormatString="{0:c}">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BankName" HeaderText="Bank Name : " SortExpression="BankName">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BankAmount" HeaderText="Bank Check Amount : " SortExpression="BankAmount"
                                        DataFormatString="{0:c}">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CheckDate" HeaderText="Check Date : " SortExpression="CheckDate"
                                        DataFormatString="{0:d}">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CheckNo" HeaderText="Check No : " SortExpression="CheckNo">
                                        <ControlStyle Width="50%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Fields>
                            </asp:DetailsView>
                            <asp:SqlDataSource ID="sdOrderMaster" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
                                SelectCommand="SELECT [OrderID], [OrderDate], [OrderAmount], [BankName], [ClientID], [MemberID], [OrderStatus], [BankAmount], [CheckDate], [CheckNo], [CenterID] FROM [OrderMaster] WHERE OrderID = @OrderID ">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" DefaultValue="-1" Name="OrderID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td width="50%" height="50%" valign="top">
                            <asp:GridView ID="gvOrderDetail" runat="server" BackColor="White" BorderColor="#2E2842"
                                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False"
                                Width="100%" CssClass="mGrid" HeaderText="Order Detail" DataSourceID="sdOrderDetail">
                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                <HeaderStyle ForeColor="#FFFFCC" BackColor="#2E2842" HorizontalAlign="Center" Font-Size="Larger"
                                    Font-Bold="true" />
                                <RowStyle Height="25" />
                                <Columns>
                                    <asp:BoundField DataField="ProductDescription" HeaderText="Product" SortExpression="ProductDescription" />
                                    <asp:BoundField DataField="ColorType" HeaderText="Type" ReadOnly="True" SortExpression="ColorType" />
                                    <asp:BoundField DataField="ProductQty" HeaderText="Qty" SortExpression="ProductQty" />
                                    <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" DataFormatString="{0:c}" />
                                    <asp:BoundField DataField="cost" HeaderText="Cost" ReadOnly="True" SortExpression="cost"
                                        DataFormatString="{0:c}" />
                                    <asp:BoundField DataField="additionalCost" HeaderText="Addtional" ReadOnly="True"
                                        SortExpression="additionalCost" DataFormatString="{0:c}" />
                                    <asp:BoundField DataField="OrderAmount" HeaderText="Amount" SortExpression="OrderAmount"
                                        DataFormatString="{0:c}" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdOrderDetail" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
                                SelectCommand="SELECT pm.ProductDescription, CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS ColorType, od.ProductQty, od.Rate, od.ProductQty * od.Rate AS cost, od.OrderAmount - od.ProductQty * od.Rate AS additionalCost, od.OrderAmount FROM OrderDetails AS od INNER JOIN ProductMaster AS pm ON od.ProductID = pm.ProductID WHERE (od.OrderID = @OrderID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" DefaultValue="-1" Name="OrderID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
