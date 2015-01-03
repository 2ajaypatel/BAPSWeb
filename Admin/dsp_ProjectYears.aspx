<%@ Page Title="Add/Edit - Project Year" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="dsp_ProjectYears.aspx.cs" Inherits="dsp_ProjectYears" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
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
                url: '<%= ResolveClientUrl("~/Admin/ProjectYears.asmx/getProjectYears") %>',
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

        var IsCurrent = { 1:'YES', 0:'NO' };

        jQuery("#grid").jqGrid({
            autowidth:false,
            altRows: true, 
            headertitles: true,
            datatype: function (pdata) { getData(pdata); },
            ajaxSelectOptions: { type: "POST", contentType: "application/json; charset=utf-8" },
            colNames: ['ProjectYear ID','Project Year','Is Current Year?'],
            colModel: [
                    { name: 'ProjectYearID', index: 'ProjectYearID',key:true, width: 100, hidden: false, align: "center", editable:false,editoptions:{readonly:true,size:10} },
                    {   name: 'ProjectYear', 
                        index: 'ProjectYear',
                        key:false, 
                        width: 100, 
                        hidden: false, 
                        align: "center", 
                        edittype:'select',
                        editable:true,
                        editoptions: { 
                            dataUrl: '<%= ResolveClientUrl("~/Admin/ProjectYears.asmx/getYears") %>',
                                        buildSelect: function(data) {
                                            var retValue = $.parseJSON(data);
                                            var response = $.parseJSON(retValue.d);
                                             var html = '<select>'
                                             var total = response.length;
                                             var item;

                                            for (var i=0; i < total; i++) {
                                                item = response[i].ProjectYear;
                                                html += '<option value=' + item + '>' + item + '</option>';
                                            }
                                            html += '</select>';
                                            return html;
                                        }
                        } , 
                        editrules: { required: true} 
                    },
                    { 
                        name: 'IsCurrent', 
                        index: 'IsCurrent', 
                        width: 50, 
                        hidden: false, 
                        align: "center", 
                        edittype:'select',
                        editable: true, 
                        editoptions: { value: IsCurrent } , 
                        editrules: { required: true} 
                   },
                ],
            hidegrid: false,
            rowList: [2, 5, 10, 15],
            pager: '#pager',
            sortname: 'ProjectYear',
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
            caption: 'Project Year',
            height: 300,
            width: 800,
            editurl: '<%= ResolveClientUrl("~/Admin/ProjectYears.asmx/ProcessEditData") %>',
        });

        jQuery("#grid").jqGrid('navGrid', '#pager', 
            {   add:true,
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
                    editCaption: "Edit Project Year Detail",
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
                {
                    recreateForm: true,
                    closeAfterAdd: true,
                    modal:true,
                    width:400,
                    addCaption: "Add Project Year Detail",
                    resize : false
                    //,
//                    beforeSubmit: function(postdata,formid){

//                            postdata.RoleCode = postdata.RoleCode.toUpperCase();

//                            $.ajax({
//                                type: "POST",
//                                url:  '<%= ResolveClientUrl("~/Admin/Roles.asmx/isUserRoleCodeExists") %>',
//                                data: '{ "RoleCode": "' + postdata.RoleCode + '"}',
//                                contentType: 'application/json; charset=utf-8',
//                                dataType: "json",
//                                success: function (response) {
//                                    var isValid = response.d;
//                                    alert(response.d);
//                                        return [false];
//                                },
//                                failure: function (msg) {
//                                    alert('error');
//                                    return [false];
//                                }
//                            });
//                                        
//                    }
                },
                {
                    recreateForm: true,
                    closeAfterDel: true,
                    modal:true,
                    width:400,
                    caption: "Delete Project Year Detail",
                    resize : false
                
                },
                {
                },
                {
                }
                );

    </script>
</asp:Content>

