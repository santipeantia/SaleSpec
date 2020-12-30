<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="companyreport.aspx.cs" Inherits="SaleSpec.pages.trans.companyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="../trans/jquery-1.11.2.min.js"></script>

    <script>
        document.addEventListener("keyup", function (e) {
            var keyCode = e.keyCode ? e.keyCode : e.which;
            if (keyCode == 44) {
                stopPrntScr();
            }
        });

        function stopPrntScr() {

            var inpFld = document.createElement("input");
            inpFld.setAttribute("value", ".");
            inpFld.setAttribute("width", "0");
            inpFld.style.height = "0px";
            inpFld.style.width = "0px";
            inpFld.style.border = "0px";
            document.body.appendChild(inpFld);
            inpFld.select();
            document.execCommand("copy");
            inpFld.remove(inpFld);
        }
        function AccessClipboardData() {
            try {
                window.clipboardData.setData('text', "Access   Restricted");
            } catch (err) {
            }
        }

        setInterval("AccessClipboardData()", 300);

        window.onload = function () {
            document.addEventListener("contextmenu", function (e) {
                Swal.fire(
                    'This page is protected..!',
                    'Do not copy or export data.',
                    'error'
                )
                e.preventDefault();
            }, false);
            document.addEventListener("keydown", function (e) {

                if (e.keyCode === 13) {
                       // Cancel the default action, if needed
                       e.preventDefault();
                       // Trigger the button element with a click
                       document.getElementById("btnQuery").click();
                }

                //document.onkeydown = function(e) {
                // "C" key
                if (e.ctrlKey && e.keyCode == 67) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }


                // "F" key
                if (e.altKey && e.keyCode == 70) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "I" key
                if (e.ctrlKey && e.shiftKey && e.keyCode == 73) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "J" key
                if (e.ctrlKey && e.shiftKey && e.keyCode == 74) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }

                // "P" key
                if (e.ctrlKey && e.keyCode == 80) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }

                // "S" key + macOS
                if (e.keyCode == 83 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "U" key
                if (e.ctrlKey && e.keyCode == 85) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }
                // "V" key
                if (e.ctrlKey && e.keyCode == 86) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not copy or export data.',
                        'error'
                    )
                    disabledEvent(e);
                }

                // "F12" key
                if (event.keyCode == 123) {
                    Swal.fire(
                        'This page is protected..!',
                        'Do not open source tag.',
                        'error'
                    )
                    disabledEvent(e);
                }
            }, false);
            function disabledEvent(e) {
                if (e.stopPropagation) {
                    e.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }
                e.preventDefault();
                return false;
            }
        };

    </script>


    <script>
        $(document).ready(function () {

            //var btnExportExcel = $('#btnExportExcel');
            var btnExportExcel = $('#btnExportExcel')
            btnExportExcel.click(function () {

                $('#txtRepOpt').val('EXCEL');

                $("#myModalVerifyPassword").modal({ backdrop: false });
                $("#myModalVerifyPassword").modal("show");
            });
        })
    </script>

    <!-- Header content -->
    <section class="content-header">
        <h1>Company Report
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
                                        <a href="#">Company Report</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel"  type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Take care by sales via projects</span>
                                </div>

                            </div>

                            <hr />
                            <div class="container-fluid">
                                <div class="col-md-4">
                                    <label class="txtLabel">Sale Spec</label>
                                    <div class="txtLabel">
                                        <select id="selectSalePort" name="selectSalePort" class="form-control input-sm" style="width: 100%">
                                            <%= strPortOption %>
                                        </select>
                                    </div>
                                    <div id="divErrorSelectSaleSpec" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

                                <%--<div class="col-md-2">
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
                                </div>--%>

                                
                                <div class="col-md-2">
                                    <label class="txtLabel">Query Info</label>
                                    <div class="">
                                        <button type="button" id="btnQuery" runat="server" onserverclick="btnQuery_Click" class="btn btn-info btn-flat btn-block btn-sm ">Show Report</button>
                                    </div>
                                </div>

                            </div>

                            <br />
                           
                            <div id="divWeeklyReport">
                                <div class="row">
                                    <table id="tableWeeklyReport" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <td>Port</td>
                                                <td>Company</td>
                                                <td class="hidden">CompanyName2</td>
                                                <td>Address</td>
                                                <td>CustType</td>
                                                <td class="hidden">CustTypeDesc</td>
                                                <td class="hidden">ProvinceID</td>
                                                <td>Contact</td>
                                                <td class="hidden">Phone</td>
                                                <td>Mobile</td>
                                                <td>Email</td>
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

        <!-- /.modal myModalVerifyPassword -->
        <div class="modal modal-default fade" id="myModalVerifyPassword">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Request Email</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="post clearfix">
                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Enter Your Email</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="txtConfirmEmail" name="txtConfirmEmail" autocomplete="off" placeholder="" value="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer clearfix">
                        <input type="text" id="txtRepOpt" name="txtRepOpt" class="hidden" value="" />
                        <%--<asp:Button ID="btnSendMail" runat="server" Text="btnSendMail" OnClick="btnSendMail_Click" CssClass="" />--%>
                        <button class="btn btn-default hidden" id="btnSendmail" runat="server" onserverclick="btnSendMail_Click">Send Mail</button>

                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="btnConfirmed" runat="server" onclick="sendMail()">Submit Request</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function sendMail() {
                document.getElementById("<%= btnSendmail.ClientID %>").click();
            }
        </script>


    </section>


</asp:Content>
