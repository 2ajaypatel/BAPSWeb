<%@ Page Title="Order & Advance By Region/Center" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="rpt_OrderAdvanceSummary.aspx.cs" Inherits="Admin_rpt_OrderAdvanceSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">

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
                                AutoPostBack="True" DataTextField="regionname" DataValueField="regionid"
                                OnSelectedIndexChanged="ddlbRegion_SelectedIndexChanged">
                                <asp:ListItem Value="-1">- - - Select Region Name - - -</asp:ListItem>
                                <asp:ListItem Value="0">All</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Select Center :</strong>
                            <asp:DropDownList ID="ddlbCenter" runat="server" Font-Size="Smaller" AppendDataBoundItems="True"
                                AutoPostBack="false" DataTextField="CenterName" DataValueField="CenterID">
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
                <b>Order & Advance Summary By Center</b>
                <br />
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                <asp:GridView ID="gv" runat="server" BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False" Width="100%" DataKeyNames="centerID"
                    CssClass="mGrid" EmptyDataText="No data in the data source." AllowPaging="True"
                    OnPageIndexChanging="gv_PageIndexChanging" OnRowDataBound="gv_RowDataBound"  AllowSorting="True" PageSize="50"
                    ShowFooter="true">
                    <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                    <%--<AlternatingRowStyle BackColor="#E8E8E8" />--%>
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                    <Columns>
                   
                        <asp:BoundField DataField="sortOrder" ItemStyle-Width="0" Visible="false" /> <%--column index 19 --%>
                       <%-- <asp:BoundField DataField="sr" HeaderText="SR." />--%>
                        <asp:BoundField DataField="OrderID" HeaderText="Order#" />
                        <asp:BoundField DataField="centername" HeaderText="Center/Zip" />
                        <asp:BoundField DataField="region" HeaderText="Region/State" />
                        <asp:BoundField DataField="BusinessName" HeaderText="Customer" />
                        <asp:BoundField DataField="sorderedQty" HeaderText="Single QTY" />
                        <asp:BoundField DataField="morderedQty" HeaderText="Multi QTY" />
                        <asp:BoundField DataField="Additional_Cost" HeaderText="Multi Color" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="StateTaxRate" HeaderText="Sale Tax(%)" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="taxRateAmount" HeaderText="Sale Tax Amount" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="Received_Amount" HeaderText="Received" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="balance" HeaderText="Balance" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="CheckNo" HeaderText="CheckNo" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="CheckDate" HeaderText="Check Date" />

                       
                    </Columns>
                    <EmptyDataTemplate>
                        <table>
                            <tr>
                                <td>
                                    There aren't any orders for selected region/center criteria.
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>

    </table>

</asp:Content>

