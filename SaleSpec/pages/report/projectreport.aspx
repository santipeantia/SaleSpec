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
                                    //'<td>' + item.WeekDate + '</td>' +
                                    //'<td>' + item.WeekTime + '</td>' +
                                    '<td>' + item.CompanyName + '</td>' +
                                    '<td>' + item.Name + '</td>' +
                                    //'<td>' + item.ProjectID + '</td>' +
                                    '<td>' + item.ProjectName + '</td>' +
                                    '<td>' + item.Location + '</td>' +
                                    '<td>' + item.ProdTypeNameEN + '</td>' +
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
                                            <option value="R001">Design --> Bidding</option>
                                            <option value="R002">Bidding --> Award Main Cons</option>
                                            <option value="R003">Award Main Cons --> Award RF</option>
                                            <option value="R004">Visit --> Next Following</option>
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
                                                <%--<td>WeekDate</td>--%>
                                                <%--<td>WeekTime</td>--%>
                                                <td>CompanyName</td>
                                                <td>Name</td>
                                                <%--<td>ProjectID</td>--%>
                                                <td>ProjectName</td>
                                                <td>Location</td>
                                                <td>ProdTypeNameEN</td>
                                                <td>ProdNameEN</td>
                                                <td>ProfNameEN</td>
                                                <td>DeliveryDate</td>
                                                <td>NextVisitDate</td>
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
    </section>


</asp:Content>
