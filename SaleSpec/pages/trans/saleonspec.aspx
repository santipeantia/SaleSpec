<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleonspec.aspx.cs" Inherits="SaleSpec.pages.trans.saleonspec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->

    

    <section class="content-header">
        <h1>Sale On Spec (SOS)
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
                        <h3 class="box-title">Sale On Spec</h3>
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
                        <div class="row" style="margin-left: 0px;">
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

                            <div class="col-md-2">
                                <label class="txtLabel">Show Report</label>
                                <input type="button" class="btn btn-block btn-primary btn-sm" value="Show Report" />
                            </div>
                        </div>

                        <hr />

                        <table id="example1" class="table table-bordered table-striped table-hover table-condensed" style="width: 5000px">
                            <%--pagination pagination-sm--%>
                            <thead>
                                <tr>
                                    <td>CompanyID</td>
                                    <td>CompanyName</td>
                                    <td>ArchitecID</td>
                                    <td>Name</td>
                                    <td>Spec</td>
                                    <td>DocuNo</td>
                                    <td>DocDate</td>
                                    <td>Rollformer</td>
                                    <td>ProjectID</td>
                                    <td>ProjectName</td>
                                    <td>RefPO</td>
                                    <td>GoodCode</td>
                                    <td>Model</td>
                                    <td>AcutalM</td>
                                    <td>SpecM</td>
                                    <td>Price</td>
                                    <td>RentAmount</td>
                                    <td>NetRF</td>
                                    <td>NetCom</td>
                                    <td>NetItem</td>
                                    <td>Port</td>
                                    <td>SendDate</td>
                                    <td class="hidden">PriceRate</td>
                                    <td class="hidden">PriceOver</td>
                                    <td>ssConfirm</td>
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
    </section>

</asp:Content>
