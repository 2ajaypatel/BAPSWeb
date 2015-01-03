<%@ Page Title="Advertisement - Upload" Language="C#" MasterPageFile="~/Secure/Calendar.master" AutoEventWireup="true" CodeFile="dsp_UploadAdvertisement.aspx.cs" Inherits="Secure_dsp_UploadAdvertisement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="../Scripts/jquery.ui.core.min.js" type="text/javascript"></script>
        <link href="../Scripts/css/ui-lightness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
        <script src="../Scripts/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>
        <%--<script src="../Scripts/jquery.ui.tabs.min.js" type="text/javascript"></script>
        <script src="../Scripts/jquery.ui.core.min.js" type="text/javascript"></script>
        <script src="../Scripts/jquery.ui.widget.min.js" type="text/javascript"></script>--%>

<script type="text/javascript">
    $(function () {
        $("#myTabs").tabs({ fx: { opacity: "toggle"} });
    });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">

    <table width="100%" align="center" >
    <tr>
        <td align="center">
            <h1>Upload Advertisement</h1>
        </td>
    </tr>
    <tr>
        <td>
                <div id="myTabs" style="width:100%;">
                    <ul>
                        <li><a href="#tab-1">Upload Advertisement</a></li>
                        <li><a href="#tab-2">View Single-Page Templates</a></li>
                        <li><a href="#tab-3">View Multi-Page Templates</a></li>
                        
                    </ul>


                    <div id="tab-2">
                        <table width="100%" align="center">
                            <tr>
                                <td align="center">
                                 <%--  if you leave this attribute then it opens pdf in same browser otherwise same window
                                  Target="_blank"
                                  
                                  --%>
                                    <asp:HyperLink 
                                        Target="_blank"
                                        Text='<img src="../templateimg/Template1-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="singletp1" 
                                        NavigateUrl="~/templateimg/Template1-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                        <br />
                                        <h2>Template 1</h2> 
                                </td>
                                <td align="center">
                                     <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template2-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink2" 
                                        NavigateUrl="~/templateimg/Template2-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 2</h2> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                             <tr>
                               <td align="center">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template3-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink3" 
                                        NavigateUrl="~/templateimg/Template3-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 3</h2> 
                                </td>
                                <td align="center">
                                     <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template4-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink4" 
                                        NavigateUrl="~/templateimg/Template4-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 4</h2> 
                                </td>
                            </tr>
                             <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                               <td align="center">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template5-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink5" 
                                        NavigateUrl="~/templateimg/Template5-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 5</h2> 
                                </td>
                                <td align="center">
                                     <asp:HyperLink 
                                      Target="_blank"
                                        Text='<img src="../templateimg/Template6-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink6" 
                                        NavigateUrl="~/templateimg/Template6-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 6</h2> 
                                </td>
                            </tr>
                             <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                               <td align="center" colspan="2">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template7-Single Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink7" 
                                        NavigateUrl="~/templateimg/Template7-Single Page-10.5x2.5inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 7</h2> 
                                </td>
                            </tr>
                        </table>
                    </div>  
                    <div id="tab-3">
                        <table width="100%" align="center">
                            <tr>
                                <td align="center">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template1-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="Multitp1" 
                                        NavigateUrl="~/templateimg/Template1-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                        <br />
                                        <h2>Template 1</h2> 
                                </td>
                                <td align="center">
                                     <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template2-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink8" 
                                        NavigateUrl="~/templateimg/Template2-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 2</h2> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                             <tr>
                               <td align="center">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template3-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink9" 
                                        NavigateUrl="~/templateimg/Template3-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 3</h2> 
                                </td>
                                <td align="center">
                                     <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template4-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink10" 
                                        NavigateUrl="~/templateimg/Template4-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 4</h2> 
                                </td>
                            </tr>
                             <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                               <td align="center">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template5-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink11" 
                                        NavigateUrl="~/templateimg/Template5-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 5</h2> 
                                </td>
                                <td align="center">
                                     <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template6-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink12" 
                                        NavigateUrl="~/templateimg/Template6-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 6</h2> 
                                </td>
                            </tr>
                             <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                               <td align="center" colspan="2">
                                    <asp:HyperLink 
                                         Target="_blank"
                                        Text='<img src="../templateimg/Template7-Multi Page_1.jpg" border="0"  />'
                                        runat="server" 
                                        id="HyperLink13" 
                                        NavigateUrl="~/templateimg/Template7-Multi Page-11.3x2.4inches.pdf" ></asp:HyperLink>
                                         <br />
                                        <h2>Template 7</h2> 
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tab-1">
                        <table width="100%" align="center" >
                           <tr>
                                <td colspan="2" align="center" >
                                Note: Your file name will be renamed by system as follow as ( xxxxYYYY.zzz ) <br />
                                        xxxx - Your File Name <br />
                                        YYYY - Order Id Number<br />
                                        .zzz - Your file extension.
                                </td>
                            </tr>
                            <tr>
                               <td colspan="2" align="center">
                                        <asp:Label 
                                            ID="Label2" 
                                            runat="server" 
                                            CssClass="labelBoldRed" 
                                            Text="If you have multiple files to upload for an advertisement, please select same calendar template from the dropdown.">
                                            </asp:Label>
                               </td>
                            </tr>
                             <tr>
                                <td colspan="2" align="center"><asp:Label ID="lbMessage" runat="server" CssClass="labelBoldRed"></asp:Label></td>
                            </tr>
                            
                            <tr>
                                <td colspan="2" align="center">
                                        <asp:RequiredFieldValidator 
                                                    ID="rfvTemplate" 
                                                    runat="server" 
                                                    Font-Bold="True" 
                                                    ForeColor="Red"
                                                    Display="Dynamic"
                                                    ErrorMessage="Calendar Template selection is required field. Please select from drop down list." 
                                                    ControlToValidate="ddlTemplate" 
                                                    ValidationGroup="btnUpdate" 
                                                    InitialValue="--Select--" ></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator 
                                            id="revFileType" 
                                            runat="server" 
                                            ErrorMessage="Error: Only doc, pdf, jpeg, jpg or eps files are allowed!" 
                                            ValidationExpression="^.+(.doc|.pdf|.jpeg|.jpg|.docx)$"
                                            ControlToValidate="fileupload" 
                                             ValidationGroup="btnUpdate" 
                                             Display="Dynamic"
                                            Font-Bold="True" 
                                            ForeColor="Red"></asp:RegularExpressionValidator>
                                          <br />
                                          <asp:RequiredFieldValidator 
                                            ValidationGroup="btnUpdate" 
                                            id="revRequired" 
                                            runat="server" 
                                            ErrorMessage="Calendar Advertisement File selection is a required field!" 
                                            ControlToValidate="fileupload" 
                                            Display="Dynamic"
                                            Font-Bold="True" 
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                         <br />
                                         
                                </td>
                            </tr>

                            <tr>
                                <td class="labelBoldRight">Select Calendar Template :</td>
                                <td>
                                    <asp:DropDownList ID="ddlTemplate" runat="server" width="145px" ValidationGroup="btnUpdate" >
                                        <asp:ListItem Text="--Select--" Value="--Select--" Selected="true"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 1" Value="Template1-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 2" Value="Template2-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 3" Value="Template3-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 4" Value="Template4-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 5" Value="Template5-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 6" Value="Template6-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Single Page - Template 7" Value="Template7-Single Page-10.5x2.5inches.pdf"></asp:ListItem>
                                        
                                        <asp:ListItem Text="Multi Page - Template 1" Value="Template1-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Multi Page - Template 2" Value="Template2-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Multi Page - Template 3" Value="Template3-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Multi Page - Template 4" Value="Template4-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Multi Page - Template 5" Value="Template5-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Multi Page - Template 6" Value="Template6-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>
                                        <asp:ListItem Text="Multi Page - Template 7" Value="Template7-Multi Page-11.3x2.4inches.pdf"></asp:ListItem>

                                     </asp:DropDownList>
                                   
                                   
                                </td>
                            </tr>

                            <tr>
                                <td class="labelBoldRight">Calendar Advertisement file:</td>
                                <td align="left" valign="top" style="text-align: left; vertical-align: top">
                                        <asp:FileUpload ID="fileupload" runat="server" ValidationGroup="btnUpdate" 
                                        CssClass="inputText" Width="300px" 
                                        ToolTip="Click on browse button to select your advertisement file." /></td>
                            </tr>

                            <tr>
                                <td class="labelBoldRight"></td>
                                <td align="left" valign="top" style="text-align: left; vertical-align: top"> 
                                <asp:Button ID="btnUpload" runat="server" Text="Upload File" CssClass="btn"  ValidationGroup="btnUpdate" 
                                        onclick="btnUpload_Click" ToolTip="Click here to upload file." />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
                                        onclick="btnCancel_Click" />
                                        </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <asp:GridView 
                                        ID="gvFile" 
                                        runat="server" 
                                        BackColor="White" 
                                        BorderColor="#2E2842" 
                                        BorderStyle="Solid" 
                                        CssClass="mGrid"
                                        BorderWidth="1px" 
                                        CellPadding="4" 
                                        DataKeyNames="id" 
                                        AutoGenerateColumns="false" 
                                        onrowcancelingedit="gvFile_RowCancelingEdit" 
                                        onrowdeleting="gvFile_RowDeleting" 
                                        onrowediting="gvFile_RowEditing" 
                                        onrowupdating="gvFile_RowUpdating" 
                                        Width="100%" >

                                        <AlternatingRowStyle BackColor="#E8E8E8" />
                                            <FooterStyle BackColor="#2E2842" ForeColor="#FFFFCC" />
                                            <HeaderStyle BackColor="#2E2842" Font-Bold="True" ForeColor="#FFFFCC" />
                                    <Columns>
            
                                        <asp:BoundField DataField="Filename" HeaderText="File Name"  ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="FileExtension" HeaderText="File Extension" ItemStyle-HorizontalAlign="Center"  />
                                        <asp:TemplateField HeaderText="File Size" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#   GetSize(DataBinder.GetPropertyValue(Container.DataItem, "fileSize"))%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Modified" HeaderText="Last Modified" ItemStyle-HorizontalAlign="Center"  />
                                        <asp:BoundField DataField="SelectedTemplate" HeaderText="Selected Template" ItemStyle-HorizontalAlign="Center"  />
                                        
                 
                
                                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center">
                                            <itemtemplate>
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#  String.Format("~/UploadedAD/{0}",Eval("FileName"))%>'>
                                                    <asp:Image ID="Image1" runat="server" BorderWidth="0"  ImageUrl="~/Images/viewfile.png" ToolTip="Click here to download/view file"   />
                                                </asp:HyperLink> 
                                            </itemtemplate>
                                          </asp:TemplateField>

                           
                                            <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDelete" CommandName="Delete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this record?');">
                                                    <asp:Image ID="Image2" src='../Images/deletefile.png' runat="server" border='0' title='Click here to delete advertisement.' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
        </td>
    </tr>
    </table>

    
</asp:Content>

