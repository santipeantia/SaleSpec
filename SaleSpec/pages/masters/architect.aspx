<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architect.aspx.cs" Inherits="SaleSpec.pages.masters.architect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script src="../trans/jquery-1.11.2.min.js"></script>
    <script>
        $(document).ready(function () {
            var selectStatusConIDDDL = $('#selectStatusConID');
            var selectCompanyDDL = $('#selectCompany');
            var selectStatusConIDEditDDL = $('#selectStatusConIDEdit');
            var selectCompanyEditDDL = $('#selectCompanyEdit');
            var selectStatusConIDDelDDL = $('#selectStatusConIDDel');
            var selectCompanyDelDDL = $('#selectCompanyDel');

            //var selectPositionEditDDL = $('#selectPositionEdit');

            var selectGradeIDDDL = $('#selectGradeID');
            var selectGradeIDEditDDL = $('#selectGradeIDEdit');
            var selectGradeIDDelDDL = $('#selectGradeIDDel');

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

            //SANTI 03/12/2019 11:15
            //$.ajax({
            //    url: '../trans/DataServices.asmx/GetPositions',
            //    method: 'post',
            //    dataType: 'json',
            //    success: function (data) {
            //        selectPositionEditDDL.append($('<option/>', { value: -1, text: 'Select Position' }));
            //        $(data).each(function (index, item) {
            //            selectPositionEditDDL.append($('<option/>', { value: item.PositionID, text: item.PositionNameEN }));
            //        });
            //    }
            //});


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
                url: '../trans/DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                    $(data).each(function (index, item) {
                        selectCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyEditDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                    $(data).each(function (index, item) {
                        selectCompanyEditDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyDelDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                    $(data).each(function (index, item) {
                        selectCompanyDelDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataGrade',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectGradeIDDDL.append($('<option/>', { value: -1, text: 'Select Grade' }));
                    $(data).each(function (index, item) {
                        selectGradeIDDDL.append($('<option/>', { value: item.GradeID, text: item.GradeDesc }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataGrade',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectGradeIDEditDDL.append($('<option/>', { value: -1, text: 'Select Grade' }));
                    $(data).each(function (index, item) {
                        selectGradeIDEditDDL.append($('<option/>', { value: item.GradeID, text: item.GradeDesc }));
                    });
                }
            });

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataGrade',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectGradeIDDelDDL.append($('<option/>', { value: -1, text: 'Select Grade' }));
                    $(data).each(function (index, item) {
                        selectGradeIDDelDDL.append($('<option/>', { value: item.GradeID, text: item.GradeDesc }));
                    });
                }
            });


           


        });
    </script>
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
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download" runat="server" onserverclick="btnDownload_click"><i class="fa fa-download"></i></button>
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
                                    <td class="hidden">CompanyID</td>
                                    <td>ArchitecID</td>
                                    <td>FirstName</td>
                                    <td>LastName</td>
                                    <td>NickName</td>
                                    <td>Position</td>
                                    <td>Address</td>
                                    <td>Phone</td>
                                    <td>Mobile</td>
                                    <td>Email</td>
                                    <td class="hidden">StatusID</td>
                                    <td>Status</td>
                                    <td class="hidden">GradeID</td>
                                    <th style="width: 20px; text-align: center;">#</th>
                                    <th style="width: 20px; text-align: center;">#</th>
                                    <td class="hidden">Birthday</td>
                                    <td>Port</td>
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
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectID" name="txtArchitectID" placeholder="" value="" ></div>
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

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                <div class="col-md-4">
                                    <label class="txtLabel">Company</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCompany" name="selectCompany" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Grade</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectGradeID" name="selectGradeID" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </div>
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
                                    <textarea cols="40" rows="2" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" ></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Birthday</div>
                                <div class="col-md-8">
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datebirthday" name="datebirthday" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
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

                            <div class="row" style="margin-top: 5px">
                                <div class="col-md-4 txtLabel">Port</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPort" name="txtPort" placeholder="" value="" >
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
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectIDEdit" name="txtArchitectIDEdit" placeholder="" value="" ></div>
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

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                <div class="col-md-4">
                                    <label class="txtLabel">Company</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCompanyEdit" name="selectCompanyEdit" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Grade</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectGradeIDEdit" name="selectGradeIDEdit" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </div>
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
                                    <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                    <textarea cols="40" rows="2" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit" ></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Birthday</div>
                                <div class="col-md-8">
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datebirthdayedit" name="datebirthdayedit" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
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

                             <div class="row" style="margin-top: 5px">
                                <div class="col-md-4 txtLabel">Port</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPortEdit" name="txtPortEdit" placeholder="" value="" >
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
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectIDDel" name="txtArchitectIDDel" placeholder="" value="" ></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtFirstNameDel" name="txtFirstNameDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLastNameDel" name="txtLastNameDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                <div class="col-md-4">
                                    <label class="txtLabel">Company</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCompanyDel" name="selectCompanyDel" class="form-control input-sm" disabled style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Grade</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectGradeIDDel" name="selectGradeIDDel" class="form-control input-sm" disabled style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">NickName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtNickNameDel" name="txtNickNameDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Position</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPositionDel" name="txtPositionDel" disabled placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address</div>
                                <div class="col-md-8">
                                    <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                    <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddressDel" disabled name="txtAddressDel" ></textarea>
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

                             <div class="row" style="margin-top: 5px">
                                <div class="col-md-4 txtLabel">Port</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPortDel" name="txtPortDel" placeholder="" value="" readonly >
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
                            var strVal11 = table.rows[rIndex].cells[11].innerHTML;
                            var strVal12 = table.rows[rIndex].cells[12].innerHTML;
                            var strVal15 = table.rows[rIndex].cells[15].innerHTML;
                            var strVal16 = table.rows[rIndex].cells[16].innerHTML; //Port

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);
                            $('#selectCompanyEdit').val(strVal0); 
                            $('#selectCompanyEdit').change();

                            $('#selectGradeIDEdit').val(strVal12); 
                            $('#selectGradeIDEdit').change();

                            document.getElementById("txtArchitectIDEdit").value = strVal1;
                            document.getElementById("txtFirstNameEdit").value = strVal2;
                            document.getElementById("txtLastNameEdit").value = strVal3;
                            document.getElementById("txtNickNameEdit").value = strVal4;

                            document.getElementById("txtPositionEdit").value = strVal5;

                            document.getElementById("txtAddressEdit").value = strVal6;
                            document.getElementById("txtPhoneEdit").value = strVal7;
                            document.getElementById("txtMobileEdit").value = strVal8;
                            document.getElementById("txtEmailEdit").value = strVal9;

                            document.getElementById("datebirthdayedit").value = strVal15;

                            $('#selectStatusConIDEdit').val(strVal10); 
                            $('#selectStatusConIDEdit').change();

                            document.getElementById("txtPortEdit").value = strVal16;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 14) {

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
                            var strVal11 = table.rows[rIndex].cells[11].innerHTML;
                            var strVal12 = table.rows[rIndex].cells[12].innerHTML;
                            var strVal16 = table.rows[rIndex].cells[16].innerHTML; //Port

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);
                            $('#selectCompanyDel').val(strVal0); 
                            $('#selectCompanyDel').change();

                            $('#selectGradeIDDel').val(strVal12); 
                            $('#selectGradeIDDel').change();

                            document.getElementById("txtArchitectIDDel").value = strVal1;
                            document.getElementById("txtFirstNameDel").value = strVal2;
                            document.getElementById("txtLastNameDel").value = strVal3;
                            document.getElementById("txtNickNameDel").value = strVal4;
                            document.getElementById("txtPositionDel").value = strVal5;
                            document.getElementById("txtAddressDel").value = strVal6;
                            document.getElementById("txtPhoneDel").value = strVal7;
                            document.getElementById("txtMobileDel").value = strVal8;
                            document.getElementById("txtEmailDel").value = strVal9;

                            $('#selectStatusConIDDel').val(strVal10); 
                            $('#selectStatusConIDDel').change();

                            document.getElementById("txtPortDel").value = strVal16;


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

            function ValidateSave() {

                var str1 = 'test'; // document.getElementById("txtArchitectID").value;
                var str2 = document.getElementById("txtFirstName").value;
                var str3 = document.getElementById("txtLastName").value;

                //alert(str1);

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
