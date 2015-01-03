<%@ Page Title="" Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true" CodeFile="Center.aspx.cs" Inherits="Admin_Center" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <asp:GridView ID="gvCenterList" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" 
        BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" 
        CellPadding="2" DataSourceID="sqlDSSelectCenter" ForeColor="Black" 
        GridLines="None" Width="100%" DataKeyNames="CenterID">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="CenterName" HeaderText="CenterName" 
                SortExpression="CenterName" >
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Street" HeaderText="Street" 
                SortExpression="Street"  >
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" >
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Zip" HeaderText="Zip" 
                SortExpression="Zip" />
            <asp:BoundField DataField="regionname" HeaderText="Region" 
                SortExpression="regionname" />
            
            <asp:BoundField DataField="Phone" HeaderText="Phone" 
                SortExpression="Phone"  >
            </asp:BoundField>

            <asp:BoundField DataField="poCode" HeaderText="PO Code" 
                SortExpression="poCode"  >
            </asp:BoundField>


            <asp:BoundField DataField="CenterID" HeaderText="CenterID" 
                InsertVisible="False" ReadOnly="True" SortExpression="CenterID" />
            <asp:BoundField DataField="StateDescription" HeaderText="StateDescription" 
                SortExpression="StateDescription" >
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="Tan" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" 
            HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
        <SortedAscendingCellStyle BackColor="#FAFAE7" />
        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
        <SortedDescendingCellStyle BackColor="#E1DB9C" />
        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
    </asp:GridView>
    <asp:SqlDataSource ID="sqlDSSelectCenter" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [Center] WHERE [CenterID] = @CenterID" 
        InsertCommand="INSERT INTO [Center] ([CenterName], [Street], [City], [State], [Zip], [Region], [Phone]) VALUES (@CenterName, @Street, @City, @State, @Zip, @Region, @Phone)" 
        SelectCommand="SELECT c.State,c.CenterName, c.Street, c.City, c.Zip, c.Phone, c.CenterID ,c.poCode,sm.StateDescription ,rm.RegionDescription as regionname FROM Center c		JOIN StateMaster sm				ON c.state = sm.statecode 		JOIN regionmaster rm								ON c.regionid = rm.regionid ORDER BY c.CenterName" 
        UpdateCommand="UPDATE [Center] SET [CenterName] = @CenterName, [Street] = @Street, [City] = @City, [State] = @State, [Zip] = @Zip, [Region] = @Region, [Phone] = @Phone WHERE [CenterID] = @CenterID">
        <DeleteParameters>
            <asp:Parameter Name="CenterID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CenterName" Type="String" />
            <asp:Parameter Name="Street" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="Zip" Type="String" />
            <asp:Parameter Name="Region" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="poCode" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CenterName" Type="String" />
            <asp:Parameter Name="Street" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="Zip" Type="String" />
            <asp:Parameter Name="Region" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="CenterID" Type="Int32" />
            <asp:Parameter Name="poCode" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <center>
    <asp:DetailsView ID="dvCenterDetail" runat="server" AutoGenerateRows="False" 
        BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" 
        CellPadding="2" DataKeyNames="CenterID" DataSourceID="sdSelectCenterDetail" 
        ForeColor="Black" GridLines="None" Height="50px" Width="85%"
         OnItemUpdated="dvCenterDetail_ItemUpdated"
         OnItemUpdating="dvCenterDetail_ItemUpdating" 
         >

        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <CommandRowStyle HorizontalAlign="Center" />
        <EditRowStyle BackColor="LightGoldenrodYellow" ForeColor="Black" BorderColor="Blue" 
            HorizontalAlign="Right" />

        <FieldHeaderStyle Font-Bold="True" HorizontalAlign="Right" />

        <Fields>
            <asp:BoundField DataField="centerName" HeaderText="Center Name :" 
                SortExpression="centerName" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="Street" HeaderText="Street :" 
                SortExpression="Street" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City :" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

             <asp:TemplateField HeaderText="US Region :" Visible="true">
                <ItemStyle HorizontalAlign="Left" />
                    <EditItemTemplate>
                        <asp:DropDownList   ID="ddlbRegion" 
                                            runat="server" 
                                            AppendDataBoundItems="true"
                                            DataSourceID="sdRegion"
                                            DataTextField="regionname" 
                                            AutoPostBack="false" 
                                            SelectedValue='<%# Bind("regionid") %>'
                                            DataValueField="regionid">
                                 <asp:ListItem Text="none" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>

                    <ItemTemplate>
                    <asp:Label ID="lbregion" runat="server" Text='<%# Bind("regionname") %>'></asp:Label>
                </ItemTemplate>
               
            </asp:TemplateField>

            <asp:TemplateField HeaderText="State :" Visible="true">
                <ItemStyle HorizontalAlign="Left" />
                    <EditItemTemplate>
                        <asp:DropDownList   ID="ddlbState" 
                                            runat="server" 
                                            AppendDataBoundItems="true"
                                            DataSourceID="sdSelectState"
                                            DataTextField="StateDescription" 
                                            AutoPostBack="false" 
                                            SelectedValue='<%# Bind("State") %>'
                                            DataValueField="StateCode">
                                 <asp:ListItem Text="none" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbState" runat="server" Text='<%# Bind("State") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="Zip" HeaderText="Zip :" SortExpression="Zip" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

           <%-- <asp:BoundField DataField="Region" HeaderText="Region :" 
                SortExpression="Region" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>--%>

            <asp:BoundField DataField="Phone" HeaderText="Phone :" SortExpression="Phone" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="CenterID" HeaderText="CenterID :" 
                InsertVisible="False" ReadOnly="True" SortExpression="CenterID" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="poCode" HeaderText="PO Code :" SortExpression="poCode" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />

        </Fields>
        <FooterStyle BackColor="Tan" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" 
            HorizontalAlign="Center" />
    </asp:DetailsView>
        <br />
    </center>
    <asp:SqlDataSource ID="sdSelectCenterDetail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [Center] WHERE [CenterID] = @CenterID" 
        InsertCommand="INSERT INTO [Center] ([CenterName], [Street], [City], [State], [Zip], [Region], [Phone] ,[poCode],regionid) VALUES (@CenterName, @Street, @City, @State, @Zip, @Region, @Phone,@poCode,@regionid)" 
        SelectCommand="SELECT c.CenterName, c.Street, c.City, ltrim(rtrim(c.State)) as State, c.Zip, c.Region, c.Phone, c.CenterID , c.poCode, c.regionid,rm.RegionDescription as regionname FROM Center c		JOIN regionmaster rm				ON c.regionid = rm.regionid WHERE   [CenterID] = @CenterID" 
        UpdateCommand="UPDATE [Center] SET [CenterName] = @CenterName, [Street] = @Street, [City] = @City, [State] = @State, [Zip] = @Zip, [Region] = @Region, [Phone] = @Phone ,[poCode] = @poCode,[regionid] = @regionid WHERE [CenterID] = @CenterID">
        
        <SelectParameters>
             <asp:ControlParameter ControlID="gvCenterList" DefaultValue="-1" 
                    Name="CenterID" 
                    PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>

        <DeleteParameters>
            <asp:Parameter Name="CenterID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CenterName" Type="String" />
            <asp:Parameter Name="Street" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="Zip" Type="String" />
            <asp:Parameter Name="Region" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
             <asp:Parameter Name="poCode" Type="String" />
             <asp:Parameter Name="regionid" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CenterName" Type="String" />
            <asp:Parameter Name="Street" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="Zip" Type="String" />
            <asp:Parameter Name="Region" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="CenterID" Type="Int32" />
             <asp:Parameter Name="poCode" Type="String" />
             <asp:Parameter Name="regionid" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdSelectState" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        SelectCommand="SELECT ltrim(rtrim(StateCode)) as StateCode, [CountryCode], [StateDescription], [StateID] FROM [StateMaster] ORDER BY [StateCode]">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdRegion" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        SelectCommand="SELECT [RegionID], RegionDescription as regionname FROM [RegionMaster]">
    </asp:SqlDataSource>
</asp:Content>

