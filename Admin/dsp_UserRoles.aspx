<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="dsp_UserRoles.aspx.cs" Inherits="Admin_dsp_UserRoles" %>
<%@ Register Assembly="Trirand.Web" TagPrefix="trirand" Namespace="Trirand.Web.UI.WebControls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<!-- The jQuery UI theme that will be used by the grid -->
    <link href="../Scripts/css/ui-lightness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
    
    
    <!-- The jQuery UI theme extension jqGrid needs -->
    <link rel="stylesheet" type="text/css" media="screen" href="../Scripts/js/trirand/themes/ui.jqgrid.css" />
    
    <!-- jQuery runtime minified -->
   <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    
    <!-- The localization file we need, English in this case -->
    <script src="../Scripts/js/trirand/i18n/grid.locale-en.js" type="text/javascript"></script>

    
    <!-- The jqGrid client-side javascript -->
    <script src="../Scripts/js/trirand/jquery.jqGrid.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">


<asp:SqlDataSource ID="sdsUserRoles" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [userroles] WHERE [RoleID] = @RoleID" 
        InsertCommand="INSERT INTO [userroles] ([RoleCode],[RoleName], [RoleDescription]) VALUES (@RoleCode,@RoleName, @RoleDescription)" 
        SelectCommand="SELECT [RoleID], [RoleCode], [RoleName], [RoleDescription] FROM [userroles]" 
        UpdateCommand="UPDATE [userroles] SET [RoleCode] = @RoleCode, [RoleName] = @RoleName,[RoleDescription] =  @RoleDescription WHERE [RoleID] = @RoleID">
        <DeleteParameters>
            <asp:Parameter Name="RoleID" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="RoleCode" Type="Int64" />
            <asp:Parameter Name="RoleName" Type="String" />
            <asp:Parameter Name="RoleDescription" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="RoleCode" Type="Int64" />
            <asp:Parameter Name="RoleName" Type="String" />
            <asp:Parameter Name="RoleDescription" Type="String" />
        </UpdateParameters>
    
    
    </asp:SqlDataSource>

<table align="center" width="100%">
    <tr>
        <td>
       
<trirand:JQGrid     runat="server" 
                    ID="jqGridUserRoles" 
                    DataSourceID="sdsUserRoles" 
                    AutoWidth="true" 
                    AddDialogSettings-Resizable="false" 
                    AddDialogSettings-Modal="true" 
                    EditDialogSettings-Resizable="false" 
                    EditDialogSettings-Modal="true"
                    ShrinkToFit="False">
        <AppearanceSettings HighlightRowsOnHover="true"/>
        <Columns>
            <trirand:JQGridColumn DataField="RoleID" PrimaryKey="True" HeaderText="Role ID" TextAlign="Center" />
            <trirand:JQGridColumn DataField="RoleCode" Editable="True"  HeaderText="Role Code" TextAlign="Center" />
             <trirand:JQGridColumn DataField="RoleName" Editable="true"  HeaderText="Role Name" TextAlign="Center" />
            <trirand:JQGridColumn DataField="RoleDescription" Editable="true"  HeaderText="Role Description" TextAlign="Center">
                <EditFieldAttributes>
                    <trirand:JQGridEditFieldAttribute Name="size" Value="40" />
                </EditFieldAttributes>
            </trirand:JQGridColumn>
        </Columns>        
        <ToolBarSettings ShowEditButton="true" ShowRefreshButton="True" ShowAddButton="true" ShowDeleteButton="false" />

         
         <EditDialogSettings CloseAfterEditing="true" Caption="Edit Selected User Role"   />  
    </trirand:JQGrid> 



    </td>
    </tr>
</table>
</asp:Content>

