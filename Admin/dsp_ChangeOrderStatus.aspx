<%@ Page Title="Change - Order Status" Language="C#" MasterPageFile="~/Secure/Calendar.master" AutoEventWireup="true" CodeFile="dsp_ChangeOrderStatus.aspx.cs" Inherits="dsp_AuditNotes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">



<table width="100%" align="center" >
     <tr>
        <td colspan="2" align="center">
            <h1>Change - Order Status</h1>
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight">Enter By :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:Literal ID="litEnterBy" runat="server"></asp:Literal>
        </td>
    </tr>

    <tr>
        <td class="labelBoldRight">Enter Date :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
           <asp:Literal ID="litEnterDate" runat="server"></asp:Literal>
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight">Select Order Status :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:DropDownList ID="ddlOrderStatus" runat="server" ValidationGroup="ChangeStatus" 
             CssClass="select"></asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight">Select Audit Note Type :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:DropDownList ID="ddlAuditNoteType" runat="server" ValidationGroup="ChangeStatus" 
             CssClass="select"></asp:DropDownList>
        </td>
    </tr>

    <tr>
        <td class="labelBoldRight">Enter Audit Notes :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:TextBox id="txtNotes" TextMode="multiline" runat="server" Columns="80"  ValidationGroup="ChangeStatus" 
                Rows="8" 
                ToolTip="Enter your add/edit auditing notes. Max Characters: 1000" 
                CssClass="textArea" />
                 <br />
             <asp:RequiredFieldValidator 
                    ID="rfvNotes" 
                    runat="server" 
                    ValidationGroup="ChangeStatus" 
                    ErrorMessage="Audit note is required." Font-Bold="True" 
                    ControlToValidate="txtNotes" ForeColor="red"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight"></td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn" ValidationGroup="ChangeStatus" 
                onclick="btnAdd_Click" />
            <asp:Button ID="btnView" runat="server" Text="View Audit Notes" 
                CssClass="btn" onclick="btnView_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
                onclick="btnCancel_Click" />
        </td>
    </tr>
    <tr><td></td></tr>
    <tr Width="100%">
        <td colspan="2" nowrap="nowrap">
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
                Width="100%" >

                <AlternatingRowStyle BackColor="#E8E8E8" />
                    <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                    <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
            <Columns>
            
               <asp:BoundField DataField="NoteID" HeaderText="Note ID" />
               <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
               <asp:BoundField DataField="EnterDate" HeaderText="Enter Date" dataformatstring="{0:f}"  />
                <asp:BoundField DataField="EnterBy" HeaderText="Enter By" />
                <asp:BoundField DataField="NoteTypeName" HeaderText="Note Type" />
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
</asp:Content>

