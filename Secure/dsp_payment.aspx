<%@ Page Title="Add/Edit - Payment" Language="C#" MasterPageFile="~/Secure/Calendar.master" AutoEventWireup="true"
    CodeFile="dsp_payment.aspx.cs" Inherits="Secure_dsp_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/demos.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.min.js" type="text/javascript"></script>
    <link href="../Scripts/css/ui-lightness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {


            // disabled credit card fields on initial load

            $('[id$="txtCompanyName"]').attr('disabled', "disabled");
            $('[id$="txtFirstName"]').attr('disabled', "disabled");
            $('[id$="txtLastName"]').attr('disabled', "disabled");
            $('[id$="txtAddress"]').attr('disabled', "disabled");
            $('[id$="txtCity"]').attr('disabled', "disabled");
            $('[id$="ddlState"]').attr('disabled', "disabled");
            $('[id$="txtZip"]').attr('disabled', "disabled");
            $('[id$="txtPhone"]').attr('disabled', "disabled");
            $('[id$="txtEmail"]').attr('disabled', "disabled");
            $('[id$="ddlCardType"]').attr('disabled', "disabled");
            $('[id$="txtCreditCardNumber"]').attr('disabled', "disabled");
            $('[id$="ddlExpireMonth"]').attr('disabled', "disabled");
            $('[id$="ddlExpireYear"]').attr('disabled', "disabled");
            $('[id$="txtAmount"]').attr('disabled', "disabled");
            $('[id$="btnPayNow"]').attr('disabled', "disabled");

           
            $("#<%=rblPaymentType.ClientID%> input").change(function () {

                var rblSelectedValue = $("#<%= rblPaymentType.ClientID %> input:checked");
                var selectedValue = rblSelectedValue.val();

               // 2=credit card, 1=check/cash
                if (selectedValue == 2) {
                    $('[id$="txtCompanyName"]').removeAttr('disabled');
                    $('[id$="txtFirstName"]').removeAttr('disabled');
                    $('[id$="txtLastName"]').removeAttr('disabled');
                    $('[id$="txtAddress"]').removeAttr('disabled');
                    $('[id$="txtCity"]').removeAttr('disabled');
                    $('[id$="ddlState"]').removeAttr('disabled');
                    $('[id$="txtZip"]').removeAttr('disabled');
                    $('[id$="txtPhone"]').removeAttr('disabled');
                    $('[id$="txtEmail"]').removeAttr('disabled');
                    $('[id$="ddlCardType"]').removeAttr('disabled');
                    $('[id$="txtCreditCardNumber"]').removeAttr('disabled');
                    $('[id$="ddlExpireMonth"]').removeAttr('disabled');
                    $('[id$="ddlExpireYear"]').removeAttr('disabled');
                    $('[id$="txtAmount"]').removeAttr('disabled');
                    $('[id$="btnPayNow"]').removeAttr('disabled');
                    
                    $('[id$="txtBankName"]').attr('disabled', "disabled");
                    $('[id$="txtCheckNo"]').attr('disabled', "disabled");
                    $('[id$="txtCheckDate"]').attr('disabled', "disabled");
                    $('[id$="txtBankAmount"]').attr('disabled', "disabled");
                    $('[id$="btnUpdate"]').attr('disabled', "disabled");
                }
                else {
                    $('[id$="txtBankName"]').removeAttr('disabled');
                    $('[id$="txtCheckNo"]').removeAttr('disabled');
                    $('[id$="txtCheckDate"]').removeAttr('disabled');
                    $('[id$="txtBankAmount"]').removeAttr('disabled');
                    $('[id$="btnUpdate"]').removeAttr('disabled');

                    $('[id$="txtCompanyName"]').attr('disabled', "disabled");
                    $('[id$="txtFirstName"]').attr('disabled', "disabled");
                    $('[id$="txtLastName"]').attr('disabled', "disabled");
                    $('[id$="txtAddress"]').attr('disabled', "disabled");
                    $('[id$="txtCity"]').attr('disabled', "disabled");
                    $('[id$="ddlState"]').attr('disabled', "disabled");
                    $('[id$="txtZip"]').attr('disabled', "disabled");
                    $('[id$="txtPhone"]').attr('disabled', "disabled");
                    $('[id$="txtEmail"]').attr('disabled', "disabled");
                    $('[id$="ddlCardType"]').attr('disabled', "disabled");
                    $('[id$="txtCreditCardNumber"]').attr('disabled', "disabled");
                    $('[id$="ddlExpireMonth"]').attr('disabled', "disabled");
                    $('[id$="ddlExpireYear"]').attr('disabled', "disabled");
                    $('[id$="txtAmount"]').attr('disabled', "disabled");
                    $('[id$="btnPayNow"]').attr('disabled', "disabled");
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
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <table width="100%" align="center">

        <tr>
            <td colspan="2">
                <table  align="center">
                    <tr>
                        <td align="center">
                          Note: Please click on radio button to select payment type.
                            <br />
                            <asp:Literal ID="litmsg" runat="server"></asp:Literal>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <table  align="center">
                    <tr>
                        <td align="right">
                            <asp:Label ID="lbPaymentType" runat="server" Text="Payment Type:" Font-Bold="true">  
                            </asp:Label>
                           
                        </td>
                        <td style="text-align: left; vertical-align: top">
                            <asp:RadioButtonList ID="rblPaymentType" 
                                runat="server" 
                                RepeatColumns="3" 
                                CellPadding="3" TextAlign="right">
                                <asp:ListItem Value="1" Selected="True">Check/Cash</asp:ListItem>
                                <asp:ListItem Value="2" >Credit Card</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
         
        <tr>
            <td valign="top">
                <asp:UpdatePanel ID="upCheckInformation" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                <table cellpadding="3" cellspacing="0" width="100%"  >
                    <tr>
                        <td colspan="2" class="columnHeader">
                            Check/Cash
                        </td>
                    </tr>
                    <tr>
                        <td class="labelBoldRight">
                            Bank Name :
                        </td>
                        <td align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:TextBox ID="txtBankName" runat="server" Width="200px" CssClass="inputText" 
                               ValidationGroup="upCheckInformation" ToolTip="Start typing bank name.." 
                                MaxLength="50"></asp:TextBox>

                            <asp:RequiredFieldValidator 
                                    ID="rfvBankName" 
                                    runat="server" 
                                    ControlToValidate="txtBankName" 
                                    CssClass="bold" 
                                    Display="Dynamic"
                                    ValidationGroup="upCheckInformation"
                                    ForeColor="Red">Bank Name is required!</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelBoldRight">
                            Check No :
                        </td>
                        <td align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:TextBox ID="txtCheckNo" runat="server" Width="80px" CssClass="inputText" 
                              ValidationGroup="upCheckInformation"  ToolTip="Enter Check Number" 
                                MaxLength="10"></asp:TextBox>

                                <asp:RequiredFieldValidator 
                                    ID="rfvCheckNo" 
                                    runat="server" 
                                    ControlToValidate="txtCheckNo" 
                                    CssClass="bold" 
                                    Display="Dynamic"
                                    ValidationGroup="upCheckInformation"
                                    ForeColor="Red">Check No is required!</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelBoldRight">
                            Check Date :
                        </td>
                        <td align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:TextBox ID="txtCheckDate" runat="server" Width="80px" 
                              ValidationGroup="upCheckInformation"   CssClass="inputText" 
                                ToolTip="Enter Check Date" MaxLength="12"></asp:TextBox>

                            <asp:RequiredFieldValidator 
                                    ID="rfvCheckDate" 
                                    runat="server" 
                                    ControlToValidate="txtCheckDate" 
                                    CssClass="bold" 
                                    Display="Dynamic"
                                    ValidationGroup="upCheckInformation"
                                    ForeColor="Red">Check Date is required!</asp:RequiredFieldValidator>

                        </td>
                    </tr>
                    <tr>
                        <td class="labelBoldRight">
                            Bank Amount :
                        </td>
                        <td align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:TextBox ID="txtBankAmount" runat="server" Width="100px" 
                             ValidationGroup="upCheckInformation"   CssClass="inputText" ToolTip="Enter check amount"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelBoldRight">
                            &nbsp;
                        </td>
                        <td align="left" valign="top" style="text-align: left; vertical-align: top">
                            <asp:Button ID="btnUpdate" runat="server" CausesValidation="true" Font-Bold="True"
                                Text="Update" CssClass="btn" OnClick="btnUpdate_Click" 
                                ValidationGroup="upCheckInformation"
                                ToolTip="Click here to update check payment." />
                             &nbsp;<asp:Button ID="btnCancel" runat="server" CausesValidation="False" Font-Bold="True"
                            Text="Cancel" CssClass="btn" onclick="btnCancel_Click" ValidationGroup="upCheckInformation" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:TextBox ID="txtOrderID" runat="server" Visible="False" CssClass="inputtext"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                 </ContentTemplate>
             </asp:UpdatePanel>
            
            </td>
            
   
            <td valign="top">
                 <table border="0" cellpadding="3" cellspacing="0" width="100%"  >
                  <tr>
                        <td colspan="2" class="columnHeader">
                            Credit Card
                        </td>
                    </tr>
                <tr>
                    <td class="labelBoldRight" width="20%">Company Name:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="inputText" 
                            Width="160px" ToolTip="Enter your Company Name"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                                                ID="rfvCompanyName" 
                                                runat="server" 
                                                ControlToValidate="txtCompanyName" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Company Name is required!</asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator ID="revCompanyName" runat="server" ControlToValidate="txtCompanyName"
                            ErrorMessage="Please limit the length of the content entered to 50 characters"
                            ValidationExpression="^[\s\S]{0,50}$">*</asp:RegularExpressionValidator>
                    </td>
                  </tr>
                <tr>
                    <td class="labelBoldRight" width="20%">First Name:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="inputText" 
                            Width="160px" ToolTip="Enter Contact First Name"></asp:TextBox>



                        <asp:RequiredFieldValidator 
                                                ID="rfvFirstName" 
                                                runat="server" 
                                                ControlToValidate="txtFirstName" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">First Name is required!</asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtFirstName"
                            ErrorMessage="Please limit the length of the content entered to 40 characters"
                            ValidationExpression="^[\s\S]{0,40}$">*</asp:RegularExpressionValidator>
                    </td>
                  </tr>
                 <tr>
                    <td class="labelBoldRight" width="10%">Last Name:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="inputText" 
                            Width="160px" ToolTip="Enter Contact Last Name"></asp:TextBox>

                       <asp:RequiredFieldValidator 
                                                ID="rfvLastName" 
                                                runat="server" 
                                                ControlToValidate="txtLastName" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Last Name is required!</asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator ID="revLastName" runat="server" ControlToValidate="txtLastName"
                            ErrorMessage="Please limit the length of the content entered to 40 characters"
                             ValidationExpression="^[\s\S]{0,40}$">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                     <td class="labelBoldRight" width="10%">Address:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="inputText" 
                            MaxLength="60" Width="300px" ToolTip="Enter billing address"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                                                ID="rfvAddress" 
                                                runat="server" 
                                                ControlToValidate="txtAddress" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Address is required!</asp:RequiredFieldValidator>
                        
                        <asp:RegularExpressionValidator ID="revAddress" runat="server" ControlToValidate="txtAddress"
                            ErrorMessage="Please limit the length of the content entered to 60 characters"
                             ValidationExpression="^[\s\S]{0,60}$">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="labelBoldRight" width="10%">City:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="inputText" 
                            ToolTip="Enter billing city name"></asp:TextBox>
                        
                       <asp:RequiredFieldValidator 
                                                ID="rfvCity" 
                                                runat="server" 
                                                ControlToValidate="txtCity" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">City is required!</asp:RequiredFieldValidator>
                        
                        <asp:RegularExpressionValidator ID="revCity" runat="server" 
                            ControlToValidate="txtCity"
                            ErrorMessage="Please limit the length of the content entered to 40 characters"
                            ValidationExpression="^[\s\S]{0,40}$">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                  <tr>
                    <td class="labelBoldRight" width="10%">State:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                         <asp:DropDownList ID="ddlState" runat="server" Height="25px" 
                                            CssClass="select" ToolTip="Select billing state name"></asp:DropDownList>
                        
                         <asp:RequiredFieldValidator 
                                                ID="rfvState" 
                                                runat="server" 
                                                ControlToValidate="ddlState" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">State Code is required!</asp:RequiredFieldValidator>
                        
                       <%-- <asp:RegularExpressionValidator ID="revState" runat="server" 
                        ControlToValidate="txtState"
                            ErrorMessage="Please limit the length of the content entered to 40 characters"
                           ValidationExpression="^[\s\S]{0,40}$">*</asp:RegularExpressionValidator>--%>
                    </td>
                </tr>
                <tr>
                     <td class="labelBoldRight" width="10%">Zip:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtZip" runat="server" CssClass="inputText" 
                            ToolTip="Enter billing zip code"></asp:TextBox>
                        
                          <asp:RequiredFieldValidator 
                                                ID="rfvZip" 
                                                runat="server" 
                                                ControlToValidate="txtZip" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Zip Code is required!</asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator ID="revZip" runat="server" 
                            ControlToValidate="txtZip"
                            ErrorMessage="Please limit the length of the content entered to 15 characters"
                            ValidationExpression="^[\s\S]{0,15}$">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
               <tr>
                     <td class="labelBoldRight" width="10%">Phone:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="inputText" 
                            ToolTip="Enter company phone number."></asp:TextBox>
                        <asp:RequiredFieldValidator 
                                                ID="rfvPhone" 
                                                runat="server" 
                                                ControlToValidate="txtPhone" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Phone is required!</asp:RequiredFieldValidator>
                    </td>
                </tr>
               <tr>
                     <td class="labelBoldRight" width="10%">Email:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="inputText" 
                            Width="280px" ToolTip="Enter contact email address"></asp:TextBox>

                         <asp:RequiredFieldValidator 
                                                ID="rfvEmail" 
                                                runat="server" 
                                                ControlToValidate="txtEmail" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Email is required!</asp:RequiredFieldValidator>
                        
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                        ControlToValidate="txtEmail"
                            ErrorMessage="Please limit the length of the content entered to 255 characters"
                            ValidationExpression="^[\s\S]{0,255}$">*</asp:RegularExpressionValidator>
                        
                        <asp:RegularExpressionValidator ID="revEmailValid" runat="server"
                            ControlToValidate="txtEmail" ErrorMessage="Please Enter a valid Email Address"
                             ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                     <td class="labelBoldRight" width="10%" nowrap="nowrap">Credit Card Type:
                     </td>
                    <td style="text-align: left; vertical-align: top">
         

                       <asp:DropDownList ID="ddlCardType" runat="server" CssClass="select" 
                            ToolTip="Select credit card type">
                            <asp:ListItem Value="" Text="-- Select One --"></asp:ListItem>
                            <asp:ListItem Value="American Express" Text="American Express"></asp:ListItem>
                            <asp:ListItem Value="Discover" Text="Discover"></asp:ListItem>
                            <asp:ListItem Value="Master" Text="Master"></asp:ListItem>
                            <asp:ListItem Value="Visa" Text="Visa"></asp:ListItem>
                      
                        </asp:DropDownList>
                        
                       <asp:RequiredFieldValidator 
                                                ID="rfvCardType" 
                                                runat="server" 
                                                ControlToValidate="ddlCardType" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Credit Card Type is required!</asp:RequiredFieldValidator>
                        
                                  
                    </td>
                </tr>
                <tr>
                     <td class="labelBoldRight" width="10%" nowrap="nowrap">Credit Card Number:
                      <br />
                        <sup style="color: Red;">1111222233334444</sup>
                     </td>
                    <td style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtCreditCardNumber" runat="server" CssClass="inputText" 
                            MaxLength="22" Width="200px" 
                            ToolTip="Enter credit card number ( only numbers )"></asp:TextBox>
                        
                       <asp:RequiredFieldValidator 
                                                ID="rfvCreditCardNumber" 
                                                runat="server" 
                                                ControlToValidate="txtCreditCardNumber" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Credit Card Number is required!</asp:RequiredFieldValidator>
                        
                        <asp:RegularExpressionValidator ID="revCreditCardNumber" runat="server" ControlToValidate="txtCreditCardNumber"
                            ErrorMessage="Please Enter a valid Credit Card Number" 
                            ValidationExpression="^[\s\S]{0,22}$">*</asp:RegularExpressionValidator>
                       
                    </td>
                </tr>
                <tr>
                   <td class="labelBoldRight" width="10%">Expiration Month:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        
                        <asp:DropDownList ID="ddlExpireMonth" runat="server" CssClass="select" 
                            ToolTip="Enter credit card expiration month">
                            <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <%--<asp:ListItem Value="01" Text="01 - January"></asp:ListItem>
                            <asp:ListItem Value="02" Text="02 - February"></asp:ListItem>
                            <asp:ListItem Value="03" Text="03 - March"></asp:ListItem>
                            <asp:ListItem Value="04" Text="04 - April"></asp:ListItem>
                            <asp:ListItem Value="05" Text="05 - May"></asp:ListItem>
                            <asp:ListItem Value="06" Text="06 - June"></asp:ListItem>
                            <asp:ListItem Value="07" Text="07 - July"></asp:ListItem>
                            <asp:ListItem Value="08" Text="08 - August"></asp:ListItem>
                            <asp:ListItem Value="09" Text="09 - September"></asp:ListItem>
                            <asp:ListItem Value="10" Text="10 - October"></asp:ListItem>
                            <asp:ListItem Value="11" Text="11 - November"></asp:ListItem>
                            <asp:ListItem Value="12" Text="12 - December"></asp:ListItem>--%>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator 
                                ID="rfvExpireMonth" 
                                runat="server" 
                                ControlToValidate="ddlExpireMonth" 
                                CssClass="bold" 
                                Display="Dynamic"
                                ForeColor="Red">Credit Card Expire Month is required!</asp:RequiredFieldValidator>
                    </td>
                 </tr>
                    <tr>
                   <td class="labelBoldRight" width="10%">Expiration Year:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        
                        <asp:DropDownList ID="ddlExpireYear" runat="server" CssClass="select" 
                            ToolTip="Enter credit card expiration year">
                             <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <%--<asp:ListItem Value="08">2008</asp:ListItem>
                            <asp:ListItem Value="09">2009</asp:ListItem>
                            <asp:ListItem Value="10">2010</asp:ListItem>
                            <asp:ListItem Value="11">2011</asp:ListItem>
                            <asp:ListItem Value="12">2012</asp:ListItem>
                            <asp:ListItem Value="13">2013</asp:ListItem>
                            <asp:ListItem Value="14">2014</asp:ListItem>
                            <asp:ListItem Value="15">2015</asp:ListItem>
                            <asp:ListItem Value="16">2016</asp:ListItem>--%>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator 
                                ID="rfvExpireYear" 
                                runat="server" 
                                ControlToValidate="ddlExpireYear" 
                                CssClass="bold" 
                                Display="Dynamic"
                                ForeColor="Red">Credit Card Expire Year is required!</asp:RequiredFieldValidator>
                    </td>
                </tr>
                 <tr>
                   <td class="labelBoldRight" width="10%">Amount:</td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:TextBox ID="txtAmount" runat="server" Text="" CssClass="inputText" 
                            ToolTip="Enter payment amount."></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                                                ID="rfvAmount" 
                                                runat="server" 
                                                ControlToValidate="txtAmount" 
                                                CssClass="bold" 
                                                Display="Dynamic"
                                                ForeColor="Red">Amount is required!</asp:RequiredFieldValidator>
                        
                        <asp:CompareValidator ID="cvAmount" runat="server" Type="Currency" Operator="DataTypeCheck"
                            ErrorMessage="Invalid Amount, only numbers and '.' allowed"
                            ControlToValidate="txtAmount" CssClass="bold" Display="Dynamic"
                            ForeColor="Red">Invalid Amount, only numbers and '.' allowed</asp:CompareValidator><br />
                    </td>
                </tr>
            <tr>
                    <td>
                        &nbsp;
                    </td>
                    <asp:HiddenField ID="hfCutomerID" runat="server" />
                    <asp:HiddenField ID="hfOrderID" runat="server" />
                    <asp:HiddenField ID="hfMemberID" runat="server" />
                    <td align="left">
                        <asp:Button ID="btnPayNow" runat="server" Text="Pay Now"  CssClass="btn"
                            ToolTip="Click here to pay by credit card." onclick="btnPayNow_Click" />

                         &nbsp;<asp:Button ID="btnCancel2" runat="server" CausesValidation="False" Font-Bold="True"
                            Text="Cancel" CssClass="btn" onclick="btnCancel2_Click"  />

                        <br />
                    </td>
                </tr>
              
            </table>
            </td>
        </tr>
    </table>
</asp:Content>
