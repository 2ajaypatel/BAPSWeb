<%@ Page Title="Add/Edit Regions" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="dsp_RegionMaster.aspx.cs" Inherits="dsp_RegionMaster" %>
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

 <asp:SqlDataSource ID="sdsRegionMaster" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [RegionMaster] WHERE [RegionID] = @RegionID" 
        InsertCommand="INSERT INTO [RegionMaster] ([RegionName], [RegionDescription]) VALUES (@RegionName, @RegionDescription)" 
        SelectCommand="SELECT [RegionID], [RegionName], [RegionDescription] FROM [RegionMaster]" 
        UpdateCommand="UPDATE [RegionMaster] SET [RegionName] = @RegionName, [RegionDescription] = @RegionDescription WHERE [RegionID] = @RegionID">
        <DeleteParameters>
            <asp:Parameter Name="RegionID" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="RegionName" Type="String" />
            <asp:Parameter Name="RegionDescription" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="RegionID" Type="Int64" />
            <asp:Parameter Name="RegionName" Type="String" />
            <asp:Parameter Name="RegionDescription" Type="String" />
        </UpdateParameters>
    
    
    </asp:SqlDataSource>

<table align="center" width="100%">
    <tr>
        <td>
        
       
<trirand:JQGrid     runat="server" 
                    ID="jqGridRegionMaster" 
                    DataSourceID="sdsRegionMaster" 
                    AutoWidth="true" 
                    AddDialogSettings-Resizable="false" 
                    AddDialogSettings-Modal="true" 
                    EditDialogSettings-Resizable="false" 
                    EditDialogSettings-Modal="true"
                    ShrinkToFit="False">
        <AppearanceSettings HighlightRowsOnHover="true"/>
        <Columns>
            <trirand:JQGridColumn DataField="RegionID" PrimaryKey="True" HeaderText="Region ID" TextAlign="Center" />
            <trirand:JQGridColumn DataField="RegionName" Editable="true"  HeaderText="Region Name" TextAlign="Center" />
            <trirand:JQGridColumn DataField="RegionDescription" Editable="true"  HeaderText="Region Description" TextAlign="Center" />
        </Columns>        
        <ToolBarSettings ShowEditButton="true" ShowRefreshButton="True" ShowAddButton="true" ShowDeleteButton="true"
            />

         <EditDialogSettings CloseAfterEditing="true" Caption="Edit Selected Region" />  
    </trirand:JQGrid> 

    </td>
    </tr>
</table>
</asp:Content>

