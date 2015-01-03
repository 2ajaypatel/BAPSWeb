<%@ Page Title="Unpaid Order Summary By Region/Center" Language="C#" MasterPageFile="~/Admin/Admin.master"
    AutoEventWireup="true" CodeFile="rpt_unpaidOrders.aspx.cs" Inherits="Admin_rpt_unpaidOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style3
        {
            width: 186px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="text-align: center; vertical-align: top">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="text-align: left; vertical-align: top" align="left" nowrap="nowrap" valign="top"
                            class="style3">
                            <strong>Select Region:</strong>
                            <asp:DropDownList ID="ddlbRegion" runat="server" Font-Size="Smaller" AppendDataBoundItems="True"
                                AutoPostBack="True" DataSourceID="sdRegionList" DataTextField="regionname" DataValueField="regionid"
                                OnSelectedIndexChanged="ddlbRegion_SelectedIndexChanged">
                                <asp:ListItem Value="-1">- - - Select Region Name - - -</asp:ListItem>
                                <asp:ListItem Value="0">All</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Select Center :</strong>
                            <asp:DropDownList ID="ddlbCenter" runat="server" Font-Size="Smaller" AppendDataBoundItems="True"
                                AutoPostBack="True" DataTextField="CenterName" DataValueField="CenterID">
                                <asp:ListItem Value="-1">- - - Select Center Name - - -</asp:ListItem>
                                <asp:ListItem Value="0">All</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="run" runat="server" Text="Run Report" CssClass="btn" OnClick="run_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnExcel" runat="server" OnClick="btnExcel_Click" Text="Export to Excel"
                                CssClass="btn" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <br />
                <b>Order Summary By Center</b>
                <br />
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <asp:GridView ID="gv" runat="server" BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False" Width="100%" DataKeyNames="centerID"
                    CssClass="mGrid" EmptyDataText="No data in the data source." AllowPaging="True"
                    OnPageIndexChanging="gv_PageIndexChanging" OnDataBound="gv_DataBound" AllowSorting="True"
                    ShowFooter="true">
                    <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                    <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                    <Columns>
                        <asp:BoundField DataField="Region" HeaderText="Region" />
                        <asp:BoundField DataField="CenterName" HeaderText="Center" />
                        <asp:TemplateField HeaderText="Karaykar Information">
                            <ItemTemplate>
                                <%#Eval("Karaykar_First_Name") + " " %>
                                <%#Eval("Karaykar_Last_Name") + "</br>" %>
                                <%#Eval("Karaykar_Cell_Phone") + "</br>"%>
                                <%#Eval("Karaykar_Home_Phone") + "</br>"%>
                                <%#Eval("Karaykar_Email") + "</br>"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Business Information">
                            <ItemTemplate>
                                <%#Eval("BusinessName") + "</br>"%>
                                <%#Eval("Client_First_Name") + " "%>
                                <%#Eval("Client_Last_Name") + "</br>"%>
                                <%#Eval("BusinessPhone") + "</br>"%>
                                <%#Eval("BusinessEmail") + "</br>"%>
                                <%#Eval("HomePhone") + "</br>"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductDescription" HeaderText="Product" />
                        <asp:BoundField DataField="Calendar_Type" HeaderText="Single/Multi Color" />
                        <asp:TemplateField HeaderText="Total Order Qty" FooterStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <asp:Label ID="lblOrderQty" Text='<%# Eval("orderedQty") %>' runat="server" Style="text-align: center;">
                                </asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotalOrderQty" runat="server" Style="text-align: center;"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Rate" HeaderText="Rate" DataFormatString="{0:c}" />
                        <asp:TemplateField HeaderText="Total Cost" FooterStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <asp:Label ID="lblCost" Text='<&#37;# DataBinder.Eval(Container.DataItem, "Cost", "{0:c}") %>'
                                    runat="server" Style="text-align: center;">
                                </asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblCost" runat="server" Style="text-align: center;"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Additional Cost" FooterStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <asp:Label ID="lblAdditional_Cost" Text='<&#37;# DataBinder.Eval(Container.DataItem, "Additional_Cost", "{0:c}") %>'
                                    runat="server" Style="text-align: center;">
                                </asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblAdditional_Cost" runat="server" Style="text-align: center;"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Order Amount" FooterStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <asp:Label ID="lblOrder_Amount" Text='<&#37;# DataBinder.Eval(Container.DataItem, "Order_Amount", "{0:c}") %>'
                                    runat="server" Style="text-align: center;">
                                </asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotalOrder_Amount" runat="server" Style="text-align: center;"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <table>
                            <tr>
                                <td>
                                    There aren't any unpaid orders for selected region/center criteria.
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top">
                <asp:SqlDataSource ID="sdCenterList" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
                    SelectCommand="SELECT CenterID, CenterName FROM Center AS c WHERE (CenterID IN (SELECT DISTINCT CenterID FROM OrderMaster WITH (nolock))) ORDER BY CenterName">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdRegionList" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
                    SelectCommand="SELECT regionid,ltrim(rtrim(regiondescription)) as regionname from regionmaster WHERE regionid < 7">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
