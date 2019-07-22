﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architectprofile.aspx.cs" Inherits="SaleSpec.pages.report.architectprofile" %>
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
                var selectSaleport = $('#selectSalePort').val();
                var strStatus = 'S01'; //$('#selectSalePort').val();
                var datepickertrans = $('#datepickertrans').val();
                var datepickerend = $('#datepickerend').val();
                var strqtystrat = $('#QtyStart').val();
                var strqtyend = $('#QtyEnd').val();
                var strsearch = $('#Search').val();

                //alert(selectSaleport);

                if (selectSaleport != "SELECTED ALL") {
                    $.ajax({
                    url: 'DataServicesReporting.asmx/GetDataProjectByPortStatus',
                    method: 'post',
                    data: {
                        strUserID: selectSaleport,
                        strStatus: strStatus,
                        strStartDate: datepickertrans,
                        strEndDate: datepickerend,
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
                                '<td>' + item.No + '</td>' +
                                //'<td>' + item.ProjectID + '</td>' +
                                '<td> ' + item.ProjectName + '</td>' +
                                //'<td>' + item.CompanyID + '</td>' +
                                '<td>' + item.CompanyName + '</td>' +
                                //'<td>' + item.ArchitecID + '</td>' +
                                '<td>' + item.Name + '</td>' +
                                '<td>' + item.Location + '</td>' +
                                '<td>' + item.ProdTypeNameEN + '</td>' +
                                '<td>' + item.StepNameEn + '</td>' +
                                '<td>' + item.StatusNameEn + '</td>' +
                                '<td>' + item.DeliveryDate + '</td>' +
                                '<td>' + item.Quantity + '</td>' +
                                '<td>' + item.CreatedBy + '</td>' +
                                '<td>' + item.CreatedDate + '</td>' +
                                '<td><a href="../report/specintakeview?opt=itk&projid='+ item.ProjectID +'" title="View"><i class="fa fa-search text-green"></i></a></td>' +
                                '</tr > ';

                            //No
                            //WeekDate
                            //WeekTime
                            //CompanyID
                            //CompanyName
                            //ArchitecID
                            //Name
                            //TransID
                            //TransNameEN
                            //ProjectID
                            //ProjectName
                            //Location
                            //TurnKey
                            //StepID
                            //StepNameEn
                            //BiddingName1
                            //OwnerName1
                            //BiddingName2
                            //OwnerName2
                            //BiddingName3
                            //OwnerName3
                            //AwardMC
                            //ContactMC
                            //AwardRF
                            //ContactRF
                            //ProdTypeID
                            //ProdTypeNameEN
                            //ProdID
                            //ProdNameEN
                            //ProfID
                            //ProfNameEN
                            //Quantity
                            //DeliveryDate
                            //NextVisitDate
                            //StatusID
                            //StatusNameEn
                            //Remark
                            //UserID
                            //EmpCode
                            //CreatedBy
                            //CreatedDate
                        });

                        $('#tableWeeklyReportx').append(trHTML);
                    }
                });
                } else {
                    //alert('You select Get Data All')

                    $.ajax({
                    url: 'DataServicesReporting.asmx/GetDataProjectByPortStatusAll',
                    method: 'post',
                        data: {
                        strUserID: selectSaleport,
                        strStatus: strStatus,
                        strStartDate: datepickertrans,
                        strEndDate: datepickerend,
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
                                '<td>' + item.No + '</td>' +
                                //'<td>' + item.ProjectID + '</td>' +
                                '<td> ' + item.ProjectName + '</td>' +
                                //'<td>' + item.CompanyID + '</td>' +
                                '<td>' + item.CompanyName + '</td>' +
                                //'<td>' + item.ArchitecID + '</td>' +
                                '<td>' + item.Name + '</td>' +
                                '<td>' + item.Location + '</td>' +
                                '<td>' + item.ProdTypeNameEN + '</td>' +
                                '<td>' + item.StepNameEn + '</td>' +
                                '<td>' + item.StatusNameEn + '</td>' +
                                '<td>' + item.DeliveryDate + '</td>' +
                                '<td>' + item.Quantity + '</td>' +
                                '<td>' + item.CreatedBy + '</td>' +
                                '<td>' + item.CreatedDate + '</td>' +
                                '<td><a href="../report/specintakeview?opt=itk&projid='+ item.ProjectID +'" title="View"><i class="fa fa-search text-green"></i></a></td>' +
                                '</tr > ';
                        });

                        $('#tableWeeklyReportx').append(trHTML);
                    }
                });
                }

                
            });
        })
    </script>




        <h1>Architect Profile
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
                                        <a href="#">Architect Profile</a>
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
                                    <span class="description">Details for weekly report</span>
                                </div>


                                <%--<div class="row" style="margin-left: 30px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Select Reports</label>
                                        <div class="txtLabel">
                                            <select id="selectReportType" name="selectReportType" class="form-control input-sm" style="width: 100%">
                                                <option value="1">New Project</option>
                                                <option value="2">Spec Intake</option>
                                                <option value="3">Step Design > Bidding </option>
                                                <option value="4">Step Bidding > Award MC</option>
                                                <option value="5">Step Award RF > Award RF </option>
                                                <option value="6">Project Bidding </option>
                                                <option value="7">Project Award MC</option>
                                                <option value="8">Project Award RF</option>
                                                <option value="9">Weekly Report</option>
                                                <option value="10">Next Visit</option>
                                            </select>
                                        </div>
                                        <div id="divErrorselectReportType" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                    </div>
                                </div>--%>

                                <div class="row" style="margin-left: 30px;">
                                    <div class="col-md-4 hidden">
                                        <label class="txtLabel">Project</label>
                                        <div class="txtLabel">
                                            <select id="selectProject" name="selectProject" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                        <div id="divErrorSelectProject" class="txtLabel text-red" style="display: none;">Please select a project...!</div>
                                    </div>

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


                                    <div class="col-md-4">
                                        <label class="txtLabel">Search</label>
                                        <div class="txtLabel">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="Search" name="Search" value="" autocomplete="off" placeholder="Can you search data in here..">
                                         </div>
                                        <div id="divErrorSearch" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                    </div>

                                     <div class="col-md-2">
                                        <label class="txtLabel">Query Info</label>
                                        <div class="">
                                            <%--<button type="button" id="btnQuery" runat="server" onserverclick="btnQuery_Click" class="btn btn-info btn-flat btn-block btn-sm hidden" >Show Report</button>--%>
                                            <button type="button" id="btnJsonReport" class="btn btn-info btn-flat btn-block btn-sm " >Show Report</button>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-2">
                                        <label class="txtLabel">Reporting</label>
                                        <div>
                                            <span class="">
                                               
                                                <button id="btnDownloadExcel" runat="server" onserverclick="btnExportExcelOption_click"  type="button" class="btn btn-success btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                    <i class="fa fa-file-excel-o"></i> Print Excel</button>
                                            </span>
                                        </div>
                                    </div>

                                    
                                </div>

                                <div class="row" style="margin-left: 30px;">
                                    
                                </div>
                            </div>
                            <hr />
                            <div id="divWeeklyReport">
                                <div class="row">
                                    <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <td>No</td>
                                                <%--<td>ProjID</td>--%>
                                                <td>Project Name</td>
                                                <%--<td>ComID</td>--%>
                                                <td>Company Name</td>
                                                <%--<td>Architec ID</td>--%>
                                                <td>Architec Name</td>
                                                <td>Location</td>
                                                <td>ProdType</td>
                                                <td>Step</td>
                                                <td>Status</td>
                                                <td>Delivery</td>
                                                <td>Quantity</td>
                                                <td>CreatedBy</td>
                                                <td>LastUpdate</td>
                                                <td>#</td>
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