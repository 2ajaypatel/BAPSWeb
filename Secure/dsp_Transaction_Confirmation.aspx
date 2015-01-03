<%@ Page Title="Credit Card - Transaction Confirmation Summary" Language="C#" MasterPageFile="~/Secure/Calendar.master" AutoEventWireup="true" CodeFile="dsp_Transaction_Confirmation.aspx.cs" Inherits="Secure_dsp_Transaction_Confirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
<table border="0" cellpadding="3" cellspacing="0" width="90%" align="center"  >
    <tr>
        <td valign="top" width="50%" border="1">
            <table width="100%" >
               <tr>
                    <td colspan="2" class="columnHeader">
                        General Information
                    </td>
                </tr>
                <tr>
                    <td class="labelBoldRight">
                        Merchant : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        Swaminarayan Aksharpith, Inc
                    </td>
                </tr>
                <tr>
                    <td class="labelBoldRight">
                        DateTime : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbTransaction_Request_Date" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top" width="50%">
            <table width="100%">
                        <tr>
                    <td colspan="2" class="columnHeader">
                        Order Information
                    </td>
                </tr>
                <tr>
                    <td class="labelBoldRight">
                        Invoice : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbInvoice_Number" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td class="labelBoldRight">
                        PO Number : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbPO_Number" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
    
                <tr>
                    <td class="labelBoldRight">
                        Description : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbDescription" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td class="labelBoldRight">
                        Amount : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbAmount" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelBoldRight">
                        Payment Method : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbMethod" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelBoldRight">
                        Type : 
                    </td>
                    <td align="left" valign="top" style="text-align: left; vertical-align: top">
                        <asp:Label ID="lbTransaction_Type" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            
            </table>
        </td>
    </tr>
 
    <tr>
        <td valign="top">
            <table width="100%">
                    <tr>
        <td colspan="2" class="columnHeader">
            Results
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight">
            Response : 
        </td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:Label ID="lbResponse_Reason_Text" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight">
            Authorization Code : 
        </td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:Label ID="lbAuthorization_Code" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="labelBoldRight">
            Transaction ID : 
        </td>
        <td align="left" valign="top" style="text-align: left; vertical-align: top">
            <asp:Label ID="lbTransaction_ID" runat="server" Text=""></asp:Label>
        </td>
    </tr>
            
            </table>
        
        </td>
        <td valign="top">
            <table width="100%">
             <tr>
                <td colspan="2" class="columnHeader">
                    Customer Billing Information
                </td>
            </tr>
            <tr>
                <td class="labelBoldRight">
                    Customer ID : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbCustomerID" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelBoldRight">
                    First Name : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbFirstName" runat="server" Text=""></asp:Label>
                </td>
            </tr>
             <tr>
                <td class="labelBoldRight">
                    Last Name : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbLastName" runat="server" Text=""></asp:Label>
                </td>
            </tr>
             <tr>
                <td class="labelBoldRight">
                    Company : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbCompany" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelBoldRight">
                    Address : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbAddress" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelBoldRight">
                    City : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbCity" runat="server" Text=""></asp:Label>
                </td>
            </tr>
             <tr>
                <td class="labelBoldRight">
                    State : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbState" runat="server" Text=""></asp:Label>
                </td>
            </tr>

             <tr>
                <td class="labelBoldRight">
                    Zip Code : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbZip_Code" runat="server" Text=""></asp:Label>
                </td>
            </tr>

             <tr>
                <td class="labelBoldRight">
                    Phone : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbPhone" runat="server" Text=""></asp:Label>
                </td>
            </tr>

             <tr>
                <td class="labelBoldRight">
                    Email : 
                </td>
                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                    <asp:Label ID="lbEmail" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            </table>
                </td>

            </tr>
    
    
   
     <tr>
        
        <td colspan="2" align="center" valign="top" style=" vertical-align: top">
           
            <asp:Button ID="btnHome" runat="server" CssClass="btn" Text="Go Back To Home" 
                onclick="btnHome_Click" />
            
            &nbsp;&nbsp;
            <asp:Button ID="btnPrint" runat="server" Text="Print" UseSubmitBehavior="False" CssClass="btn" CausesValidation="False" OnClientClick="javascript:self.print();return false;"  />

        </td>
    </tr>

</table>
</asp:Content>

