<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Main.master" AutoEventWireup="true" CodeFile="forgotPassword.aspx.cs" Inherits="Secure_forgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/js/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
    
 
   <script type="text/javascript">
       $(document).ready(function () {

           $('input[id$=txtUserID]').qtip({
               content: ' <b>Enter your userid.</b>.',
               position: { corner: { target: 'rightMiddle', tooltip: 'leftMiddle'} },
               style: { name: 'blue', tip: 'leftMiddle', border: { width: 2, radius: 1} },
               show: { when: { event: 'mouseover'} },
               hide: { when: { event: 'mouseout'} }
           });

           $('input[id$=btnSend]').qtip({
               content: 'Click here and system will email you password.',
               position: { corner: { target: 'topMiddle', tooltip: 'bottomMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue',
                   tip: 'bottomMiddle' // this will show tool tip triangle position.
               }
           });

           $('select[id$=ddlbCenter]').qtip({
               content: 'Select your center (Mandir).',
               position: { corner: { target: 'rightMiddle', tooltip: 'leftMiddle'} },
               style: {
                   width: 200,
                   padding: 5,
                   textAlign: 'center',
                   name: 'blue', 
                   tip: 'leftMiddle'
               }
           });

       });
</script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
           
         <table width="100%" style="width: 100%;" >
        <tr>
            <td style="text-align: center; vertical-align: middle" align="center" width="100%">
                <h1>Forgot Your Password?</h1>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: middle" align="center" width="100%">
                <table width="100%" style="width: 100%;" align="center" >
                    <tr>
                        <td class="labelBoldRed" colspan="3">
                            <asp:Label ID="lbErrorMessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                         <td class="style1">
                           
                        </td>
                        <td style="text-align: right" class="labelBoldRight">
                            User Id:
                        </td>
                        <td style="text-align: left">
                            <asp:TextBox  ID="txtUserID" runat="server" CssClass="inputText" Width="340px" 
                                 ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUserID" runat="server" 
                                ControlToValidate="txtUserID" CssClass="labelBoldRed" Display="Dynamic" 
                                ErrorMessage="User Id is required!"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                         <td class="style1">
                           
                        </td>
                        <td class="labelBoldRight">
                            Select Your Center:
                        </td>
                        <td style="text-align: left">
                            
                            <asp:DropDownList ID="ddlbCenter" runat="server" 
                                DataSourceID="sdsGetCenter" DataTextField="CenterName" 
                                DataValueField="CenterID" AppendDataBoundItems="True" CssClass="select" 
                                >
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCenter" runat="server" 
                                ControlToValidate="ddlbCenter" CssClass="labelBoldRed" 
                                ErrorMessage="Center name is required!" InitialValue="--Select--"></asp:RequiredFieldValidator>
                            
                        </td>
                    </tr>

                   <tr>
                        <td class="labelBoldRed" colspan="3">
                            Note: Your password will be emailed to you shortly once you send an request.
                        </td>
                    </tr>

                    <tr>
                        <td class="style1"></td>
                         <td>
                        </td>
                        <td style="text-align: left">
                            <asp:Button ID="btnSend" runat="server"  Text="Send" 
                                CssClass="btn" onclick="btnSend_Click" 
                                 />
                            &nbsp;<asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                                Text="Cancel" CssClass="btn" />

                            <asp:SqlDataSource ID="sdsGetCenter" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
                                SelectCommand="SELECT [CenterID], [CenterName] FROM [Center]">
                            </asp:SqlDataSource>
                            
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: middle" align="center" width="100%">
            </td>
        </tr>
    </table>
</asp:Content>

