<%@ Page Title="Swaminarayan Aksharpith, Inc. - Edit Regions" Language="C#" MasterPageFile="~/Admin/Admin.master"
    AutoEventWireup="true" CodeFile="dsp_Regions.aspx.cs" Inherits="Admin_dsp_Regions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <table id="grid">
    </table>
    <div id="pager">
    </div>
    <script type="text/javascript">

        var grid = $("#grid");
        function getData(pData) {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: '<%= ResolveClientUrl("~/Admin/regions.asmx/getRegions") %>',
                data: '{}',
                dataType: "json",
                success: function (data, textStatus) {

                    if (textStatus == "success")
                        ReceivedClientData(jQuery.parseJSON(getMain(data)));
                        
                },
                error: function (data, textStatus) {
                    alert('An error has occured retrieving data!' + data);
                }
            });
        }

        function ReceivedClientData(data) {
            var thegrid = $("#grid");
            thegrid.clearGridData();
            for (var i = 0; i < data.length; i++)
                thegrid.addRowData(i + 1, data[i]);
        }
        function getMain(dObj) {
            if (dObj.hasOwnProperty('d'))
                return dObj.d;
            else
                return dObj;
        }


        jQuery("#grid").jqGrid({
            autowidth:true,
            altRows: true, 
            headertitles: true,
            datatype: function (pdata) { getData(pdata); },
            ajaxSelectOptions: { type: "POST", contentType: "application/json; charset=utf-8" },
            colNames: ['RegionID','Region Name', 'Region Description'],
            colModel: [
                    { name: 'RegionID', index: 'RegionID',key:true, width: 100, hidden: true, align: "right", editable:false,editoptions:{readonly:true,size:10} },
                    { name: 'RegionName', index: 'RegionName', width: 50, hidden: false, align: "center", editable: true, editoptions: { size: 50} , editrules: { required: true} },
                    { name: 'RegionDescription', index: 'RegionDescription', width: 100, hidden: false, editable: true, editoptions: { size: 100} , editrules: { required: true} },
                ],
            hidegrid: false,
            rowList: [2, 5, 10, 15],
            pager: '#pager',
            sortname: 'RegionName',
            sortorder: "desc",
            viewrecords: true,
            emptyrecords: 'No record found',
            loadtext: 'Loading...',
            jsonReader: {
                repeatitems: false,
                page: function (obj) { return 1; },
                total: function (obj) { return 1; },
                records: function (obj) { return 10; },
                userdata: "userData",
                id: 'Id'
            },
            caption: 'Region',
            height: 300,
            width: 900,
            editurl: '<%= ResolveClientUrl("~/Admin/regions.asmx/ProcessEditData") %>',
        });

        jQuery("#grid").jqGrid('navGrid', '#pager', 
            {   add:false,
                edit:true,
                del:false,
                search:false,
                refresh:true ,
                view:false,
                addtext: 'Add',
                edittext: 'Edit',
                deltext: 'Delete',
                refreshtext: 'Reload',
                viewtext: 'View'},
                            {
                                recreateForm: true,
                                closeAfterEdit: true,
                                closeAfterAdd: true,
                                modal:true,
                                width:600,
                                editCaption: "Edit Region",
                                resize : false
                            },
                            {
                                recreateForm: true,
                                closeAfterAdd: true,
                                modal:true,
                                width:600,
                                addCaption: "Add Region",
                                resize : false
                            },
                            {
                               afterShowForm: function(form) {
                                form.closest('div.ui-jqdialog').center();
                                }                            }
                            );

    </script>
</asp:Content>
