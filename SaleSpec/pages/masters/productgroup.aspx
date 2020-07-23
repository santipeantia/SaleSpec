<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="productgroup.aspx.cs" Inherits="SaleSpec.pages.masters.productgroup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../trans/jquery-1.11.2.min.js"></script>
    <script>
        $(document).ready(function () {
            var selectProductTypeDDL = $('#selectProductType');
            var selectProductTypeEditDDL = $('#selectProductTypeEdit');
            var selectProductTypeDelDDL = $('#selectProductTypeDel');

             //Get data project type
            $.ajax({
                url: '../trans/DataServices.asmx/GetProductType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProductTypeDDL.append($('<option/>', { value: -1, text: 'Select product type' }));
                    $(data).each(function (index, item) {
                        selectProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                    });
                }
            });

             $.ajax({
                url: '../trans/DataServices.asmx/GetProductType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProductTypeEditDDL.append($('<option/>', { value: -1, text: 'Select product type' }));
                    $(data).each(function (index, item) {
                        selectProductTypeEditDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                    });
                }
            });


            $.ajax({
                url: '../trans/DataServices.asmx/GetProductType',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectProductTypeDelDDL.append($('<option/>', { value: -1, text: 'Select product type' }));
                    $(data).each(function (index, item) {
                        selectProductTypeDelDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                    });
                }
            });

        });
    </script>
     <!-- Header content -->
    <section class="content-header">
        <h1>Product Group
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
                                    <th class="hide">ProdID </th>
                                    <th class="hide">ProdTypeID </th>
                                    <th>ProdTypeName </th>
                                    <th>ProdNameTH </th>
                                    <th>ProdNameEN </th>
                                    <th>ProdDesc </th>
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
                        <h4 class="modal-title">New Product</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4">ProdID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdID" name="txtProdID" placeholder="" value=""  required></div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Product Type</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectProductType" name="selectProductType" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                                <div id="divErrorProductType" class="txtLabel text-red" style="display: none;">Please select a product type...!</div>
                            </div>

                            <div class="row" style="margin-bottom: 5px; margin-top: 5px;">
                                <div class="col-md-4">ProdNameTH</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdNameTH" name="txtProdNameTH" placeholder="" value="" required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px; margin-top: 5px;">
                                <div class="col-md-4">ProdNameEN</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdNameEN" name="txtProdNameEN" placeholder="" value="" required></div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                     <textarea id="txtProdDesc" name="txtProdDesc" cols="30" rows="2" class="form-control input-sm txtLabel"></textarea>
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
                        <h4 class="modal-title">Edit Products</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4">ProdID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdIDEdit" name="txtProdIDEdit" placeholder="" value=""  required></div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Product Type</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectProductTypeEdit" name="selectProductTypeEdit" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                                <div id="divErrorProductTypeEdit" class="txtLabel text-red" style="display: none;">Please select a product type...!</div>
                            </div>

                            <div class="row" style="margin-bottom: 5px; margin-top: 5px;">
                                <div class="col-md-4">ProdNameTH</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdNameTHEdit" name="txtProdNameTHEdit" placeholder="" value="" required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px; margin-top: 5px;">
                                <div class="col-md-4">ProdNameEN</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdNameENEdit" name="txtProdNameENEdit" placeholder="" value="" required></div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                     <textarea id="txtProdDescEdit" name="txtProdDescEdit" cols="30" rows="2" class="form-control input-sm txtLabel"></textarea>
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
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4">ProdID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdIDDel" name="txtProdIDDel" placeholder="" value=""  required></div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Product Type</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectProductTypeDel" name="selectProductTypeDel" class="form-control input-sm" disabled style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                                <div id="divErrorProductTypeDel" class="txtLabel text-red" style="display: none;">Please select a product type...!</div>
                            </div>

                            <div class="row" style="margin-bottom: 5px; margin-top: 5px;">
                                <div class="col-md-4">ProdNameTH</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdNameTHDel" name="txtProdNameTHDel" disabled placeholder="" value="" required></div>
                            </div>

                            <div class="row" style="margin-bottom: 5px; margin-top: 5px;">
                                <div class="col-md-4">ProdNameEN</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtProdNameENDel" name="txtProdNameENDel" disabled placeholder="" value="" required></div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                     <textarea id="txtProdDescDel" name="txtProdDescDel" disabled cols="30" rows="2" class="form-control input-sm txtLabel"></textarea>
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
                            var strVal1 = table.rows[rIndex].cells[0].innerHTML;
                            var strVal2 = table.rows[rIndex].cells[1].innerHTML;
                            var strVal3 = table.rows[rIndex].cells[2].innerHTML;
                            var strVal4 = table.rows[rIndex].cells[3].innerHTML;
                            var strVal5 = table.rows[rIndex].cells[4].innerHTML;
                            var strVal6 = table.rows[rIndex].cells[5].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtProdIDEdit").value = strVal1;
                            document.getElementById("selectProductTypeEdit").value = strVal3;
                            document.getElementById("txtProdNameTHEdit").value = strVal4;
                            document.getElementById("txtProdNameENEdit").value = strVal5;
                            document.getElementById("txtProdDescEdit").value = strVal6;

                            //var e  = document.getElementById("selectProductTypeEdit");
                            //e.value = strVal2;
                            //document.getElementById('selectProductTypeEdit').value = strVal2;

                            $('#selectProductTypeEdit').val(strVal2); 
                            $('#selectProductTypeEdit').change();

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 7) {
                            var strVal1 = table.rows[rIndex].cells[0].innerHTML;
                            var strVal2 = table.rows[rIndex].cells[1].innerHTML;
                            var strVal3 = table.rows[rIndex].cells[2].innerHTML;
                            var strVal4 = table.rows[rIndex].cells[3].innerHTML;
                            var strVal5 = table.rows[rIndex].cells[4].innerHTML;
                            var strVal6 = table.rows[rIndex].cells[5].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtProdIDDel").value = strVal1;
                            document.getElementById("selectProductTypeDel").value = strVal3;
                            document.getElementById("txtProdNameTHDel").value = strVal4;
                            document.getElementById("txtProdNameENDel").value = strVal5;
                            document.getElementById("txtProdDescDel").value = strVal6;

                            $('#selectProductTypeDel').val(strVal2); 
                            $('#selectProductTypeDel').change();

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
                var str1 = document.getElementById("selectProductType").value;
                var str2 = document.getElementById("txtProdNameTH").value;
                var str3 = document.getElementById("txtProdNameEN").value;
                if (str1 != '' && str2 != '' && str3 !='') {
                    document.getElementById("<%=  btnSaveNewCustomer.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str = document.getElementById("txtProdIDEdit").value;
                if (str != '')
                {             
                    document.getElementById("<%= btnUpdateCustomer.ClientID %>").click();
                }      
            }

            function ValidateDelete() {
                var str = document.getElementById("txtProdIDDel").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteCustomer.ClientID %>").click();
                }
            }
        </script>
    </section>

</asp:Content>
