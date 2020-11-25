<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="specifier.aspx.cs" Inherits="SaleSpec.pages.masters.specifier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="../trans/jquery-1.11.2.min.js"></script>

    <script>
        document.addEventListener("keyup", function (e) {
            var keyCode = e.keyCode ? e.keyCode : e.which;
            if (keyCode == 44) {
                stopPrntScr();
            }
        });

        function stopPrntScr() {

            var inpFld = document.createElement("input");
            inpFld.setAttribute("value", ".");
            inpFld.setAttribute("width", "0");
            inpFld.style.height = "0px";
            inpFld.style.width = "0px";
            inpFld.style.border = "0px";
            document.body.appendChild(inpFld);
            inpFld.select();
            document.execCommand("copy");
            inpFld.remove(inpFld);
        }
        function AccessClipboardData() {
            try {
                window.clipboardData.setData('text', "Access   Restricted");
            } catch (err) {
            }
        }

        setInterval("AccessClipboardData()", 300);

        window.onload = function () {
            document.addEventListener("contextmenu", function (e) {
                Swal.fire(
                    'This page is protected..!',
                    'Do not copy or export data.',
                    'error'
                )
                e.preventDefault();
            }, false);
            document.addEventListener("keydown", function (e) {
                //document.onkeydown = function(e) {
                // "C" key
                if (e.ctrlKey && e.keyCode == 67) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }


                // "F" key
                if (e.altKey && e.keyCode == 70) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "I" key
                if (e.ctrlKey && e.shiftKey && e.keyCode == 73) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "J" key
                if (e.ctrlKey && e.shiftKey && e.keyCode == 74) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }

                // "P" key
                if (e.ctrlKey && e.keyCode == 80) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }

                // "S" key + macOS
                if (e.keyCode == 83 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "U" key
                if (e.ctrlKey && e.keyCode == 85) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "V" key
                if (e.ctrlKey && e.keyCode == 86) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }

                // "F12" key
                if (event.keyCode == 123) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not open source tag.',
                        'error'
                    )
                    disabledEvent(e);
                }
            }, false);
            function disabledEvent(e) {
                if (e.stopPropagation) {
                    e.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }
                e.preventDefault();
                return false;
            }
        };

    </script>

    <!-- Header content -->
    <section class="content-header">
        <h1>Specifier Setup
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->
        <%= strMsgAlert %>

        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Specifier Details</h3>
                        <div class="pull-right">
                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                <i class="fa fa-plus"></i>
                            </button>
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click"><i class="fa fa-table"></i></button>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="example1" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <%--pagination pagination-sm--%>
                            <thead>
                                <tr>
                                    <td>ID</td>
                                    <td>Title</td>
                                    <td>FirstName</td>
                                    <td>LastName</td>
                                    <td>Description</td>
                                    <td class="hidden">EmpCode</td>
                                    <th style="width: 20px; text-align: center;">#</th>
                                    <th style="width: 20px; text-align: center;">#</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%= strTblDetail %>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>

        <!-- /.modal myModalNew -->
        <div class="modal modal-default fade" id="myModalNew">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">New Specifier</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">SpecID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtSpecID" name="txtSpecID" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Title</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtTitle" name="txtTitle" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtFirstName" name="txtFirstName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtLastName" name="txtLastName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">EmpCode</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtEmpCode" name="txtEmpCode" placeholder="" value="">
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <textarea class="form-control input input-sm" id="txtSpecDesc" name="txtSpecDesc" placeholder=""></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Status</div>
                                <div class="input-group col-md-8">
                                    <div class="col-md-12">
                                        <input type="text" id="txtStatusID" name="txtStatusID" class="form-control input input-sm txtLabel hidden" value="" />
                                        <input type="text" id="txtStatusDesc" name="txtStatusDesc" class="form-control input input-sm txtLabel" style="width: 84%" value="" readonly>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-warning btn-flat btn-sm" data-toggle="modal" data-target="#myModalActive">Find..!</button>
                                        </span>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnSaveNewData" onserverclick="btnSaveNewData_click" runat="server">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalEdit -->
        <div class="modal modal-default fade" id="q">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Specifier</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">SpecID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtSpecIDEdit" name="txtSpecIDEdit" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Title</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtTitleEdit" name="txtTitleEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtFirstNameEdit" name="txtFirstNameEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtLastNameEdit" name="txtLastNameEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">EmpCode</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtEmpCodeEdit" name="txtEmpCodeEdit" placeholder="" value="">
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <textarea class="form-control input input-sm" id="txtSpecDescEdit" name="txtSpecDescEdit" placeholder=""></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Status</div>
                                <div class="input-group col-md-8">
                                    <div class="col-md-12">
                                        <input type="text" id="txtStatusIDEdit" name="txtStatusIDEdit" class="form-control input input-sm txtLabel hidden" value="" />
                                        <input type="text" id="txtStatusDescEdit" name="txtStatusDescEdit" class="form-control input input-sm txtLabel" style="width: 84%" value="" readonly>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-warning btn-flat btn-sm" data-toggle="modal" data-target="#myModalActive">Find..!</button>
                                        </span>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitEdit" class="btn btn-primary" onclick="ValidateUpdate()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateDate" onserverclick="btnUpdateData_click" runat="server">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalDelete -->
        <div class="modal modal-default fade" id="myModalDelete">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Delete Specifier</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">SpecID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtSpecIDDel" name="txtSpecIDDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Title</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtTitleDel" name="txtTitleDel" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtFirstNameDel" name="txtFirstNameDel" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtLastNameDel" name="txtLastNameDel" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">EmpCode</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtEmpCodeDel" name="txtEmpCodeDel" placeholder="" value="">
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <textarea class="form-control input input-sm" id="txtSpecDescDel" name="txtSpecDescDel" placeholder=""></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Status</div>
                                <div class="input-group col-md-8">
                                    <div class="col-md-12">
                                        <input type="text" id="txtStatusIDDel" name="txtStatusIDDel" class="form-control input input-sm txtLabel hidden" value="" />
                                        <input type="text" id="txtStatusDescDel" name="txtStatusDescDel" class="form-control input input-sm txtLabel" style="width: 84%" value="" readonly>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-warning btn-flat btn-sm" data-toggle="modal" data-target="#myModalActive">Find..!</button>
                                        </span>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitDel" class="btn btn-danger" onclick="ValidateDelete()">Delete Confirm</button>
                        <button type="button" class="btn btn-primary hidden" id="btnDeleteData" onserverclick="btnDeleteData_click" runat="server">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalActiveNew not in use -->
        <div class="modal modal-default fade" id="myModalActiveNew">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Selected Active Status</h4>
                    </div>
                    <div class="modal-body">

                        <table id="tableActiveNew" class="table table-bordered table-striped table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descript</th>
                                    <th>Details</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%= strTblActive %>
                            </tbody>
                        </table>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <!-- /.modal myModalActive not in use -->
        <div class="modal modal-default fade" id="myModalActive">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Selected Active Status</h4>
                    </div>
                    <div class="modal-body">

                        <table id="tableActive" class="table table-bordered table-striped table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descript</th>
                                    <th>Details</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%= strTblActive %>

                                <%--  <tr>
                                            <td>0</td>
                                            <td>Not Active</td>
                                            <td>Not in use or status is holding</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" data-toggle="modal" class="" title="แก้ไข"><span class='glyphicon glyphicon-edit text-green'></span></a></td>
                                        </tr>
                                        <tr>
                                            <td>1</td>
                                            <td>Active</td>
                                            <td>Using status in affective</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" data-toggle="modal" class="" title="แก้ไข"><span class='glyphicon glyphicon-edit text-green'></span></a></td>
                                        </tr>
                                        <tr>
                                             <td>2</td>
                                            <td>Backlist</td>
                                            <td>Customers is wihtout business roles..!</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" data-toggle="modal" class="" title="แก้ไข"><span class='glyphicon glyphicon-edit text-green'></span></a></td>
                                        </tr>
                                --%>
                            </tbody>
                        </table>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <script>
            function openModal() {

                $("#myModalNew").modal({ backdrop: false });
                $('[id=myModalNew]').modal('show');
            }

            var table = document.getElementById("example1"), rIndex;
            for (var i = 1; i < table.rows.length; i++) {
                for (var j = 0; j < table.rows[i].cells.length; j++) {
                    table.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 6) {
                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strTitle = table.rows[rIndex].cells[1].innerHTML;
                            var strFirstName = table.rows[rIndex].cells[2].innerHTML;
                            var strLastName = table.rows[rIndex].cells[3].innerHTML;
                            var strDesc = table.rows[rIndex].cells[4].innerHTML;
                            var strEmpCode = table.rows[rIndex].cells[5].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtSpecIDEdit").value = strID;
                            document.getElementById("txtTitleEdit").value = strTitle;
                            document.getElementById("txtFirstNameEdit").value = strFirstName;
                            document.getElementById("txtLastNameEdit").value = strLastName;
                            document.getElementById("txtEmpCodeEdit").value = strEmpCode;
                            document.getElementById("txtSpecDescEdit").value = strDesc;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 7) {
                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strTitle = table.rows[rIndex].cells[1].innerHTML;
                            var strFirstName = table.rows[rIndex].cells[2].innerHTML;
                            var strLastName = table.rows[rIndex].cells[3].innerHTML;
                            var strDesc = table.rows[rIndex].cells[4].innerHTML;
                            var strEmpCode = table.rows[rIndex].cells[5].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtSpecIDDel").value = strID;
                            document.getElementById("txtTitleDel").value = strTitle;
                            document.getElementById("txtFirstNameDel").value = strFirstName;
                            document.getElementById("txtLastNameDel").value = strLastName;
                            document.getElementById("txtEmpCodeDel").value = strEmpCode;
                            document.getElementById("txtSpecDescDel").value = strDesc;


                            $("#myModalDelete").modal({ backdrop: false });
                            $("#myModalDelete").modal("show");

                        }
                    }
                }
            }



            var tableActive = document.getElementById("tableActive"), rIndex;
            for (var i = 1; i < tableActive.rows.length; i++) {
                for (var j = 0; j < tableActive.rows[i].cells.length; j++) {
                    tableActive.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 3) {
                            var strStatusID = tableActive.rows[rIndex].cells[0].innerHTML;
                            var strStatusDesc = tableActive.rows[rIndex].cells[1].innerHTML;
                            var strDetail = tableActive.rows[rIndex].cells[2].innerHTML;

                            document.getElementById("txtStatusID").value = strStatusID;
                            document.getElementById("txtStatusDesc").value = strStatusDesc;

                            document.getElementById("txtStatusIDEdit").value = strStatusID;
                            document.getElementById("txtStatusDescEdit").value = strStatusDesc;


                            $("#myModalActive").modal("hide");

                            //alert(strStatusID);
                        }

                    }
                }
            }

            var tableActiveNew = document.getElementById("tableActiveNew"), rIndex;
            for (var i = 1; i < tableActiveNew.rows.length; i++) {
                for (var j = 0; j < tableActiveNew.rows[i].cells.length; j++) {
                    tableActiveNew.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 3) {
                            var strStatusID = tableActiveNew.rows[rIndex].cells[0].innerHTML;
                            var strStatusDesc = tableActiveNew.rows[rIndex].cells[1].innerHTML;
                            var strDetail = tableActiveNew.rows[rIndex].cells[2].innerHTML;

                            document.getElementById("txtStatusIDNew").value = strStatusID;
                            document.getElementById("txtStatusNew").value = strStatusDesc;
                            $("#myModalActiveNew").modal("hide");

                            //alert(strStatusID);
                        }

                    }
                }
            }

            //$(function () {

            //    $("#myModalEdit").validate({
            //        rules: {
            //            txtCustTypeDesc: {
            //                required: true,
            //                minlength: 8
            //            },
            //            action: "required"
            //        },
            //        messages: {
            //            txtCustTypeDesc: {
            //                required: "Please enter some data",
            //                minlength: "Your data must be at least 8 characters"
            //            },
            //            action: "Please provide some data"
            //        }
            //    });
            //});

            function ValidateSave() {
                var str1 = document.getElementById("txtSpecID").value;
                var str2 = document.getElementById("txtFirstName").value;
                var str3 = document.getElementById("txtLastName").value;
                if (str1 != '' && str2 != '' && str3 != '') {
                    document.getElementById("<%=  btnSaveNewData.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str1 = document.getElementById("txtSpecIDEdit").value;
                var str2 = document.getElementById("txtFirstNameEdit").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        document.getElementById("<%= btnUpdateDate.ClientID %>").click();
                    }
                }
            }


            function ValidateDelete() {
                var str = document.getElementById("txtSpecIDDel").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteData.ClientID %>").click();
                }
            }
        </script>
    </section>

</asp:Content>
