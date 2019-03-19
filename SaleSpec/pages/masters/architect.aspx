<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architect.aspx.cs" Inherits="SaleSpec.pages.masters.architect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <h1>Architecture Setup
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
                        <h3 class="box-title">Architect Details</h3>
                        <div class="pull-right">
                            <%--<a class="btn btn-default btn-sm checkbox-toggle" href="../../pages/trans/apprequest-new?opt=sarc"><i class="fa fa-plus"></i></a>--%>
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
                                    <td>ArchitecID </td>
                                   
                                    <td>FirstName</td>
                                    <td>LastName</td>
                                    <td>NickName</td>
                                    <td>Position</td>
                                    <td>Address</td>
                                    <td>Phone</td>
                                    <td>Mobile</td>
                                    <td>Email</td>
                                    <td>Status</td>
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
                        <h4 class="modal-title">New Architect</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectID" name="txtArchitectID" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtFirstName" name="txtFirstName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLastName" name="txtLastName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">NickName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtNickName" name="txtNickName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Position</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPosition" name="txtPosition" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address</div>
                                <div class="col-md-8">
                                    <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                    <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" ></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhone" name="txtPhone" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobile" name="txtMobile" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmail" name="txtEmail" placeholder="" value="" required>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnSaveNewData" onserverclick="btnSaveNewData_click" runat="server" >Save Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalEdit -->
        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Architecture</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectIDEdit" name="txtArchitectIDEdit" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtFirstNameEdit" name="txtFirstNameEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLastNameEdit" name="txtLastNameEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">NickName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtNickNameEdit" name="txtNickNameEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Position</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPositionEdit" name="txtPositionEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address</div>
                                <div class="col-md-8">
                                    <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit" placeholder="" value="" required>--%>
                                    <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit" ></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneEdit" name="txtPhoneEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobileEdit" name="txtMobileEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmailEdit" name="txtEmailEdit" placeholder="" value="" required>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData" onserverclick="btnUpdateData_click" runat="server" >Update Changes</button>
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
                        <h4 class="modal-title">Delete Architect</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectIDDel" name="txtArchitectIDDel" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtFirstNameDel" name="txtFirstNameDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLastNameDel" name="txtLastNameDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">NickName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtNickNameDel" name="txtNickNameDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Position</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPositionDel" name="txtPositionDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address</div>
                                <div class="col-md-8">
                                    <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit" placeholder="" value="" required>--%>
                                    <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddressDel" name="txtAddressDel" ></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneDel" name="txtPhoneDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobileDel" name="txtMobileDel" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmailDel" name="txtEmailDel" placeholder="" value="" readonly required>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitDelete" class="btn btn-danger" onclick="ValidateDelete()">Delete Confirme</button>
                        <button type="button" class="btn btn-danger hidden" id="btnDeleteData" onserverclick="btnDeleteData_click" runat="server" >Delete Confirme</button>
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

                        if (this.cellIndex == 9) {
                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strFirstName = table.rows[rIndex].cells[1].innerHTML;
                            var strLastName = table.rows[rIndex].cells[2].innerHTML;
                            var strNickName = table.rows[rIndex].cells[3].innerHTML;
                            var strPosition = table.rows[rIndex].cells[4].innerHTML;
                            var strAddress = table.rows[rIndex].cells[5].innerHTML;
                            var strPhone = table.rows[rIndex].cells[6].innerHTML;
                            var strMobile = table.rows[rIndex].cells[7].innerHTML;
                            var strEmail = table.rows[rIndex].cells[8].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtArchitectIDEdit").value = strID;
                            document.getElementById("txtFirstNameEdit").value = strFirstName;
                            document.getElementById("txtLastNameEdit").value = strLastName;
                            document.getElementById("txtNickNameEdit").value = strNickName;
                            document.getElementById("txtPositionEdit").value = strPosition;
                            document.getElementById("txtAddressEdit").value = strAddress;
                            document.getElementById("txtPhoneEdit").value = strPhone;
                            document.getElementById("txtMobileEdit").value = strMobile;
                            document.getElementById("txtEmailEdit").value = strEmail;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 10) {
                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strFirstName = table.rows[rIndex].cells[1].innerHTML;
                            var strLastName = table.rows[rIndex].cells[2].innerHTML;
                            var strNickName = table.rows[rIndex].cells[3].innerHTML;
                            var strPosition = table.rows[rIndex].cells[4].innerHTML;
                            var strAddress = table.rows[rIndex].cells[5].innerHTML;
                            var strPhone = table.rows[rIndex].cells[6].innerHTML;
                            var strMobile = table.rows[rIndex].cells[7].innerHTML;
                            var strEmail = table.rows[rIndex].cells[8].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtArchitectIDDel").value = strID;
                            document.getElementById("txtFirstNameDel").value = strFirstName;
                            document.getElementById("txtLastNameDel").value = strLastName;
                            document.getElementById("txtNickNameDel").value = strNickName;
                            document.getElementById("txtPositionDel").value = strPosition;
                            document.getElementById("txtAddressDel").value = strAddress;
                            document.getElementById("txtPhoneDel").value = strPhone;
                            document.getElementById("txtMobileDel").value = strMobile;
                            document.getElementById("txtEmailDel").value = strEmail;

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

            $(function () {

                $("#myModalEdit").validate({
                    rules: {
                        txtCustTypeDesc: {
                            required: true,
                            minlength: 8
                        },
                        action: "required"
                    },
                    messages: {
                        txtCustTypeDesc: {
                            required: "Please enter some data",
                            minlength: "Your data must be at least 8 characters"
                        },
                        action: "Please provide some data"
                    }
                });
            });

            function ValidateSave() {
                var str1 = document.getElementById("txtGradeID").value;
                var str2 = document.getElementById("txtGradeDesc").value;
                var str3 = document.getElementById("txtGradeDetail").value;
                if (str1 != '' && str2 != '' && str3 !='') {
                    document.getElementById("<%=  btnSaveNewData.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str1 = document.getElementById("txtArchitectIDEdit").value;
                //var str2 = document.getElementById("txtGradeDescEdit").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' ) {
                    {
                        document.getElementById("<%= btnUpdateData.ClientID %>").click();
                    }
                }
            }


            function ValidateDelete() {
                var str = document.getElementById("txtArchitectIDDel").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteData.ClientID %>").click();
                    }
                }
        </script>
    </section>

</asp:Content>
