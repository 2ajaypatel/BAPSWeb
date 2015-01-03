<%@ Page Title="Add/Edit Users" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="dsp_UserMaster.aspx.cs" Inherits="Admin_UserMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <asp:GridView ID="gvUserMaster" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" 
        BorderWidth="1px" CellPadding="2" DataKeyNames="UserIDNumber" 
        DataSourceID="sdSelectUserMaster" ForeColor="Black" 
        AllowSorting="True" Width="100%">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
             
            <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="firstname" HeaderText="First" 
                SortExpression="firstname" />
            <asp:BoundField DataField="lastname" HeaderText="Last" 
                SortExpression="lastname" />
            <asp:BoundField DataField="UserID" HeaderText="UserID" 
                SortExpression="UserID" />
            <asp:BoundField DataField="UserPassword" HeaderText="User Password" 
                SortExpression="UserPassword" />
            <asp:CheckBoxField DataField="IsActive" HeaderText="Is Active?" 
                SortExpression="IsActive" />
            <asp:BoundField DataField="CenterName" HeaderText="Center Name" 
                SortExpression="CenterName" />
            <asp:BoundField DataField="RoleName" HeaderText="User Role" 
                SortExpression="RoleName" />
            <asp:BoundField DataField="UserIDNumber" HeaderText="UserIDNumber" 
                InsertVisible="False" ReadOnly="True" SortExpression="UserIDNumber" />
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
    <br />

    <asp:SqlDataSource ID="sdSelectUserMaster" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [UserMaster] WHERE [UserIDNumber] = @UserIDNumber" 
        SelectCommand="SELECT [firstname], [lastname], [MobilePhone], [HomePhone], [UserID], [email2], [UserPassword], [IsActive], [Center].[CenterName] as CenterName, [UserIDNumber] ,[UserRoles].[RoleName] as RoleName FROM [UserMaster] , [Center] ,[UserRoles] WHERE UserMaster.centerID = Center.CenterID AND UserMaster.RoleCode = UserRoles.RoleCode ORDER BY [UserMaster].[centerName], [UserMaster].[firstname], [UserMaster].[lastname] " >
        <DeleteParameters>
            <asp:Parameter Name="UserIDNumber" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <center>

    

    <asp:DetailsView ID="dvUserMasterDetail" runat="server" AutoGenerateRows="False" 
        BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" 
        CellPadding="2" DataKeyNames="UserIDNumber" DataSourceID="sdDataViewUserMaster" 
        ForeColor="Black" GridLines="None" Height="50px" Width="600px"
         OnItemUpdated="dvUserMasterDetail_ItemUpdated"
         OnItemUpdating="dvUserMasterDetail_ItemUpdating" 
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

            <asp:BoundField DataField="firstname" HeaderText="First Name :" 
                SortExpression="firstname" >
                <ControlStyle Width="300px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="lastname" HeaderText="Last Name :" 
                SortExpression="lastname" >
                    <ControlStyle Width="300px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="MobilePhone" HeaderText="Cell Phone :" 
                SortExpression="MobilePhone" >
                    <ControlStyle Width="200px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="HomePhone" HeaderText="Home Phone :" 
                SortExpression="HomePhone" >
                    <ControlStyle Width="200px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="UserID" HeaderText="User ID :" 
                SortExpression="UserID" >
                    <ControlStyle Width="300px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="email2" HeaderText="Email2 :" 
                SortExpression="email2" >
                    <ControlStyle Width="300px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:BoundField DataField="UserPassword" HeaderText="User Password :" 
                SortExpression="UserPassword" >
                    <ControlStyle Width="300px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:CheckBoxField DataField="IsActive" HeaderText="Is Active? :" 
                SortExpression="IsActive" >
                    <ItemStyle HorizontalAlign="Left" />
            </asp:CheckBoxField>

            
            <asp:BoundField DataField="UserIDNumber" HeaderText="UserIDNumber :" 
                InsertVisible="False" ReadOnly="True" SortExpression="UserIDNumber" >
                    <ControlStyle Width="300px" />
                    <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>

            <asp:TemplateField HeaderText="Center Name :" Visible="true">
                <ItemStyle HorizontalAlign="Left" />
                <EditItemTemplate>
                <asp:DropDownList   ID="ddlbCenterList" 
                                    runat="server" 
                                    AppendDataBoundItems="true"
                                    DataSourceID="sdSelectCenter"
                                    DataTextField="CenterName" 
                                    AutoPostBack="false" 
                                    SelectedValue='<%# Bind("centerID") %>'
                                    DataValueField="centerID">
                </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CenterName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="User Role :" Visible="true">
                <ItemStyle HorizontalAlign="Left" />
                <EditItemTemplate>
                <asp:DropDownList   ID="ddlbUserRoleList" 
                                    runat="server" 
                                    AppendDataBoundItems="true"
                                    DataSourceID="sdsUserRoles"
                                    DataTextField="RoleName" 
                                    AutoPostBack="false" 
                                    SelectedValue='<%# Bind("RoleCode") %>'
                                    DataValueField="RoleCode">
                </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CenterName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
        </Fields>
        <FooterStyle BackColor="Tan" HorizontalAlign="Center" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" HorizontalAlign="Right" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" 
            HorizontalAlign="Center" />
        <RowStyle HorizontalAlign="Left" />
    </asp:DetailsView>
    </center>
    <br />
    <asp:SqlDataSource ID="sdDataViewUserMaster" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        DeleteCommand="DELETE FROM [UserMaster] WHERE [UserIDNumber] = @UserIDNumber" 
        InsertCommand="INSERT INTO [UserMaster] ([centerName], [firstname], [lastname], [MobilePhone], [HomePhone], [UserID], [email2], [UserPassword], [IsActive], [centerID],[RoleCode]) VALUES (@centerName, @firstname, @lastname, @MobilePhone, @HomePhone, @UserID, @email2, @UserPassword, @IsActive, @centerID,@RoleCode)" 
        SelectCommand="SELECT [Center].[CenterName], [firstname], [lastname], [MobilePhone], [HomePhone], [UserID], [email2], [UserPassword], [IsActive],[RoleCode], [UserMaster].[centerID], [UserIDNumber] FROM [UserMaster] , [Center] WHERE [UserIDNumber] = @UserIDNumber  AND UserMaster.centerID = Center.CenterID " 
        UpdateCommand="UPDATE [UserMaster] SET [centerName] = @centerName, [firstname] = @firstname, [lastname] = @lastname, [MobilePhone] = @MobilePhone, [HomePhone] = @HomePhone, [UserID] = @UserID, [email2] = @email2, [UserPassword] = @UserPassword, [IsActive] = @IsActive, [RoleCode] = @RoleCode, [centerID] = @centerID WHERE [UserIDNumber] = @UserIDNumber" 
        >
      
         
         <SelectParameters>
             <asp:ControlParameter ControlID="gvUserMaster" DefaultValue="-1" 
                    Name="UserIDNumber" 
                    PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
        
        <DeleteParameters>
            <asp:Parameter Name="UserIDNumber" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="centerName" Type="String" />
            <asp:Parameter Name="firstname" Type="String" />
            <asp:Parameter Name="lastname" Type="String" />
            <asp:Parameter Name="MobilePhone" Type="String" />
            <asp:Parameter Name="HomePhone" Type="String" />
            <asp:Parameter Name="UserID" Type="String" />
            <asp:Parameter Name="email2" Type="String" />
            <asp:Parameter Name="UserPassword" Type="String" />
            <asp:Parameter Name="IsActive" Type="Boolean" />
            <asp:Parameter Name="centerID" Type="Int32" />
            <asp:Parameter Name="RoleCode" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="centerName" Type="String" />
            <asp:Parameter Name="firstname" Type="String" />
            <asp:Parameter Name="lastname" Type="String" />
            <asp:Parameter Name="MobilePhone" Type="String" />
            <asp:Parameter Name="HomePhone" Type="String" />
            <asp:Parameter Name="UserID" Type="String" />
            <asp:Parameter Name="email2" Type="String" />
            <asp:Parameter Name="UserPassword" Type="String" />
            <asp:Parameter Name="IsActive" Type="Boolean" />
            <asp:Parameter Name="centerID" Type="Int32" />
            <asp:Parameter Name="UserIDNumber" Type="Int32" />
            <asp:Parameter Name="RoleCode" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdSelectCenter" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        SelectCommand="SELECT [CenterName], [CenterID] FROM [Center]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUserRoles" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
        SelectCommand="SELECT RoleCode,Rolename FROM UserRoles">
    </asp:SqlDataSource>
</asp:Content>

