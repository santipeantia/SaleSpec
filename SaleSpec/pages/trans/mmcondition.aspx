<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="mmcondition.aspx.cs" Inherits="SaleSpec.pages.trans.mmcondition" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="jquery-1.11.2.min.js"></script>

    <script>
        $(document).ready(function () {


        });
    </script>

     <!-- Header content -->
    <section class="content-header">
        <h1>Metre to Mile Condition
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner">
                <span class="spinner"></span>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="box box-info" style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Condition</a>
                                        
                                    </span>
                                    <span class="description">Monitoring progression of projects</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- <%--step 2 design user interface ui below--%>
                    <div class="box-body">
                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Date Start:</label>
                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right"  id="datepickerstart">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Date End:</label>
                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right"  id="datepickerend">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">View Report</label>
                                <div class="input-group date">
                                    <input type="button" id="btnViewReport" name="btnViewReport" class="btn btn-info btn-flat btn-block btn-sm" value="Show Report Here" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            

            <div class="col-md-12">            

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-blue"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnAddNew1044" class="btn btn-default btn-sm" data-toggle="tooltip" title="addnew"><i class="fa fa-plus text-green"></i></button>
                                <button type="button" id="btnPdf1044" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1044" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">กำหนดเงื่อนไข</label>
                        </div>
                        <div class="box-body">
                            <%--<div id="loaderDiv1014" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1044">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblmmcondition" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">ProjectName</th>
                                        <th class="">Date</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">CustCode</th>
                                        <th class="">CustName</th>
                                        <th class="">TotalTraget</th>
                                        <th class="">SubTraget</th>
                                        <th class="">TotalPrice</th>
                                        <th class="">RemarkDesc</th>
                                        <th class="">#</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>

            </div>
        </div>

    </section>


</asp:Content>
