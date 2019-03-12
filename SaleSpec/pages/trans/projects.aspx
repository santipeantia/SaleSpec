<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projects.aspx.cs" Inherits="SaleSpec.pages.trans.projects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Header content -->
    <section class="content-header">
        <h1>Projects Center
            <small>Control panel</small>
        </h1>
    </section>
    
    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->

        <%= strMsgAlert %>

        <div class="row">
            <div class="col-xs-12">
                <div class="box box-success">
                    <div class="box-header">
                        <h3 class="box-title">Select Data</h3>
                    </div>
                    <div class="box-body">
                        <%--<div class="row">
                            <div class="form-group col-md-2">
                                <label class="txtLabel">From Month</label>
                                <select id="frommonth" class="form-control txtLabel">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>

                            <div class="form-group col-md-2">
                                <label class="txtLabel">From Year</label>
                                <select id="fromyear" class="form-control txtLabel">
                                    <option value="2015">2015</option>
                                    <option value="2016">2016</option>
                                    <option value="2017">2017</option>
                                    <option value="2018">2018</option>
                                    <option value="2019">2019</option>
                                    <option value="2020">2020</option>
                                    <option value="2021">2021</option>
                                    <option value="2022">2022</option>
                                    <option value="2023">2023</option>
                                    <option value="2024">2024</option>
                                    <option value="2025">2025</option>
                                </select>
                            </div>

                            <div class="col-md-1 text-center">
                                <span class="text-green" style="top: 30px; position: relative;">
                                    <i class="fa fa-exchange" aria-hidden="true"></i>
                                </span>
                            </div>

                            <div class="col-md-2"> 
                                <label class="txtLabel">To Month</label>
                                <select id="tomonth" class="form-control txtLabel">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">To Year</label>
                                    <select id="toyear" class="form-control txtLabel">
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                    </select>
                                </div>
                            </div>
                        </div>--%>

                        <div class="row">
                                <div class="form-group col-md-2">
                                    <label class="txtLabel">Start Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left" id="datepickertrans">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-md-2">
                                    <label class="txtLabel">To Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left" id="datepickerstart">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label class="txtLabel">Query Info..</label>
                                    <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel" id="Button1" runat="server">Query Project</button>
                                </div>
                            </div>

                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">Status</label>
                                    <select id="status" class="form-control txtLabel">
                                        <option value=""></option>
                                        <option value="S01">Intake</option>
                                        <option value="S02">Sold</option>
                                        <option value="S03">Finished</option>
                                        <option value="S04">Cancel</option>
                                        <option value="S05">Hold</option>
                                        <option value="S06">N/A</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">Process Step</label>
                                    <select id="step" class="form-control txtLabel">
                                        <option value=""></option>
                                        <option value="PS01">Design</option>
                                        <option value="PS02">Bidding</option>
                                        <option value="PS03">Award MC</option>
                                        <option value="PS04">Award RF</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="txtLabel">Sale Spec</label>
                                    <select id="sale" class="form-control txtLabel">
                                        <option value=""></option>
                                        <option value="PS01">Pimsiri Wannaroj</option>
                                        <option value="PS02">Sunisa Deeramai</option>
                                        <option value="PS03">Sarunya Leelalers</option>
                                        <option value="PS04">Lapasrada Musigachai</option>
                                         <option value="PS04">Suppaluk Phungpan</option>
                                         <option value="PS04">Chanyanut	Sakoolkitiyut</option>
                                         <option value="PS04">Sirivimol	Khampanont</option>

                                    </select>
                                </div>
                            </div>

                            <div class="form-group col-md-2">
                                <label class="txtLabel">Query Info..</label>
                                <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel" id="btnSearch" runat="server">Get Query Info..</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       

        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">Project Details</h3>
                        <div class="pull-right">
                            <%--<button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                <i class="fa fa-plus"></i>
                            </button>--%>

                            <a class="btn btn-default btn-sm checkbox-toggle" href="../../pages/trans/apprequest-new?opt=reqf"><i class="fa fa-plus"></i></a>

                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel" runat="server" ><i class="fa fa-table"></i></button>
                            </div>
                        </div>
                    </div>

                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="example1" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <%--pagination pagination-sm--%>
                            <thead>
                                <tr>
                                    <td>SpecID</td>
                                    <td>FirstName</td>
                                    <td>LastName</td>
                                    <td>ID</td>
                                    <td>Year</td>
                                    <td>Month</td>
                                    <td>ProjectName</td>
                                    <td>CompanyName</td>
                                    <td>Location</td>
                                    <td>TypeID</td>
                                    <td>SaleSpec</td>
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
                        <h4 class="modal-title">New Customer Type</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">GradeID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeID" name="txtGradeID" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDesc" name="txtGradeDesc" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetail" name="txtGradeDetail" class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnSaveNewData"  runat="server">Save Changes</button>
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
                                    <input type="text" class="form-control input input-sm" id="txtGradeIDEdit" name="txtGradeIDEdit" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetailEdit" name="txtGradeDetailEdit" class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData" runat="server">Update Changes</button>
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
                                    <input type="text" class="form-control input input-sm" id="txtGradeIDDelete" name="txtGradeIDDelete" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDescDelete" name="txtGradeDescDelete" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetailDelete" name="txtGradeDetailDelete" disabled class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitDelete" class="btn btn-danger" onclick="ValidateDelete()">Delete Confirme</button>
                        <button type="button" class="btn btn-danger hidden" id="btnDeleteData" runat="server">Delete Confirme</button>
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

                        if (this.cellIndex == 3) {

                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strDesc = table.rows[rIndex].cells[1].innerHTML;
                            var strDetail = table.rows[rIndex].cells[2].innerHTML;

                            window.open('webform1.aspx?id=' + strID + '&ref=' + strDesc, '_blank', 'height=200, width=200, top=200, left=300, toolbar=no, titlebar=no,location=no,status=no,menubar=no');

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtGradeIDEdit").value = strID;
                            document.getElementById("txtGradeDescEdit").value = strDesc;
                            document.getElementById("txtGradeDetailEdit").value = strDetail;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 4) {
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
                if (str1 != '' && str2 != '' && str3 != '') {
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
