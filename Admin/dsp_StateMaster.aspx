<%@ Page Title="Swaminarayan Aksharpith, Inc. - Edit State" Language="C#" MasterPageFile="~/Admin/Admin.master"
    AutoEventWireup="true" CodeFile="dsp_StateMaster.aspx.cs" Inherits="Admin_dsp_StateMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
div.centered {
    position: fixed;
    top: 50%;
    left: 50%;
    margin-top: -50px;
    margin-left: -100px;
}
</style>
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
                url: '<%= ResolveClientUrl("~/Admin/StateMasters.asmx/getStateMasters") %>',
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
            autowidth:false,
            altRows: true, 
            headertitles: true,
            datatype: function (pdata) { getData(pdata); },
            ajaxSelectOptions: { type: "POST", contentType: "application/json; charset=utf-8" },
            colNames: ['State ID','State Code','State Description', 'Country Code', 'State Tax Rate'],
            colModel: [
                    { name: 'StateID', index: 'StateID',key:true, width: 10, hidden: true, align: "right", editable:true,editoptions:{size:10} },
                    { name: 'StateCode', index: 'StateCode',key:false, width: 10, hidden: false, align: "center", editable:true,editoptions:{readonly:true,size:10} },
                    { name: 'StateDescription', index: 'StateDescription', width: 20, hidden: false, align: "center", editable:true,editoptions:{readonly:true,size:30} },
                    { name: 'CountryCode', index: 'CountryCode', width: 10, hidden: false,align: "center", editable: true, editable:true,editoptions:{readonly:true,size:10} },
                    { name: 'StateTaxRate', index: 'StateTaxRate',key:false, width: 20, hidden: false, align: "center", editable:true,editoptions:{size:25}, editrules: { required: true},formatter: 'number', formatoptions: { decimalPlaces: 2 }  },
                ],
            hidegrid: false,
            rowList: [2, 5, 10, 15],
            pager: '#pager',
            sortname: 'StateDescription',
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
            caption: 'State Detail',
            height: 300,
            width: 900,
            editurl: '<%= ResolveClientUrl("~/Admin/StateMasters.asmx/ProcessEditData") %>',
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
                                modal:true,
                                width:400,
                                editCaption: "Edit State Master Detail",
                                resize : false,
                                beforeShowForm: function(form) {
                                    //alert('adding' + "#editmod" + grdNames[0].id);
                                    var dlgDiv = $("#editmod" + grid[0].id);
                                    var parentDiv = dlgDiv.parent(); // div#gbox_list
                                    var dlgWidth = dlgDiv.width();
                                    var parentWidth = parentDiv.width();
                                    var dlgHeight = dlgDiv.height();
                                    var parentHeight = parentDiv.height();

                                    // Grabbed jQuery for grabbing offsets from here:
                                    var parentTop = parentDiv.offset().top;
                                    var parentLeft = parentDiv.offset().left;


                                    // HINT: change parentWidth and parentHeight in case of the grid
                                    //       is larger as the browser window
                                    dlgDiv[0].style.top =  Math.round(  parentTop  + (parentHeight-dlgHeight)/2  ) + "px";
                                    dlgDiv[0].style.left = Math.round(  parentLeft + (parentWidth-dlgWidth  )/2 )  + "px";
                               }
                            },
                            {},
                            {}
                            );
         jQuery("#grid").jqGrid('filterToolbar', {stringResult: true, searchOnEnter: false, defaultSearch : "cn"});

    </script>
</asp:Content>
