<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleonspec.aspx.cs" Inherits="SaleSpec.pages.trans.saleonspec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <%--<script src="../../bower_components/jquery/dist/jquery.min.js"></script>--%>
    <%--<script src="jquery-1.11.2.min.js"></script>--%>

    <%--<script src="https://smtpjs.com/v3/smtp.js"></script>--%>
    <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
    <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>--%>

  
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="jquery-1.11.2.min.js"></script>
    
    <style>
        .hide_column {
            display: none;
        }

        #tblprojectlists i:hover {
            cursor: pointer;
        }

         #tableSaleOnSpecFinal tr:hover {
                color: red;
                font-weight: bold;
            }

         #tableSaleOnSpec2 tr:hover {
                color: red;
                font-weight: bold;
            }

        #tbltranswithoutsalesconsignee i:hover {
            cursor: pointer;
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

        .myclass {
            text-align: right;
        }

        .myclassblue {
            text-align: right;
            color: blue;
        }

        .myblue {
            color: blue;
            cursor: pointer;
        }

            .myblue:hover {
                cursor: pointer;
                color: red;
                font-weight: bold;
            }
    </style>

    <script>
        $(document).ready(function () {
            $('#divSaleOnSpec').hide();
            $('#divSaleOnSpec2').hide();

            var btnReport = $('#btnReport');
            btnReport.click(function () {

                var sdate = $('#datepickertrans').val();
                var edate = $('#datepickerend').val();

                //alert(sdate.val());

                getSaleOnSpecWithProject(sdate, edate);
                getSaleOnSpecWithProject2(sdate, edate);

            });

            var btnConfirm = $('#btnConfirm');
            btnConfirm.click(function () {
                //alert('button confirm click');
                // declare variable table for assign attribute
                var table = $('#tblemployee').DataTable();
                var arr = [];
                var checkedvalues = table.$('input:checked').each(function () {
                    arr.push($(this).attr('id'))
                });
                // convert array to string                    

                arr = arr.toString();
                var empid = arr.split(",");

                $('#example-result').text(empid);
                //table.$('input:checked').removeAttr('checked');  
                var refdocno = $('#example-result').text();
                var projecid = $('#txtProjectId').val();


                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Go ahead..!'
                }).then((result) => {
                    if (result.value) {
                        $.ajax({
                            url: '../report/DataServicesSaleOnSpec.asmx/GetssProjectMappingUpdate',
                            method: 'POST',
                            data: {
                                projectid: projecid,
                                refdocno: refdocno + ','
                            },
                            dataType: 'json',
                            complete: function (data) {
                                Swal.fire(
                                    'Success!',
                                    'Your data has been updated.',
                                    'success')
                            }
                        });
                        //$('#txtRefDoc').val(xempid);

                        $("#modal-refinvoice").modal("hide");

                    }
                })
            });



            var btnuncheck = $('#btnuncheck');
            btnuncheck.click(function () {
                //alert('uncheck..');
                var table = $('#tblemployee').DataTable();
                var checkedvalues = table.$('input:checked').each(function () {
                    $(this).prop("checked", false);
                });

                $('#example-result').text('');

            });

            var btncheckedall = $('#btncheckedall')
            btncheckedall.click(function () {
                //alert('uncheck..');
                var table = $('#tblemployee').DataTable();

                $("input", table.rows({ search: 'applied' }).nodes()).each(function () {
                    $(this).prop("checked", true);
                });

                $('#example-result').text('');
            });

        });

        function getSaleOnSpecWithProject(sdate, edate) {

            // alert(sdate + ":" + edate);

            $.ajax({
                url: '../report/DataServicesSaleOnSpec.asmx/GetSaleOnSpecFinal',
                method: 'post',
                data: {
                    sdate: sdate,
                    edate: edate
                },
                datatype: 'json',
                beforeSend: function () {
                    $('#tableSaleOnSpecFinal tr td').remove();
                    $('#divSaleOnSpec').show();
                },
                success: function (data) {
                    var table;
                    table = $('#tableSaleOnSpecFinal').DataTable();
                    table.clear();

                    if (data != '') {
                        $.each(data, function (i, item) {
                            table.row.add([data[i].CompanyID, data[i].CompanyName, data[i].ArchitecID, data[i].Name, data[i].sosMonth, data[i].ProjectYear
                                , data[i].ProjectMonth, data[i].DocuNo, data[i].CustCode, data[i].CustName, data[i].ProjectId, data[i].ProjectName, data[i].GoodID
                                , data[i].GoodName, data[i].ActQty, data[i].SpecQty, data[i].Amount, data[i].PerUnit, data[i].NetRF_B, data[i].NetCom, data[i].TotalSale
                                , data[i].SaleCode, data[i].SaleName, data[i].DocuDate, data[i].chkTrash]);
                        });
                    }

                    //table.column(5).nodes().to$().addClass('myblue');
                    //table.column(6).nodes().to$().addClass('myblue');
                    //table.column(8).nodes().to$().addClass('myblue');
                    //table.column(11).nodes().to$().addClass('myblue');
                    //table.column(13).nodes().to$().addClass('myblue');
                    //table.column(14).nodes().to$().addClass('myblue');

                    table.draw();
                    $('#divSaleOnSpec').hide();

                    $('#tableSaleOnSpecFinal tbody').on('click', 'td', function (e) {
                        e.preventDefault();
                        //$('#tableSaleOnSpec td').click(function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;

                        //alert(rIndex);

                        if (rIndex != 0 & cIndex == 24 ) {
                            var companyid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(0)').text();
                            var companyname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(1)').text();
                            var architectid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(2)').text();
                            var architectname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(3)').text();
                            var projectdue = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(4)').text();
                            var refdocno = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(7)').text();
                            var projectid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(10)').text();
                            var projectname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(11)').text();
                            var actqty = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(16)').text();
                            var salqty = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(17)').text();

                            var salecode = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(23)').text();
                            var salename = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(24)').text();

                            console.log("Update : " + companyid + ":" + companyname + ":" + architectid + ":" + architectname + ":" + projectid + ":" + projectname + ":" + salecode + ":" + salename + ":" + projectdue);

                            $('#txtCompanyId').val(companyid);
                            $('#txtCompanyName').val(companyname);
                            $('#txtArchitectId').val(architectid);
                            $('#txtArchitectName').val(architectname);
                            $('#txtProjectId').val(projectid);
                            $('#txtProjectName').val(projectname);
                            $('#txtQuantity').val(actqty + " / " + salqty);
                            $('#txtProjectDue').val(projectdue);
                            $('#txtPortName').val(salecode + " : " + salename);

                            Swal.fire({
                                title: 'Delete '+ refdocno +', Are you sure..?',
                                text: "You won't be able to revert this!",
                                type: 'info',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Yes, Delete it..!'
                            }).then((result) => {
                                if (result.value) {
                                    $.ajax({
                                        url: '../report/DataServicesSaleOnSpec.asmx/GetssProjectMappingDelete',
                                        method: 'POST',
                                        data: {
                                            projectid: projectid,
                                            refdocno: refdocno
                                        },
                                        dataType: 'json',
                                        complete: function (data) {
                                            Swal.fire(
                                                'Success!',
                                                'Your data has been deleted..',
                                                'success')
                                        }
                                    });

                                    $('#btnReport').click();

                                }
                            })
                        }                         
                    });
                }
            })
        };


        function getSaleOnSpecWithProject2(sdate, edate) {

            // alert(sdate + ":" + edate);

            $.ajax({
                url: '../report/DataServicesSaleOnSpec.asmx/GetSaleOnSpecFinalWithOutProject',
                method: 'post',
                data: {
                    sdate: sdate,
                    edate: edate
                },
                datatype: 'json',
                beforeSend: function () {
                    $('#tableSaleOnSpec2 tr td').remove();
                    $('#divSaleOnSpec2').show();
                },
                success: function (data) {
                    var table;
                    table = $('#tableSaleOnSpec2').DataTable();
                    table.clear();

                    if (data != '') {
                        $.each(data, function (i, item) {
                            table.row.add([data[i].CompanyID, data[i].CompanyName, data[i].ArchitecID, data[i].Name, data[i].sosMonth, data[i].ProjectYear
                                , data[i].ProjectMonth, data[i].DocuNo, data[i].CustCode, data[i].CustName, data[i].ProjectId, data[i].ProjectName, data[i].GoodID
                                , data[i].GoodName, data[i].ActQty, data[i].SpecQty, data[i].Amount, data[i].PerUnit, data[i].NetRF_B, data[i].NetCom, data[i].TotalSale
                                , data[i].SaleCode, data[i].SaleName, data[i].DocuDate, data[i].chkTrash]);
                        });
                    }

                    table.draw();
                    //$('#tableSaleOnSpec2 td:nth-of-type(6)').addClass('myclassblue');  //ProjectYear
                    //$('#tableSaleOnSpec2 td:nth-of-type(7)').addClass('myclassblue');  //ProjectMonth
                    //$('#tableSaleOnSpec2 td:nth-of-type(9)').addClass('myclassblue');  //CustCode
                    //$('#tableSaleOnSpec2 td:nth-of-type(12)').addClass('myblue');  //ProjectId
                    //$('#tableSaleOnSpec2 td:nth-of-type(13)').addClass('myclassblue');  // GoodID


                    $('#tableSaleOnSpec2 tbody').on('click', 'td', function (e) {
                        e.preventDefault();
                        //$('#tableSaleOnSpec td').click(function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;

                        //alert(rIndex);

                        if (rIndex != 0 & cIndex == 24) {

                          
                            var firstname = '<%= Session["sEmpEngFirstName"] %>';
                            var lastname = '<%= Session["sEmpEngLastName"] %>';
                            var fullname = firstname +' '+ lastname;
                           
                            var empcode = '<%= Session["EmpCode"] %>';
                            var refdocno = $("#tableSaleOnSpec2").find('tr:eq(' + rIndex + ')').find('td:eq(7)').text();

                            console.log(firstname + ', ' + lastname + ', ' + refdocno)

                             Swal.fire({
                                title: 'Delete '+ refdocno +', Are you sure..?',
                                text: "You won't be able to revert this!",
                                type: 'info',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Yes, Delete it..!'
                            }).then((result) => {
                                if (result.value) {
                                    $.ajax({
                                        url: '../report/DataServicesSaleOnSpec.asmx/GetssProjectMappingExcept',
                                        method: 'POST',
                                        data: {
                                            docuno: refdocno,
                                            empid: empcode,
                                            empname: fullname
                                        },
                                        dataType: 'json',
                                        complete: function (data) {
                                            Swal.fire(
                                                'Success!',
                                                'Your data has been deleted..',
                                                'success')
                                        }
                                    });

                                    $('#btnReport').click();

                                }
                            })
                        }
                    })

                    $('#divSaleOnSpec2').hide();
                }
            })
        };

        function getDataInvoiceList(sdate, edate) {
            $.ajax({
                url: '../report/DataServicesInvoiceList.asmx/GetInvoiceListSOS',
                method: 'post',
                data: {
                    sdate: sdate,
                    edate: edate
                },
                beforeSend: function () {
                    $('#tblemployee tr td').remove();
                    $("#loademployee").show();
                },
                dataType: 'json',
                success: function (data) {
                    var table;
                    table = $('#tblemployee').DataTable();
                    table.clear();
                    if (data != '') {
                        $.each(data, function (i, item) {
                            table.row.add([data[i].InvNo, data[i].DocuDate, data[i].CustCode, data[i].CustName, data[i].EmpCode, data[i].SaleName, data[i].TotalPrice, data[i].chk]);
                        });
                    }
                    else {
                    }
                    //finally draw into a table
                    table.column(6).nodes().to$().addClass('myposition');
                    table.draw();
                    $("#loademployee").hide();
                }
            });
        };

    </script>



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
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel"><i class="fa fa-table"></i></button>

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

                            <div class="col-md-1">
                                <label class="txtLabel">Show Report</label>
                                <input type="button" id="btnReport" name="btnReport" class="btn btn-block btn-primary btn-flat txtLabel" value="Show Report" />
                            </div>
                        </div>

                        <hr />


                        <div class="">
                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#sosprojects" data-toggle="tab">SOS Projects</a></li>
                                    <li><a href="#sosunidentified" data-toggle="tab">SOS <span class="text-red">Unidentified</span></a></li>

                                </ul>
                                <div class="tab-content">
                                    <div class="active tab-pane" id="sosprojects">
                                        <div class="">
                                            <div class="box box-solid">
                                                <div class="box-header with-border">
                                                    <i class="fa fa-flag-checkered text-green"></i>
                                                    <span class="btn-group pull-right">
                                                        <button type="button" id="btnSaleOnSpecPdf" runat="server" onserverclick="btnExportPDF_click" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                                        <button type="button" id="btnSaleOnSpecExcel" runat="server" onserverclick="btnExportExcel_click" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                                                    </span>
                                                    <label class="txtLabel">Sale On Spec (SOS Projects)</label>
                                                </div>
                                                <div class="box-body">
                                                    <div class="cv-spinner" id="divSaleOnSpec">
                                                        <span class="spinner"></span>
                                                    </div>
                                                   
                                                    <table id="tableSaleOnSpecFinal" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <th>CompanyID</th>
                                                                <th>CompanyName</th>
                                                                <th>ArchitecID</th>
                                                                <th>Name</th>
                                                                <th>sosMonth</th>
                                                                <th>ProjectYear</th>
                                                                <th>ProjectMonth</th>
                                                                <th>DocuNo</th>
                                                                <th>CustCode</th>
                                                                <th>CustName</th>
                                                                <th>ProjectId</th>
                                                                <th>ProjectName</th>
                                                                <th>GoodID</th>                                                                
                                                                <th>GoodName</th>
                                                                <th>ActQty</th>
                                                                <th>SpecQty</th>
                                                                <th>Amount</th>
                                                                <th>PerUnit</th>
                                                                <th>NetRF</th>
                                                                <th>NetCom</th>
                                                                <th>TotalSale</th>
                                                                <th>SaleCode</th>
                                                                <th>SaleName</th>
                                                                <th>DocuDate</th>
                                                                <th>#</th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                       
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.tab-pane -->
                                    <div class="tab-pane" id="sosunidentified">
                                        <div class="">
                                            <div class="box box-solid">
                                                <div class="box-header with-border">
                                                    <i class="fa fa-flag-checkered text-orange"></i>
                                                    <span class="btn-group pull-right">
                                                        <button type="button" id="btnSaleOnSpec2Pdf" runat="server" onserverclick="btnExportPDF2_click" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                                        <button type="button" id="btnSaleOnSpec2Excel" runat="server" onserverclick="btnExportExcel2_click" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                                                    </span>
                                                    <label class="txtLabel">Sale On Spec (SOS <span class="text-red">Unidentified</span>)</label>
                                                </div>
                                                <div class="box-body">
                                                    <div class="cv-spinner" id="divSaleOnSpec2">
                                                        <span class="spinner"></span>
                                                    </div>
                                                   
                                                    <table id="tableSaleOnSpec2" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <th>CompanyID</th>
                                                                <th>CompanyName</th>
                                                                <th>ArchitecID</th>
                                                                <th>Name</th>
                                                                <th>sosMonth</th>
                                                                <th>ProjectYear</th>
                                                                <th>ProjectMonth</th>
                                                                <th>DocuNo</th>
                                                                <th>CustCode</th>
                                                                <th>CustName</th>
                                                                <th>ProjectId</th>
                                                                <th>ProjectName</th>
                                                                <th>GoodID</th>                                                               
                                                                <th>GoodName</th>
                                                                <th>ActQty</th>
                                                                <th>SpecQty</th>
                                                                <th>Amount</th>
                                                                <th>PerUnit</th>
                                                                <th>NetRF</th>
                                                                <th>NetCom</th>
                                                                <th>TotalSale</th>
                                                                <th>SaleCode</th>
                                                                <th>SaleName</th>
                                                                <th>DocuDate</th>
                                                                <th style="width: 20px; text-align: center;">#</th>
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

                        <div class="modal modal-default fade" id="modal-refinvoice">
                            <div class="modal-dialog" style="width: 60%">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Reference Invoice</h4>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Post -->

                                        <div class="row" style="background-color: lightblue; padding: 10px 5px 5px 5px; position: relative; top: -10px;">

                                            <div class="col-md-12" style="margin-bottom: 5px;">
                                                <div class="col-md-2">
                                                    <label class="txtLabel">Company :</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtCompanyId" name="txtCompanyId" value="" readonly autocomplete="off">
                                                </div>
                                                <div class="col-md-5">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtCompanyName" name="txtCompanyName" readonly value="" autocomplete="off">
                                                </div>
                                                <div class="col-md-1">
                                                    <label class="txtLabel">ActQty/Spec:</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtQuantity" name="txtQuantity" value="" readonly autocomplete="off">
                                                </div>
                                            </div>

                                            <div class="col-md-12" style="margin-bottom: 5px;">
                                                <div class="col-md-2">
                                                    <label class="txtLabel">Architect :</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtArchitectId" name="txtArchitectId" value="" readonly autocomplete="off">
                                                </div>
                                                <div class="col-md-5">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtArchitectName" name="txtArchitectName" value="" readonly autocomplete="off">
                                                </div>
                                                <div class="col-md-1">
                                                    <label class="txtLabel">Of Month:</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtProjectDue" name="txtProjectDue" value="" readonly autocomplete="off">
                                                </div>
                                            </div>

                                            <div class="col-md-12" style="margin-bottom: 5px;">
                                                <div class="col-md-2">
                                                    <label class="txtLabel">Project :</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtProjectId" name="txtProjectId" value="" readonly autocomplete="off">
                                                </div>
                                                <div class="col-md-5">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtProjectName" name="txtProjectName" value="" readonly autocomplete="off">
                                                </div>
                                                <div class="col-md-1">
                                                    <label class="txtLabel">Port</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtPortName" name="txtPortName" value="" readonly autocomplete="off">
                                                </div>
                                            </div>

                                        </div>

                                        <br />

                                        <div class="post">
                                            <table id="tblemployee" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th>InvNo</th>
                                                        <th>DocuDate</th>
                                                        <th>CustCode</th>
                                                        <th>CustName</th>
                                                        <th>EmpCode</th>
                                                        <th>SaleName</th>
                                                        <th>TotalPrice</th>
                                                        <th>#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>

                                            <div id="loademployee">
                                                <div class="cv-spinner">
                                                    <span class="spinner"></span>
                                                </div>
                                            </div>

                                            <p>
                                                <button type="button" id="btnuncheck" name="btnuncheck" class="btn btn-warning btn-sm btn-flat">Clear All</button>
                                                <button type="button" id="btncheckedall" name="btncheckedall" class="btn btn-primary btn-sm btn-flat">Selected All</button>
                                                <button type="button" id="btnConfirm" name="btnConfirm" class="btn btn-success btn-sm btn-flat pull-right">Confirmed</button>
                                            </p>
                                            <p id="example-result"></p>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>








                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>

    </section>

</asp:Content>
