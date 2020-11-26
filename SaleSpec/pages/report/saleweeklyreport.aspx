<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleweeklyreport.aspx.cs" Inherits="SaleSpec.pages.report.saleweeklyreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://smtpjs.com/v3/smtp.js"></script>
    <script src="jquery-1.11.2.min.js"></script>
    <script src="jquery.table2excel.js"></script>

    <style>
        #overlay {
            position: fixed;
            top: 0;
            z-index: 100;
            width: 100%;
            height: 100%;
            display: none;
            background: rgba(0,0,0,0.6);
        }

        .cv-spinner {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px #ddd solid;
            border-top: 4px #2e93e6 solid;
            border-radius: 50%;
            animation: sp-anime 0.8s infinite linear;
        }

        @keyframes sp-anime {
            100% {
                transform: rotate(360deg);
            }
        }

        .is-hide {
            display: none;
        }

        .mypointer:hover {
            cursor: pointer;
            color: red;
            font-weight: bold;
        }

        .mypointer {
            cursor: pointer;
            color: darkblue;
            font-weight: normal;
        }

        .mypointerid {
            cursor: pointer;
            color: darkblue;
            font-weight: normal;
        }
    </style>

  <%--  <script>
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

    </script>--%>

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

            var selecttimeDDL = $('#selecttime');

            selecttimeDDL.change(function () {
                var strchange = $('#selecttime option:selected').text();
                $('#txtVisitTime').val(strchange);
            });



            var btnJsonReport = $('#btnJsonReport');
            btnJsonReport.click(function () {
                var selectSaleport = $('#selectSalePort').val();
                var datepickertrans = $('#datepickertrans').val();
                var datepickerend = $('#datepickerend').val();
                var strsearch = $('#Search').val();
                //alert('get data here');
                $.ajax({
                    url: 'DataServicesReporting.asmx/GetWeeklyReporting',
                    method: 'post',
                    beforeSend: function () {
                        $("#overlay").show();
                    },
                    data: {
                        strUserID: selectSaleport,
                        strStartDate: datepickertrans,
                        strEndDate: datepickerend,
                        strsearch: strsearch
                    },
                    dataType: 'json',
                    success: function (data) {

                        //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                        //var trHTML = '';
                        //$('#tableSaleWeeklyReport tr:not(:first)').remove();
                        //$(data).each(function (index, item) {
                        //    trHTML += '<tr>' +
                        //        '<td>' + item.WeekDate + '</td>' +
                        //        '<td> ' + item.WeekTime + '</td>' +
                        //        '<td>' + item.CompanyID + '</td>' +
                        //        '<td>' + item.CompanyName + '</td>' +
                        //        '<td>' + item.ArchitecID + '</td>' +
                        //        '<td>' + item.Name + '</td>' +
                        //        '<td>' + item.ProjectID + '</td>' +
                        //        '<td>' + item.ProjectName + '</td>' +
                        //        '<td>' + item.Location + '</td>' +
                        //        '<td class="hidden">' + item.StatusID + '</td>' +
                        //        '<td>' + item.StatusNameEn + '</td>' +
                        //        '<td class="hidden">' + item.StepID + '</td>' +
                        //        '<td>' + item.StepNameEn + '</td>' +
                        //        '<td>' + item.Remark + '</td>' +
                        //        '<td>' + item.CreatedBy + '</td>' +
                        //        '<td>' + item.CreatedDate + '</td>' +
                        //        '</tr > ';
                        //});

                        //$('#tableSaleWeeklyReport').append(trHTML);

                        var table;
                        table = $('#tableSaleWeeklyReport').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].WeekDate, data[i].WeekTime, data[i].CompanyID, data[i].CompanyName, data[i].ArchitecID
                                    , data[i].Name, data[i].ProjectID, data[i].ProjectName
                                    , data[i].Location, data[i].StatusID, data[i].StatusNameEn, data[i].StepID, data[i].StepNameEn, data[i].Remark
                                    , data[i].UserID, data[i].EmpCode, data[i].CreatedBy, data[i].CreatedDate, data[i].TransID, data[i].TransNameEN]);
                            });
                        }
                        table.column(2).nodes().to$().addClass('hidden');
                        table.column(4).nodes().to$().addClass('hidden');
                        table.column(9).nodes().to$().addClass('hidden');
                        table.column(11).nodes().to$().addClass('hidden');
                        table.column(18).nodes().to$().addClass('hidden');
                        //table.column(12).nodes().to$().addClass('hidden');

                        table.column(3).nodes().to$().addClass('mypointer');
                        table.column(5).nodes().to$().addClass('mypointer');
                        table.column(6).nodes().to$().addClass('mypointer');
                        table.column(7).nodes().to$().addClass('mypointer');
                        table.draw();

                        $('#tableSaleWeeklyReport tbody').on('click', 'td', function (e) {
                            e.preventDefault();
                            var rowIndex = $(this).parent().children().eq(4).text(); //  $(this).closest('.mypointer').text();
                            var rowValue = $(this).parent().children().eq(5).text();
                            console.log(rowIndex + ':' + rowValue);

                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            console.log('row : ' + rIndex + 'cell : ' + cIndex);

                            if (rIndex != 0 & cIndex == 3 || cIndex == 5 || cIndex == 6 || cIndex == 7) {
                                window.open("../report/architectprofile.aspx?opt=rarc&id=" + rowIndex + "", "_blank");
                            }
                        });

                        $("#overlay").hide();
                    }
                });
            });

            //var btnExportExcel = $('#btnExportExcel');

            var btnExportExcel = $('#btnExportExcel')
            btnExportExcel.click(function () {

                $('#txtRepOpt').val('EXCEL');

                $("#myModalVerifyPassword").modal({ backdrop: false });
                $("#myModalVerifyPassword").modal("show");
            });


        })

        function loadExcel() {
            //alert('you click');
            var datepickerstart = $('#datepickerstart').val();
            var datepickerend = $('#datepickerend').val();
            var filefulname = 'weekreport' + '_from_' + datepickerstart + '_to_' + datepickerend;
            exportTableToExcel('tableSaleWeeklyReport', filefulname)
        }

        function exportTableToExcel(tableID, filename = '') {
            var downloadLink;
            var dataType = 'application/vnd.ms-excel';
            var tableSelect = document.getElementById(tableID);
            var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

            // Specify file name
            filename = filename ? filename + '.xls' : 'excel_data.xls';

            // Create download link element
            downloadLink = document.createElement("a");

            document.body.appendChild(downloadLink);

            if (navigator.msSaveOrOpenBlob) {
                var blob = new Blob(['\ufeff', tableHTML], {
                    type: dataType
                });
                navigator.msSaveOrOpenBlob(blob, filename);
            } else {
                // Create a link to the file
                downloadLink.href = 'data:' + dataType + ', ' + tableHTML;

                // Setting the file name
                downloadLink.download = filename;

                //triggering the function
                downloadLink.click();
            }
        }
    </script>



    <!-- Header content -->
    <section class="content-header">
        <h1>Sale Weekly Report
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div id="overlay">
            <div class="cv-spinner" style="margin-right: 20%">
                <span class="spinner"></span>
            </div>
        </div>

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
                                        <a href="#">Weekly Report</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <%--<button id="btnDownload" runat="server" onserverclick="btnDownload_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Screen" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>--%>
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
                                                <option value="5">Step Award MC > Award RF </option>
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
                                        <button type="button" id="btnQuery" runat="server" onserverclick="btnQuery_Click" class="btn btn-info btn-flat btn-block btn-sm hidden">Show Report</button>
                                        <button type="button" id="btnJsonReport" class="btn btn-info btn-flat btn-block btn-sm ">Show Report</button>

                                        <%--<button type="button" class="btn btn-default" onclick="alerterror()" data-dismiss="modal">click alert</button>--%>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">Reporting</label>
                                    <div>
                                        <span class="">
                                            <button id="btnExportExcel" type="button" class="btn btn-success btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                <i class="fa fa-file-excel-o"></i>Print Excel</button>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <%--<hr />--%>
                            <br />

                            <div class="col-md-12">
                                <div id="divWeeklyReport">
                                    <table id="tableSaleWeeklyReport" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th class="">WeekDate</th>
                                                <th class="">WeekTime</th>
                                                <th class="hidden">CompanyID</th>
                                                <th class="">CompanyName</th>
                                                <th class="hidden">ArchitecID</th>
                                                <th class="">Name</th>
                                                <th class="">ProjectID</th>
                                                <th class="">ProjectName</th>
                                                <th class="">Location</th>
                                                <th class="hidden">StatusID</th>
                                                <th class="">StatusNameEn</th>
                                                <th class="hidden">StepID</th>
                                                <th class="">StepNameEn</th>
                                                <th class="">Remark</th>
                                                <th class="">UserID</th>
                                                <th class="">EmpCode</th>
                                                <th class="">CreatedBy</th>
                                                <th class="">CreatedDate</th>
                                                <th class="hidden">TransID</th>
                                                <th class="">TransNameEn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%-- <%= strTblDetail %>--%>
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
                        <%--<asp:Button ID="btnSendMail" runat="server" Text="btnSendMail" OnClick="btnSendMail_Click" CssClass="" />--%>
                        <button class="btn btn-default hidden" id="btnSendmail" runat="server" onserverclick="btnSendMail_Click" >Send Mail</button>

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
