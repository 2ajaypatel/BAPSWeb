<%@ Page Title="Swaminarayan Aksharpith, Inc. - Edit Roles" Language="C#" MasterPageFile="~/Admin/Admin.master"
    AutoEventWireup="true" CodeFile="dsp_Roles.aspx.cs" Inherits="Admin_dsp_Roles" %>

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
                url: '<%= ResolveClientUrl("~/Admin/roles.asmx/getRoles") %>',
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
            colNames: ['Role ID','Role Code','Role Name', 'Role Description'],
            colModel: [
                    { name: 'RoleID', index: 'RegionID',key:true, width: 100, hidden: true, align: "right", editable:false,editoptions:{readonly:true,size:10} },
                    { name: 'RoleCode', index: 'RoleCode',key:false, width: 100, hidden: false, align: "center", editable:true,editoptions: { size: 10} , editrules: { required: true} },
                    { name: 'RoleName', index: 'RoleName', width: 50, hidden: false, align: "center", editable: true, editoptions: { size: 50} , editrules: { required: true} },
                    { name: 'RoleDescription', index: 'RoleDescription', width: 100, hidden: false, editable: true, editoptions: { size: 100} , editrules: { required: true} },
                ],
            hidegrid: false,
            rowList: [2, 5, 10, 15],
            pager: '#pager',
            sortname: 'RoleName',
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
            caption: 'User Roles',
            height: 300,
            width: 900,
            editurl: '<%= ResolveClientUrl("~/Admin/Roles.asmx/ProcessEditData") %>',
        });

        jQuery("#grid").jqGrid('navGrid', '#pager', 
            {add:true,edit:true,del:true,search:false,refresh:true ,view:false, cloneToTop: true,
                                addtext: 'Add',
                                edittext: 'Edit',
                                deltext: 'Delete',
                                refreshtext: 'Reload',
                                viewtext: 'View'},
                            {
                                recreateForm: true,
                                closeAfterEdit: true,
                                modal:true,
                                width:600,
                                editCaption: "Edit Role Detail",
                                resize : false
                            },
                            {
                                recreateForm: true,
                                closeAfterAdd: true,
                                modal:true,
                                width:600,
                                addCaption: "Add Role Detail",
                                resize : false,
                                beforeSubmit: function(postdata,formid){

                                        postdata.RoleCode = postdata.RoleCode.toUpperCase();

                                        $.ajax({
                                            type: "POST",
                                            url:  '<%= ResolveClientUrl("~/Admin/Roles.asmx/isUserRoleCodeExists") %>',
                                           data: '{ "RoleCode": "' + postdata.RoleCode + '"}',
                                            contentType: 'application/json; charset=utf-8',
                                            dataType: "json",
                                            success: function (response) {
                                                var isValid = response.d;
                                                alert(response.d);
                                                 return [false];
                                            },
                                            failure: function (msg) {
                                                alert('error');
                                                return [false];
                                            }
                                        });
                                        
                                }
                            },
                            {
                                recreateForm: true,
                                closeAfterDel: true,
                                modal:true,
                                width:600,
                                caption: "Delete Role Detail",
                                resize : false
                
                            },
                            {
                            }
                            ,
                            {
                               
                
                            }
                            );

    </script>
</asp:Content>
