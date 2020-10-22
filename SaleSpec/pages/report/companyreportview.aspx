<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="companyreportview.aspx.cs" Inherits="SaleSpec.pages.report.companyreportview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <script src="jquery-1.11.2.min.js"></script>
        <script>
            $(document).ready(function () {

                 var example1 = $('#example1');
                $('#example1 td').hover(function () {
                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;
                    if (rIndex != 0 & cIndex == 3 || cIndex == 7) {
                        $(this).css('cursor', 'pointer');
                    }
                });

                $('#example1 td').click(function () {
                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;

                    if (rIndex != 0 & cIndex == 3 || cIndex ==7) {

                        var strarcid = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(6)').text().replace(' ','');

                        //alert(strarcid.text().replace(' ', ''));

                        window.open("../report/architectprofile.aspx?opt=rarc&id="+strarcid+"", "_blank");
                    }
                });



            });
        </script>



         <h1>Company Report View
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
                                        <a href="#">Spec Intake Report</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnReply" runat="server" onserverclick="btnReply_Click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Back"><i class="fa fa-reply"></i></button>
                                                <button id="btnDownload" runat="server" onserverclick="btnDownload_click" type="button" class="btn btn-default btn-sm hidden" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm hidden" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card hidden"></i></button>
                                                <button id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click" type="button" class="btn btn-default btn-sm hidden" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table hidden"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Details for weekly report</span>
                                </div>

                                <hr />

                                <div class="box-body">
                                    <table id="example1" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                        <%--pagination pagination-sm--%>
                                        <thead>
                                            <tr>
                                                <td class="hidden">ProjectID</td>
                                                <td>Year</td>
                                                <td>Month</td>
                                                <td>Project</td>
                                                <td class="hidden">CompanyID</td>
                                                <td>Company</td>
                                                <td class="hidden">ArchitecID</td>
                                                <td>Architect</td>
                                                <td>Location</td>
                                                <td>TurnKey</td>
                                                <td>MainCons</td>
                                                <td>RF</td>
                                                <td>Product</td>
                                                <td>Profile</td>
                                                <td>ProdName</td>
                                                <td>Quantity</td>
                                                <td>Delivery</td>
                                                <td>Status</td>
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
