﻿<%@ Page Title="Gross Order Sale By Region and Center" Language="C#" MasterPageFile="~/Admin/Admin.master"
    AutoEventWireup="true" CodeFile="rpt_GrossOrderSaleByRegionCenter.aspx.cs" Inherits="Admin_rpt_GrossOrderSaleByRegionCenter" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="text-align: center; vertical-align: top">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <%--OnSelectedIndexChanged="ddlbRegion_SelectedIndexChanged--%>
                    <tr>
                        <td style="text-align: left; vertical-align: top" align="left" nowrap="nowrap" valign="top"
                            class="style3">
                            <strong>Select Region:</strong>
                            <asp:DropDownList ID="ddlbRegion" runat="server" Font-Size="Smaller" AppendDataBoundItems="True"
                                AutoPostBack="True" DataSourceID="sdRegionList" DataTextField="regionname" DataValueField="regionid"
                                OnSelectedIndexChanged="ddlbRegion_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="run" runat="server" Text="Export" CssClass="btn" 
                                onclick="export_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; vertical-align: top" align="center" valign="top">
                
            </td>
        </tr>
        <tr>
            <td>
                <asp:Chart ID="chartRegion" 
                        runat="server" 
                        Width="900px" 
                        Height="650px" 
                        BackColor="#C0C5CB"  
                        BorderlineColor="Olive"  
                        BorderlineDashStyle="Solid"  
                        BorderlineWidth="2" 
                        BackImageTransparentColor="White" 
                        Visible="true" ImageLocation="">
                        
                    <Titles>
                        <asp:Title 
                            Text=""
                            ForeColor="White"  
                            Docking="Top"  
                            BackColor="#834717"  
                            name="chartTitle"
                            Font="trebuchet ms, 13pt, style=Bold"  
                            BorderColor="DarkGreen"  >
                        </asp:Title>
                    </Titles>
                    <Legends>
                        <asp:Legend Name="Legend1" 
                                BackGradientStyle="DiagonalRight" 
                                BorderColor="Black" 
                                Docking="Bottom">
                        </asp:Legend>
                    </Legends>
                    <Series>
                        <asp:Series  Name="Series1" 
                            ToolTip="Previous Year Multi Page - Gross Sales: #VAL{C}" 
                            ChartArea="ChartArea1" 
                            IsValueShownAsLabel="True" 
                            ChartType="StackedColumn100" 
                            Color="#FFFF66" 
                            LegendText="Previous Year Multi Page">
                        </asp:Series>
                        <asp:Series Name="Series2" 
                                ToolTip="Current Year Multi Page - Gross Sales: #VAL{C}" 
                                ChartArea="ChartArea1"
                                IsValueShownAsLabel="True" 
                                 Color="#3399FF" 
                                LegendText="Current Year Multi Page" 
                                ChartType="StackedColumn100">
                        </asp:Series>
                        
                        <asp:Series Name="Series3" 
                                ToolTip="Previous Year Single Page - Gross Sales: #VAL{C}" 
                                ChartArea="ChartArea1"
                                IsValueShownAsLabel="True" 
                                Color="#00CC00" 
                                LegendText="Previous Year Single Page" 
                                ChartType="StackedColumn100">
                        </asp:Series>

                        <asp:Series Name="Series4" 
                            ToolTip="Current Year Single Page - Gross Sales: #VAL{C}" 
                            ChartArea="ChartArea1"
                            IsValueShownAsLabel="True" 
                             Color="#FF0066" 
                            LegendText="Current Year Single Page" 
                            ChartType="StackedColumn100">
                        </asp:Series>

                        
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1">
                            <AxisX Interval="1" TextOrientation="Rotated90">
                                <MajorGrid Enabled="false" />
                            </AxisX>
                            <AxisY>
                                <MajorGrid Enabled="false" />
                            </AxisY>
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
                <br />
            </td>
        </tr>
        <asp:SqlDataSource ID="sdRegionList" runat="server" ConnectionString="<%$ ConnectionStrings:BAPS_CALENDARConnectionString %>"
            SelectCommand="SELECT regionid,ltrim(rtrim(regiondescription)) as regionname from regionmaster WHERE regionid < 7">
        </asp:SqlDataSource>
    </table>
</asp:Content>
