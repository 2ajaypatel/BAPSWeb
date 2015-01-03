<%@ Page Title="Order - Edit Payment" Language="C#" MasterPageFile="~/Secure/Calendar.master" AutoEventWireup="true" CodeFile="editPayment.aspx.cs" Inherits="Secure_editPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/demos.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.min.js" type="text/javascript"></script>
    <link href="../Scripts/css/ui-lightness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {

            //setup edit person dialog
            $('#editBankInfo').dialog({
                autoOpen: false,
                draggable: true,
                title: "Edit Bank Information",
                open: function (type, data) {
                    $(this).parent().appendTo("form");
                }
            });

          
        });

        $(function () {
            $('input[id$=txtBankName]').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "../OrderDetail.asmx/GetBankName",
                        data: "{ 'mail': '" + request.term + "' }",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    value: item
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, callStatus, errorThrown) {
                            alert(callStatus);
                        }
                    });
                },
                minLength: 1
            });
        });

        function showDialog(id) {
            $('#' + id).dialog("open");
        }

        function closeDialog(id, bankName) {
            alert(bankName);
            $('input[id$=txtBankName]').val(bankName)
            $('#' + id).dialog("close");
        }
              
    </script>

    <script type="text/javascript">
        $(function () {

            $('#ctl00_cphContent_txtCheckDate').datepicker({
                numberOfMonths: 2,
                showButtonPanel: true
            });

        });    
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
<asp:ScriptManager ID="mainScriptManager" runat="server"></asp:ScriptManager>
<h1>Edit Payment</h1>
   
       
<asp:UpdatePanel ID="upGrid" UpdateMode="Conditional" runat="server">
 <ContentTemplate>
       
<table width="50%" align="center" >
    <tr>
        <td class="labelBoldRight">Bank Name :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:TextBox ID="txtBankName" runat="server" Width="265px" 
                CssClass="inputText"></asp:TextBox>
        </td>
    </tr>

    <tr>
        <td class="labelBoldRight">Check No :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:TextBox ID="txtCheckNo" runat="server" Width="265px" CssClass="inputText"></asp:TextBox>
        </td>
    </tr>

    <tr>
        <td class="labelBoldRight">Check Date :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:TextBox ID="txtCheckDate" runat="server" Width="265px" 
                CssClass="inputText"></asp:TextBox>
        </td>
    </tr>

    <tr>
        <td class="labelBoldRight">Bank Amount :</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:TextBox ID="txtBankAmount" runat="server" Width="265px" 
                CssClass="inputText"></asp:TextBox>
        </td>
    </tr>

    <tr>
        <td class="labelBoldRight">&nbsp;</td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            

            <asp:Button ID="btnUpdate" 
                        runat="server" 
                        CausesValidation="False" 
                        Font-Bold="True"
                        Text="Update" 
                        CssClass="btn" onclick="btnUpdate_Click" />
             &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
             <asp:Button ID="btnCC" 
                        runat="server" 
                        CausesValidation="False" 
                        Font-Bold="True"
                        Text="Pay By Credit Card" 
                        CssClass="btn" onclick="btnCC_Click"  />
        </td>
        </tr>
    <tr>
        <td colspan="2" >
            <asp:TextBox ID="txtOrderID" runat="server" Visible="False" 
                CssClass="inputtext"></asp:TextBox>
       
        </td>
    </tr>
</table>
</ContentTemplate>
        </asp:UpdatePanel>   

        <div id='editBankInfo'>
            <asp:UpdatePanel ID="upEditUpdatePanel" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server">
            <ContentTemplate>       
                <asp:Label ID="lblEditName" runat="server" AssociatedControlID="txtEditName" Text="Name"></asp:Label>
                <asp:TextBox ID="txtEditName" runat="server" CssClass="inputtext"></asp:TextBox>
                 <asp:Button ID="btnEditSave" runat="server" Text="Save" 
                    onclick="btnEditSave_Click" />
            </ContentTemplate>
            </asp:UpdatePanel>            
        </div>  
</asp:Content>

