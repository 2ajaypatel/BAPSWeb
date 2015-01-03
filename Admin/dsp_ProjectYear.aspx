<%@ Page Title="Project Year - Summary View" Language="C#" MasterPageFile="~/Admin/Admin.master"
    AutoEventWireup="true" CodeFile="dsp_ProjectYear.aspx.cs" Inherits="Admin_dsp_ProjectYear"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.min.js" type="text/javascript"></script>
    <link href="../Scripts/css/ui-lightness/jquery-ui-1.8.7.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="../Scripts/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                //setup edit person dialog
                $('#ViewProjectYear').dialog({
                    autoOpen: false,
                    draggable: true,
                    model: true,
                    resizable: false,
                    width: 350,
                    height: 200,
                    title : "",
                    open: function (type, data) {
                        $(this).parent().appendTo("form");

                    }
                });
            });

           
            function EditProjectYearDialog(id) {
                $('#' + id).dialog( "option", "title", 'Edit Project Year' );
                $('#' + id).dialog("open"); 
            }

            function AddProjectYearDialog(id) {

                $('input[id$=btnUpdate]').attr('value', 'Add');
                $('#' + id).dialog( "option", "title", 'Add Project Year' );
                $('#' + id).dialog("open"); 
            }

            function CloseProjectYearDialog(id) {
                $('#' + id).dialog("close");
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="upGrid" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <table align="center" width="100%">
                <tr>
                    <td align="center">
                        <h3>Note: Only one Project Year can be active/current at a time.</h3> 
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:GridView ID="gv" runat="server" BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
                            BorderWidth="0px" CellPadding="4" AutoGenerateColumns="False" Width="70%" 
                            OnRowCommand="gv_RowCommand" 
                            DataKeyNames="ProjectYearID" 
                            OnPageIndexChanging="gv_PageIndexChanging" 
                            PageIndex="10"
                            OnRowDataBound="gv_OnRowDataBound"
                            CssClass="mGrid" AllowPaging="True" AllowSorting="True">
                            <AlternatingRowStyle BackColor="#E8E8E8" />
                            <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                            <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                            <Columns>
                                <asp:TemplateField HeaderText="Add Project Year" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton 
                                            ID="lnkBtnAddProjectYear" 
                                            CommandArgument='0,2999,0' 
                                            CommandName="AddProjectYear" 
                                            OnClientClick="AddProjectYearDialog('ViewProjectYear');"
                                            runat="server">
                                            <asp:Image ID="imgAdd" src="../Images/add.gif" runat="server" border='0'
                                                title='Click here to add new project year.' />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Edit Project Year" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton 
                                            ID="lnkBtnViewProjectYear" 
                                            CommandArgument='<%#Eval("ProjectYearID") + "," + Eval("ProjectYear") + "," + Eval("IsCurrent") %>' 
                                            CommandName="EditProjectYear" 
                                            OnClientClick="EditProjectYearDialog('ViewProjectYear');"
                                            runat="server">
                                            <asp:Image ID="imgEdit" src="../Images/edit.gif" runat="server" border='0'
                                                title='Click here to edit selected project year.' />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProjectYearID" HeaderText="Project Year ID" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ProjectYear" HeaderText="Project Year" Visible="true" ItemStyle-HorizontalAlign="Center"/>
                                <asp:BoundField DataField="IsCurrent" HeaderText="Is Current?" Visible="true" ItemStyle-HorizontalAlign="Center"/>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

<div id='ViewProjectYear'>
          
            <asp:UpdatePanel ID="upProjectYear" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server">
            <ContentTemplate>       
                <table width="90%" align="center" >
                    <tr>
                        <td align="center" colspan=2 class="labelBoldRed">
                            <h3>Note: Only one Project Year can be active/current at a time.</h3> 
                        </td>
                    </tr>
                    <tr><td colspan=2><asp:Literal ID="litmsg" runat="server"></asp:Literal></td></tr>
                    <tr>
                        <td colspan=2 align="center">
                            <asp:CompareValidator 
                                    ID="cmpProjectYear" 
                                    runat="server" 
                                    ControlToValidate="ddlProjectYear"
                                    Display="Dynamic" 
                                    ErrorMessage="Project Year is required." 
                                    Operator="NotEqual" 
                                    ValidationGroup="upProjectYear"
                                    ValueToCompare="0" Width="305px" CssClass="labelBoldRed">
                                 </asp:CompareValidator>
                        </td>
                     </tr>
                    <tr>
                        <td class="labelBoldRight">Project Year<span class="labelBoldRed">*</span>:</td>
                        
                        <td  align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:DropDownList ID="ddlProjectYear" runat="server" ValidationGroup="upProjectYear">
                            </asp:DropDownList>
                           
                                 
                        </td>
                    </tr>
                    <tr>
                       
                        <td class="labelBoldRight">Is Current Year?<span class="labelBoldRed">*</span>:</td>
                       
                       <td  align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:CheckBox ID="chkIsCurrent" runat="server" ValidationGroup="upProjectYear" Checked="false" />
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="labelBoldRight">
                            &nbsp;
                        </td>
                        <td align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:HiddenField ID="hfProjectYearID" runat="server" Value="-1" />
                            <asp:HiddenField ID="hfProjectYear" runat="server" Value="2999" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn" 
                                ValidationGroup="upProjectYear" onclick="btnUpdate_Click"/>
                            <asp:Button ID="btnViewNoteClose" runat="server" Text="Close" 
                                onclick="btnViewNoteClose_Click" CssClass="btn"  />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            </asp:UpdatePanel>            
        </div>
</asp:Content>
