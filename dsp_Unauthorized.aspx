<%@ Page Title="Access Denied - Unauthorized Access" Language="C#" MasterPageFile="~/Master/Main.master" AutoEventWireup="true" CodeFile="dsp_Unauthorized.aspx.cs" Inherits="dsp_Unauthorized" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <img src="Images/noaccess.gif" /></br></br>
<h1>We are sorry, but you are not authorized to view this page.</h1>
</br></br>
Please return to the 
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/dsp_Login.aspx">Login</asp:HyperLink> page.
</br></br>

Thank you.
</asp:Content>

