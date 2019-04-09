<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleweeklyreport.aspx.cs" Inherits="SaleSpec.pages.report.saleweeklyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- Header content -->
    <section class="content-header">
        <h1>Sale Weekly Report
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <%--   <%= strMsgAlert %>--%>

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
                                        <a href="#">Weekly Report</a>
                                        <span class="pull-right">
                                        <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                        <span class="btn-group">
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                            <button id="btnExportExcel" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                        </span>
                                    </span>

                                    </span>
                                    <span class="description">Details for weekly report</span>
                                </div>

                              

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
                                            <select id="selectSaleSpec" name="selectSaleSpec" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                        <div id="divErrorSelectSaleSpec" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                    </div>

                                    <div class="col-md-2">
                                        <label class="txtLabel">From Date</label>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickertrans" value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <label class="txtLabel">End Date</label>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerend" value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <label class="txtLabel">Query Info</label>
                                        <div class="input-group">
                                            <button type="button" id="btnQuery" runat="server" onserverclick="btnQuery_Click" class="btn btn-info btn-flat btn-block " >Show Report</button>
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
                                                <th>ID</th>
                                                <th>Descript</th>
                                                <th>Details</th>
                                                <th>#</th>
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
