<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleonspecfilter.aspx.cs" Inherits="SaleSpec.pages.trans.saleonspecfilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="jquery-1.11.2.min.js"></script>
        
        <style>
            .hide_column {
            display: none;
        }

            #tableSosProjectFilter tr:hover {
                color: red;
                font-weight: bold;
            }

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

            .myposition {
                text-align: right;
            }
        </style>

        <script>
            $(document).ready(function () {
                getSosProjectFilter();

                $('#tableSosProjectFilter tbody').on('click', 'td', function (e) {
                    e.preventDefault();
                    //$('#tableSaleOnSpec td').click(function () {
                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;

                    console.log('Row : '+ rIndex + ', Cell : ' + cIndex)

                    if (rIndex != 0 & cIndex == 14) {
                        var docuno = $("#tableSosProjectFilter").find('tr:eq(' + rIndex + ')').find('td:eq(1)').text();
                        //console.log(docno);

                        Swal.fire({
                            title: 'Delete ' + docuno + ', Are you sure..?',
                            text: "You won't be able to revert this!",
                            type: 'info',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, Delete it..!'
                        }).then((result) => {
                            if (result.value) {
                                $.ajax({
                                    url: '../report/DataServicesSaleOnSpec.asmx/GetssProjectFilterDelete',
                                    method: 'POST',
                                    data: {
                                        docuno: docuno
                                    },
                                    dataType: 'json',
                                    complete: function (data) {
                                        Swal.fire(
                                            'Success!',
                                            'Your data has been deleted..',
                                            'success')
                                    }
                                });

                                getSosProjectFilter();

                            }
                        });
                    }
                });

            });

            function getSosProjectFilter() {
                $.ajax({
                    url: '../report/DataServicesSaleOnSpec.asmx/GetssProjectMappingFilter',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $('#tableSosProjectFilter tr td').remove();
                        $('#tableSosProjectFilter').show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tableSosProjectFilter').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].DocuNo, data[i].DocuDate, data[i].SendDate, data[i].GoodCode, data[i].GoodName,
                                data[i].StockQty, data[i].GoodPrice2, data[i].GoodAmnt, data[i].CustCode, data[i].CustName, data[i].ContactName,
                                data[i].EmpCode, data[i].EmpName, data[i].chkTrash]);
                            });
                        }

                        table.draw();
                    }
                })
            };


        </script>
        <h1>SOS Final Filter
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner" style="padding-right: 20%">
                <span class="spinner"></span>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">SOS Final Filter</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" runat="server" onserverclick="btnDownload_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Monitoring progression of projects</span>
                                </div>

                            </div>
                            <hr />
                        </div>

                        <div class="col-md-12">
                            <div id="divWeeklyReport">
                                <table id="tableSosProjectFilter" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th class="">ID</th>
                                            <th>DocuNo</th>
                                            <th>DocuDate</th>
                                            <th>SendDate</th>
                                            <th>GoodCode</th>
                                            <th>GoodName</th>
                                            <th>StockQty</th>
                                            <th>GoodPrice2</th>
                                            <th>GoodAmnt</th>
                                            <th>CustCode</th>
                                            <th>CustName</th>
                                            <th>ContactName</th>
                                            <th>EmpCode</th>
                                            <th>EmpName</th>
                                            <th>#</th>
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

    </section>

</asp:Content>
