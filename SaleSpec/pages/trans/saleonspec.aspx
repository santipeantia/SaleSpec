<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleonspec.aspx.cs" Inherits="SaleSpec.pages.trans.saleonspec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <script src="https://smtpjs.com/v3/smtp.js"></script>
    <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="../../bower_components/jquery/dist/jquery.min.js"></script>

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
                cursor: pointer;
            }

         #tableSaleOnSpec2 tr:hover {
                color: red;
                font-weight: bold;
                cursor: pointer;
            }

        #tbltranswithoutsalesconsignee i:hover {
            cursor: pointer;
        }

         #tblproject tr:hover {
                color: red;
                font-weight: bold;
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
            $('#loadproject').hide();


            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var xyyy = today.getFullYear() - 2;
            var yyyy = today.getFullYear();
            var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
            var lastdate = xyyy + '-01' + '-01'   //+ ' ' + tt;
            var currentdate = yyyy + '-' + mm + '-' + dd   //+ ' ' + tt;

            $('#datepickerexpsdate').val(lastdate);
            $('#datepickerexpedate').val(currentdate);

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

            var btnDocExport = $('#btnDocExport');
            btnDocExport.click(function () {
                //alert('Doc Export');
                $('#txtExid').val('');                
                $('#txtExProjecID').val('');
                $('#txtExProjectName').val('');
                $('#txtProduct').val('');
                $('#txtExCompanyID').val('');
                $('#txtExCompany').val('');
                $('#txtExArchitectID').val('');
                $('#txtExArchitect').val('');
                $('#txtActQty').val('');
                $('#txtSpecQty').val('');
                $('#txtExpAmount').val('');
                $('#txtExPerUnit').val('');
                $('#txtExpNetRF').val('');
                $('#txtExNetComm').val('');
                $('#txtExpRenComm').val('');
                $('#txtExTotalSale').val('');
                $('#txtSosMonth').val('');
                $('#txtExPortName').val('');
                $('#txtDocuNo').val('');
                $('#datepickerdocudate').val('');
                $('#txtExCustName').val('');

                $("#modal-exportdoc").modal({ backdrop: false });
                $("#modal-exportdoc").modal("show");
            });

            var btnRefProj = $('#btnRefProj');
            btnRefProj.click(function () {
                //alert('click ref. here');

                //$("#modal-ProjectCommission").modal({ backdrop: false });
                //$("#modal-ProjectCommission").modal("show");

                $('#modal-project').modal({ backdrop: true });
                $('#modal-project').modal('show');

            });

            var btnGetRef = $('#btnGetRef')
            btnGetRef.click(function () {
                var sdate = $('#datepickerexpsdate').val();
                var edate = $('#datepickerexpedate').val();

                //alert(sdate + ' : ' + edate);

                $('#loadproject').show();

                getDataProjectReferenceExport(sdate, edate)
            });

            var btnUpdateSOS = $('#btnUpdateSOS')
            btnUpdateSOS.click(function () {

                var sdate = $('#datepickertrans').val();
                var edate = $('#datepickerend').val();

                //var trn = $('#txtExtrn').val();
                var id = $('#txtExid').val();
                var projectid = $('#txtExProjecID').val();
                var projectname = $('#txtExProjectName').val();
                var product = $('#txtProduct').val();
                var companyid = $('#txtExCompanyID').val();
                var companyname = $('#txtExCompany').val();
                var architectid = $('#txtExArchitectID').val();
                var architectname = $('#txtExArchitect').val();
                var actqyt = $('#txtActQty').val();
                var specqty = $('#txtSpecQty').val();
                var amount = $('#txtExpAmount').val();
                var perunit = $('#txtExPerUnit').val();
                var netrf = $('#txtExpNetRF').val();
                //var netrf = $('#txtExpNetRF').val();
                var netcom = $('#txtExNetComm').val();
                var rencom = $('#txtExpRenComm').val();
                var totalsale = $('#txtExTotalSale').val();
                var sosmonth = $('#txtSosMonth').val();
                var portname = $('#txtExPortName').val();
                var docuno = $('#txtDocuNo').val();
                var docudate = $('#datepickerdocudate').val();
                var custname = $('#txtExCustName').val();

                if ((projectid == '') || (projectname == '')) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Wrong, please enter project name..!'
                    });
                    return;
                }

                if ((companyid == '') || (companyname == '')) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Wrong, please enter company name..!'
                    });
                    return;
                }

                if ((architectid == '') || (architectname == '')) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Wrong, please enter architect name..!'
                    });
                    return;
                }

                if ((docuno == '') || (docudate == '')) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Wrong, please enter reference docno..!'
                    });
                    return;
                }
                
                $.ajax({
                    url: '../report/DataServicesSaleOnSpec.asmx/GetUpdateProjectReferenceExport',
                    method: 'post',
                    data: {
                        trn: '',
                        id: id,
                        companyid: companyid,
                        companyname: companyname,
                        architecid: architectid,
                        name: architectname,
                        sosmonth: sosmonth, 
                        projectyear: 'Export',
                        projectmonth: 'Export',
                        docuno: docuno,
                        custcode: '',
                        custname: custname,
                        projectid: projectid, 
                        projectname: projectname,
                        goodid: '',
                        goodname: product,
                        actqty: actqyt.replace(',',''),
                        specqty: specqty.replace(',',''),
                        amount: amount.replace(',',''),
                        perunit: perunit.replace(',',''),
                        netrf_b: netrf.replace(',',''),
                        netcom: netcom.replace(',',''),
                        totalsale: totalsale.replace(',',''),
                        salecode: portname,
                        salename: portname, 
                        docudate: docudate,
                        chktrash: '',
                        rentcom: rencom.replace(',','')

                    },
                    datatype: 'json',
                    success: function (data) {
                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Your work has been saved',
                            showConfirmButton: false,
                            timer: 1500
                        })

                        getSaleOnSpecWithProject(sdate, edate);

                        $("#modal-exportdoc").modal("hide");

                    },
                    error: function (jqXHR, exception) {
                        var msg = '';
                        if (jqXHR.status === 0) {
                            msg = 'Not connect.\n Verify Network.';
                        } else if (jqXHR.status == 404) {
                            msg = 'Requested page not found. [404]';
                        } else if (jqXHR.status == 500) {
                            msg = 'Internal Server Error [500].';
                        } else if (exception === 'parsererror') {
                            msg = 'Requested JSON parse failed.';
                        } else if (exception === 'timeout') {
                            msg = 'Time out error.';
                        } else if (exception === 'abort') {
                            msg = 'Ajax request aborted.';
                        } else {
                            msg = 'Uncaught Error.\n' + jqXHR.responseText;
                        }
                        alert('Error, ' + msg);
                    }
                });


            });

            var btnDeleteSOS = $('#btnDeleteSOS');
            btnDeleteSOS.click(function () {

                var sdate = $('#datepickertrans').val();
                var edate = $('#datepickerend').val();

                var id = $('#txtExid').val();
                var docuno = $('#txtDocuNo').val();

                if (id != '') {
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
                                url: '../report/DataServicesSaleOnSpec.asmx/GetUpdateProjectReferenceExport',
                                method: 'post',
                                data: {
                                    trn: '1',
                                    id: id,
                                    companyid: null,
                                    companyname: null,
                                    architecid: null,
                                    name: null,
                                    sosmonth: null,
                                    projectyear: 'Export',
                                    projectmonth: 'Export',
                                    docuno: docuno,
                                    custcode: '',
                                    custname: null,
                                    projectid: null,
                                    projectname: null,
                                    goodid: '',
                                    goodname: null,
                                    actqty: null,
                                    specqty: null,
                                    amount: null,
                                    perunit: null,
                                    netrf_b: null,
                                    netcom: null,
                                    totalsale: null,
                                    salecode: null,
                                    salename: null,
                                    docudate: null,
                                    chktrash: null,
                                    rentcom: null
                                },
                                datatype: 'json',
                                success: function (data) {
                                    Swal.fire({
                                        position: 'top-end',
                                        icon: 'success',
                                        title: 'Your work has been deleted',
                                        showConfirmButton: false,
                                        timer: 1500
                                    })

                                    getSaleOnSpecWithProject(sdate, edate);
                                    $("#modal-exportdoc").modal("hide");
                                },
                                error: function (jqXHR, exception) {
                                    var msg = '';
                                    if (jqXHR.status === 0) {
                                        msg = 'Not connect.\n Verify Network.';
                                    } else if (jqXHR.status == 404) {
                                        msg = 'Requested page not found. [404]';
                                    } else if (jqXHR.status == 500) {
                                        msg = 'Internal Server Error [500].';
                                    } else if (exception === 'parsererror') {
                                        msg = 'Requested JSON parse failed.';
                                    } else if (exception === 'timeout') {
                                        msg = 'Time out error.';
                                    } else if (exception === 'abort') {
                                        msg = 'Ajax request aborted.';
                                    } else {
                                        msg = 'Uncaught Error.\n' + jqXHR.responseText;
                                    }
                                    alert('Error, ' + msg);
                                }
                            });
                        }
                    })
                }
            });

            $(".allownumericwithdecimal").on("keypress keyup blur", function (event) {

                $(this).val(function (index, value) {
                    return value.replace(/(?!\.)\D/g, "").replace(/(?<=\..*)\./g, "").replace(/(?<=\.\d\d).*/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                });

                if ($(this).val() === '') {
                    //alert('null');
                    $(this).val('0.00');
                }

                if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                    event.preventDefault();
                }

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
                                , data[i].SaleCode, data[i].SaleName, data[i].DocuDate, data[i].chkTrash, data[i].RentCom, data[i].id]);
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

                       
                        //& cIndex == 24
                        if (rIndex != 0  ) {
                            var companyid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(0)').text();
                            var companyname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(1)').text();
                            var architecid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(2)').text();
                            var name = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(3)').text();
                            var sosmonth = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(4)').text();
                            var projectyear = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(5)').text();
                            var projectmonth = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(6)').text();
                            var docuno = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(7)').text();
                            var custcode = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(8)').text();
                            var custname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(9)').text();
                            var projectid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(10)').text();
                            var projectname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(11)').text();
                            var goodid = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(12)').text();
                            var goodname = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(13)').text();
                            var actqty = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(14)').text();
                            var specqty = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(15)').text();
                            var amount = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(16)').text();
                            var perunit = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(17)').text();
                            var netrf_b = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(18)').text();
                            var netcom = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(19)').text();
                            var totalsale = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(20)').text();
                            var salecode = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(21)').text();
                            var salename = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(22)').text();
                            var docudate = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(23)').text();
                            var chktrash = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(24)').text();
                            var rentcom = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(25)').text();
                            var id = $("#tableSaleOnSpecFinal").find('tr:eq(' + rIndex + ')').find('td:eq(26)').text();


                            //console.log("Update : " + companyid + ":" + companyname + ":" + architectid + ":" + architectname + ":" + projectid + ":" + projectname + ":" + salecode + ":" + salename + ":" + projectdue);

                            //$('#txtCompanyId').val(companyid);
                            //$('#txtCompanyName').val(companyname);
                            //$('#txtArchitectId').val(architectid);
                            //$('#txtArchitectName').val(architectname);
                            //$('#txtProjectId').val(projectid);
                            //$('#txtProjectName').val(projectname);
                            //$('#txtQuantity').val(actqty + " / " + salqty);
                            //$('#txtProjectDue').val(projectdue);
                            //$('#txtPortName').val(salecode + " : " + salename);

                            if (projectyear != 'Export') {
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
                                            url: '../report/DataServicesSaleOnSpec.asmx/GetssProjectMappingDelete',
                                            method: 'POST',
                                            data: {
                                                projectid: projectid,
                                                refdocno: docuno
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
                            else {
                                //alert('export');

                                $('#txtExid').val(id);
                                $('#txtExProjecID').val(projectid);
                                $('#txtExProjectName').val(projectname);
                                $('#txtProduct').val(goodname);
                                $('#txtExCompanyID').val(companyid);
                                $('#txtExCompany').val(companyname);
                                $('#txtExArchitectID').val(architecid);
                                $('#txtExArchitect').val(name);
                                $('#txtActQty').val(actqty);
                                $('#txtSpecQty').val(specqty);
                                $('#txtExpAmount').val(amount);
                                $('#txtExPerUnit').val(perunit);
                                $('#txtExpNetRF').val(netrf_b);
                                $('#txtExNetComm').val(netcom);
                                $('#txtExpRenComm').val(rentcom);
                                $('#txtExTotalSale').val(totalsale);
                                $('#txtSosMonth').val(sosmonth);
                                $('#txtExPortName').val(salecode);
                                $('#txtDocuNo').val(docuno);
                                $('#datepickerdocudate').val(docudate);
                                $('#txtExCustName').val(custname);

                                $('#modal-exportdoc').modal({ backdrop: true });
                                $('#modal-exportdoc').modal('show');



                            }

                            
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

        function getDataProjectReferenceExport(sdate, edate) {
            $.ajax({
                url: '../report/DataServicesInvoiceList.asmx/GetDataProjectReferenceExport',
                method: 'post',
                data: {
                    sdate: sdate,
                    edate: edate
                },
                beforSend: function () {
                    $('#tblproject tr td').remove();
                    $('#loadproject').show();
                },
                datatype: 'json',
                success: function (data) {
                    var table;
                    table = $('#tblproject').DataTable();
                    table.clear();
                    if (data != '') {
                        $.each(data, function (i, item) {
                            table.row.add([data[i].ID, data[i].WeekDate, data[i].CompanyID, data[i].CompanyName, data[i].ArchitecID,
                                data[i].Name, data[i].ProjectID, data[i].ProjectName, data[i].ProdNameEN, data[i].DeliveryDate,
                                data[i].Quantity, data[i].ProjYear, data[i].UserID, data[i].SosType, data[i].chkTrash])
                        });

                        table.draw();
                        table.column(15).nodes().to$().addClass('myposition');

                        $('#loadproject').hide();


                        $('#tblproject tbody').on('click', 'td', function (e) {
                            e.preventDefault();
                            
                            //var id = $(this).parent().children().eq(0).text();
                            var weekdate = $(this).parent().children().eq(1).text();
                            var companyid = $(this).parent().children().eq(2).text();
                            var companyname = $(this).parent().children().eq(3).text();
                            var architecid = $(this).parent().children().eq(4).text();
                            var name = $(this).parent().children().eq(5).text();
                            var projectid = $(this).parent().children().eq(6).text();
                            var projectname = $(this).parent().children().eq(7).text();
                            var prodnameen = $(this).parent().children().eq(8).text();
                            var deliverydate = $(this).parent().children().eq(9).text();
                            var quantity = $(this).parent().children().eq(10).text();
                            var projyear = $(this).parent().children().eq(11).text();
                            var userid = $(this).parent().children().eq(12).text();
                            var sostype = $(this).parent().children().eq(13).text();
                            var chkTrash = $(this).parent().children().eq(14).text();

                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            if (rIndex != 0) {
                                //alert(CompanyName);
                                //var trn = $('#txtExtrn').val();
                                //$('#txtExid').val(id);
                                $('#txtExProjecID').val(projectid);
                                $('#txtExProjectName').val(projectname);
                                $('#txtProduct').val(prodnameen);
                                $('#txtExCompanyID').val(companyid);
                                $('#txtExCompany').val(companyname);
                                $('#txtExArchitectID').val(architecid);
                                $('#txtExArchitect').val(name);
                                $('#txtActQty').val('0.00');
                                $('#txtActQty').keypress();

                                $('#txtSpecQty').val(quantity);
                                $('#txtSpecQty').keypress();//   addClass('allownumericwithdecimal');

                                $('#txtExpAmount').val('0.00');
                                $('#txtExpAmount').keypress();

                                $('#txtExPerUnit').val('0.00');
                                $('#txtExPerUnit').keypress();

                                $('#txtExpNetRF').val('0.00');
                                $('#txtExpNetRF').keypress();                                

                                $('#txtExNetComm').val('0.00');
                                $('#txtExNetComm').keypress();

                                $('#txtExpRenComm').val('0.00');
                                $('#txtExpRenComm').keypress();

                                $('#txtExTotalSale').val('0.00');
                                $('#txtExTotalSale').keypress();

                                $('#txtSosMonth').val(projyear);
                                $('#txtDocuNo').val('');
                                $('#datepickerdocudate').val('');
                                $('#txtExPortName').val(userid);
                                //$('#txtExpRemark').val('');

                                $('#modal-project').modal('hide');
                            }

                        });



                    }                   
                },
                error: function (jqXHR, exception) {
                    var msg = '';
                        if (jqXHR.status === 0) {
                            msg = 'Not connect.\n Verify Network.';
                        } else if (jqXHR.status == 404) {
                            msg = 'Requested page not found. [404]';
                        } else if (jqXHR.status == 500) {
                            msg = 'Internal Server Error [500].';
                        } else if (exception === 'parsererror') {
                            msg = 'Requested JSON parse failed.';
                        } else if (exception === 'timeout') {
                            msg = 'Time out error.';
                        } else if (exception === 'abort') {
                            msg = 'Ajax request aborted.';
                        } else {
                            msg = 'Uncaught Error.\n' + jqXHR.responseText;
                        }
                        alert('Error, ' + msg);
                }
            });

        }

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
                                                        <button type="button" id="btnDocExport" class="btn btn-default btn-sm" data-toggle="tooltip" title="Export"><i class="fa fa-plus text-green"></i></button>
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
                                                                <th>RentCom</th>
                                                                <th>id</th>

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

                        <div class="modal modal-default fade" id="modal-exportdoc">
                            <div class="modal-dialog" style="width: 40%" >
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Export Order</h4>
                                    </div>

                                    <div class="modal-body">
                                        <!-- Post -->

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">Project :</label>
                                                </div>
                                                <div class="col-md-8">
                                                    
                                                    <input type="text" class="form-control input-sm pull-left txtLabel " id="txtExid" name="txtExid" readonly value="" autocomplete="off">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel hidden" id="txtExProjecID" name="txtExProjecID" readonly value="" autocomplete="off">
                                                    <div class="input-group input-group-sm">
                                                        <span>
                                                            <input type="text" class="form-control input-sm input-flat pull-left txtLabel" id="txtExProjectName" name="txtExProjectName" value="" autocomplete="off">
                                                        </span>

                                                        <span class="input-group-btn">
                                                            <button type="button" id="btnRefProj" class="btn btn-info ">Go!</button>
                                                        </span>
                                                    </div>
                                                    

                                                    <%-- <div class="input-group input-group-sm">
                                                    <input type="text" class="form-control">
                                                    <span class="input-group-addon"><i class="fa fa-check"></i></span>
                                                </div>--%>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                 <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">Product :</label>
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtProduct" name="txtProduct" value="" autocomplete="off">
                                                </div>
                                                
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">Company :</label>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="input-group col-md-12">
                                                        <span class="txtLabel">
                                                            <%--<select id="selectCompany" class="form-control input input-sm " style="width: 100%;">
                                                        </select>--%>
                                                            <input type="text" class="form-control input-sm pull-left txtLabel hidden" id="txtExCompanyID" name="txtExCompanyID" readonly value="" autocomplete="off">
                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="txtExCompany" name="txtExCompany" value="" autocomplete="off">
                                                        </span>
                                                    </div>
                                                </div>
                                                 
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">Architect :</label>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="input-group col-md-12">
                                                        <span class="txtLabel">
                                                            <%--<select id="selectArchitect" class="form-control input input-sm " style="width: 100%;">
                                                        </select>--%>
                                                            <input type="text" class="form-control input-sm pull-left txtLabel hidden" id="txtExArchitectID" name="txtExArchitectID" readonly value="" autocomplete="off">
                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="txtExArchitect" name="txtExArchitect" value="" autocomplete="off">
                                                        </span>
                                                    </div>
                                                </div>
                                                 
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">ActQty :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel allownumericwithdecimal" id="txtActQty" name="txtActQty" value="" autocomplete="off">
                                                </div>
                                                <div class="col-md-2">
                                                    <label class="txtLabel">SpecQty :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel allownumericwithdecimal" id="txtSpecQty" name="txtSpecQty" value="" autocomplete="off">
                                                </div>

                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">Amount :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel allownumericwithdecimal" id="txtExpAmount" name="txtExpAmount" value="" autocomplete="off">
                                                </div>
                                                <div class="col-md-2">
                                                    <label class="txtLabel">PerUnit :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel allownumericwithdecimal" id="txtExPerUnit" name="txtExPerUnit" value="" autocomplete="off">
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">NetRF :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtExpNetRF" name="txtExpNetRF" value="" autocomplete="off">
                                                </div>
                                                <div class="col-md-2">
                                                    <label class="txtLabel">NetComm :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtExNetComm" name="txtExNetComm" value="" autocomplete="off">
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">RenComm :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel allownumericwithdecimal" id="txtExpRenComm" name="txtExpRenComm" value="" autocomplete="off">
                                                </div>
                                                <div class="col-md-2">
                                                    <label class="txtLabel">TotalSale :</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel allownumericwithdecimal" id="txtExTotalSale" name="txtExTotalSale" value="" autocomplete="off">
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">SOS Type :</label>
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtSosMonth" name="txtSosMonth" value="" readonly autocomplete="off">
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtExPortName" name="txtExPortName" value="" autocomplete="off">
                                                </div>

                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">DocuNo :</label>
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtDocuNo" name="txtDocuNo" value="" autocomplete="off">
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="input-group date">
                                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdocudate" name="datepickerdocudate" value="" autocomplete="off">
                                                        <div class="input-group-addon input-sm">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>                                           

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-1">
                                                    </div>
                                                <div class="col-md-3">
                                                    <label class="txtLabel">Customer :</label>
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="txtExCustName" name="txtExCustName" value="" autocomplete="off">
                                                </div>
                                            </div>

                                        </div>

                                    <div class="modal-footer clearfix">
                                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-danger" id="btnDeleteSOS" name="btnDeleteSOS">Confirm Delete..!</button>
                                            <button type="button" class="btn btn-primary" id="btnUpdateSOS" name="btnUpdateSOS">Save Change</button>
                                        </div>
                                    
                                </div>
                            </div>
                        </div>






                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="modal-project">
            <div class="modal-dialog" style="width: 60%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Projects year</h4>
                    </div>

                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post clearfix">
                            <div class="row " style="margin-bottom: 5px">
                                <div class="col-md-2">
                                    <label class="txtLabel">From Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerexpsdate" name="datepickerexpsdate" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">From Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerexpedate" name="datepickerexpedate" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">Get Ref</label>
                                    <button type="button" id="btnGetRef" class="btn btn-info btn-sm">Get Project Reference</button>
                                    <%--<div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickertrans2" name="datepickertrans2" value="" autocomplete="off">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>--%>
                                </div>


                            </div>

                            <hr />

                            <div class="row" style="margin-bottom: 5px; border: thin green">
                                <div class="cv-spinner" id="loadproject">
                                        <span class="spinner"></span>
                                    </div>

                                <div class="col-md-12">
                                    
                                    <table id="tblproject" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>WeekDate</th>	
                                                <th>CompanyID</th>	
                                                <th>CompanyName</th>
                                                <th>ArchitecID</th>
                                                <th>Name</th>
                                                <th>ProjectID</th>
                                                <th>ProjectName</th>
                                                <th>ProdNameEN</th>
                                                <th>DeliveryDate</th>	
                                                <th>Quantity</th>
                                                <th>ProjYear</th>	
                                                <th>UserID</th>
                                                <th>SosType</th>
                                                <th>#</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                        <!-- /.post -->
                    </div>

                    <%--<div class="modal-footer clearfix">
                        <div class="row">
                            <div class="col-md-4">
                                <button type="button" class="btn btn-danger pull-left" id="btnDeleteProject">Delete Project</button>
                            </div>
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-4">
                                <button type="button" class="btn btn-primary" id="btnUpdateProject">Update Project</button>
                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>

    </section>
</asp:Content>
