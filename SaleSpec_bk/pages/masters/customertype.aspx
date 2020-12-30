<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="customertype.aspx.cs" Inherits="SaleSpec.pages.masters.customertype" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="jquery-1.11.2.min.js"></script>

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
        <h1>Customers
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
                        <h3 class="box-title">Customer Type</h3>
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
                        <table id="example1" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%;">
                            <%--pagination pagination-sm--%>
                            <thead>
                                <tr>
                                    <th>CusTypeID</th>
                                    <th>Description</th>
                                    <th class="hide">StatusID</th>
                                    <th>Status</th>
                                    <th style="width: 20px; text-align: center;">#</th>
                                    <th style="width: 20px; text-align: center;">#</th>
                                </tr>
                            </thead>
                            <tbody>

                                <%= strTblDetail %>

                               <%-- <tr>
                                    <td>C1</td>
                                    <td>ARCHITECT</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C2</td>
                                    <td>TurnKeyThai</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C3</td>
                                    <td>TurnKeyNonThai</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C4</td>
                                    <td>Owner</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C5</td>
                                    <td>Government/University</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C6</td>
                                    <td>Developer</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C7</td>
                                    <td>Home Builder</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>
                                <tr>
                                    <td>C8</td>
                                    <td>Factory Builder</td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></>                             </td>
                                    <td style="width: 20px; text-align: center;">
                                        <a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></>
                                    </td>
                                </tr>--%>

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
                        <h4 class="modal-title">New Customer Type</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CustomerID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCustomerID" name="txtCustomerID" placeholder="" value=""  required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CustTypeDesc</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCustTypeDescNew" name="txtCustTypeDescNew" placeholder="" value="" required></div>
                            </div>

                            <div class="row hide" style="margin-bottom: 5px">
                                <div class="col-md-4">StatusID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtStatusIDNew" name="txtStatusIDNew" placeholder="" value="" required></div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Status</div>
                                <div class="input-group col-md-8">
                                    <div class="col-md-12">
                                        <input type="text" id="txtStatusNew" name="txtStatusNew" class="form-control input input-sm txtLabel" style="width: 84%" value="" required readonly>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-warning btn-flat btn-sm" data-toggle="modal" data-target="#myModalActiveNew">Find..!</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnSaveNewCustomer" onserverclick="btnSaveNewCustomer_click" runat="server" >Save Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Customer Type</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CustomerID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCustomerIDEdit" name="txtCustomerIDEdit" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CustTypeDesc</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCustTypeDesc" name="txtCustTypeDesc" placeholder="" value="" required></div>
                            </div>

                            <div class="row hide" style="margin-bottom: 5px">
                                <div class="col-md-4">StatusID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtStatusID" name="txtStatusID" placeholder="" value="" required></div>
                            </div>

                            <div class="row">

                                <div class="col-md-4">Status</div>
                                <div class="input-group col-md-8">
                                    <div class="col-md-12">
                                        <input type="text" id="txtStatusEdit" name="txtStatusEdit" class="form-control input input-sm txtLabel" style="width: 84%" value="" readonly>
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
                        <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateCustomer" onserverclick="btnUpdateCustomer_click" runat="server" >Update Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="myModalDelete">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Delete Customer Type</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CustomerID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCustomerIDDelete" name="txtCustomerIDDelete" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CustTypeDesc</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCustTypeDescDelete" name="txtCustTypeDescDelete" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row hide" style="margin-bottom: 5px">
                                <div class="col-md-4">StatusID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtStatusIDDelete" name="txtStatusIDDelete" placeholder="" value="" required></div>
                            </div>

                            <div class="row">

                                <div class="col-md-4">Status</div>
                                <div class="input-group col-md-8">
                                    <div class="col-md-12">
                                        <input type="text" id="txtStatusDelete" name="txtStatusDelete" class="form-control input input-sm txtLabel" style="width: 84%" value="" readonly>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-warning btn-flat btn-sm" data-toggle="modal" disabled data-target="#myModalActive">Find..!</button>
                                        </span>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitDelete" class="btn btn-danger" onclick="ValidateDelete()">Delete Confirme</button>
                        <button type="button" class="btn btn-danger hidden" id="btnDeleteCustomer" onserverclick="btnDeleteCustomer_click" runat="server" >Update Changes</button>
                    </div>
                </div>
            </div>
        </div>

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

                        if (this.cellIndex == 4) {
                            var strCustID = table.rows[rIndex].cells[0].innerHTML;
                            var strDesc = table.rows[rIndex].cells[1].innerHTML;
                            var strCustStatusID = table.rows[rIndex].cells[2].innerHTML;
                            var strStatusEdit = table.rows[rIndex].cells[3].innerHTML;

                            console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtCustomerIDEdit").value = strCustID;
                            document.getElementById("txtCustTypeDesc").value = strDesc;
                            document.getElementById("txtStatusID").value = strCustStatusID;
                            document.getElementById("txtStatusEdit").value = strStatusEdit;



                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 5) {
                            var strCustID = table.rows[rIndex].cells[0].innerHTML;
                            var strDesc = table.rows[rIndex].cells[1].innerHTML;
                            var strCustStatusID = table.rows[rIndex].cells[2].innerHTML;
                            var strStatusEdit = table.rows[rIndex].cells[3].innerHTML;

                            console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtCustomerIDDelete").value = strCustID;
                            document.getElementById("txtCustTypeDescDelete").value = strDesc;
                            document.getElementById("txtStatusIDDelete").value = strCustStatusID;
                            document.getElementById("txtStatusDelete").value = strStatusEdit;



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
                            var strStatusID= tableActive.rows[rIndex].cells[0].innerHTML;
                            var strStatusDesc = tableActive.rows[rIndex].cells[1].innerHTML;
                            var strDetail = tableActive.rows[rIndex].cells[2].innerHTML;

                            document.getElementById("txtStatusID").value = strStatusID;
                            document.getElementById("txtStatusEdit").value = strStatusDesc;
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
                var str1 = document.getElementById("txtCustomerID").value;
                var str2 = document.getElementById("txtCustTypeDescNew").value;
                var str3 = document.getElementById("txtStatusIDNew").value;
                if (str1 != '' && str2 != '' && str3 !='') {
                    document.getElementById("<%=  btnSaveNewCustomer.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str = document.getElementById("txtCustTypeDesc").value;
                if (str != '')
                {             
                    document.getElementById("<%= btnUpdateCustomer.ClientID %>").click();
                }      
            }

            function ValidateDelete() {
                var str = document.getElementById("txtCustomerIDDelete").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteCustomer.ClientID %>").click();
                }
            }
        </script>
    </section>
</asp:Content>
