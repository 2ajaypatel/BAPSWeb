<%@ Page Title="Order Summary" EnableEventValidation="false" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="rpt_OrderSummaryByCenter.aspx.cs" Inherits="Admin_OrderSummaryByCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
             &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Button ID="btnExcel" runat="server" onclick="btnExcel_Click" 
                     Text="Export to Excel" CssClass="btn" />
            </td>
            
    </tr>
    <tr>
        <td style="text-align:center; vertical-align:top" 
                        align="center" valign="top">
            <b>Order Summary By Center</b></td>
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
                        DataKeyNames="centerID"
                        CssClass="mGrid" 
                        AllowPaging="True" 
                        EmptyDataText="No data in the data source."
                        onpageindexchanging="gv_PageIndexChanging" 
                        ondatabound="gv_DataBound"
                        AllowSorting="True" showfooter="true">

              <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                    <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                
                 <Columns>
                   <asp:BoundField DataField="Region" HeaderText="Region Name" />
                   <asp:BoundField DataField="CenterName" HeaderText="Center Name" />
                   <asp:BoundField DataField="ProductDescription" HeaderText="Product Description" />
                   <asp:BoundField DataField="CalendarItem1" HeaderText="Single or Multi Color"  />

                   <asp:TemplateField HeaderText="Total Order" FooterStyle-HorizontalAlign="center">  
                        <ItemTemplate>  
                            <asp:Label ID="lblOrder" 
                                    Text='<%# Eval("orderCount") %>' 
                                    runat="server" 
                                    Style="text-align: center;">
                            </asp:Label>
                        </ItemTemplate>  
                        <FooterTemplate>  
                            <asp:Label ID="lblTotalOrder" runat="server" Style="text-align: center;"></asp:Label>  
                        </FooterTemplate>  
                    </asp:TemplateField>  

                   <asp:BoundField DataField="Rate" HeaderText="Rate" DataFormatString="{0:c}"  />

                   <asp:TemplateField HeaderText="Total Qty" FooterStyle-HorizontalAlign="center">  
                        <ItemTemplate>  
                            <asp:Label ID="lblQTY" 
                                    Text='<%# Eval("totalQTY") %>' 
                                    runat="server" 
                                    Style="text-align: center;">
                            </asp:Label>
                        </ItemTemplate>  
                        <FooterTemplate>  
                            <asp:Label ID="lblTotalQty" runat="server" Style="text-align: center;"></asp:Label>  
                        </FooterTemplate>  
                    </asp:TemplateField>  

                    <asp:TemplateField HeaderText="Total Amount" FooterStyle-HorizontalAlign="center">  
                        <ItemTemplate>  
                            <asp:Label ID="lblCost" 
                                    Text='<%# Eval("totalCOST") %>' 
                                    runat="server" 
                                    Style="text-align: center;">
                            </asp:Label>
                        </ItemTemplate>  
                        <FooterTemplate>  
                            <asp:Label ID="lblTotalCost" runat="server" Style="text-align: center;"></asp:Label>  
                        </FooterTemplate>  
                    </asp:TemplateField> 

                  <asp:TemplateField HeaderText="Additional Cost" FooterStyle-HorizontalAlign="center">  
                        <ItemTemplate>  
                            <asp:Label ID="lblAdditionalCost" 
                                    Text='<%# Eval("totalAdditionalCost") %>' 
                                    runat="server" 
                                    Style="text-align: center;">
                            </asp:Label>
                        </ItemTemplate>  
                        <FooterTemplate>  
                            <asp:Label ID="lbltotalAdditionalCost" runat="server"></asp:Label>  
                        </FooterTemplate>  
                    </asp:TemplateField> 
   
                  </Columns>
              
            </asp:GridView>
         </td>
    </tr>
    <tr>
        <td style="text-align:center; vertical-align:top">
            <asp:SqlDataSource ID="sdCenterList" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                SelectCommand="SELECT CenterID, CenterName FROM Center AS c WHERE (CenterID IN (SELECT DISTINCT CenterID FROM OrderMaster WITH (nolock))) ORDER BY CenterName">
            </asp:SqlDataSource>
                    </td>
    </tr>

</table>
</asp:Content>

