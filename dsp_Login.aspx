<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Main.master" AutoEventWireup="true"
    CodeFile="dsp_Login.aspx.cs" Inherits="Secure_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <table  style="width: 100%;padding:5px 5px 5px 5px;" align="center">
        <tr>
            <td style="text-align: center; vertical-align: middle" align="center" width="100%">
                <b>Member's Login</b>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: middle" align="center" width="100%">
                <table  style="width: 100%;padding:5px 5px 5px 5px;" align="center">
                    <tr>
                        <td width="25%">&nbsp;</td>
                        <td class="labelBoldRight">
                            User Id:
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtUserID" runat="server" CssClass="inputText" Width="340px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                       <td width="25%">&nbsp;</td>
                        <td class="labelBoldRight">
                            Password:
                        </td>
                         <td align="left">
                            <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="inputText"
                                Width="340px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td style="text-align: left;" >
                             <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" CssClass="btn" />
                            &nbsp;<asp:Button ID="btnCancel" runat="server" CausesValidation="False" Text="Cancel"
                                CssClass="btn" />&nbsp;
                            <asp:Button ID="btnForgotPassword" runat="server" CssClass="btn" OnClick="btnForgotPassword_Click"
                                Text="Forgot your password?" ToolTip="Forgot your password, click here?" Width="124px" />&nbsp;
                            <asp:CheckBox ID="chkRememberMe" runat="server" Text="Remember Me" ToolTip="Remember User ID."
                                Checked="True" />
                                <%--&nbsp;&nbsp;&nbsp;
                                <asp:Literal ID="ltmsg" runat="server"></asp:Literal>--%>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
             <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
