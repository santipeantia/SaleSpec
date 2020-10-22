<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architectreport.aspx.cs" Inherits="SaleSpec.pages.report.architectreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
     <script src="jquery-1.11.2.min.js"></script>
    <script>

        $(document).ready(function () {            
                getHover();            
        });


        function getHover() {

            $('#tableArchitectProfile td').hover(function () {
                rIndex = this.parentElement.rowIndex;
                cIndex = this.cellIndex;
                if (rIndex != 0 & cIndex == 3 || cIndex == 4 || cIndex == 6) {
                    $(this).css('cursor', 'pointer');
                    $(this).css('color', 'red');
                    $(this).css('font-weight', 'bold');
                }
            }, function () {
                rIndex = this.parentElement.rowIndex;
                cIndex = this.cellIndex;
                if ((rIndex != 0 & cIndex == 3 || cIndex == 4 || cIndex == 6)) {
                    $(this).css("color", "darkblue");
                    $(this).css('font-weight', 'normal');
                }
            });
        }
        
       
    </script>


    <section class="content-header">
        <h1>Architect Report
            <small>Control panel</small>
        </h1>
    </section>



    <section class="content">
         <%--  <%= strMsgAlert %>--%>

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
                                            <button id="btnDownload" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                            <button id="btnExportExcel" runat="server"  type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                        </span>
                                    </span>

                                    </span>
                                    <span class="description">Details for weekly report</span>
                                </div>
                                
                                <div class="hidden">
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
                                               <%-- <%= strPortOption %>--%>
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
                                               
                                                <button id="btnDownloadExcel" runat="server" type="button" class="btn btn-success btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                    <i class="fa fa-file-excel-o"></i> Print Excel</button>
                                            </span>
                                        </div>
                                    </div>

                                    
                                </div>

                                </div>

                                <div class="row" style="margin-left: 30px;">
                                    
                                </div>
                            </div>
                            <hr />
                            <div id="divWeeklyReport">
                                <div class="row">
                                    <table id="tableArchitectProfile" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <td class="hidden">strID</td>
                                                <td class="hidden">strArchitecID</td>                                                
                                                <td class="hidden">strName</td>
                                                <td>FirstName</td>
                                                <td>LastName</td>
                                                <td>NickName</td>
                                                <td class="">CompanyName</td>
                                                <td class="hidden">strPosition</td>
                                                <td class="hidden">strAddress</td>
                                                <td>Phone</td>
                                                <td>Mobile</td>
                                                <td>Email</td>
                                                <td class="hidden">strStatusConID</td>
                                                <td class="hidden">strCreatedDate</td>
                                                <td class="hidden">strUpdatedDate</td>
                                                <td class="hidden">strGradeID</td>
                                                <td class="hidden">strConDesc</td>
                                                <td class="hidden">strConDesc2</td>
                                                <td>Position</td>
                                                <td class="hidden">strPositionNameEN</td>
                                                <td>Grade</td>
                                                <td class="hidden">strGradeDetail</td>
                                                <td class="">Port</td>
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
