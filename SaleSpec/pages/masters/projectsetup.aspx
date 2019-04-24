<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projectsetup.aspx.cs" Inherits="SaleSpec.pages.masters.projectsetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../trans/jquery-1.11.2.min.js"></script>
    <script>
        $(document).ready(function () {
            var selectCompanyIDDDL = $('#selectCompanyID');
            var selectArchitecIDDDL = $('#selectArchitecID');
            var selectProjStepDDL = $('#selectProjStep');
            var selectProdTypeIDDDL = $('#selectProdTypeID');
            var selectProdIDDDL = $('#selectProdID');
            var selectTypeIDDDL = $('#selectTypeID');
            var selectStatusConIDDDL = $('#selectStatusConID');

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyIDDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                    selectArchitecIDDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                    $(data).each(function (index, item) {
                        selectCompanyIDDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                    });
                }
            });


            selectCompanyIDDDL.change(function () {
                $.ajax({
                    url: '../trans/DataServices.asmx/GetDataArchitect',
                    method: 'post',
                    data: { CompanyID: $(this).val() },
                    dataType: 'json',
                    success: function (data) {
                        selectArchitecIDDDL.empty();
                        selectArchitecIDDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                        selectArchitecIDDDL.prop('disabled', false);
                        $(data).each(function (index, item) {
                            selectArchitecIDDDL.append($('<option/>', { value: item.ArchitecID, text: item.FullName }));
                        });
                    }
                });
            });

            //Get data step of sale spec project
            $.ajax({
                url: '../trans/DataServices.asmx/GetStepSpec',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProjStepDDL.append($('<option/>', { value: -1, text: 'Select project step' }));
                    $(data).each(function (index, item) {
                        selectProjStepDDL.append($('<option/>', { value: item.StepID, text: item.StepNameEn }));
                    });
                }
            });

            //Get Product type such as Ampelite, Ampelram
            $.ajax({
                url: '../trans/DataServices.asmx/GetProductType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProdTypeIDDDL.append($('<option/>', { value: -1, text: 'Select product type of project' }));
                    selectProdIDDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                    $(data).each(function (index, item) {
                        selectProdTypeIDDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                    });
                }
            });

            //When product type changed cascading of product
            selectProdTypeIDDDL.change(function () {
                if ($(this).val() == "-1") {
                    selectProdIDDDL.empty();
                    selectProdIDDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                    selectProdIDDDL.val('-1');
                } else {
                    $.ajax({
                        url: '../trans/DataServices.asmx/GetProducts',
                        method: 'post',
                        data: { ProdTypeID: $(this).val() },
                        dataType: 'json',
                        success: function (data) {
                            selectProdIDDDL.prop('disabled', false);
                            selectProdIDDDL.empty();
                            selectProdIDDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                            $(data).each(function (index, item) {
                                selectProdIDDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                            });
                        }
                    });
                }
            });

            //Get Spec Personal / Sale Spec
            $.ajax({
                url: '../trans/DataServices.asmx/GetSpecPerson',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectTypeIDDDL.append($('<option/>', { value: -1, text: 'Select personal spec' }));
                    $(data).each(function (index, item) {
                        selectTypeIDDDL.append($('<option/>', { value: item.SpecID, text: item.FullName }));
                    });
                }
            });

            //Get project status
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatus',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                    });
                }
            });

        });
    </script>

    <!-- Header content -->
    <section class="content-header">
        <h1>Projects Setup
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
                        <h3 class="box-title">Project Details</h3>
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
                                    <th>ProjectID</th>
                                    <th class="hidden">ProjectYear</th>
                                    <th class="hidden">ProjectMonth</th>
                                    <th>Project</th>
                                    <th class="hidden">ArchitecID</th>
                                    <th class="hidden">CompanyID</th>
                                    <th>Company</th>
                                    <th>Location</th>
                                    <th class="hidden">MainCons</th>
                                    <th class="hidden">RefRfDf</th>
                                    
                                    <td class="hidden">ProjStep</td>
                                    <td>Step</td>

                                    <th class="hidden">ProdTypeID</th>
                                    <th>TypeName</th>
                                    <th class="hidden">ProdID</th>
                                    <th>ProdName</th>
                                    <th>RefProfile</th>
                                    <th>Quantity</th>
                                    <th>Delivery</th>
                                    <th class="hidden">StatusID</th>
                                    <th>Step</th>
                                    <th>Port</th>
                                    <th class="hidden">StatusConID</th>
                                    <th>Status</th>
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
            <div class="modal-dialog"  style="width: 800px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">New Project</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <%--Left side--%>
                            <div class="col-md-12">
                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-2 txtLabel">ProjectName </div>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectName" name="ProjectName" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-2">
                                        <label class="txtLabel">Company</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="txtLabel">
                                            <select id="selectCompanyID" name="selectCompanyID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-2">
                                        <label class="txtLabel">ArchitecID</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="txtLabel">
                                            <select id="selectArchitecID" name="selectArchitecID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="col-md-6">
                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectID" name="ProjectID" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectYear</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectYear" name="ProjectYear" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectMonth</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectMonth" name="ProjectMonth" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px; margin-top: 5px">
                                    <div class="col-md-4 txtLabel">Location</div>
                                    <div class="col-md-8">
                                        <textarea cols="40" rows="3" id="Location" name="Location" class="form-control input input-sm txtLabel"></textarea>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Main Consumer</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="MainCons" name="MainCons" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Roll Former</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="RefRfDf" name="RefRfDf" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Project Step</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProjStep" name="selectProjStep" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Port</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectTypeID" name="selectTypeID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--Right Side--%>
                            <div class="col-md-6">
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Product Type</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProdTypeID" name="selectProdTypeID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Product</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProdID" name="selectProdID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Profile</label>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProfID" name="ProfID" placeholder="" value="" required>
                                    </div>
                                </div>

                                <%--<div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Project Step</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStep" name="selectStep" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>--%>

                                <div class="row" style="margin-bottom: 5px; margin-top: 5px">
                                    <div class="col-md-4 txtLabel">Quantity</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="Quantity" name="Quantity" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Delivery</div>
                                    <div class="col-md-8">
                                        <%--<input type="text" class="form-control input input-sm txtLabel" id="DeliveryDate" name="DeliveryDate" placeholder="" value="" required>--%>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdelivery" name="datepickerdelivery" value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    
                                    </div>
                                </div>

                                

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Status</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusConID" name="selectStatusConID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
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
                        <h4 class="modal-title">Edit Grade Details</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">GradeID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeIDEdit" name="txtGradeIDEdit" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetailEdit" name="txtGradeDetailEdit" class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%></div>
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
                        <h4 class="modal-title">Delete Grade</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">GradeID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeIDDelete" name="txtGradeIDDelete" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDescDelete" name="txtGradeDescDelete" placeholder="" value="" readonly required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetailDelete" name="txtGradeDetailDelete" disabled class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%></div>
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

                        if (this.cellIndex == 24) {
                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strDesc = table.rows[rIndex].cells[1].innerHTML;
                            var strDetail = table.rows[rIndex].cells[2].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtGradeIDEdit").value = strID;
                            document.getElementById("txtGradeDescEdit").value = strDesc;
                            document.getElementById("txtGradeDetailEdit").value = strDetail;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 25) {
                            var strGradeIDDelete = table.rows[rIndex].cells[0].innerHTML;
                            var stGradeDescDelete = table.rows[rIndex].cells[1].innerHTML;
                            var strGradeDetailDelete = table.rows[rIndex].cells[2].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtGradeIDDelete").value = strGradeIDDelete;
                            document.getElementById("txtGradeDescDelete").value = stGradeDescDelete;
                            document.getElementById("txtGradeDetailDelete").value = strGradeDetailDelete;


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
               
                var str1 = 'new'; //document.getElementById("ProjectID").value;
                var str2 = document.getElementById("ProjectName").value;
                var str3 = document.getElementById("selectCompanyID").value;
                var str4 = document.getElementById("selectArchitecID").value;
                var str5 = document.getElementById("ProjectYear").value;
                var str6 = document.getElementById("ProjectMonth").value;
                var str7 = document.getElementById("Location").value;
                var str8 = document.getElementById("MainCons").value;
                var str9 = document.getElementById("RefRfDf").value;
                var str10 = document.getElementById("selectProjStep").value;
                var str11 = document.getElementById("selectTypeID").value;
                var str12 = document.getElementById("selectProdTypeID").value;
                var str13 = document.getElementById("selectProdID").value;
                var str14 = document.getElementById("ProfID").value;
                var str15 = document.getElementById("Quantity").value;
                var str16 = document.getElementById("datepickerdelivery").value;
                var str17 = document.getElementById("selectStatusConID").value;
                if (str1 != '' && str2 != '' && str3 != '' && str4 !='') {
                    document.getElementById("<%=  btnSaveNewData.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str1 = document.getElementById("txtGradeIDEdit").value;
                var str2 = document.getElementById("txtGradeDescEdit").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        document.getElementById("<%= btnUpdateData.ClientID %>").click();
                    }
                }
            }


            function ValidateDelete() {
                var str = document.getElementById("txtGradeIDDelete").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteData.ClientID %>").click();
                    }
                }
        </script>
    </section>

</asp:Content>
