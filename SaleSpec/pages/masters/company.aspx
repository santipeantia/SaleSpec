<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="company.aspx.cs" Inherits="SaleSpec.pages.masters.company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../trans/jquery-1.11.2.min.js"></script>
    <script>
        $(document).ready(function () {
            var selectStatusConIDDDL = $('#selectStatusConID');
            var selectStatusConIDEditDDL = $('#selectStatusConIDEdit');
            var selectStatusConIDDelDDL = $('#selectStatusConIDDel');
            var selectCustTypeIDDDL = $('#selectCustTypeID');
            var selectCustTypeIDEditDDL = $('#selectCustTypeIDEdit');
            var selectCustTypeIDDelDDL = $('#selectCustTypeIDDel');


            //Get data project type
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatusConfirm',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDDDL.append($('<option/>', { value: -1, text: 'Select Status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDDDL.append($('<option/>', { value: item.StatusConID, text: item.ConDesc2 }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetStatusConfirm',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDEditDDL.append($('<option/>', { value: -1, text: 'Select Status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDEditDDL.append($('<option/>', { value: item.StatusConID, text: item.ConDesc2 }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetStatusConfirm',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDDelDDL.append($('<option/>', { value: -1, text: 'Select Status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDDelDDL.append($('<option/>', { value: item.StatusConID, text: item.ConDesc2 }));
                    });
                }
            });
           
             $.ajax({
                url: '../trans/DataServices.asmx/GetCustomerType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCustTypeIDDDL.append($('<option/>', { value: -1, text: 'Select CustomerType' }));
                    $(data).each(function (index, item) {
                        selectCustTypeIDDDL.append($('<option/>', { value: item.CustTypeID, text: item.CustTypeDesc }));
                    });
                }
            });
            
            $.ajax({
                url: '../trans/DataServices.asmx/GetCustomerType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCustTypeIDEditDDL.append($('<option/>', { value: -1, text: 'Select CustomerType' }));
                    $(data).each(function (index, item) {
                        selectCustTypeIDEditDDL.append($('<option/>', { value: item.CustTypeID, text: item.CustTypeDesc }));
                    });
                }
            });

             $.ajax({
                url: '../trans/DataServices.asmx/GetCustomerType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCustTypeIDDelDDL.append($('<option/>', { value: -1, text: 'Select CustomerType' }));
                    $(data).each(function (index, item) {
                        selectCustTypeIDDelDDL.append($('<option/>', { value: item.CustTypeID, text: item.CustTypeDesc }));
                    });
                }
            });


        });
    </script>

         <!-- Header content -->
    <section class="content-header">
        <h1>Company Setup
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
                        <h3 class="box-title">Company Details</h3>
                        <div class="pull-right">
                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                <i class="fa fa-plus"></i>
                            </button>
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download" id="btnDownload" runat="server" onserverclick="btnDownload_click"><i class="fa fa-download"></i></button>
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
                                    <td>CompanyID</td>
                                    <td>CompanyName</td>
                                    <td>CompanyName2</td>
                                    <td class="hidden">CustTypeID</td>
                                    <td>Address</td>
                                    <td class="hidden">ProvinceID</td>
                                    <td>ContactPerson</td>
                                    <td>Phone</td>
                                    <td class="hidden">Mobile</td>
                                    <td class="hidden">Email</td>
                                    <td class="hidden">StatusConID"</td>
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
                        <h4 class="modal-title">New Company</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyID" name="txtCompanyID" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyName" name="txtCompanyName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyName2</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyName2" name="txtCompanyName2" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">CustomerType</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCustTypeID" name="selectCustTypeID" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address	</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtAddress" name="txtAddress" class="form-control input input-sm txtLabel"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                            
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ProvinceID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProvinceID" name="txtProvinceID" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ContactName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtContactName" name="txtContactName" placeholder="" value="" required>
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

                             <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">StatusConID</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectStatusConID" name="selectStatusConID" class="form-control input-sm"  style="width: 100%">
                                        </select>
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
        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Company Details</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyIDEdit" name="txtCompanyIDEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyNameEdit" name="txtCompanyNameEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyName2</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyName2Edit" name="txtCompanyName2Edit" placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">CustomerType</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCustTypeIDEdit" name="selectCustTypeIDEdit" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address	</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtAddressEdit" name="txtAddressEdit" class="form-control input input-sm txtLabel"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                            
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ProvinceID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProvinceIDEdit" name="txtProvinceIDEdit" placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ContactName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtContactNameEdit" name="txtContactNameEdit" placeholder="" value="" >
                                </div>
                            </div>
                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneEdit" name="txtPhoneEdit" placeholder="" value="" >
                                </div>
                            </div>

                             <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobileEdit" name="txtMobileEdit" placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmailEdit" name="txtEmailEdit" placeholder="" value="" >
                                </div>
                            </div>

                             <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">StatusConID</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectStatusConIDEdit" name="selectStatusConIDEdit" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData" onserverclick="btnUpdateData_click" runat="server">Update Changes</button>
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
                        <h4 class="modal-title">Delete Company</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyIDDel" name="txtCompanyIDDel" readonly placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyNameDel" name="txtCompanyNameDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">CompanyName2</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyName2Del" name="txtCompanyName2Del" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">CustomerType</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCustTypeIDDel" name="selectCustTypeIDDel" class="form-control input-sm" disabled style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address	</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtAddressDel" name="txtAddressDel" disabled class="form-control input input-sm txtLabel"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                            
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ProvinceID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProvinceIDDel" name="txtProvinceIDDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ContactName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtContactNameDel" name="txtContactNameDel" disabled placeholder="" value="" required>
                                </div>
                            </div>
                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneDel" name="txtPhoneDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                             <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobileDel" name="txtMobileDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmailDel" name="txtEmailDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                             <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">StatusConID</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectStatusConIDDel" name="selectStatusConIDDel" class="form-control input-sm" disabled style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitDelete" class="btn btn-danger" onclick="ValidateDelete()">Delete Confirme</button>
                        <button type="button" class="btn btn-danger hidden" id="btnDeleteData" onserverclick="btnDeleteData_click" runat="server">Delete Confirme</button>
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

                        if (this.cellIndex == 12) {
                            var strVal0 = table.rows[rIndex].cells[0].innerHTML;
                            var strVal1 = table.rows[rIndex].cells[1].innerHTML;
                            var strVal2 = table.rows[rIndex].cells[2].innerHTML;
                            var strVal3 = table.rows[rIndex].cells[3].innerHTML;
                            var strVal4 = table.rows[rIndex].cells[4].innerHTML;
                            var strVal5 = table.rows[rIndex].cells[5].innerHTML;
                            var strVal6 = table.rows[rIndex].cells[6].innerHTML;
                            var strVal7 = table.rows[rIndex].cells[7].innerHTML;
                            var strVal8 = table.rows[rIndex].cells[8].innerHTML;
                            var strVal9 = table.rows[rIndex].cells[9].innerHTML;
                            var strVal10 = table.rows[rIndex].cells[10].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtCompanyIDEdit").value = strVal0;
                            document.getElementById("txtCompanyNameEdit").value = strVal1;
                            document.getElementById("txtCompanyName2Edit").value = strVal2;

                            $('#selectCustTypeIDEdit').val(strVal3); 
                            $('#selectCustTypeIDEdit').change();

                            document.getElementById("txtAddressEdit").value = strVal4;
                            document.getElementById("txtProvinceIDEdit").value = strVal5;
                            document.getElementById("txtContactNameEdit").value = strVal6;
                            document.getElementById("txtPhoneEdit").value = strVal7;
                            document.getElementById("txtMobileEdit").value = strVal8;
                            document.getElementById("txtEmailEdit").value = strVal9;

                            //document.getElementById("selectStatusConID").value = strDetail;
                            $('#selectStatusConIDEdit').val(strVal10); 
                            $('#selectStatusConIDEdit').change();

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 13) {
                            var strVal0 = table.rows[rIndex].cells[0].innerHTML;
                            var strVal1 = table.rows[rIndex].cells[1].innerHTML;
                            var strVal2 = table.rows[rIndex].cells[2].innerHTML;
                            var strVal3 = table.rows[rIndex].cells[3].innerHTML;
                            var strVal4 = table.rows[rIndex].cells[4].innerHTML;
                            var strVal5 = table.rows[rIndex].cells[5].innerHTML;
                            var strVal6 = table.rows[rIndex].cells[6].innerHTML;
                            var strVal7 = table.rows[rIndex].cells[7].innerHTML;
                            var strVal8 = table.rows[rIndex].cells[8].innerHTML;
                            var strVal9 = table.rows[rIndex].cells[9].innerHTML;
                            var strVal10 = table.rows[rIndex].cells[10].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtCompanyIDDel").value = strVal0;
                            document.getElementById("txtCompanyNameDel").value = strVal1;
                            document.getElementById("txtCompanyName2Del").value = strVal2;

                            $('#selectCustTypeIDDel').val(strVal3); 
                            $('#selectCustTypeIDDel').change();

                            document.getElementById("txtAddressDel").value = strVal4;
                            document.getElementById("txtProvinceIDDel").value = strVal5;
                            document.getElementById("txtContactNameDel").value = strVal6;
                            document.getElementById("txtPhoneDel").value = strVal7;
                            document.getElementById("txtMobileDel").value = strVal8;
                            document.getElementById("txtEmailDel").value = strVal9;

                            $('#selectStatusConIDDel').val(strVal10); 
                            $('#selectStatusConIDDel').change();

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
                var str1 = document.getElementById("txtCompanyName").value;
                var str2 = document.getElementById("txtCompanyName2").value;
                var str3 = document.getElementById("txtAddress").value;
                if (str1 != '' && str2 != '' && str3 != '') {
                    document.getElementById("<%=  btnSaveNewData.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str1 = document.getElementById("txtCompanyIDEdit").value;
                var str2 = document.getElementById("txtCompanyNameEdit").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        document.getElementById("<%= btnUpdateData.ClientID %>").click();
                    }
                }
            }


            function ValidateDelete() {
                var str = document.getElementById("txtCompanyIDDel").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteData.ClientID %>").click();
                }
            }
        </script>
    </section>

</asp:Content>
