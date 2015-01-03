<%@ Page Title="Missing Orders By Center" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="rpt_MissingOrdersByCenter.aspx.cs" Inherits="Admin_rpt_MissingOrdersByCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
        .style1
        {
            height: 28px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
<table style="width: 100%">
       
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <br />
                <h1>Missing Orders By Center</h1>
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
                    ShowFooter="true">
                    <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                    <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                    <Columns>
                        <asp:BoundField DataField="RegionDescription" HeaderText="Region" />
                        <asp:BoundField DataField="CenterName" HeaderText="Center" />
                        <asp:TemplateField HeaderText="Calendar Coordinator">
                            <ItemTemplate>
                                <%#Eval("firstname") + " " %>
                                <%#Eval("lastname")  %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="mobilephone" HeaderText="Cell Phone" />
                         <asp:BoundField DataField="homephone" HeaderText="Home Phone" />
                        <asp:BoundField DataField="userid" HeaderText="Email" />
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

