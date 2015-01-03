<%@ Page Title="Orders - Missing AD And Payment By Center " Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="rpt_MissingOrdersADPaymentByCenter.aspx.cs" Inherits="Admin_rpt_MissingOrdersADPaymentByCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">           
             
              .cssPager td
            {
                  padding-left: 4px;     
                  padding-right: 4px;    
              }
        </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
<table style="width: 100%">
       
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <br />
                <h1>Orders - Missing AD And Payment By Center</h1>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td width="30%" style="text-align:left; vertical-align:top" align="left" nowrap="nowrap" valign="top" class="style1">
                            <strong>Select Project Year:</strong>
                            <asp:DropDownList ID="ddlbProjectYear" 
                                name="ddlbProjectYear"
                                runat="server" 
                                Font-Size="Smaller" 
                                AppendDataBoundItems="True"
                                AutoPostBack="True" 
                                DataTextField="ProjectYear"
                                DataValueField="ProjectYear"
                                OnSelectedIndexChanged="ddlbProjectYear_SelectedIndexChanged">
                                <asp:ListItem Value="-1">- - - Select Year  - - -</asp:ListItem>
                            </asp:DropDownList>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="run" runat="server" Text="Run Report" CssClass="btn" OnClick="run_Click" />
                            
                        </td>
                        <td align="right" style="vertical-align:top">
                            

                            <asp:ImageButton 
                                ID="imgBtnExcel" 
                                runat="server" ImageUrl="~/Images/excel.png" 
                                onclick="imgBtnExcel_Click" 
                                ToolTip="Click here to download order detail..." />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <asp:GridView ID="gv" runat="server" BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False" Width="100%" DataKeyNames="centerID"
                    CssClass="mGrid" EmptyDataText="No data in the data source." AllowPaging="True"
                    
                    OnPageIndexChanging="gv_PageIndexChanging"
                     AllowSorting="True"
                    ShowFooter="true" PageSize="25">
                    <PagerStyle CssClass="cssPager" />
                    <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                    <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                    <Columns>
                        <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                        <asp:BoundField DataField="RegionDescription" HeaderText="Region" />
                        <asp:BoundField DataField="CenterName" HeaderText="Center" />
                        <asp:TemplateField HeaderText="Calendar Coordinator Information">
                            <ItemTemplate>
                                <b>Name:</b> <%#Eval("cc_firstname") + " "%>
                                <%#Eval("cc_lastname") + "</br>"%>
                                <b>Cell Phone:</b> <%#Eval("cc_mobilephone") + "</br>"%>
                                <b>Home Phone:</b> <%#Eval("cc_homephone") + "</br>"%>
                            </ItemTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField HeaderText="Business Contact Information">
                            <ItemTemplate>
                                <b>Business Name:</b> <%#Eval("BusinessName") + "</br>"%>
                                <b>Name:</b> <%#Eval("FirstName") + " "%>
                                <%#Eval("lastname") + "</br>"%>
                                <b>Business Phone:</b> <%#Eval("BusinessPhone") + "</br>"%>
                                <b>Home Phone:</b> <%#Eval("HomePhone") + "</br>"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Calendar Type/Color">
                            <ItemTemplate>
                                 <%#Eval("ProductDescription") + "</br>"%>
                                 <%#Eval("Calendar_Type") + " "%>
                               </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductQty" HeaderText="Quantity" />
                        <asp:BoundField DataField="Invoice_Amount" HeaderText="Invoice Amount" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="PaymentReceived" HeaderText="Payment Received ?" />
                        <asp:BoundField DataField="ADReceived" HeaderText="AD Received ?" />
                     </Columns>
                     <EmptyDataTemplate>
                        <table>
                            <tr>
                                <td>
                                     There aren't any orders missing for selected center criteria.
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>
       
    </table>
</asp:Content>

