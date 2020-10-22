<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projectsetup.aspx.cs" Inherits="SaleSpec.pages.masters.projectsetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../trans/jquery-1.11.2.min.js"></script>
    <script>
        $(document).ready(function () {
            // in case insert data new project
            var selectCompanyIDDDL = $('#selectCompanyID');
            var selectArchitecIDDDL = $('#selectArchitecID');
            var selectProjStepDDL = $('#selectProjStep');
            var selectProdTypeIDDDL = $('#selectProdTypeID');
            var selectProdIDDDL = $('#selectProdID');
            var selectTypeIDDDL = $('#selectTypeID');
            var selectStatusConIDDDL = $('#selectStatusConID');
            var selectStatusIDDDL = $('#selectStatusID');

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

                        var strComName = $('#selectCompanyID option:selected').text();
                        $('#CompanyName').val(strComName);
                    }
                });
            });

            selectArchitecIDDDL.change(function () {
                var strArchitecName = $('#selectArchitecID option:selected').text();
                        $('#ArchitecName').val(strArchitecName);
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

            selectProjStepDDL.change(function () {
                var strProjStep = $('#selectProjStep option:selected').text();
                $('#ProjStepName').val(strProjStep);
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

            selectProdTypeIDDDL.change(function () {
                var strProductTypeName = $('#selectProdTypeID option:selected').text();
                $('#ProductTypeName').val(strProductTypeName);
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

            selectProdIDDDL.change(function () {
                var strProductName = $('#selectProdID option:selected').text();
                $('#ProductName').val(strProductName);
            });
            
            //Get Spec Personal / Sale Spec / port
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

            selectTypeIDDDL.change(function () {
                var strTypeName = $('#selectTypeID option:selected').text();
                $('#TypeName').val(strTypeName);
            });

            //Get project status confirm
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatusConfirm',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDDDL.append($('<option/>', { value: item.StatusConID, text: item.ConDesc2 }));
                    });
                }
            });

            //Get project status project
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatus',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusIDDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusIDDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                    });
                }
            });

            selectStatusIDDDL.change(function () {
                 var txtStatusID = $('#selectStatusID option:selected').text();
                $('#txtStatusID').val(txtStatusID);

            });



            // ** End in case insert data new project
            //***********************************************//
            // in case insert data update project
            var selectCompanyIDEditDDL = $('#selectCompanyIDEdit');
            var selectArchitecIDEditDDL = $('#selectArchitecIDEdit');
            var selectProjStepEditDDL = $('#selectProjStepEdit');
            var selectProdTypeIDEditDDL = $('#selectProdTypeIDEdit');
            var selectProdIDEditDDL = $('#selectProdIDEdit');
            var selectTypeIDEditDDL = $('#selectTypeIDEdit');
            var selectStatusConIDEditDDL = $('#selectStatusConIDEdit');
            var selectStatusIDEditDDL = $('#selectStatusIDEdit');

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyIDEditDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                    selectArchitecIDEditDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                    $(data).each(function (index, item) {
                        selectCompanyIDEditDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                    });
                }
            });

            selectCompanyIDEditDDL.change(function () {
                $.ajax({
                    url: '../trans/DataServices.asmx/GetDataArchitect',
                    method: 'post',
                    data: { CompanyID: $(this).val() },
                    dataType: 'json',
                    success: function (data) {
                        selectArchitecIDEditDDL.empty();
                        selectArchitecIDEditDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                        selectArchitecIDEditDDL.prop('disabled', false);
                        $(data).each(function (index, item) {
                            selectArchitecIDEditDDL.append($('<option/>', { value: item.ArchitecID, text: item.FullName }));
                            
                            var valArchitecIDEdit = $('#ArchitecIDEdit').val();
                            $('#selectArchitecIDEdit').val(valArchitecIDEdit).change();
                        });

                        var strComName = $('#selectCompanyIDEdit option:selected').text();
                        $('#CompanyNameEdit').val(strComName);
                    }
                });
            });

            selectArchitecIDEditDDL.change(function () {
                var strArchitecName = $('#selectArchitecIDEdit option:selected').text();
                $('#ArchitecNameEdit').val(strArchitecName);
            });
            
            //Get data step of sale spec project
            $.ajax({
                url: '../trans/DataServices.asmx/GetStepSpec',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProjStepEditDDL.append($('<option/>', { value: -1, text: 'Select project step' }));
                    $(data).each(function (index, item) {
                        selectProjStepEditDDL.append($('<option/>', { value: item.StepID, text: item.StepNameEn }));
                    });
                }
            });

            selectProjStepEditDDL.change(function () {
                var strProjStep = $('#selectProjStepEdit option:selected').text();
                $('#ProjStepNameEdit').val(strProjStep);
            });
            
            //Get Product type such as Ampelite, Ampelram
            $.ajax({
                url: '../trans/DataServices.asmx/GetProductType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProdTypeIDEditDDL.append($('<option/>', { value: -1, text: 'Select product type of project' }));
                    selectProdIDEditDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                    $(data).each(function (index, item) {
                        selectProdTypeIDEditDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                    });
                }
            });

            selectProdTypeIDEditDDL.change(function () {
                var strProductTypeName = $('#selectProdTypeIDEdit option:selected').text();
                $('#ProductTypeNameEdit').val(strProductTypeName);
            });
            
            //When product type changed cascading of product
            selectProdTypeIDEditDDL.change(function () {
                if ($(this).val() == "-1") {
                    selectProdIDEditDDL.empty();
                    selectProdIDEditDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                    selectProdIDEditDDL.val('-1');
                } else {
                    $.ajax({
                        url: '../trans/DataServices.asmx/GetProducts',
                        method: 'post',
                        data: { ProdTypeID: $(this).val() },
                        dataType: 'json',
                        success: function (data) {
                            selectProdIDEditDDL.prop('disabled', false);
                            selectProdIDEditDDL.empty();
                            selectProdIDEditDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                            $(data).each(function (index, item) {
                                selectProdIDEditDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));

                                var valProdIDEdit = $('#ProdIDEdit').val();
                                $('#selectProdIDEdit').val(valProdIDEdit).change();
                            });
                        }
                    });
                }
            });

            selectProdIDEditDDL.change(function () {
                var strProductName = $('#selectProdIDEdit option:selected').text();
                $('#ProductNameEdit').val(strProductName);
            });
            
            //Get Spec Personal / Sale Spec / port
            $.ajax({
                url: '../trans/DataServices.asmx/GetSpecPerson',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectTypeIDEditDDL.append($('<option/>', { value: -1, text: 'Select personal spec' }));
                    $(data).each(function (index, item) {
                        selectTypeIDEditDDL.append($('<option/>', { value: item.SpecID, text: item.FullName }));
                    });
                }
            });

            selectTypeIDEditDDL.change(function () {
                var strTypeName = $('#selectTypeIDEdit option:selected').text();
                $('#TypeNameEdit').val(strTypeName);
            });

            //Get project status confirm
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatusConfirm',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDEditDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDEditDDL.append($('<option/>', { value: item.StatusConID, text: item.ConDesc2 }));
                    });
                }
            });

            //Get project status project
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatus',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusIDEditDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusIDEditDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                    });
                }
            });

            selectStatusIDEditDDL.change(function () {
                 var txtStatusID = $('#selectStatusIDEdit option:selected').text();
                $('#txtStatusIDEdit').val(txtStatusID);

            });

            // ** End in case insert data update project
            //***********************************************//
 
            // in case insert data delete project
            var selectCompanyIDDelDDL = $('#selectCompanyIDDel');
            var selectArchitecIDDelDDL = $('#selectArchitecIDDel');
            var selectProjStepDelDDL = $('#selectProjStepDel');
            var selectProdTypeIDDelDDL = $('#selectProdTypeIDDel');
            var selectProdIDDelDDL = $('#selectProdIDDel');
            var selectTypeIDDelDDL = $('#selectTypeIDDel');
            var selectStatusConIDDelDDL = $('#selectStatusConIDDel');
            var selectStatusIDDelDDL  = $('#selectStatusIDDel');

            $.ajax({
                url: '../trans/DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyIDDelDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                    selectArchitecIDDelDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                    $(data).each(function (index, item) {
                        selectCompanyIDDelDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                    });
                }
            });

            selectCompanyIDDelDDL.change(function () {
                $.ajax({
                    url: '../trans/DataServices.asmx/GetDataArchitect',
                    method: 'post',
                    data: { CompanyID: $(this).val() },
                    dataType: 'json',
                    success: function (data) {
                        selectArchitecIDDelDDL.empty();
                        selectArchitecIDDelDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                        $(data).each(function (index, item) {
                            selectArchitecIDDelDDL.append($('<option/>', { value: item.ArchitecID, text: item.FullName }));
                            
                            var valArchitecIDDel = $('#ArchitecIDDel').val();
                            $('#selectArchitecIDDel').val(valArchitecIDDel).change();
                        });

                        var strComName = $('#selectCompanyIDDel option:selected').text();
                        $('#CompanyNameDel').val(strComName);
                    }
                });
            });

            selectArchitecIDDelDDL.change(function () {
                var strArchitecName = $('#selectArchitecIDDel option:selected').text();
                $('#ArchitecNameDel').val(strArchitecName);
            });
            
            //Get data step of sale spec project
            $.ajax({
                url: '../trans/DataServices.asmx/GetStepSpec',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProjStepDelDDL.append($('<option/>', { value: -1, text: 'Select project step' }));
                    $(data).each(function (index, item) {
                        selectProjStepDelDDL.append($('<option/>', { value: item.StepID, text: item.StepNameEn }));
                    });
                }
            });

            selectProjStepDelDDL.change(function () {
                var strProjStep = $('#selectProjStepDel option:selected').text();
                $('#ProjStepNameDel').val(strProjStep);
            });
            
            //Get Product type such as Ampelite, Ampelram
            $.ajax({
                url: '../trans/DataServices.asmx/GetProductType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProdTypeIDDelDDL.append($('<option/>', { value: -1, text: 'Select product type of project' }));
                    selectProdIDDelDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                    $(data).each(function (index, item) {
                        selectProdTypeIDDelDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                    });
                }
            });

            selectProdTypeIDDelDDL.change(function () {
                var strProductTypeName = $('#selectProdTypeIDDel option:selected').text();
                $('#ProductTypeNameDel').val(strProductTypeName);
            });
            
            //When product type changed cascading of product
            selectProdTypeIDDelDDL.change(function () {
                if ($(this).val() == "-1") {
                    selectProdIDDelDDL.empty();
                    selectProdIDDelDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                    selectProdIDDelDDL.val('-1');
                } else {
                    $.ajax({
                        url: '../trans/DataServices.asmx/GetProducts',
                        method: 'post',
                        data: { ProdTypeID: $(this).val() },
                        dataType: 'json',
                        success: function (data) {
                            selectProdIDDelDDL.empty();
                            selectProdIDDelDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                            $(data).each(function (index, item) {
                                selectProdIDDelDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));

                                var valProdIDDel = $('#ProdIDDel').val();
                                $('#selectProdIDDel').val(valProdIDDel).change();
                            });
                        }
                    });
                }
            });

            selectProdIDDelDDL.change(function () {
                var strProductName = $('#selectProdIDDel option:selected').text();
                $('#ProductNameDel').val(strProductName);
            });
            
            //Get Spec Personal / Sale Spec / port
            $.ajax({
                url: '../trans/DataServices.asmx/GetSpecPerson',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectTypeIDDelDDL.append($('<option/>', { value: -1, text: 'Select personal spec' }));
                    $(data).each(function (index, item) {
                        selectTypeIDDelDDL.append($('<option/>', { value: item.SpecID, text: item.FullName }));
                    });
                }
            });

            selectTypeIDDelDDL.change(function () {
                var strTypeName = $('#selectTypeIDDel option:selected').text();
                $('#TypeNameDel').val(strTypeName);
            });

            //Get project status confirm
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatusConfirm',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusConIDDelDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusConIDDelDDL.append($('<option/>', { value: item.StatusConID, text: item.ConDesc2 }));
                    });
                }
            });

            //Get project status project
            $.ajax({
                url: '../trans/DataServices.asmx/GetStatus',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectStatusIDDelDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                    $(data).each(function (index, item) {
                        selectStatusIDDelDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                    });
                }
            });

            selectStatusIDDelDDL.change(function () {
                 var txtStatusID = $('#selectStatusIDDel option:selected').text();
                $('#txtStatusIDDel').val(txtStatusID);

            });

            // ** End in case insert data delete project
            //***********************************************//


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
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download" id="btnDownload" runat="server" onserverclick="btnDownload_click" ><i class="fa fa-download"></i></button>
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
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="CompanyName" name="CompanyName" placeholder="" value="" required>
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
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ArchitecName" name="ArchitecName" placeholder="" value="" required>
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
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProjStepName" name="ProjStepName" placeholder="" value="" required>
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
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="TypeName" name="TypeName" placeholder="" value="" required>
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
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProductTypeName" name="ProductTypeName" placeholder="" value="" required>
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
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProductName" name="ProductName" placeholder="" value="" required>
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
                                        <label class="txtLabel">Active</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusConID" name="selectStatusConID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Status</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusID" name="selectStatusID" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="txtStatusID" name="txtStatusID" placeholder="" value="" required>
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
            <div class="modal-dialog" style="width: 800px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Project Details</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <%--Left side--%>
                            <div class="col-md-12">
                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-2 txtLabel">ProjectName </div>
					
				    <div class="col-md-2">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectIDEdit" name="ProjectIDEdit" readonly value="" required>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectNameEdit" name="ProjectNameEdit" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-2">
                                        <label class="txtLabel">Company</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="txtLabel">
                                            <select id="selectCompanyIDEdit" name="selectCompanyIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="CompanyNameEdit" name="CompanyNameEdit" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-2">
                                        <label class="txtLabel">ArchitecID</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="txtLabel">
                                            <select id="selectArchitecIDEdit" name="selectArchitecIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ArchitecIDEdit" name="ArchitecIDEdit" placeholder="" value="" required>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ArchitecNameEdit" name="ArchitecNameEdit" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="col-md-6">
                                

                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectYear</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectYearEdit" name="ProjectYearEdit" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectMonth</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectMonthEdit" name="ProjectMonthEdit" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px; margin-top: 5px">
                                    <div class="col-md-4 txtLabel">Location</div>
                                    <div class="col-md-8">
                                        <textarea cols="40" rows="3" id="LocationEdit" name="LocationEdit" class="form-control input input-sm txtLabel"></textarea>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Main Consumer</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="MainConsEdit" name="MainConsEdit" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Roll Former</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="RefRfDfEdit" name="RefRfDfEdit" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Project Step</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProjStepEdit" name="selectProjStepEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProjStepNameEdit" name="ProjStepNameEdit" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Port</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectTypeIDEdit" name="selectTypeIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="TypeNameEdit" name="TypeNameEdit" placeholder="" value="" required>
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
                                            <select id="selectProdTypeIDEdit" name="selectProdTypeIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProductTypeNameEdit" name="ProductTypeNameEdit" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Product</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProdIDEdit" name="selectProdIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProdIDEdit" name="ProdIDEdit" placeholder="" value="" required>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProductNameEdit" name="ProductNameEdit" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Profile</label>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProfIDEdit" name="ProfIDEdit" placeholder="" value="" required>
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
                                        <input type="text" class="form-control input input-sm txtLabel" id="QuantityEdit" name="QuantityEdit" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Delivery</div>
                                    <div class="col-md-8">
                                        <%--<input type="text" class="form-control input input-sm txtLabel" id="DeliveryDate" name="DeliveryDate" placeholder="" value="" required>--%>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdeliveryEdit" name="datepickerdeliveryEdit" value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    
                                    </div>
                                </div>

                                

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Active</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusConIDEdit" name="selectStatusConIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Status</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusIDEdit" name="selectStatusIDEdit" class="form-control input-sm" style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="txtStatusIDEdit" name="txtStatusIDEdit" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                        <button type="button" class="btn btn-primary hidden " id="btnUpdateData" onserverclick="btnUpdateData_click" runat="server" >Update Changesxx</button>
                       
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalDelete -->
        <div class="modal modal-default fade" id="myModalDelete">
            <div class="modal-dialog"  style="width: 800px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Delete Project</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <%--Left side--%>
                            <div class="col-md-12">
                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-2 txtLabel">ProjectName </div>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectNameDel" name="ProjectNameDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-2">
                                        <label class="txtLabel">Company</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="txtLabel">
                                            <select id="selectCompanyIDDel" name="selectCompanyIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="CompanyNameDel" name="CompanyNameDel" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-2">
                                        <label class="txtLabel">ArchitecID</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="txtLabel">
                                            <select id="selectArchitecIDDel" name="selectArchitecIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ArchitecIDDel" name="ArchitecIDDel" placeholder="" value="" required>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ArchitecNameDel" name="ArchitecNameDel" placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="col-md-6">
                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectIDDel" name="ProjectIDDel" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectYear</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectYearDel" name="ProjectYearDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectMonth</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProjectMonthDel" name="ProjectMonthDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px; margin-top: 5px">
                                    <div class="col-md-4 txtLabel">Location</div>
                                    <div class="col-md-8">
                                        <textarea cols="40" rows="3" id="LocationDel" name="LocationDel" class="form-control input input-sm txtLabel" disabled></textarea>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Main Consumer</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="MainConsDel" name="MainConsDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Roll Former</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="RefRfDfDel" name="RefRfDfDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Project Step</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProjStepDel" name="selectProjStepDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProjStepNameDel" name="ProjStepNameDel" disabled placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Port</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectTypeIDDel" name="selectTypeIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="TypeNameDel" name="TypeNameDel" disabled placeholder="" value="" required>
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
                                            <select id="selectProdTypeIDDel" name="selectProdTypeIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProductTypeNameDel" name="ProductTypeNameDel" disabled placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Product</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectProdIDDel" name="selectProdIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProdIDDel" name="ProdIDDel" disabled placeholder="" value="" required>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="ProductNameDel" name="ProductNameDel" disabled placeholder="" value="" required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Profile</label>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="ProfIDDel" name="ProfIDDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px; margin-top: 5px">
                                    <div class="col-md-4 txtLabel">Quantity</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="QuantityDel" name="QuantityDel" disabled placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Delivery</div>
                                    <div class="col-md-8">
                                        <%--<input type="text" class="form-control input input-sm txtLabel" id="DeliveryDate" name="DeliveryDate" placeholder="" value="" required>--%>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdeliveryDel" name="datepickerdeliveryDel" disabled value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    
                                    </div>
                                </div>

                                

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Active</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusConIDDel" name="selectStatusConIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Status</label>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="txtLabel">
                                            <select id="selectStatusIDDel" name="selectStatusIDDel" class="form-control input-sm" disabled style="width: 100%">
                                            </select>
                                            <input type="text" class="form-control input input-sm txtLabel hidden" id="txtStatusIDDel" name="txtStatusIDDel" placeholder="" value="" required>
                                        </div>
                                    </div>
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
                            var strVal13 = table.rows[rIndex].cells[13].innerHTML;
                            var strVal14 = table.rows[rIndex].cells[14].innerHTML;
                            var strVal15 = table.rows[rIndex].cells[15].innerHTML;
                            var strVal16 = table.rows[rIndex].cells[16].innerHTML;
                            var strVal17 = table.rows[rIndex].cells[17].innerHTML;
                            var strVal18 = table.rows[rIndex].cells[18].innerHTML;
                            var strVal19 = table.rows[rIndex].cells[19].innerHTML;
                            var strVal20 = table.rows[rIndex].cells[20].innerHTML;
                            var strVal21 = table.rows[rIndex].cells[21].innerHTML;
                            var strVal22 = table.rows[rIndex].cells[22].innerHTML;
				
			    //alert(strVal0);
			    document.getElementById("ProjectIDEdit").value = strVal0;
                            document.getElementById("ProjectNameEdit").value = strVal3;

                            //document.getElementById("selectCompanyIDEdit").value = strVal5;
                            $('#selectCompanyIDEdit').val(strVal5); 
                            $('#selectCompanyIDEdit').change();

                            // raminder please check here when using select option cascade...
                            document.getElementById("ArchitecIDEdit").value = strVal4;

                            //document.getElementById("selectArchitecIDEdit").value = strVal4;
                            //$('#idUkuran').val(11).change();
                            //$('#selectArchitecIDEdit').val(strVal4).change(); 
                            //$('#selectArchitecIDEdit').change();

                            //$("#selectArchitecIDEdit option[value='"+strVal4+"']").attr("selected", true);


                            document.getElementById("ProjectIDEdit").value = strVal0;
                            document.getElementById("ProjectYearEdit").value = strVal1;
                            document.getElementById("ProjectMonthEdit").value = strVal2;
                            document.getElementById("LocationEdit").value = strVal7;
                            document.getElementById("MainConsEdit").value = strVal8;
                            document.getElementById("RefRfDfEdit").value = strVal9;

                            //document.getElementById("selectProjStepEdit").value = strVal10;
                            $('#selectProjStepEdit').val(strVal10); 
                            $('#selectProjStepEdit').change();

                            //document.getElementById("selectTypeIDEdit").value = strVal21;
                            $('#selectTypeIDEdit').val(strVal21); 
                            $('#selectTypeIDEdit').change();

                            //document.getElementById("selectProdTypeIDEdit").value = strVal21;
                            $('#selectProdTypeIDEdit').val(strVal12); 
                            $('#selectProdTypeIDEdit').change();

                            //document.getElementById("selectProdIDEdit").value = strVal14;
                            $('#selectProdIDEdit').val(strVal14);
                            $('#selectProdIDEdit').change();

                            document.getElementById("ProdIDEdit").value = strVal14;

                            //alert(strVal14);

                            document.getElementById("ProfIDEdit").value = strVal16;
                            document.getElementById("QuantityEdit").value = strVal17;

                            document.getElementById("datepickerdeliveryEdit").value = strVal18;
                            //document.getElementById("selectStatusConIDEdit").value = strVal19;
                            $('#selectStatusConIDEdit').val(strVal22); 
                            $('#selectStatusConIDEdit').change();

                            $('#selectStatusIDEdit').val(strVal19); 
                            $('#selectStatusIDEdit').change();
                            
                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            //document.getElementById("txtGradeIDEdit").value = strID;
                            //document.getElementById("txtGradeDescEdit").value = strDesc;
                            //document.getElementById("txtGradeDetailEdit").value = strDetail;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 25) {
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
                            var strVal13 = table.rows[rIndex].cells[13].innerHTML;
                            var strVal14 = table.rows[rIndex].cells[14].innerHTML;
                            var strVal15 = table.rows[rIndex].cells[15].innerHTML;
                            var strVal16 = table.rows[rIndex].cells[16].innerHTML;
                            var strVal17 = table.rows[rIndex].cells[17].innerHTML;
                            var strVal18 = table.rows[rIndex].cells[18].innerHTML;
                            var strVal19 = table.rows[rIndex].cells[19].innerHTML;
                            var strVal20 = table.rows[rIndex].cells[20].innerHTML;
                            var strVal21 = table.rows[rIndex].cells[21].innerHTML;
                            var strVal22 = table.rows[rIndex].cells[22].innerHTML;

                            document.getElementById("ProjectNameDel").value = strVal3;
                            //document.getElementById("selectCompanyIDDel").value = strVal5;
                            $('#selectCompanyIDDel').val(strVal5); 
                            $('#selectCompanyIDDel').change();

                            // raminder please check here when using select option cascade...
                            document.getElementById("ArchitecIDDel").value = strVal4;

                            document.getElementById("ProjectIDDel").value = strVal0;
                            document.getElementById("ProjectYearDel").value = strVal1;
                            document.getElementById("ProjectMonthDel").value = strVal2;
                            document.getElementById("LocationDel").value = strVal7;
                            document.getElementById("MainConsDel").value = strVal8;
                            document.getElementById("RefRfDfDel").value = strVal9;

                            //document.getElementById("selectProjStepDel").value = strVal10;
                            $('#selectProjStepDel').val(strVal10); 
                            $('#selectProjStepDel').change();

                            //document.getElementById("selectTypeIDDel").value = strVal21;
                            $('#selectTypeIDDel').val(strVal21); 
                            $('#selectTypeIDDel').change();

                            //document.getElementById("selectProdTypeIDDel").value = strVal21;
                            $('#selectProdTypeIDDel').val(strVal12); 
                            $('#selectProdTypeIDDel').change();

                            //document.getElementById("selectProdIDDel").value = strVal14;
                            $('#selectProdIDDel').val(strVal14);
                            $('#selectProdIDDel').change();

                            document.getElementById("ProdIDDel").value = strVal14;

                            document.getElementById("ProfIDDel").value = strVal16;
                            document.getElementById("QuantityDel").value = strVal17;

                            document.getElementById("datepickerdeliveryDel").value = strVal18;
                            //document.getElementById("selectStatusConIDDel").value = strVal19;
                            $('#selectStatusConIDDel').val(strVal22); 
                            $('#selectStatusConIDDel').change();

                            $('#selectStatusIDDel').val(strVal19); 
                            $('#selectStatusIDDel').change();

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
                var str1 = document.getElementById("selectCompanyIDEdit").value;
                var str2 = document.getElementById("ProjectNameEdit").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        document.getElementById("<%= btnUpdateData.ClientID %>").click();
                    }
                }
            }


            function ValidateDelete() {
                var str = document.getElementById("selectCompanyIDDel").value;
                if (str != '') {
                    if (confirm("Are you sure to delete..?")) {
                        //click yes
                        document.getElementById("<%= btnDeleteData.ClientID %>").click();
                    } else {
                        //click no
                    }
                }
            }
        </script>
    </section>

</asp:Content>
