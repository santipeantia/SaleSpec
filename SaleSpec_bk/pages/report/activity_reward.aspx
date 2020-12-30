<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="activity_reward.aspx.cs" Inherits="SaleSpec.pages.report.activity_reward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="jquery-1.11.2.min.js"></script>

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
    </style>

    <section class="content-header">
        <h1>Reward Report
            <small>Control panel</small>
        </h1>
    </section>

    <script>

        $(document).ready(function () {
            var btnQuery = $('#btnQuery')
            btnQuery.click(function () {

                //alert('get data here');
                $.ajax({
                    url: 'DataServicesReporting.asmx/GetActiviteReward',
                    method: 'post',
                    beforeSend: function () {
                        $("#overlay").show();
                    },
                    dataType: 'json',
                    success: function (data) {

                        var table;
                        table = $('#tableWeeklyReportx').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].architect_id, data[i].Name, data[i].NickName, data[i].Birthday, data[i].Mobile, data[i].CompanyID, data[i].CompanyName
                                    , data[i].id, data[i].event_id, data[i].event_desc, data[i].title_id, data[i].title_desc, data[i].trans_date, data[i].details
                                    , data[i].inv_id, data[i].inv_desc, data[i].attn_id, data[i].attn_desc, data[i].remark, data[i].userid, data[i].created_date, data[i].lasted_date
                                    , data[i].isdelete]);
                            });
                        }
                        table.column(5).nodes().to$().addClass('hidden');
                        table.column(7).nodes().to$().addClass('hidden');
                        table.column(8).nodes().to$().addClass('hidden');
                        table.column(10).nodes().to$().addClass('hidden');
                        table.column(14).nodes().to$().addClass('hidden');
                        table.column(16).nodes().to$().addClass('hidden');

                        table.column(19).nodes().to$().addClass('hidden');
                        table.column(20).nodes().to$().addClass('hidden');
                        table.column(21).nodes().to$().addClass('hidden');
                        table.column(22).nodes().to$().addClass('hidden');

                        table.column(1).nodes().to$().addClass('mypointer');
                        table.column(2).nodes().to$().addClass('mypointer');
                        table.column(3).nodes().to$().addClass('mypointer');
                        table.column(9).nodes().to$().addClass('mypointer');
                        table.column(11).nodes().to$().addClass('mypointer');
                        table.column(13).nodes().to$().addClass('mypointer');
                        table.draw();

                        $('#tableWeeklyReportx tbody').on('click', 'td', function (e) {
                            e.preventDefault();
                            var rowIndex = $(this).parent().children().eq(0).text(); //  $(this).closest('.mypointer').text();
                            var rowValue = $(this).parent().children().eq(6).text();
                            console.log(rowIndex + ':' + rowValue);

                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            console.log('row : ' + rIndex + 'cell : ' + cIndex);

                            if (rIndex != 0 & cIndex == 1 || cIndex == 2 || cIndex == 3 || cIndex == 9 || cIndex == 11 || cIndex == 13) {
                                window.open("../report/architectprofile.aspx?opt=rarc&id=" + rowIndex + "", "_blank");
                            }
                        });

                        $("#overlay").hide();
                    }
                });
            });
        });

    </script>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner" style="padding-right: 20%">
                <span class="spinner"></span>
            </div>
        </div>

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
                                        <a href="#">Reward Report</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Take care by sales via projects</span>
                                </div>

                            </div>

                            <hr />
                            <div class="container-fluid">
                                <div class="col-md-4 hidden">
                                    <label class="txtLabel">Sale Spec</label>
                                    <div class="txtLabel">
                                        <select id="selectSalePort" name="selectSalePort" class="form-control input-sm" style="width: 100%">
                                            <%= strPortOption %>
                                        </select>
                                    </div>
                                    <div id="divErrorSelectSaleSpec" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>



                                <div class="col-md-2">
                                    <label class="txtLabel">Query Info</label>
                                    <div class="">
                                        <button type="button" id="btnQuery" class="btn btn-info btn-flat btn-block btn-sm ">Show Report</button>
                                    </div>
                                </div>

                            </div>

                            <br />

                            <div class="col-md-12">
                                <div id="divWeeklyReport">
                                    <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>architect_id</th>
                                                <th>Name</th>
                                                <th>NickName</th>
                                                <th>Birthday</th>
                                                <th>Mobile</th>
                                                <th class="hidden">CompanyID</th>
                                                <th>CompanyName</th>
                                                <th class="hidden">id</th>
                                                <th class="hidden">event_id</th>
                                                <th>event_desc</th>
                                                <th class="hidden">title_id</th>
                                                <th>title_desc</th>
                                                <th>trans_date</th>
                                                <th>details</th>
                                                <th class="hidden">inv_id</th>
                                                <th>inv_desc</th>
                                                <th class="hidden">attn_id</th>
                                                <th>attn_desc</th>
                                                <th>remark</th>
                                                <th class="hidden">userid</th>
                                                <th class="hidden">created_date</th>
                                                <th class="hidden">lasted_date</th>
                                                <th class="hidden">isdelete</th>
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
            </div>
        </div>
    </section>

</asp:Content>
