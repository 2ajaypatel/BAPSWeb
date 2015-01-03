<%@ Page Title="New Order Form" Language="C#" MasterPageFile="~/Secure/Calendar.master" AutoEventWireup="true" CodeFile="OrderForm.aspx.cs" Inherits="Secure_OrderForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.min.js" type="text/javascript"></script>
    <link href="../Scripts/css/ui-lightness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {

            $('input[id$=txtDate]').datepicker({
                numberOfMonths: 2,
                showOn: "focus",
                //buttonImage: "../Images/calendar.gif",
                showButtonPanel: true
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

    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            //setup edit person dialog
            $('#editBusInfo').dialog({
                autoOpen: false,
                draggable: true,
                model: true,
                resizable : false,
                width: 1000,
                height: 400,
                title: "Search Business Information",
                open: function (type, data) {
                    $(this).parent().appendTo("form:first");
                    }
            });


            //setup search karyakar dialog
            $('#searchKaryakar').dialog({
                autoOpen: false,
                draggable: true,
                model: true,
                resizable: false,
                width: 1000,
                height: 400,
                title: "Search Karyakar Information",
                open: function (type, data) {
                    $(this).parent().appendTo("form:first");
                }
            });



            });

            
            
            function showDialog(id) {
                $('#' + id).dialog("open");
                $('#<%=gvClientData.ClientID %>').hide();
            }

            function showKaryakarDialog(id) {
                $('#' + id).dialog("open");
                $('#<%=gvKaryakarData.ClientID %>').hide();
            }

            function closeDialog(id, addressID) {
                $('#' + id).dialog("close");

                $('input[id$=txtDate]').datepicker({
                    numberOfMonths: 2,
                    showOn: "focus",
                    //buttonImage: "../Images/calendar.gif",
                    showButtonPanel: false
                });
            }

            function closeKaryakarDialog(id, addressID) {
                $('#' + id).dialog("close");

                $('input[id$=txtDate]').datepicker({
                    numberOfMonths: 2,
                    showOn: "focus",
                    //buttonImage: "../Images/calendar.gif",
                    showButtonPanel: false
                });
            }

            function cancelDialog(id) {
                $('#' + id).dialog("close");    
            }

            function cancelKaryakarDialog(id) {
                $('#' + id).dialog("close");    
            }
              
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upBusinessInfo" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
    <table  style="width: 100%;padding:5px 5px 5px 5px;" align="center">

       
        <tr>
            <td>
                <table  style="padding:5px 5px 5px 5px;">
                   <%-- <tr>
                        <td width="50%" style="width: 50%; text-align: left; vertical-align: top" align="left"
                            valign="top">
                            &nbsp;
                        </td>
                        <td width="50%" style="width: 50%; text-align: left; vertical-align: top" align="left"
                            valign="top">
                            &nbsp;<asp:HyperLink    ID="backToMain" runat="server" 
                                                    Font-Bold="True" Font-Size="Medium" ForeColor="Red" 
                                                    NavigateUrl="~/Secure/OrderView.aspx">Back to Main Page</asp:HyperLink>
                        </td>
                    </tr>
                     
                    <tr>
                        <td width="50%" style="width: 50%; text-align: left; vertical-align: top" align="left"
                            valign="top">
                            &nbsp;
                        </td>
                        <td width="50%" style="width: 50%; text-align: left; vertical-align: top" align="left"
                            valign="top">
                            &nbsp;
                            <asp:Label ID="lbMessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                   --%>
                     <tr>
                        <td colspan="2" style="text-align: center; vertical-align: top" align="center">
                            Note: Field label with * is required field.

                            <br /><br />
                           
                        </td>
                    </tr>
                    <tr>
                         <td colspan="2" style="text-align: center; vertical-align: top" align="center">
                            <table>
                                <tr>
                                   <td class="labelBoldRight">
                                        Mandir/Center:<span class="labelBoldRed">*</span>
                                    </td>

                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:DropDownList ID="ddlCenter" runat="server"
                                        ValidationGroup="upBusinessInfo" CssClass="select"></asp:DropDownList>
                                        <br />
                                        
                                        <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator2" 
                                                runat="server" 
                                                ControlToValidate="ddlCenter" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Mandir/Center is required!</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                                    </td>
                                    <td align="right" valign="top">
                                        <asp:Button ID="btnBusEdit" runat="server" Text="Populate Business Information" 
                                            CssClass="btn" OnClientClick="showDialog('editBusInfo'); " 
                                            ToolTip="Click here to populate business information."    /> 

                                    </td>
                                    <td>
                                     &nbsp; &nbsp; &nbsp; &nbsp;
                                    </td>
                                    <td class="labelBoldRight" valign="bottom">Order Date<span class="labelBoldRed">*</span>:</td>

                                    <td align="left"  valign="bottom">
                                        <asp:TextBox ID="txtDate" runat="server" ValidationGroup="upBusinessInfo" 
                                            CssClass="inputText" ToolTip="Click here to select order date." 
                                            Width="80px"></asp:TextBox>

                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator10" 
                                                runat="server" 
                                                ControlToValidate="txtDate" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Date is required!</asp:RequiredFieldValidator>
                                    </td>
                                     <td>
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                                    </td>
                                     <td align="right" valign="top">
                                        <asp:Button ID="btnKayakar" runat="server" Text="Populate Karyakar Information" 
                                            CssClass="btn" OnClientClick="showKaryakarDialog('searchKaryakar'); " 
                                            ToolTip=" click here to open karaykar window."    /> 

                                    </td>
                                

                                </tr>
                            </table>
                        </td>
                    </tr>
                 

                    <tr>
                        <td style="border: thin solid #834717; text-align: left; vertical-align: top" align="left" 
                            valign="top">
                            <table>
                                

                                <tr>
                                    <td class="columnHeader"  colspan="2">
                                        <b>Business Information</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Business Name:<span class="labelBoldRed">*</span></td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessName" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                        <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator1" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessName" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Business Name is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                
                                <tr>
                                    <td class="labelBoldRight">Contact First Name<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtCoFirstName" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator21" 
                                                runat="server" 
                                                ControlToValidate="txtCoFirstName" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Contact First Name is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">
                                        Contact Last Name<span class="labelBoldRed">*</span>:
                                    </td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtCoLastName" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                        <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator22" 
                                                runat="server" 
                                                ControlToValidate="txtCoLastName" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Contact Last Name is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelBoldRight">Address1:<span class="labelBoldRed">*</span></td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessAddress1" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                           <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator3" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessAddress1" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Address 1 is required!</asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Address2:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessAddress2" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">City:<span class="labelBoldRed">*</span></td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessCity" runat="server" Width="265px" 
                                            CssClass="inputText"></asp:TextBox>
                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator4" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessCity" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">City is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">State:<span class="labelBoldRed">*</span></td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:DropDownList ID="ddlBusinessState" runat="server" Height="25px" 
                                            Width="201px" ValidationGroup="upBusinessInfo" CssClass="select"></asp:DropDownList>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator5" 
                                                runat="server" 
                                                ControlToValidate="ddlBusinessState" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">State is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">ZipCode:<span class="labelBoldRed">*</span></td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessZipCode" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator6" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessZipCode" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Zip Code is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Home Phone<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessHomePhone" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator7" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessHomePhone" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Business Home Phone is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Business Phone<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessPhone" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator8" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessPhone" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Business Phone is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Fax:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessFax" runat="server" Width="265px" 
                                            CssClass="inputText"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Email<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusinessEmail" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator9" 
                                                runat="server" 
                                                ControlToValidate="txtBusinessEmail" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Business Email is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td  style="border-style: solid; border-width: thin;  text-align: left; vertical-align: top" align="left" >
                            <table style="width: 100%">
                                <tr>
                                    <td class="columnHeader" colspan="2">
                                        <b>Order Collecting Karyakar Information</b>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelBoldRight">Karyakar First Name<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtFirstName" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator11" 
                                                runat="server" 
                                                ControlToValidate="txtFirstName" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">First Name is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">
                                        Karyakar Last Name<span class="labelBoldRed">*</span>:
                                    </td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtLastName" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                        <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator12" 
                                                runat="server" 
                                                ControlToValidate="txtLastName" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Last Name is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Address1<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtAddress1" runat="server" Width="265px"  
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator13" 
                                                runat="server" 
                                                ControlToValidate="txtAddress1" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Address 1 is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Address2:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtAddress2" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">City<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtCity" runat="server" Width="265px" CssClass="inputText"></asp:TextBox>
                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator14" 
                                                runat="server" 
                                                ControlToValidate="txtCity" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">City is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">State<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:DropDownList ID="ddlState" runat="server" Height="25px" Width="212px" 
                                            ValidationGroup="upBusinessInfo" CssClass="select"></asp:DropDownList>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator15" 
                                                runat="server" 
                                                ControlToValidate="ddlState" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">State is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">ZipCode<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtZipCode" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                         <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator16" 
                                                runat="server" 
                                                ControlToValidate="txtZipCode" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Zip Code is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Home Phone<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtHomePhone" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator17" 
                                                runat="server" 
                                                ControlToValidate="txtHomePhone" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Home Phone is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Cell Phone<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtCellPhone" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator18" 
                                                runat="server" 
                                                ControlToValidate="txtCellPhone" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Cell Phone is required!</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Fax:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtFax" runat="server" Width="265px" CssClass="inputText" ></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Email<span class="labelBoldRed">*</span>:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtEmail" runat="server" Width="265px" 
                                            ValidationGroup="upBusinessInfo" CssClass="inputText"></asp:TextBox>
                                        <br />
                                         <asp:RequiredFieldValidator 
                                                ID="RequiredFieldValidator19" 
                                                runat="server" 
                                                ControlToValidate="txtEmail" 
                                                CssClass="bold" 
                                                Display="Dynamic" 
                                                ValidationGroup="upBusinessInfo"
                                                ForeColor="Red">Email is required!</asp:RequiredFieldValidator>

                                        <asp:HiddenField ID="hdfAddressID" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdfClientAddressID" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdfClientID" runat="server" />
                                        
                                        <asp:HiddenField ID="hdfMemberID" runat="server" />
                                        <asp:HiddenField ID="hdfMemberAddressID" runat="server" Value="0" />

                                        <asp:HiddenField ID="hdfOrderID" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdfCenterID" runat="server" Value="0" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
         <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="center">
                 <asp:Label ID="lbMessage" runat="server" CssClass="labelBoldRed"></asp:Label>
            </td>
        </tr>
        <tr>
        <td  style="border-style: solid; border-width: thin;  text-align: left; vertical-align: top" align="left" >
         <table width="100%" >
                <tr>
                    <td class="columnHeader">
                        <b>Calendar Order Details</b>
                    </td>
                </tr>
               
                                    <tr>
                                        <td align="center" valign="top" style="text-align: center; vertical-align: top">
                                                <table>
                                                    <tr>
                                                        <td class="labelBoldCenter">
                                                            Product
                                                        </td>
                                                         <td class="labelBoldCenter">
                                                            Rate
                                                        </td>
                                                         <td class="labelBoldCenter">
                                                            Sub Type
                                                        </td>
                                                        <td class="labelBoldCenter">
                                                            Additional Rate
                                                        </td>
                                                         <td class="labelBoldCenter">
                                                            Quantity
                                                        </td>
                                                         <td class="labelBoldCenter">
                                                            Amount
                                                        </td>
                                                         <td class="labelBoldCenter">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" valign="top" style="text-align: center; vertical-align: top">
                                                            <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="True" 
                                                                OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged" CssClass="select">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="center" valign="top" style="text-align: center; vertical-align: top">
                                                            <asp:TextBox ID="txtRate" runat="server" Width="92px" Enabled="False" 
                                                                CssClass="inputText"></asp:TextBox>
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            <asp:DropDownList ID="ddlProductType" runat="server" AutoPostBack="True" 
                                                                OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged" CssClass="select">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="center" valign="top" style="text-align: center; vertical-align: top">
                                                            <asp:TextBox ID="txtAdditionalRate" runat="server" Width="92px" Enabled="False" 
                                                                CssClass="inputText"></asp:TextBox>
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            <asp:TextBox 
                                                                ID="txtQuantity" 
                                                                runat="server" 
                                                                AutoPostBack="True" 
                                                                OnTextChanged="txtQuantity_TextChanged"
                                                                Width="143px" CssClass="inputText"
                                                                onkeydown= "return OnlyNumeric(event,this);">
                                                             </asp:TextBox>

                                                        </td>
                                                        <td align="center" valign="top" style="text-align: center; vertical-align: top">
                                                            <asp:TextBox ID="txtAmount" runat="server" Width="110px" CssClass="inputText"></asp:TextBox>
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            <asp:Button ID="btnAddOrder" runat="server" Font-Bold="True" Text="Add Order" 
                                                                onclick="btnAddOrder_Click" CssClass="btn" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            &nbsp;
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            &nbsp;
                                                            <asp:TextBox ID="txtRateID" runat="server" Visible="False" Width="71px" 
                                                                CssClass="inputText"></asp:TextBox>
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            &nbsp;
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            &nbsp;&nbsp;</td>
                                                        <td align="left" style="text-align: left; vertical-align: top" valign="top">
                                                            &nbsp;
                                                            </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            <asp:TextBox ID="txtAdditionRateID" runat="server" Visible="False" Width="92px" 
                                                                CssClass="inputText"></asp:TextBox>
                                                            &nbsp;
                                                        </td>
                                                        <td align="center" style="text-align: center; vertical-align: top" valign="top">
                                                            <asp:TextBox ID="txtSeqNo" runat="server" Visible="False" 
                                                                CssClass="inputText"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                          
                        
                                                            <asp:CompareValidator 
                                                                ID="cvOnlyCurrency" 
                                                                runat="server" 
                                                                Type="Currency" 
                                                                Operator="DataTypeCheck"
                                                                ErrorMessage="Invalid Amount, only numbers and '.' allowed"
                                                                ControlToValidate="txtAmount" 
                                                                CssClass="bold"
                                                                Display="Dynamic"
                                                                ValidationGroup="upBusinessInfo"
                                                                ForeColor="Red">Invalid Amount, only numbers and '.' allowed</asp:CompareValidator><br />
                                                        </td>
                                                    </tr>
                                                </table>            
                                       
                </td>
                </tr>
            </table>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
             <td  style="border-style: solid; border-width: thin; text-align: left; vertical-align: top" align="left" >
               <table width="100%" >
                            <tr>
                                <td class="columnHeader">
                                    <b>Calendar Summary Order Details</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView 
                                            CssClass="mGrid"
                                            ID="grdPendingOrder" 
                                            runat="server" 
                                            BackColor="White" 
                                            BorderColor="#2E2842" 
                                            BorderStyle="Solid"
                                            AutoGenerateColumns="False" 
                                            DataKeyNames="ProductID,ProductTypeID,ProductRateID,ProductAdditionalRateID,SequenceNo" 
                                            Width="100%">
                                        
                                        <AlternatingRowStyle BackColor="#E8E8E8" />
                                        <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                        <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" HorizontalAlign="Center" />
                                        <Columns>
                                           
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDelete" CausesValidation="False" 
                                                        onclick="lnkDelete_Click" runat="server">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="SequenceNo" HeaderText="Sequence No" />
                                            <asp:BoundField DataField="ProductDescription" HeaderText="Product" />
                                            <asp:BoundField DataField="ProductRate" HeaderText="Rate" />
                                            <asp:BoundField DataField="ProductTypeDescription" HeaderText="Sub Type" />
                                            <asp:BoundField DataField="ProductAdditionalRate" HeaderText="Additional Rate" />
                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                                            <asp:BoundField DataField="Amount" HeaderText="Amount" />

                                            
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                &nbsp;
                                </td>
                            </tr>
                   </table>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
             <td  style="border-style: solid; border-width: thin; text-align: left; vertical-align: top" align="left" >
               <table width="100%" >
                 <tr>
                    <td class="columnHeader">
                        <b>Payment Details
                    </tr>
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td class="labelBoldRed" colspan="2" align="center">
                                    Note: Please make a check payable to Swaminarayan Aksharpith.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; vertical-align: top" align="left"
                                    valign="top">
                                    <table >
                                        <tr>
                                           
                                            <td  class="labelBoldRight">
                                                Bank Name:
                                            </td>
                                            <td style="text-align: left; vertical-align: top">
                                                <asp:TextBox ID="txtBankName" runat="server" Width="265px" CssClass="inputText"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td  class="labelBoldRight">
                                                Bank Amount:</td>
                                           <td style="text-align: left; vertical-align: top">
                                                <asp:TextBox ID="txtBankAmount" runat="server" Width="265px" 
                                                    CssClass="inputText"></asp:TextBox>
                                                <br />
                                                <asp:RangeValidator 
                                                    id="rcBankAmount" 
                                                    runat="server" 
                                                    ControlToValidate="txtBankAmount"
                                                    Type="Double" 
                                                    Minimum="1.0000" 
                                                    Maximum="9999999.9999" 
                                                    ErrorMessage="Bank amount is out of range. Enter valid amount. " 
                                                    Display="Dynamic"
                                                    ValidationGroup="upBusinessInfo"
                                                    ForeColor="Red"
                                                    />
                                                
                                               <%-- <asp:CompareValidator 
                                                    ID="cvAmount" 
                                                    runat="server" 
                                                    Type="Currency" 
                                                    Operator="DataTypeCheck"
                                                    ErrorMessage="Invalid Amount, only numbers and '.' allowed"
                                                    ControlToValidate="txtBankAmount" 
                                                    CssClass="bold" 
                                                    Display="Dynamic"
                                                    ValidationGroup="upBusinessInfo"
                                                    ForeColor="Red">Invalid Amount, only numbers and '.' allowed</asp:CompareValidator><br />--%>

                                            </td>
                                        </tr>
                                    <tr>
                                            
                                    </tr>
                                    </table>
                                </td>
                                <td style=" text-align: left; vertical-align: top" align="left"
                                    valign="top">
                                    <table >
                                        <tr>
                                            <td  class="labelBoldRight">
                                                Check No:</td>
                                            <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                                <asp:TextBox ID="txtCheckNo" runat="server" Width="265px" CssClass="inputText"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td  class="labelBoldRight">Total Payment:</td>
                                            <td>
                                                <asp:Label ID="lblTotalPayment" 
                                                runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="labelBoldRed" align="center">
                Note: Credit Card Payment can be made by calling Swaminarayan Aksharpith Headquarters 
                <br />
                (Phone:732-777-1414, Extension: x102 or x104 or x105).
            </td>
        </tr>
        </table>
        </td></tr>


        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        
        <tr>
            <td>
                <asp:Button ID="btnProceed" runat="server" Font-Bold="True" OnClick="btnCheckOut_Click"
                    Text="Proceed" CssClass="btn" ValidationGroup="upBusinessInfo" />
                &nbsp;<asp:Button ID="btnCancel" runat="server" CausesValidation="False" Font-Bold="True"
                    Text="Cancel" CssClass="btn" onclick="btnCancel_Click" />
            </td>
        </tr>

    </table>

    </ContentTemplate>
     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddOrder" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="ddlProduct" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="ddlProductType" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtQuantity" EventName="TextChanged" />
                    </Triggers>
        </asp:UpdatePanel>   

        <div id='editBusInfo'>
          
            <asp:UpdatePanel ID="upEditUpdatePanel" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server">
            <ContentTemplate>       
                <table width="100%" align="center" >
                    <tr>
                        <td>
                           <table width="70%" align="center" >
                                <tr>
                                    <td class="labelBoldRight">Business Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtBusName" runat="server" Width="200px" AutoPostBack="true"
                                            CssClass="inputText" MaxLength="50" ontextchanged="txtBusName_TextChanged"></asp:TextBox>
                          
                                    </td>
                                    <td class="labelBoldRight">City Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtCityName" runat="server" Width="200px" 
                                            CssClass="inputText" MaxLength="50"></asp:TextBox>
                                            <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelBoldRight">Contact First Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtContactFirstName" runat="server" Width="200px" 
                                            CssClass="inputText" MaxLength="50"></asp:TextBox>
                          
                                    </td>
                                    <td class="labelBoldRight">Contact Last Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtContactLastName" runat="server" Width="200px" 
                                            CssClass="inputText" MaxLength="50"></asp:TextBox>
                          
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                     &nbsp;
                                    </td>
                                    <td colspan="3" style="text-align: left; vertical-align: top">
                                        <asp:Button ID="btnSearchClient" runat="server" Text="Search" CssClass="btn" 
                                            ToolTip="Click here to search client information." 
                                            onclick="btnSearchClient_Click" />
                         
                                          <asp:Button ID="btnCloseClient" runat="server" Text="Close" CssClass="btn" 
                                            ToolTip="Click here to close window" onclick="btnCloseClient_Click" 
                                             />
                         
                                          <asp:Button ID="btnCancelDialogClient" runat="server" Text="Cancel" CssClass="btn" 
                                            ToolTip="Click here to close window" onclick="btnCancelClient_Click" 
                                             />
                                    </td>
                                </tr>
                           </table>
                        </td>
       
                    </tr>
                    <tr>
                        <td >
                         <%-- Text='<%# Eval("ClientID").ToString() %>' --%>
                             <asp:GridView ID="gvClientData" 
                                        runat="server" 
                                        BackColor="White" 
                                        BorderColor="#CC9966" 
                                        BorderStyle="Solid" 
                                        CellPadding="2" 
                                        AutoGenerateColumns="False"
                                        Width="100%"
                                        CssClass="mGrid" 
                                        onrowcreated="gvClientData_RowCreated" 
                                        OnPageIndexChanging="gvClientData_PageIndexChanging"
                                        OnSorting ="gvClientData_OnSorting"
                                        AllowPaging="True" 
                                        AllowSorting="True" 
                                        EmptyDataText="No record found. Please try with different search options."
                                        PageSize="8">

                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />
                                <HeaderStyle BackColor="#FF9900" Font-Bold="True" ForeColor="#FFFFCC" />
                
                                 <Columns>

                                   <asp:TemplateField>
                                    <ItemTemplate>
                      
                                        <asp:CheckBox ID="chkClientID" runat="server" 
                                            AutoPostBack="true" 
                                            OnCheckedChanged="chkSelectClient_CheckedChanged"/>
                          
                                    </ItemTemplate>                    
                                </asp:TemplateField>

                  

                                   <asp:BoundField DataField="businessname" HeaderText="Business Name" sortexpression="businessname" />
                                   <asp:BoundField DataField="firstname" HeaderText="First Name" sortexpression="firstname" />
                                   <asp:BoundField DataField="lastname" HeaderText="Last Name" sortexpression="lastname" />
                                   <asp:BoundField DataField="address1" HeaderText="Address 1" Visible="true" />
                                   <asp:BoundField DataField="address2" HeaderText="Address 2"  Visible="true"  />
                                   <asp:BoundField DataField="city" HeaderText="City" />
                                   <asp:BoundField DataField="zipcode" HeaderText="Zip" />
                                   <asp:BoundField DataField="businessphone" HeaderText="Business Phone" />
                                   <asp:BoundField DataField="HomePhone" HeaderText="Home Phone" />
                                   <asp:BoundField DataField="businessfax" HeaderText="Fax" />
                                   <asp:BoundField DataField="businessemail" HeaderText="Email" />

                                     <asp:TemplateField Visible="false">
                                         <ItemTemplate>
                                             <asp:Label id="lblAddressId" runat ="server" text='<%# Eval("addressid").ToString() %>' />
                                         </ItemTemplate>
                                      </asp:TemplateField>

                                      <asp:TemplateField Visible="false">
                                         <ItemTemplate>
                                             <asp:Label id="lblClientId" runat ="server" text='<%# Eval("clientid").ToString() %>' />
                                         </ItemTemplate>
                                      </asp:TemplateField>

                                      <asp:TemplateField Visible="false">
                                         <ItemTemplate>
                                             <asp:Label id="StateID" runat ="server" text='<%# Eval("StateID").ToString() %>' />
                                         </ItemTemplate>
                                      </asp:TemplateField>
                                      <asp:BoundField DataField="businessaddress" HeaderText="Business Address" Visible="false" />
                                  </Columns>
                                  <emptydatarowstyle backcolor="LightBlue" forecolor="Red"/>
                                    <EmptyDataTemplate>No record found. Please try with different search options.</EmptyDataTemplate>
              
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            </asp:UpdatePanel>            
        </div>


        <div id='searchKaryakar'>
          
            <asp:UpdatePanel ID="UpdatePanelKaryakar" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server">
            <ContentTemplate>       
                <table width="100%" align="center" >
                    <tr>
                        <td>
                           <table width="70%" align="center" >
                                <tr>
                                    <td class="labelBoldRight">Karyakar First Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtKaryakarFirstName" runat="server" Width="200px" 
                                            CssClass="inputText" MaxLength="50"></asp:TextBox>
                          
                                    </td>
                                    <td class="labelBoldRight">Karyakar Last Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtKaryakarLastName" runat="server" Width="200px" 
                                            CssClass="inputText" MaxLength="50"></asp:TextBox>
                          
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td class="labelBoldRight">Karyakar Email:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtKaryakarEmail" runat="server" Width="200px" AutoPostBack="true"
                                            CssClass="inputText" MaxLength="50" ></asp:TextBox>
                          
                                    </td>
                                    <td class="labelBoldRight">City Name:</td>
                                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:TextBox ID="txtKaryakarCityName" runat="server" Width="200px" 
                                            CssClass="inputText" MaxLength="50"></asp:TextBox>
                                            <br />
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td>
                                     &nbsp;
                                    </td>
                                    <td colspan="3" style="text-align: left; vertical-align: top">
                                        <asp:Button ID="btnSearchKaryakar" runat="server" Text="Search Karyakar" CssClass="btn" 
                                            ToolTip="Click here to search karyakar information." 
                                            onclick="btnSearchKaryakar_Click" />
                         
                                          <asp:Button ID="btnCloseKaryakar" runat="server" Text="Close" CssClass="btn" 
                                            ToolTip="Click here to close dialog box." onclick="btnCloseKaryakar_Click" 
                                             />
                         
                                          <asp:Button ID="btnCancelKaryakar" runat="server" Text="Cancel" CssClass="btn" 
                                            ToolTip="Click here to close window" onclick="btnCancelKaryakar_Click" 
                                             />
                                    </td>
                                </tr>
                           </table>
                        </td>
       
                    </tr>
                    <tr>
                        <td >
                         <%-- Text='<%# Eval("ClientID").ToString() %>' --%>
                             <asp:GridView ID="gvKaryakarData" 
                                        runat="server" 
                                        BackColor="White" 
                                        BorderColor="#CC9966" 
                                        BorderStyle="Solid" 
                                        CellPadding="2" 
                                        AutoGenerateColumns="False"
                                        Width="100%"
                                        CssClass="mGrid" 
                                        onrowcreated="gvKaryakarData_RowCreated" 
                                        OnPageIndexChanging="gvKaryakarData_PageIndexChanging"
                                        OnSorting ="gvKaryakarData_OnSorting"
                                        AllowPaging="True" 
                                        AllowSorting="True" 
                                        EmptyDataText="No record found. Please try with different search options."
                                        PageSize="8">

                                <AlternatingRowStyle BackColor="#E8E8E8" />
                                <FooterStyle BackColor="#FF9900" ForeColor="#FFFFCC" />
                                <HeaderStyle BackColor="#FF9900" Font-Bold="True" ForeColor="#FFFFCC" />
                
                                 <Columns>

                                   <asp:TemplateField>
                                    <ItemTemplate>
                      
                                        <asp:CheckBox ID="chkMemberID" runat="server" 
                                            AutoPostBack="true" 
                                            OnCheckedChanged="chkSelectKaryakar_CheckedChanged"/>
                          
                                    </ItemTemplate>                    
                                </asp:TemplateField>

                                   <asp:BoundField DataField="firstname" HeaderText="First Name" sortexpression="firstname" />
                                   <asp:BoundField DataField="lastname" HeaderText="Last Name" sortexpression="lastname" />
                                   <asp:BoundField DataField="address1" HeaderText="Address 1" Visible="true" />
                                   <asp:BoundField DataField="address2" HeaderText="Address 2"  Visible="true"  />
                                   <asp:BoundField DataField="city" HeaderText="City" />
                                   <asp:BoundField DataField="zipcode" HeaderText="Zip" />
                                   <asp:BoundField DataField="HomePhone" HeaderText="Home Phone" />
                                   <asp:BoundField DataField="cellphone" HeaderText="Cell Phone" />
                                   <asp:BoundField DataField="fax" HeaderText="Fax" />
                                   <asp:BoundField DataField="email" HeaderText="Email" />

                                     <asp:TemplateField Visible="false">
                                         <ItemTemplate>
                                             <asp:Label id="lblAddressId" runat ="server" text='<%# Eval("addressid").ToString() %>' />
                                         </ItemTemplate>
                                      </asp:TemplateField>

                                      <asp:TemplateField Visible="false">
                                         <ItemTemplate>
                                             <asp:Label id="lblMemberID" runat ="server" text='<%# Eval("MemberID").ToString() %>' />
                                         </ItemTemplate>
                                      </asp:TemplateField>

                                      <asp:TemplateField Visible="false">
                                         <ItemTemplate>
                                             <asp:Label id="StateID" runat ="server" text='<%# Eval("StateID").ToString() %>' />
                                         </ItemTemplate>
                                      </asp:TemplateField>
                                      <asp:BoundField DataField="memberaddress" HeaderText="Karyakar Address" Visible="false" />
                                  </Columns>

                                  <emptydatarowstyle backcolor="LightBlue" forecolor="Red"/>
                                    <EmptyDataTemplate>No record found. Please try with different search options.</EmptyDataTemplate>
              
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            </asp:UpdatePanel>            
        </div>


</asp:Content>

