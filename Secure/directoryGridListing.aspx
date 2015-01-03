<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Main.master" AutoEventWireup="true" CodeFile="directoryGridListing.aspx.cs" Inherits="Secure_directoryGridListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">

 <br />
    

        <asp:Literal ID="LitMessage" runat="server"></asp:Literal>

         <div>
       <h4>Select a file to upload:</h4>

       <asp:FileUpload id="FileUpload1"                 
           runat="server" CssClass="btn">
       </asp:FileUpload>

       <br /><br />

       <asp:Button id="UploadButton" 
           Text="Upload file"
           OnClick="UploadButton_Click"
           runat="server" CssClass="btn">
       </asp:Button>    

       <hr />

       <asp:Label id="UploadStatusLabel"
           runat="server">
       </asp:Label>        
    </div>
     
    <br /><br />
    <asp:DataGrid ID="DataGridFile" runat="server" CssClass="griddatastyle" Width="98%"
                AutoGenerateColumns="false" BorderColor="#cccccc" 
                OnItemCommand="DataGridFile_Command">

                <AlternatingItemStyle CssClass="GridAlternatingDataStyle"></AlternatingItemStyle>
                <PagerStyle ForeColor="White" BackColor="#6699CC"></PagerStyle>
                <HeaderStyle HorizontalAlign="Left" Font-Size="8pt" ForeColor="White" BackColor="#FF9900"
                    Wrap="False"></HeaderStyle>
                <ItemStyle Font-Size="Smaller"></ItemStyle>
                <Columns>
                     
                     <asp:ButtonColumn 
                     HeaderText="Delete File" 
                     ButtonType="LinkButton" 
                     Text="Delete" 
                     CommandName="Delete"/>

                    <asp:TemplateColumn>
                        <ItemTemplate>
                            <asp:CheckBox ID="chk" runat="server" />
                        </ItemTemplate>
                        <ItemStyle Width="1%" />
                    </asp:TemplateColumn>

                    <asp:BoundColumn Visible="False" DataField="Type" HeaderText="Type"></asp:BoundColumn>
                    
                    <asp:BoundColumn Visible="False" DataField="Name" HeaderText="HidName"></asp:BoundColumn>
                    
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <img  alt="" src="<%# DataBinder.Eval(Container, "DataItem.FileIcon")%>">
                            
                        </ItemTemplate>
                        <ItemStyle Width="5%" />
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            Name
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" CommandName='<%# DataBinder.Eval(Container.DataItem,"Type") %>'
                                CommandArgument='<%# DataBinder.Eval(Container.DataItem,"Name") %>' Text='<%# DataBinder.Eval(Container.DataItem,"Name") %>'
                                runat="server">LinkButton</asp:LinkButton></td>
                        </ItemTemplate>
                        <ItemStyle Width="50%" />
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            Grand.
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"Size") %>
                            K
                        </ItemTemplate>
                        <ItemStyle Width="15%" />
                    </asp:TemplateColumn>
                    <asp:BoundColumn HeaderText="Data Creation" DataField="CreationTime" SortExpression="CreationTime">
                        <ItemStyle Width="15%" Wrap="False" />
                    </asp:BoundColumn>
                </Columns>
            </asp:DataGrid></p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="AddressID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="AddressID" HeaderText="AddressID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="AddressID" />
                <asp:BoundField DataField="Address1" HeaderText="Address1" 
                    SortExpression="Address1" />
                <asp:BoundField DataField="Address2" HeaderText="Address2" 
                    SortExpression="Address2" />
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                <asp:BoundField DataField="StateID" HeaderText="StateID" 
                    SortExpression="StateID" />
                <asp:BoundField DataField="ZipCode" HeaderText="ZipCode" 
                    SortExpression="ZipCode" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>" 
            SelectCommand="SELECT * FROM [Address]"></asp:SqlDataSource>
    </p>
    <p>
    </p>

</asp:Content>

