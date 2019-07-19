<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projectreport.aspx.cs" Inherits="SaleSpec.pages.report.projectreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <script src="jquery-1.11.2.min.js"></script>
        <script>
            $(document).ready(function () {

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                var firstdate = yyyy + '-' + mm + '-01';
                var currentdate = yyyy + '-' + mm + '-' + dd;


                var datepickertrans = $('#datepickertrans');
                var datepickerend = $('#datepickerend');
                datepickertrans.val(firstdate);
                datepickerend.val(currentdate);

                var btnJsonReport = $('#btnJsonReport');
                btnJsonReport.click(function () {
                    var selectOption = $('#selectReportOption').val();
                    var datepickertrans = $('#datepickertrans').val();
                    var datepickerend = $('#datepickerend').val();
                    var selectSaleport = $('#selectSalePort').val();
                    var strqtystrat = $('#QtyStart').val();
                    var strqtyend = $('#QtyEnd').val();
                    var strsearch = $('#Search').val();

                    //alert(selectSaleport);


                    $.ajax({
                        url: 'DataServicesReporting.asmx/GetDataProjectByPortByOption',
                        method: 'post',
                        data: {
                            strOption: selectOption,
                            strDateStart: datepickertrans,
                            strDateEnd: datepickerend,
                            strUserID: selectSaleport,
                            strQtyStart: strqtystrat,
                            strQtyEnd: strqtyend,
                            strSearch: strsearch
                        },
                        dataType: 'json',
                        success: function (data) {

                            //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                            var trHTML = '';
                            $('#tableWeeklyReportx tr:not(:first)').remove();
                            $(data).each(function (index, item) {
                                trHTML += '<tr>' +
                                    '<td class="hidden">' + item.ID + '</td>' +
                                    '<td class="hidden">' + item.WeekDate + '</td>' +
                                    '<td class="hidden">' + item.WeekTime + '</td>' +
                                    '<td>' + item.CompanyName + '</td>' +
                                    '<td class="hidden">' + item.ArchitectID + '</td>' +
                                    '<td>' + item.Name + '</td>' +
                                    '<td class="hidden">' + item.ProjectID + '</td>' +
                                    '<td>' + item.ProjectName + '</td>' +
                                    '<td>' + item.Location + '</td>' +
                                    '<td class="hidden">' + item.ProdTypeID + '</td>' +
                                    '<td>' + item.ProdTypeNameEN + '</td>' +
                                    '<td class="hidden">' + item.ProdID + '</td>' +
                                    '<td>' + item.ProdNameEN + '</td>' +
                                    '<td>' + item.ProfNameEN + '</td>' +
                                    '<td>' + item.DeliveryDate + '</td>' +
                                    '<td>' + item.NextVisitDate + '</td>' +
                                    '<td>' + item.Quantity + '</td>' +
                                    '<td>' + item.StepNameA + '</td>' +
                                    '<td>' + item.StepNameB + '</td>' +
                                    '<td>' + item.RefWeekDate + '</td>' +
                                    '<td>' + item.Ref1 + '</td>' +
                                    '<td>' + item.Ref2 + '</td>' +
                                    '<td>' + item.Ref3 + '</td>' +
                                    '<td>' + item.RefRemark + '</td>' +
                                    '</tr > ';

                            });

                            $('#tableWeeklyReportx').append(trHTML);

                            $(function () {

                                //var refTab = $('#tableWeeklyReportx');
                                //for (var i = 0; i < refTab.rows[i]; i++) {
                                //    var row = refTab.rows.item(i);
                                //    for (var j = 0; j < row.cells[j]; j++) {
                                //        refTab.rows[i].cells[j].onclick = function () {
                                //            var col = row.cells.item(j);
                                //            alert(col.firstChild.innerText);
                                //        }
                                //    }
                                //}

                                var table = $('#tableWeeklyReportx');
                                $('#tableWeeklyReportx td').click(function () {

                                    rIndex = this.parentElement.rowIndex;
                                    cIndex = this.cellIndex;

                                    if (rIndex != 0 & cIndex == 7) {
                                        //alert(rIndex + '' + cIndex);

                                        var strVal0 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                        var strVal1 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                        var strVal2 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                        var strVal3 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                        var strVal4 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                        var strVal5 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                        var strVal6 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                        var strVal7 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                        var strVal8 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                        var strVal9 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                        var strVal11 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(11)');
                                        
                                        var strVal13 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                        var strVal14 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                        var strVal15 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                        var strVal16 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                        var strVal23 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(23)');


                                        //document.getElementById("txtid").value = strVal0.text();
                                        $('#txtid').val(strVal0.text());
                                        $('#txtVisitDate').val(strVal1.text());
                                        $('#txtTime').val(strVal2.text());
                                        $('#txtCompanyName').val(strVal3.text());

                                        var selectArchitectNameDDL = $('#selectArchitectName');

                                        //Get update architect name by company
                                        $.ajax({
                                            url: 'DataServicesReporting.asmx/DataReportGetArchitect',
                                            method: 'post',
                                            data: {
                                                id: strVal0.text()
                                            },
                                            datatype: 'json',
                                            success: function (data){
                                                selectArchitectNameDDL.empty();
                                                $(data).each(function (index, item) {
                                                    selectArchitectNameDDL.append($('<option/>', { value: item.ArchitecID, text: item.ArchitectName }));

                                                    $('#selectArchitectName').val(strVal4.text()); 
                                                    $('#selectArchitectName').change();

                                                    //selectArchitectNameDDL.text = strVal4.text();
                                                    //selectArchitectNameDDL.change();
                                                });
                                            }

                                        });

                                        $('#txtProjectName').val(strVal7.text());
                                        $('#txtLocation').val(strVal8.text());


                                        //Get Product type such as Ampelite, Ampelram
                                        var selectProductTypeDDL = $('#selectProductType');
                                        $.ajax({
                                            url: '../trans/DataServices.asmx/GetProductType',
                                            method: 'post',
                                            dataType: 'json',
                                            success: function (data) {
                                                selectProductTypeDDL.empty();
                                                $(data).each(function (index, item) {
                                                    selectProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                                                    $('#selectProductType').val(strVal9.text());
                                                    $('#selectProductType').change();
                                                });
                                            }
                                        });


                                        //When product type changed cascading of product
                                        var selectProductNameDDL = $('#selectProductName');
                                        selectProductTypeDDL.change(function () {
                                            $.ajax({
                                                url: '../trans/DataServices.asmx/GetProducts',
                                                method: 'post',
                                                data: { ProdTypeID: $(this).val() },
                                                dataType: 'json',
                                                success: function (data) {
                                                    selectProductNameDDL.empty();
                                                    selectProductNameDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                                                    $(data).each(function (index, item) {
                                                        selectProductNameDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                                                        selectProductNameDDL.val(strVal11.text());
                                                        selectProductNameDDL.change();
                                                    });
                                                }
                                            });
                                        });




                                        $('#txtProfile').val(strVal13.text());
                                        $('#datedelivery').val(strVal14.text());
                                        $('#datefollowing').val(strVal15.text());
                                        $('#txtQuantity').val(strVal16.text());
                                        $('#txtRemark').val(strVal23.text());
                                        


                                        setTimeout(function () {
                                            $("#myModalEdit").modal({ backdrop: false });
                                            $("#myModalEdit").modal("show");
                                        }, 500);

                                        
                                    }

                                   
                                    //$('table tbody tr:not(:first)').on('click', function () {

                                    //    alert($(this).html()); // or .text()
                                    //});
                                });

                            });

                        }
                    });
                });


               
            })
        </script>



        <h1>Project Status
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <%= strMsgAlert %>

        <%-- Application Forms--%>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <div class="box-body">
                            <a href="#">content</a>
                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Project Status</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" runat="server" onserverclick="btnDownload_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Monitoring progression of projects</span>
                                </div>

                            </div>

                            <hr />

                            <div class="row" style="margin-left: 30px;">
                               
                                <div class="col-md-4">
                                    <label class="txtLabel">Report Options</label>
                                    <div class="txtLabel">
                                        <select id="selectReportOption" name="selectReportOption" class="form-control input-sm" style="width: 100%">
                                            <%--<%= strReportOption %>--%>
                                            <option value="R001">Design <--> Bidding</option>
                                            <option value="R002">Bidding <--> Award Main Cons</option>
                                            <option value="R003">Award Main Cons <--> Award RF</option>
                                            <option value="R004">Next Following</option>
                                            <option value="R011">Design --> Bidding</option>
                                            <option value="R012">Bidding --> Award Main Cons</option>
                                            <option value="R013">Award Main Cons --> Award RF</option>
                                            <option value="R099">View all</option>
                                        </select>
                                    </div>
                                    <div id="divErrorselectReportOption" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

                               

                                <div class="col-md-2">
                                    <label class="txtLabel">From Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickertrans" name="datepickertrans" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">End Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerend" name="datepickerend" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-left: 30px;">
                                
                                 <div class="col-md-4">
                                    <label class="txtLabel">Sale Spec</label>
                                    <div class="txtLabel">
                                        <select id="selectSalePort" name="selectSalePort" class="form-control input-sm" style="width: 100%">
                                            <%= strPortOption %>
                                        </select>
                                    </div>
                                    <div id="divErrorSelectSaleSpec" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

                               <div class="col-md-2">
                                    <label class="txtLabel">From Quantity</label>
                                    <div class="txtLabel">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="QtyStart" name="QtyStart" value="" autocomplete="off" placeholder="">
                                    </div>
                                    <div id="divErrorQtyStart" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">To Quantity</label>
                                    <div class="txtLabel">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="QtyEnd" name="QtyEnd" value="" autocomplete="off" placeholder="">
                                    </div>
                                    <div id="divErrorQtyEnd" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>
                            </div>

                            <div class="row" style="margin-left: 30px;">
                                


                                <div class="col-md-6">
                                    <label class="txtLabel">Search</label>
                                    <div class="txtLabel">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="Search" name="Search" value="" autocomplete="off" placeholder="Can you search data in here..">
                                    </div>
                                    <div id="divErrorSearch" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">Query Info</label>
                                    <div class="">
                                        <button type="button" id="btnJsonReport" class="btn btn-info btn-flat btn-block btn-sm ">Show Report</button>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">Reporting</label>
                                    <div>
                                        <span class="">
                                            <button id="btnDownloadExcel" runat="server" onserverclick="btnExportExcelOption_click" type="button" class="btn btn-success btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                <i class="fa fa-file-excel-o"></i> Print Excel</button>
                                        </span>
                                    </div>
                                </div>

                                <div class="col-md-2 hidden">
                                    <label class="txtLabel">Reporting</label>
                                    <div>
                                        <span class="">
                                            <button id="btnDownloadPDF" runat="server" type="button" class="btn btn-warning btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                <i class="fa fa-pdf-o"></i> Print PDF</button>
                                        </span>
                                    </div>
                                </div>


                            </div>


                            <br />
                           
                            <div id="divWeeklyReport">
                                <div class="row">
                                    <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <td class="hidden">ID</td>
                                                <td class="hidden">WeekDate</td>
                                                <td class="hidden">WeekTime</td>
                                                <td>CompanyName</td>
                                                <td class="hidden">ArchitectID</td>
                                                <td>Name</td>
                                                <td class="hidden">ProjectID</td>
                                                <td>ProjectName</td>
                                                <td>Location</td>
                                                <td class="hidden">ProdTypeID</td>
                                                <td>ProdType</td>
                                                <td>ProdID</td>
                                                <td class="hidden">ProdName</td>
                                                <td>Profile</td>
                                                <td>Delivery</td>
                                                <td>Following</td>
                                                <td>Quantity</td>
                                                <td>StepNameA</td>
                                                <td>StepNameB</td>
                                                <td>RefWeekDate</td>
                                                <td>Ref1</td>
                                                <td>Ref2</td>
                                                <td>Ref3</td>
                                                <td>RefRemark</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%= strTblDetail %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>



                        </div>
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
                        <h4 class="modal-title">Project Update</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtid" name="txtid"  autocomplete="off" readonly placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                
                                    <div class="col-md-4 txtLabel">Date / Time</div>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control input input-sm txtLabel" id="txtVisitDate" name="txtVisitDate" readonly autocomplete="off" placeholder="" value="" required>
                                    </div>
                               

                                    <div class="col-md-4">
                                        <input type="text" class="form-control input input-sm txtLabel" id="txtTime" name="txtTime"  readonly autocomplete="off" placeholder="" value="" required>
                                    </div>
                                
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Company</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyName" name="txtCompanyName" readonly autocomplete="off" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Project Name</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProjectName" name="txtProjectName" readonly autocomplete="off" placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Architect</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectArchitectName" name="selectArchitectName" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Location</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLocation" name="txtLocation" autocomplete="off" placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">ProductType</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectProductType" name="selectProductType" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">ProductName</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectProductName" name="selectProductName" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Profile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProfile" name="txtProfile" autocomplete="off" placeholder="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Delivery / Following</div>
                                <div class="col-md-4">
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datedelivery" name="datedelivery" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datefollowing" name="datefollowing" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Quantity</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtQuantity" name="txtQuantity" autocomplete="off" placeholder="" value="" >
                                </div>
                            </div>
                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Remark</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="5" id="txtRemark" name="txtRemark" class="form-control input input-sm txtLabel"></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Status</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectStatus" name="selectStatus" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="btnSubmitUpdate" class="btn btn-primary" >Update Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData" runat="server">Update Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            //var refTab = document.getElementById("tableWeeklyReportx")
            //var ttl;
            //// Loop through all rows and columns of the table and popup alert with the value
            //// /content of each cell.
            //for (var i = 0; row = refTab.rows[i]; i++) {
            //    row = refTab.rows[i];
            //    for (var j = 0; col = row.cells[j]; j++) {

            //        //refTab.rows[i].cells[j].onclick = function () {
                        
            //        //}

            //        alert(col.firstChild.nodeValue);
                    
            //    }
            //}




            //var table = $('#tableWeeklyReportx');
            //for (var i = 0; i < table.rows[i]; i++) {
            //    row = refTab.rows[i];
            //    for (var j = 0; col = table.rows[i].cells[j]; j++) {

                    //table.rows[i].cells[j].onclick = function () {
                        //rIndex = this.parentElement.rowIndex;
                        //cIndex = this.cellIndex;
                        //console.log(rIndex + "  :  " + cIndex);

                        //if (this.cellIndex == 3) {

                        //    $("#myModalEdit").modal({ backdrop: false });
                        //    $("#myModalEdit").modal("show");

                        //}
                //    }
                //}


            //$('#tableWeeklyReportx').find('td').click(function () {
            //    alert($(this).text());
            //});



        </script>

    </section>
</asp:Content>
