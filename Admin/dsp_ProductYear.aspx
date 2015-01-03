<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="dsp_ProductYear.aspx.cs" Inherits="Admin_dsp_ProductYear" Title="Add/Edit Product Year" %>
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
    <asp:SqlDataSource ID="sdsProjectYear" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [ProjectYear] WHERE [ProjectYearID] = @ProjectYearID" 
        InsertCommand="INSERT INTO [ProjectYear] ([ProjectYear], [IsCurrent]) VALUES (@ProjectYear, @IsCurrent)" 
        SelectCommand="SELECT [ProjectYearID], [ProjectYear], [IsCurrent] FROM [ProjectYear]" 
        UpdateCommand="UPDATE [ProjectYear] SET [ProjectYear] = @ProjectYear, [IsCurrent] = @IsCurrent WHERE [ProjectYearID] = @ProjectYearID">
        <DeleteParameters>
            <asp:Parameter Name="ProjectYearID" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProjectYear" Type="Int32" />
            <asp:Parameter Name="IsCurrent" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ProjectYearID" Type="Int64" />
            <asp:Parameter Name="ProjectYear" Type="Int32" />
            <asp:Parameter Name="IsCurrent" Type="Boolean" />
        </UpdateParameters>
    
    
    </asp:SqlDataSource>

<table align="center" width="100%">
    <tr>
        <td>
        
       
<trirand:JQGrid runat="server" ID="jqGridProjectYear" DataSourceID="sdsProjectYear" AutoWidth="true" AddDialogSettings-Resizable="false" AddDialogSettings-Modal="true" EditDialogSettings-Resizable="false" EditDialogSettings-Modal="true"
        
        ShrinkToFit="False">
        <AppearanceSettings HighlightRowsOnHover="true" />
        <Columns>
            <trirand:JQGridColumn DataField="ProjectYearID" PrimaryKey="True" HeaderText="Project Year ID" TextAlign="Center" />
            <trirand:JQGridColumn DataField="ProjectYear" Editable="true"  HeaderText="Project Year" TextAlign="Center" />
            <trirand:JQGridColumn DataField="IsCurrent" Editable="true"  HeaderText="Is Current Year?" TextAlign="Center" />
        </Columns>        
        <ToolBarSettings ShowEditButton="true" ShowRefreshButton="True" ShowAddButton="true" ShowDeleteButton="true"
             />

         <EditDialogSettings CloseAfterEditing="true" Caption="Edit Selected Project Year" />  
    </trirand:JQGrid> 

    </td>
    </tr>
</table>
</asp:Content>

