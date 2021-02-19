<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projectreport.aspx.cs" Inherits="SaleSpec.pages.report.projectreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
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

            .myposition {
                text-align: right;
            }
        </style>
        <script>
            function validateExcel() {
                var selectSaleport = $('#selectSalePort').val();
                var empcode = '<%= Session["EmpCode"] %>';

                if (selectSaleport == 'SELECTED ALL') {
                    if (empcode == '118052' || empcode == '316010' || empcode == '506009' || empcode == '113048' || empcode == '519023') {
                        //sendMail();
                        $("#myModalVerifyPassword").modal({ backdrop: false });
                        $("#myModalVerifyPassword").modal("show");
                        return;
                        document.getElementById("<%=  btnDownloadExcel.ClientID %>").click();
                    }
                    else {
                        successalert();
                        return;
                    }
                }
                else {
                    if (empcode == '118052' || empcode == '316010' || empcode == '506009' || empcode == '113048' || empcode == '519023') {
                        //sendMail();
                        $("#myModalVerifyPassword").modal({ backdrop: false });
                        $("#myModalVerifyPassword").modal("show");
                        return;
                        document.getElementById("<%=  btnDownloadExcel.ClientID %>").click();
                    }
                    else {
                        erroralert();
                        return;
                    }
                }
            }

            function successalert() {
                Swal.fire({
                    type: 'error',
                    title: 'You do not have permission print all..!',
                    text: 'Permission access denied.',
                    footer: 'Please contact system administrator..'
                })
            }

            function erroralert() {
                Swal.fire({
                    type: 'error',
                    title: 'Permission is protected..!',
                    text: 'Permission access denied.',
                    footer: 'Please contact system administrator..'
                })
            }

            function exportexcel() {
                $("#tableHistory").table2excel({
                    name: "Table2Excel",
                    filename: "myFileName",
                    fileext: ".xls"
                });
            }

            function getShowdetails() {
                var tbl = document.getElementById("tableWeeklyReportx");
                if (tbl != null) {
                    for (var i = 0; i < tbl.rows.length; i++) {
                        for (var j = 0; j < tbl.rows[i].cells.length; j++)
                            tbl.rows[i].cells[j].onclick = function () { getval(this); };
                    }
                }
                function getval(cel) {
                    alert(cel.innerHTML);
                }


                //alert('click..');
                // var table = $('#tableWeeklyReportx');

                // $('#tableWeeklyReportx').click(function () {
                //    rIndex = this.parentElement.rowIndex;
                //    cIndex = this.cellIndex;

                //    if (rIndex != 0 & cIndex == 7 || cIndex == 8 || cIndex == 9) {
                //        console.log(rIndex + '' + cIndex);

                //        document.getElementById("divErrorArchitect").style.display = 'none';
                //        document.getElementById("divErrorLocation").style.display = 'none';
                //        document.getElementById("divErrorProductType").style.display = 'none';
                //        document.getElementById("divErrorProductName").style.display = 'none';
                //        document.getElementById("divErrorProfile").style.display = 'none';
                //        document.getElementById("divErrorDelivery").style.display = 'none';
                //        document.getElementById("divErrorFollowing").style.display = 'none';
                //        document.getElementById("divErrorQuantity").style.display = 'none';
                //        document.getElementById("divErrorRemark").style.display = 'none';
                //        document.getElementById("divErrorStatus").style.display = 'none';

                //        var strVal0 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(0)');  //ID
                //        var strVal1 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(1)');  //UserID
                //        var strVal2 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(2)');  //WeekDate
                //        var strVal3 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(3)');  //WeekTime
                //        var strVal4 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(4)');  //CompanyName
                //        var strVal5 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(5)');  //ArchitectID
                //        var strVal6 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(6)');  //Name
                //        var strVal7 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(7)');  //ProjectID
                //        var strVal8 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(8)');  //ProjectName
                //        var strVal9 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(9)');  //Location
                //        var strVal10 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(10)'); //ProdTypeID
                //        var strVal11 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(11)'); //ProdTypeNameEN
                //        var strVal12 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(12)'); //ProdID
                //        var strVal13 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(13)');  //ProdNameEN
                //        var strVal14 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(14)');    //ProfNameEN
                //        var strVal15 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(15)');    //DeliveryDate
                //        var strVal16 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(16)');    //NextVisitDate
                //        var strVal17 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(17)');    //Quantity
                //        var strVal18 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(18)');    //StepNameA
                //        var strVal19 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(19)');    //StepNameB
                //        var strVal20 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(20)');    //RefWeekDate
                //        var strVal21 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(21)');    //Ref1
                //        var strVal22 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(22)');    //Ref2
                //        var strVal23 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(23)');    //Ref3
                //        var strVal24 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(24)');    //RefRemark
                //        var strVal25 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(25)');    //StepID

                //        document.getElementById("ProjectID").value = strVal7.text();

                //        $('#txtid').val(strVal0.text());
                //        $('#txtVisitDate').val(strVal2.text());
                //        $('#txtTime').val(strVal3.text());
                //        $('#txtCompanyName').val(strVal4.text());

                //        var selectArchitectNameDDL = $('#selectArchitectName');

                //        //Get update architect name by company
                //        $.ajax({
                //            url: 'DataServicesReporting.asmx/DataReportGetArchitect',
                //            method: 'post',
                //            data: {
                //                id: strVal0.text()
                //            },
                //            datatype: 'json',
                //            success: function (data) {
                //                selectArchitectNameDDL.empty();
                //                $(data).each(function (index, item) {
                //                    selectArchitectNameDDL.append($('<option/>', { value: item.ArchitecID, text: item.ArchitectName }));

                //                    $('#selectArchitectName').val(strVal5.text());
                //                    $('#selectArchitectName').change();
                //                    //selectArchitectNameDDL.text = strVal4.text();
                //                    //selectArchitectNameDDL.change();
                //                });
                //            }
                //        });
                //        $('#txtProjectName').val(strVal8.text());
                //        $('#txtLocation').val(strVal9.text());

                //        //Get Product type such as Ampelite, Ampelram
                //        var selectProductTypeDDL = $('#selectProductType');
                //        $.ajax({
                //            url: '../trans/DataServices.asmx/GetProductType',
                //            method: 'post',
                //            dataType: 'json',
                //            success: function (data) {
                //                selectProductTypeDDL.empty();
                //                $(data).each(function (index, item) {
                //                    selectProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                //                    $('#selectProductType').val(strVal10.text());
                //                    $('#selectProductType').change();
                //                });
                //            }
                //        });

                //        //When product type changed cascading of product
                //        var selectProductNameDDL = $('#selectProductName');
                //        selectProductTypeDDL.change(function () {
                //            $.ajax({
                //                url: '../trans/DataServices.asmx/GetProducts',
                //                method: 'post',
                //                data: { ProdTypeID: $(this).val() },
                //                dataType: 'json',
                //                success: function (data) {
                //                    selectProductNameDDL.empty();
                //                    selectProductNameDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                //                    $(data).each(function (index, item) {
                //                        selectProductNameDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                //                        selectProductNameDDL.val(strVal12.text());
                //                        selectProductNameDDL.change();
                //                    });
                //                }
                //            });
                //        });

                //        //Get Product type such as Ampelite, Ampelram
                //        var selectStepDDL = $('#selectStep');
                //        $.ajax({
                //            url: '../trans/DataServices.asmx/GetStepSpec',
                //            method: 'post',
                //            dataType: 'json',
                //            success: function (data) {
                //                selectStepDDL.empty();
                //                $(data).each(function (index, item) {
                //                    selectStepDDL.append($('<option/>', { value: item.StepID, text: item.StepNameTh }));
                //                    $('#selectStep').val(strVal25.text());
                //                    $('#selectStep').change();
                //                });
                //            }
                //        });

                //        //Get Product type such as Ampelite, Ampelram
                //        var selectStatusDDL = $('#selectStatus');
                //        $.ajax({
                //            url: '../trans/DataServices.asmx/GetStatus',
                //            method: 'post',
                //            dataType: 'json',
                //            success: function (data) {
                //                selectStatusDDL.empty();
                //                $(data).each(function (index, item) {
                //                    selectStatusDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                //                    //$('#selectStatus').val('S03');
                //                    //$('#selectStatus').change();
                //                })

                //                $.ajax({
                //                    url: '../trans/DataServices.asmx/GetStatusWithProject',
                //                    method: 'post',
                //                    data: {
                //                        ProjectID: strVal6.text()
                //                    },
                //                    dataType: 'json',
                //                    success: function (data) {
                //                        var obj = jQuery.parseJSON(JSON.stringify(data));

                //                        if (obj != '') {
                //                            $.each(obj, function (key, inval) {
                //                                $('#selectStatus').val(inval["StatusID"]);
                //                                $('#selectStatus').change();
                //                            });

                //                            alert(obj);
                //                        }
                //                    }
                //                })
                //            }
                //        });

                //        //alert($('#selectStatus').val());

                //        $('#txtProfile').val(strVal14.text());
                //        $('#datedelivery').val(strVal15.text());
                //        $('#datefollowing').val(strVal16.text());
                //        $('#txtQuantity').val(strVal18.text());

                //        if (strVal25.text() == '1') {
                //            $('#txtRefMcRf').val(strVal21.text());
                //            $('#txtContactMcRf').val(strVal22.text());
                //        }
                //        else if (strVal25.text() == '2') {
                //            $('#txtRefMcRf').val(strVal22.text());
                //            $('#txtContactMcRf').val(strVal23.text());
                //        }
                //        else {
                //            $('#txtRefMcRf').val(strVal22.text());
                //            //$('#txtContactMcRf').val(strVal22.text());
                //        }

                //        $('#txtRemark').val(strVal24.text());

                //        $.ajax({
                //            url: 'DataServicesReporting.asmx/GetDataProjectHistory',
                //            method: 'post',
                //            data: { ProjectID: strVal7.text() },
                //            dataType: 'json',
                //            success: function (data) {
                //                var trHTML2 = '';
                //                $('#tableHistory tr:not(:first)').remove();

                //                $(data).each(function (index, item) {
                //                    trHTML2 += '<tr>' +
                //                        '<td class="">' + item.WeekDate + '</td>' +
                //                        '<td class="">' + item.WeekTime + '</td>' +
                //                        '<td class="">' + item.NextVisitDate + '</td>' +
                //                        '<td class="">' + item.TransNameEN + '</td>' +
                //                        '<td class="">' + item.StepNameEn + '</td>' +
                //                        '<td class="hidden">' + item.ProdTypeNameEN + '</td>' +
                //                        '<td class="">' + item.ProdNameEN + '</td>' +
                //                        '<td class="">' + item.BiddingName1 + '</td>' +
                //                        '<td class="">' + item.AwardMC + '</td>' +
                //                        '<td class="">' + item.AwardRF + '</td>' +
                //                        '<td class="">' + item.Quantity + '</td>' +
                //                        '<td class="">' + item.Remark + '</td>' +
                //                        '</tr > ';
                //                });
                //                $('#tableHistory').append(trHTML2);
                //            }
                //        });

                //        setTimeout(function () {
                //            $("#myModalEdit").modal({ backdrop: false });
                //            $("#myModalEdit").modal("show");
                //        }, 1500);


                //    }
                //});

            }

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
                       document.getElementById("btnJsonReport").click();
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

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                var firstdate = (yyyy - 2) + '-' + mm + '-01';
                var currentdate = yyyy + '-' + mm + '-' + dd;

                var datepickertrans = $('#datepickertrans');
                var datepickerend = $('#datepickerend');
                datepickertrans.val(firstdate);
                datepickerend.val(currentdate);

                var selectReportOptionDDL = $('#selectReportOption');
                selectReportOptionDDL.change(function () {
                    var strOption = $("#selectReportOption option:selected").text();
                    $('#optionName').val(strOption);

                    //alert(strOption);

                });


                var selectStatus = $('#selectStatus');
                var txtRefDoc = $('#txtRefDoc');
                selectStatus.change(function () {
                    //alert(selectStatus.val());
                    if ((selectStatus.val() == 'S02') || (selectStatus.val() == 'S06') || selectStatus.val() == null) {

                        //alert('Please enter reference invoice ');
                        //txtRefDoc.focus().select();
                        //txtRefDoc.css('background-color', '#00aaff');
                        $('#btnRefInv').removeAttr('disabled');
                        //txtRefDoc.css('visibility', '');
                        //txtRefDoc.val('');

                    } else {
                        //txtRefDoc.css('background-color', '');                        
                        $('#btnRefInv').attr('disabled', 'disabled');
                        //txtRefDoc.css('visibility', 'hidden');
                        //txtRefDoc.val('');
                    }
                })

                var btnJsonReport = $('#btnJsonReport');
                btnJsonReport.click(function () {
                    var selectOption = $('#selectReportOption').val();
                    var datepickertrans = $('#datepickertrans').val();
                    var datepickerend = $('#datepickerend').val();
                    var selectSaleport = $('#selectSalePort').val();
                    var strqtystrat = $('#QtyStart').val();
                    var strqtyend = $('#QtyEnd').val();
                    var strsearch = $('#Search').val();

                    var empcode = '<%= Session["EmpCode"] %>';

                    //alert(selectOption);

                    selectReportOptionDDL.change();

                    if (selectSaleport == 'SELECTED ALL') {
                        if (empcode == '118052' || empcode == '316010' || empcode == '506009') {
                            $.ajax({
                                url: 'DataServicesReporting.asmx/GetDataProjectByPortByOption',
                                method: 'post',
                                beforeSend: function () {
                                    $("#overlay").show();
                                },
                                data: {
                                    strOption: selectOption,
                                    strDateStart: datepickertrans,
                                    strDateEnd: datepickerend,
                                    strUserID: selectSaleport,
                                    strQtyStart: strqtystrat,
                                    strQtyEnd: strqtyend,
                                    strSearch: strsearch
                                },
                                dataType: 'json',
                                success: function (data) {
                                    var table;
                                    table = $('#tableWeeklyReportx').DataTable();
                                    table.clear();

                                    if (data != '') {
                                        $.each(data, function (i, item) {
                                            table.row.add([data[i].ID, data[i].UserID, data[i].WeekDate, data[i].WeekTime, data[i].CompanyName, data[i].ArchitectID, data[i].Name
                                                , data[i].ProjectID, data[i].ProjectName, data[i].Location, data[i].ProdTypeID, data[i].ProdTypeNameEN, data[i].ProdID
                                                , data[i].ProdNameEN, data[i].ProfNameEN, data[i].DeliveryDate, data[i].NextVisitDate, data[i].Quantity, data[i].StepNameA
                                                , data[i].StepNameB, data[i].RefWeekDate, data[i].Ref1, data[i].Ref2, data[i].Ref3, data[i].RefRemark, data[i].StepID]);
                                        });
                                    }
                                    table.column(0).nodes().to$().addClass('hidden');
                                    table.column(2).nodes().to$().addClass('hidden');
                                    table.column(3).nodes().to$().addClass('hidden');
                                    table.column(5).nodes().to$().addClass('hidden');
                                    table.column(7).nodes().to$().addClass('hidden');
                                    table.column(10).nodes().to$().addClass('hidden');
                                    table.column(12).nodes().to$().addClass('hidden');
                                    table.column(25).nodes().to$().addClass('hidden');
                                    table.column(8).nodes().to$().addClass('mypointer');
                                    table.column(24).nodes().to$().addClass('mypointer');
                                    table.draw();

                                    $('#tableWeeklyReportx tbody').on('click', 'td', function (e) {
                                        e.preventDefault();
                                        var rowIndex = $(this).parent().children().eq(0).text(); //  $(this).closest('.mypointer').text();
                                        var rowValue = $(this).parent().children().eq(7).text();
                                        console.log(rowIndex + ':' + rowValue);

                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;

                                        console.log('row : ' + rIndex + 'cell : ' + cIndex);

                                        if (rIndex != 0 & cIndex == 8 || cIndex == 24) {
                                            //alert(rIndex + '' + cIndex);

                                            document.getElementById("divErrorArchitect").style.display = 'none';
                                            document.getElementById("divErrorLocation").style.display = 'none';
                                            document.getElementById("divErrorProductType").style.display = 'none';
                                            document.getElementById("divErrorProductName").style.display = 'none';
                                            document.getElementById("divErrorProfile").style.display = 'none';
                                            document.getElementById("divErrorDelivery").style.display = 'none';
                                            document.getElementById("divErrorFollowing").style.display = 'none';
                                            document.getElementById("divErrorQuantity").style.display = 'none';
                                            document.getElementById("divErrorRemark").style.display = 'none';
                                            document.getElementById("divErrorStatus").style.display = 'none';

                                            var strVal0 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(0)');  //ID
                                            var strVal1 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(1)');  //UserID
                                            var strVal2 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(2)');  //WeekDate
                                            var strVal3 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(3)');  //WeekTime
                                            var strVal4 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(4)');  //CompanyName
                                            var strVal5 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(5)');  //ArchitectID
                                            var strVal6 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(6)');  //Name
                                            var strVal7 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(7)');  //ProjectID
                                            var strVal8 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(8)');  //ProjectName
                                            var strVal9 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(9)');  //Location
                                            var strVal10 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(10)'); //ProdTypeID
                                            var strVal11 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(11)'); //ProdTypeNameEN
                                            var strVal12 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(12)'); //ProdID
                                            var strVal13 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(13)');  //ProdNameEN
                                            var strVal14 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(14)');    //ProfNameEN
                                            var strVal15 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(15)');    //DeliveryDate
                                            var strVal16 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(16)');    //NextVisitDate
                                            var strVal17 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(17)');    //Quantity
                                            var strVal18 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(18)');    //StepNameA
                                            var strVal19 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(19)');    //StepNameB
                                            var strVal20 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(20)');    //RefWeekDate
                                            var strVal21 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(21)');    //Ref1
                                            var strVal22 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(22)');    //Ref2
                                            var strVal23 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(23)');    //Ref3
                                            var strVal24 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(24)');    //RefRemark
                                            var strVal25 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(25)');    //StepID

                                           console.log(strVal0.text() + ' : ' +strVal7.text() + ' : ' + strVal8.text());

                                            //return;

                                            //document.getElementById("txtid").value = strVal0.text();
                                            $('#txtid').val(strVal0.text());
                                            $('#txtVisitDate').val(strVal2.text());
                                            $('#txtTime').val(strVal3.text());
                                            $('#txtCompanyName').val(strVal4.text());
                                            $('#ProjectID').val(strVal7.text());

                                            var selectArchitectNameDDL = $('#selectArchitectName');

                                            //Get update architect name by company
                                            $.ajax({
                                                url: 'DataServicesReporting.asmx/DataReportGetArchitect',
                                                method: 'post',
                                                data: {
                                                    id: strVal0.text()
                                                },
                                                datatype: 'json',
                                                success: function (data) {
                                                    selectArchitectNameDDL.empty();
                                                    $(data).each(function (index, item) {
                                                        selectArchitectNameDDL.append($('<option/>', { value: item.ArchitecID, text: item.ArchitectName }));

                                                        $('#selectArchitectName').val(strVal5.text());
                                                        $('#selectArchitectName').change();

                                                        //selectArchitectNameDDL.text = strVal4.text();
                                                        //selectArchitectNameDDL.change();
                                                    });
                                                }

                                            });

                                            $('#txtProjectName').val(strVal8.text());
                                            $('#txtLocation').val(strVal9.text());


                                            //Get Product type such as Ampelite, Ampelram
                                            var selectProductTypeDDL = $('#selectProductType');
                                            $.ajax({
                                                url: '../trans/DataServices.asmx/GetProductType',
                                                method: 'post',
                                                dataType: 'json',
                                                success: function (data) {
                                                    selectProductTypeDDL.empty();
                                                    $(data).each(function (index, item) {
                                                        selectProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                                                        $('#selectProductType').val(strVal10.text());
                                                        $('#selectProductType').change();
                                                    });
                                                }
                                            });

                                            //alert(strVal12.text());

                                            //When product type changed cascading of product
                                            var selectProductNameDDL = $('#selectProductName');
                                            selectProductTypeDDL.change(function () {
                                                $.ajax({
                                                    url: '../trans/DataServices.asmx/GetProducts',
                                                    method: 'post',
                                                    data: { ProdTypeID: $(this).val() },
                                                    dataType: 'json',
                                                    success: function (data) {
                                                        selectProductNameDDL.empty();
                                                        selectProductNameDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                                                        $(data).each(function (index, item) {
                                                            selectProductNameDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                                                            selectProductNameDDL.val(strVal12.text());
                                                            selectProductNameDDL.change();
                                                        });
                                                    }
                                                });
                                            });


                                            //Get Product type such as Ampelite, Ampelram
                                            var selectStepDDL = $('#selectStep');
                                            $.ajax({
                                                url: '../trans/DataServices.asmx/GetStepSpec',
                                                method: 'post',
                                                dataType: 'json',
                                                success: function (data) {
                                                    selectStepDDL.empty();
                                                    $(data).each(function (index, item) {
                                                        selectStepDDL.append($('<option/>', { value: item.StepID, text: item.StepNameTh }));
                                                        $('#selectStep').val(strVal25.text());
                                                        $('#selectStep').change();
                                                    });
                                                }
                                            });


                                            //Get Product type such as Ampelite, Ampelram
                                            var selectStatusDDL = $('#selectStatus');
                                            $.ajax({
                                                url: '../trans/DataServices.asmx/GetStatus',
                                                method: 'post',
                                                dataType: 'json',
                                                success: function (data) {
                                                    selectStatusDDL.empty();
                                                    $(data).each(function (index, item) {
                                                        selectStatusDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                                                        //$('#selectStatus').val('S03');
                                                        //$('#selectStatus').change();                                                           
                                                    })

                                                    $.ajax({
                                                        url: '../trans/DataServices.asmx/GetStatusWithProject',
                                                        method: 'post',
                                                        data: {
                                                            ProjectID: strVal7.text()
                                                        },
                                                        dataType: 'json',
                                                        success: function (data) {
                                                            var obj = jQuery.parseJSON(JSON.stringify(data));

                                                            if (obj != '') {
                                                                $.each(obj, function (key, inval) {
                                                                    $('#selectStatus').val(inval["StatusID"]);
                                                                    $('#selectStatus').change();
                                                                });
                                                            }
                                                        }
                                                    })
                                                }
                                            });
                                            

                                            //alert(strVal6.text());

                                            $('#txtProfile').val(strVal14.text());
                                            $('#datedelivery').val(strVal15.text());
                                            $('#datefollowing').val(strVal16.text());
                                            $('#txtQuantity').val(strVal17.text());

                                            if (strVal25.text() == '1') {
                                                $('#txtRefMcRf').val(strVal21.text());
                                                $('#txtContactMcRf').val(strVal22.text());
                                            }
                                            else if (strVal25.text() == '2') {
                                                $('#txtRefMcRf').val(strVal22.text());
                                                $('#txtContactMcRf').val(strVal23.text());
                                            }
                                            else {
                                                $('#txtRefMcRf').val(strVal23.text());
                                                //$('#txtContactMcRf').val(strVal22.text());
                                            }
                                            $('#txtRemark').val(strVal24.text());
                                            $.ajax({
                                                url: 'DataServicesReporting.asmx/GetDataProjectHistory',
                                                method: 'post',
                                                data: { ProjectID: strVal7.text() },
                                                dataType: 'json',
                                                success: function (data) {
                                                    //var trHTML2 = '';
                                                    //$('#tableHistory tr:not(:first)').remove();

                                                    //$(data).each(function (index, item) {
                                                    //    trHTML2 += '<tr>' +
                                                    //        '<td class="">' + item.WeekDate + '</td>' +
                                                    //        '<td class="">' + item.WeekTime + '</td>' +
                                                    //        '<td class="">' + item.NextVisitDate + '</td>' +
                                                    //        '<td class="">' + item.TransNameEN + '</td>' +
                                                    //        '<td class="">' + item.StepNameEn + '</td>' +
                                                    //        '<td class="hidden">' + item.ProdTypeNameEN + '</td>' +
                                                    //        '<td class="">' + item.ProdNameEN + '</td>' +
                                                    //        '<td class="">' + item.BiddingName1 + '</td>' +
                                                    //        '<td class="">' + item.AwardMC + '</td>' +
                                                    //        '<td class="">' + item.AwardRF + '</td>' +
                                                    //        '<td class="">' + item.Quantity + '</td>' +
                                                    //        '<td class="">' + item.Remark + '</td>' +
                                                    //        '</tr > ';
                                                    //});
                                                    //$('#tableHistory').append(trHTML2);

                                                    var table;
                                                    table = $('#tableHistory').DataTable();
                                                    table.clear();

                                                    if (data != '') {
                                                        $.each(data, function (i, item) {
                                                            table.row.add([data[i].WeekDate, data[i].WeekTime, data[i].NextVisitDate, data[i].TransNameEN, data[i].StepNameEn,
                                                            data[i].ProdTypeNameEN, data[i].ProdNameEN, data[i].BiddingName1, data[i].AwardMC, data[i].AwardRF, data[i].Quantity, data[i].Remark]);
                                                        });
                                                    };
                                                    table.draw();
                                                }
                                            });

                                            $('#txtRefDoc').val('');

                                            setTimeout(function () {
                                                $("#myModalEdit").modal({ backdrop: false });
                                                $("#myModalEdit").modal("show");
                                            }, 1000);
                                        }
                                        //alert(table.cell(this).data());

                                        //var rowIndex = $(this).find('td:eq(7)').text();
                                        //alert(rowIndex);
                                    });

                                    $("#overlay").hide();

                                }
                            });
                        } else {
                            //alert('Warnning, คุณไม่มีสิทธิ์เรียกดูข้อมูลทั้งหมด..');

                            Swal.fire({
                                type: 'error',
                                title: 'You do not have permission selected all.',
                                text: 'Permission access denied.',
                                footer: 'Please contact system administrator..'
                            })
                        }

                        return;
                    }
                    else {

                        $.ajax({
                            url: 'DataServicesReporting.asmx/GetDataProjectByPortByOption',
                            method: 'post',
                            beforeSend: function () {
                                $("#overlay").show();
                            },
                            data: {
                                strOption: selectOption,
                                strDateStart: datepickertrans,
                                strDateEnd: datepickerend,
                                strUserID: selectSaleport,
                                strQtyStart: strqtystrat,
                                strQtyEnd: strqtyend,
                                strSearch: strsearch
                            },
                            dataType: 'json',
                            success: function (data) {

                                var table;
                                table = $('#tableWeeklyReportx').DataTable();
                                table.clear();

                                if (data != '') {
                                    $.each(data, function (i, item) {
                                        table.row.add([data[i].ID, data[i].UserID, data[i].WeekDate, data[i].WeekTime, data[i].CompanyName, data[i].ArchitectID, data[i].Name
                                            , data[i].ProjectID, data[i].ProjectName, data[i].Location, data[i].ProdTypeID, data[i].ProdTypeNameEN, data[i].ProdID
                                            , data[i].ProdNameEN, data[i].ProfNameEN, data[i].DeliveryDate, data[i].NextVisitDate, data[i].Quantity, data[i].StepNameA
                                            , data[i].StepNameB, data[i].RefWeekDate, data[i].Ref1, data[i].Ref2, data[i].Ref3, data[i].RefRemark, data[i].StepID]);
                                    });
                                }
                                table.column(0).nodes().to$().addClass('hidden');
                                table.column(2).nodes().to$().addClass('hidden');
                                table.column(3).nodes().to$().addClass('hidden');
                                table.column(5).nodes().to$().addClass('hidden');
                                table.column(7).nodes().to$().addClass('hidden');
                                table.column(10).nodes().to$().addClass('hidden');
                                table.column(12).nodes().to$().addClass('hidden');
                                table.column(25).nodes().to$().addClass('hidden');
                                table.column(8).nodes().to$().addClass('mypointer');
                                table.column(24).nodes().to$().addClass('mypointer');
                                table.draw();

                                $('#tableWeeklyReportx tbody').on('click', 'td', function (e) {
                                    e.preventDefault();
                                    var rowIndex = $(this).parent().children().eq(0).text(); //  $(this).closest('.mypointer').text();
                                    var rowValue = $(this).parent().children().eq(7).text();
                                    console.log(rowIndex + ':' + rowValue);

                                    rIndex = this.parentElement.rowIndex;
                                    cIndex = this.cellIndex;

                                    console.log('row : ' + rIndex + 'cell : ' + cIndex);

                                    if (rIndex != 0 & cIndex == 8 || cIndex == 24) {
                                        //alert(rIndex + '' + cIndex);

                                        document.getElementById("divErrorArchitect").style.display = 'none';
                                        document.getElementById("divErrorLocation").style.display = 'none';
                                        document.getElementById("divErrorProductType").style.display = 'none';
                                        document.getElementById("divErrorProductName").style.display = 'none';
                                        document.getElementById("divErrorProfile").style.display = 'none';
                                        document.getElementById("divErrorDelivery").style.display = 'none';
                                        document.getElementById("divErrorFollowing").style.display = 'none';
                                        document.getElementById("divErrorQuantity").style.display = 'none';
                                        document.getElementById("divErrorRemark").style.display = 'none';
                                        document.getElementById("divErrorStatus").style.display = 'none';

                                        var strVal0 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(0)');  //ID
                                        var strVal1 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(1)');  //UserID
                                        var strVal2 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(2)');  //WeekDate
                                        var strVal3 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(3)');  //WeekTime
                                        var strVal4 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(4)');  //CompanyName
                                        var strVal5 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(5)');  //ArchitectID
                                        var strVal6 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(6)');  //Name
                                        var strVal7 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(7)');  //ProjectID
                                        var strVal8 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(8)');  //ProjectName
                                        var strVal9 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(9)');  //Location
                                        var strVal10 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(10)'); //ProdTypeID
                                        var strVal11 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(11)'); //ProdTypeNameEN
                                        var strVal12 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(12)'); //ProdID
                                        var strVal13 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(13)');  //ProdNameEN
                                        var strVal14 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(14)');    //ProfNameEN
                                        var strVal15 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(15)');    //DeliveryDate
                                        var strVal16 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(16)');    //NextVisitDate
                                        var strVal17 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(17)');    //Quantity
                                        var strVal18 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(18)');    //StepNameA
                                        var strVal19 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(19)');    //StepNameB
                                        var strVal20 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(20)');    //RefWeekDate
                                        var strVal21 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(21)');    //Ref1
                                        var strVal22 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(22)');    //Ref2
                                        var strVal23 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(23)');    //Ref3
                                        var strVal24 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(24)');    //RefRemark
                                        var strVal25 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(25)');    //StepID

                                        //alert(strVal7.text());

                                        //return;

                                        //document.getElementById("txtid").value = strVal0.text();
                                        $('#txtid').val(strVal0.text());
                                        $('#txtVisitDate').val(strVal2.text());
                                        $('#txtTime').val(strVal3.text());
                                        $('#txtCompanyName').val(strVal4.text());
                                        $('#ProjectID').val(strVal7.text());

                                        var selectArchitectNameDDL = $('#selectArchitectName');

                                        //Get update architect name by company
                                        $.ajax({
                                            url: 'DataServicesReporting.asmx/DataReportGetArchitect',
                                            method: 'post',
                                            data: {
                                                id: strVal0.text()
                                            },
                                            datatype: 'json',
                                            success: function (data) {
                                                selectArchitectNameDDL.empty();
                                                $(data).each(function (index, item) {
                                                    selectArchitectNameDDL.append($('<option/>', { value: item.ArchitecID, text: item.ArchitectName }));

                                                    $('#selectArchitectName').val(strVal5.text());
                                                    $('#selectArchitectName').change();

                                                    //selectArchitectNameDDL.text = strVal4.text();
                                                    //selectArchitectNameDDL.change();
                                                });
                                            }

                                        });

                                        $('#txtProjectName').val(strVal8.text());
                                        $('#txtLocation').val(strVal9.text());


                                        //Get Product type such as Ampelite, Ampelram
                                        var selectProductTypeDDL = $('#selectProductType');
                                        $.ajax({
                                            url: '../trans/DataServices.asmx/GetProductType',
                                            method: 'post',
                                            dataType: 'json',
                                            success: function (data) {
                                                selectProductTypeDDL.empty();
                                                $(data).each(function (index, item) {
                                                    selectProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                                                    $('#selectProductType').val(strVal10.text());
                                                    $('#selectProductType').change();
                                                });
                                            }
                                        });


                                        //When product type changed cascading of product
                                        var selectProductNameDDL = $('#selectProductName');
                                        selectProductTypeDDL.change(function () {
                                            $.ajax({
                                                url: '../trans/DataServices.asmx/GetProducts',
                                                method: 'post',
                                                data: { ProdTypeID: $(this).val() },
                                                dataType: 'json',
                                                success: function (data) {
                                                    selectProductNameDDL.empty();
                                                    selectProductNameDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                                                    $(data).each(function (index, item) {
                                                        selectProductNameDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                                                        selectProductNameDDL.val(strVal12.text());
                                                        selectProductNameDDL.change();
                                                    });
                                                }
                                            });
                                        });


                                        //Get Product type such as Ampelite, Ampelram
                                        var selectStepDDL = $('#selectStep');
                                        $.ajax({
                                            url: '../trans/DataServices.asmx/GetStepSpec',
                                            method: 'post',
                                            dataType: 'json',
                                            success: function (data) {
                                                selectStepDDL.empty();
                                                $(data).each(function (index, item) {
                                                    selectStepDDL.append($('<option/>', { value: item.StepID, text: item.StepNameTh }));
                                                    $('#selectStep').val(strVal25.text());
                                                    $('#selectStep').change();
                                                });
                                            }
                                        });


                                        //Get Product type such as Ampelite, Ampelram
                                        var selectStatusDDL = $('#selectStatus');
                                        $.ajax({
                                            url: '../trans/DataServices.asmx/GetStatus',
                                            method: 'post',
                                            dataType: 'json',
                                            success: function (data) {
                                                selectStatusDDL.empty();
                                                $(data).each(function (index, item) {
                                                    selectStatusDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                                                    //$('#selectStatus').val('S03');
                                                    //$('#selectStatus').change();                                                           
                                                })

                                                $.ajax({
                                                    url: '../trans/DataServices.asmx/GetStatusWithProject',
                                                    method: 'post',
                                                    data: {
                                                        ProjectID: strVal7.text()
                                                    },
                                                    dataType: 'json',
                                                    success: function (data) {
                                                        var obj = jQuery.parseJSON(JSON.stringify(data));

                                                        if (obj != '') {
                                                            $.each(obj, function (key, inval) {
                                                                $('#selectStatus').val(inval["StatusID"]);
                                                                $('#selectStatus').change();
                                                            });
                                                        }
                                                    }
                                                })
                                            }
                                        });

                                        //alert(strVal6.text());

                                        $('#txtProfile').val(strVal14.text());
                                        $('#datedelivery').val(strVal15.text());
                                        $('#datefollowing').val(strVal16.text());
                                        $('#txtQuantity').val(strVal17.text());

                                        if (strVal25.text() == '1') {
                                            $('#txtRefMcRf').val(strVal21.text());
                                            $('#txtContactMcRf').val(strVal22.text());
                                        }
                                        else if (strVal25.text() == '2') {
                                            $('#txtRefMcRf').val(strVal22.text());
                                            $('#txtContactMcRf').val(strVal23.text());
                                        }
                                        else {
                                            $('#txtRefMcRf').val(strVal23.text());
                                            //$('#txtContactMcRf').val(strVal22.text());
                                        }

                                        $('#txtRemark').val(strVal24.text());

                                        $.ajax({
                                            url: 'DataServicesReporting.asmx/GetDataProjectHistory',
                                            method: 'post',
                                            data: { ProjectID: strVal7.text() },
                                            dataType: 'json',
                                            success: function (data) {
                                                //var trHTML2 = '';
                                                //$('#tableHistory tr:not(:first)').remove();

                                                //$(data).each(function (index, item) {
                                                //    trHTML2 += '<tr>' +
                                                //        '<td class="">' + item.WeekDate + '</td>' +
                                                //        '<td class="">' + item.WeekTime + '</td>' +
                                                //        '<td class="">' + item.NextVisitDate + '</td>' +
                                                //        '<td class="">' + item.TransNameEN + '</td>' +
                                                //        '<td class="">' + item.StepNameEn + '</td>' +
                                                //        '<td class="hidden">' + item.ProdTypeNameEN + '</td>' +
                                                //        '<td class="">' + item.ProdNameEN + '</td>' +
                                                //        '<td class="">' + item.BiddingName1 + '</td>' +
                                                //        '<td class="">' + item.AwardMC + '</td>' +
                                                //        '<td class="">' + item.AwardRF + '</td>' +
                                                //        '<td class="">' + item.Quantity + '</td>' +
                                                //        '<td class="">' + item.Remark + '</td>' +
                                                //        '</tr > ';
                                                //});
                                                //$('#tableHistory').append(trHTML2);

                                                var table;
                                                    table = $('#tableHistory').DataTable();
                                                    table.clear();

                                                    if (data != '') {
                                                        $.each(data, function (i, item) {
                                                            table.row.add([data[i].WeekDate, data[i].WeekTime, data[i].NextVisitDate, data[i].TransNameEN, data[i].StepNameEn,
                                                            data[i].ProdTypeNameEN, data[i].ProdNameEN, data[i].BiddingName1, data[i].AwardMC, data[i].AwardRF, data[i].Quantity, data[i].Remark]);
                                                        });
                                                    };
                                                table.draw();                                            
                                            }
                                        });

                                        $('#txtRefDoc').val('');

                                        setTimeout(function () {
                                            $("#myModalEdit").modal({ backdrop: false });
                                            $("#myModalEdit").modal("show");
                                        }, 1000);
                                    }
                                    //alert(table.cell(this).data());

                                    //var rowIndex = $(this).find('td:eq(7)').text();
                                    //alert(rowIndex);
                                });

                                $("#overlay").hide();
                            }
                        });
                    }



                });

                $('#txtQuantity').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)) {
                        event.preventDefault();
                    }
                });

                //var btnHistoryExcel = $('#btnHistoryExcel');
                //btnHistoryExcel.click(
                //    function() {
                //        var table = document.getElementById("tableHistory");
                //        var html = table.outerHTML;
                //        var url = 'data:application/vnd.ms-excel,' + escape(html); // Set your html table into url 
                //        elem.setAttribute("href", url);
                //        elem.setAttribute("download", "history.xls"); // Choose the file name
                //        return false;
                //    })

                var btnRefInv = $('#btnRefInv');
                btnRefInv.click(function () {
                    //alert('test');
                   
                    $('#example-result').text('');
                    getDataInvoiceList();

                    $("#modal-refinvoice").modal({ backdrop: false });
                    $("#modal-refinvoice").modal("show");


                });



                $("#tblemployee").on('click', '.btnSelect', function () {
                    // get the current row
                    var currentRow = $(this).closest("tr");

                    var emp_id = currentRow.find("td:eq(0)").html(); // get current row 1st table cell td value
                    var firstname = currentRow.find("td:eq(1)").html(); // get current row 2nd table cell td value
                    var lastname = currentRow.find("td:eq(2)").html(); // get current row 3rd table cell  td value
                    var data = emp_id + "\n" + firstname + "\n" + lastname;

                    //alert(data);

                    $('#emp_id').val(emp_id);
                    $('#firstname').val(firstname);
                    $('#lastname').val(lastname);

                    //alert('Open Modal Member...1');

                    //$('#modal-employee').modal({ backdrop: false });
                    $('#modal-employee').modal("hide");
                });


                var btncheck = $('#btncheck');
                btncheck.click(function () {

                    // declare variable table for assign attribute
                    var table = $('#tblemployee').DataTable();
                    var arr = [];
                    var checkedvalues = table.$('input:checked').each(function () {
                        arr.push($(this).attr('id'))
                    });
                    // convert array to string                    

                    arr = arr.toString();
                    var empid = arr.split(",");

                    //empid.forEach(getEmpid);

                    //function getEmpid(item, index) {
                    //    console.log(index + ':' + item)                        
                    //}

                    $('#example-result').text(empid);
                    //table.$('input:checked').removeAttr('checked');  
                    var xempid = $('#example-result').text();

                    $('#txtRefDoc').val(xempid);
                    $("#modal-refinvoice").modal("hide");
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

                    //var checkedvalues = table.$('input:checkbox').each(function () {
                    //    $(this).prop("checked", true);
                    //});

                });
                    //******************* End Of document.ready() *************************//
                    //******************* End Of document.ready() *************************//
            })

            function getDataInvoiceList() {
                $.ajax({
                    url: 'DataServicesInvoiceList.asmx/GetInvoiceList',
                    method: 'post',
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

        <h1>Project Status
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner" style="padding-right: 20%">
                <span class="spinner"></span>
            </div>
        </div>

        <%--<%= strMsgAlert %>--%>

        <%-- Application Forms--%>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <div class="box-body">
                            <a href="#">content</a>
                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Project Status</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" runat="server" onserverclick="btnDownload_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" ><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Monitoring progression of projects</span>
                                </div>

                            </div>

                            <hr />

                            <div class="row" style="margin-left: 30px;">

                                <div class="col-md-4">
                                    <input type="hidden" id="optionName" name="optionName" value="">

                                    <label class="txtLabel">Report Options</label>
                                    <input type="hidden" id="hidselectReportOption" name="hidselectReportOption" value="">
                                    <div class="txtLabel">
                                        <select id="selectReportOption" name="selectReportOption" class="form-control input-sm" style="width: 100%">
                                            <%--<%= strReportOption %>--%>
                                            <option value="R099">View all</option>
                                            <option value="R001">Design</option>
                                            <option value="R002">Bidding</option>
                                            <option value="R003">Award Main Cons</option>
                                            <option value="R006">Award Roll Formers</option>
                                            <option value="R004">Next Following</option>
                                            <option value="R005">On Delivery Date</option>
                                            <option value="R011">Design --> Bidding</option>
                                            <option value="R012">Bidding --> Award Main Cons</option>
                                            <option value="R013">Award Main Cons --> Award RF</option>

                                        </select>
                                    </div>
                                    <div id="divErrorselectReportOption" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
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
                                    <label class="txtLabel">Sale Spec</label>
                                    <input type="hidden" id="hidselectSalePort" name="hidselectSalePort" value="">
                                    <div class="txtLabel">
                                        <select id="selectSalePort" name="selectSalePort" class="form-control input-sm" style="width: 100%">
                                            <%= strPortOption %>
                                        </select>
                                    </div>
                                    <div id="divErrorSelectSaleSpec" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

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
                            </div>

                            <div class="row" style="margin-left: 30px;">



                                <div class="col-md-6">
                                    <label class="txtLabel">Search</label>
                                    <div class="txtLabel">
                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="Search" name="Search" value="" autocomplete="off" placeholder="Can you search data in here..">
                                    </div>
                                    <div id="divErrorSearch" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">Query Info</label>
                                    <div class="">
                                        <button type="button" id="btnJsonReport" class="btn btn-info btn-flat btn-block btn-sm ">Show Report</button>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="txtLabel">Reporting</label>
                                    <div>
                                        <span class="">
                                            <button type="button" id="alert" name="alert" class="btn btn-success btn-flat btn-block btn-sm " onclick="validateExcel();"><i class="fa fa-file-excel-o"></i>Print Excel</button>

                                            <button id="btnDownloadExcel" runat="server" onserverclick="btnExportExcelOption_click" type="button" class="btn btn-success btn-flat btn-block btn-sm hidden" data-toggle="tooltip" title="Print Excel">
                                                <i class="fa fa-file-excel-o"></i>Print Excel</button>

                                            <asp:Button ID="btnSendMail" runat="server" Text="btnSendMail" OnClick="btnSendMail_Click" UseSubmitBehavior="false" CssClass="hidden" />
                                        </span>
                                    </div>
                                </div>

                                <div class="col-md-2 hidden">
                                    <label class="txtLabel">Reporting</label>
                                    <div>
                                        <span class="">
                                            <button id="btnDownloadPDF" runat="server" type="button" class="btn btn-warning btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                <i class="fa fa-pdf-o"></i>Print PDF</button>

                                        </span>
                                    </div>
                                </div>


                            </div>


                            <br />




                        </div>


                        <div class="col-md-12">
                            <div id="divWeeklyReport">
                                <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th class="hidden">ID</th>
                                            <th>Port</th>
                                            <th class="hidden">WeekDate</th>
                                            <th class="hidden">WeekTime</th>
                                            <th>CompanyName</th>
                                            <th class="hidden">ArchitectID</th>
                                            <th>Name</th>
                                            <th class="hidden">ProjectID</th>
                                            <th>ProjectName</th>
                                            <th>Location</th>
                                            <th class="hidden">ProdTypeID</th>
                                            <th>ProdTypeName</th>
                                            <th class="hidden">ProdID</th>
                                            <th class="">ProdName</th>
                                            <th>Profile</th>
                                            <th>Delivery</th>
                                            <th>Following</th>
                                            <th>Quantity</th>
                                            <th>StepNameA</th>
                                            <th>ProjMonth</th>
                                            <th>RefWeekDate</th>
                                            <th>BD</th>
                                            <th>MC</th>
                                            <th>RF</th>
                                            <th>RefRemark</th>
                                            <th class="hidden">StepID</th>

                                            <%--ID, UserID, WeekDate, WeekTime, CompanyName, ArchitectID, Name
                                                , ProjectID, ProjectName, Location, ProdTypeID, ProdTypeNameEN, ProdID
                                                , ProdNameEN, ProfNameEN, DeliveryDate, NextVisitDate, Quantity, StepNameA
                                                , StepNameB, RefWeekDate, Ref1, Ref2, Ref3, RefRemark, StepID--%>
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

        <!-- /.modal myModalEdit -->
        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog" style="width: 60%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Project Update</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#overview" data-toggle="tab">Overview</a></li>
                                    <li><a href="#history" data-toggle="tab">Project History</a></li>

                                </ul>

                                <div class="tab-content">
                                    <div class="active tab-pane" id="overview">
                                        <!-- Post -->
                                        <div class="post clearfix">
                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">ID</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtid" name="txtid" autocomplete="off" readonly placeholder="" value="" required>
                                                </div>
                                            </div>

                                            <div class="row hidden" style="margin-bottom: 5px">

                                                <div class="col-md-4 txtLabel">Date / Time</div>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtVisitDate" name="txtVisitDate" readonly autocomplete="off" placeholder="" value="" required>
                                                </div>


                                                <div class="col-md-4">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtTime" name="txtTime" readonly autocomplete="off" placeholder="" value="" required>
                                                </div>

                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Company</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompanyName" name="txtCompanyName" readonly autocomplete="off" placeholder="" value="" required>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Project Name</div>
                                                <div class="col-md-8">

                                                    <input type="text" class="form-control input input-sm txtLabel hidden" id="ProjectID" name="ProjectID" readonly autocomplete="off" placeholder="" value="">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProjectName" name="txtProjectName" readonly autocomplete="off" placeholder="" value="">
                                                </div>
                                            </div>

                                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                                <div class="col-md-4">
                                                    <label class="txtLabel">Architect</label>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="txtLabel">
                                                        <select id="selectArchitectName" name="selectArchitectName" class="form-control input-sm" style="width: 100%">
                                                        </select>
                                                    </div>
                                                    <div id="divErrorArchitect" class="txtLabel text-red" style="display: none;">Please select data at least one item..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Location</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLocation" name="txtLocation" autocomplete="off" placeholder="" value="">
                                                    <div id="divErrorLocation" class="txtLabel text-red" style="display: none;">Location is not empty please check and try agian..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                                <div class="col-md-4">
                                                    <label class="txtLabel">ProductType</label>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="txtLabel">
                                                        <select id="selectProductType" name="selectProductType" class="form-control input-sm" style="width: 100%">
                                                        </select>
                                                    </div>
                                                    <div id="divErrorProductType" class="txtLabel text-red" style="display: none;">Please select data at least one item..!</div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="txtLabel">
                                                        <select id="selectProductName" name="selectProductName" class="form-control input-sm" style="width: 100%">
                                                        </select>
                                                    </div>
                                                    <div id="divErrorProductName" class="txtLabel text-red" style="display: none;">Please select data at least one item..!</div>
                                                </div>
                                            </div>



                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Profile</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProfile" name="txtProfile" autocomplete="off" placeholder="">
                                                    <div id="divErrorProfile" class="txtLabel text-red" style="display: none;">Data profile is not empty please check and try agian..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Delivery / Following</div>
                                                <div class="col-md-4">
                                                    <div class="input-group date">
                                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datedelivery" name="datedelivery" autocomplete="off">
                                                        <div class="input-group-addon input-sm">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                    </div>
                                                    <div id="divErrorDelivery" class="txtLabel text-red" style="display: none;">Delivery date is not empty please check and try agian..!</div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="input-group date">
                                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datefollowing" name="datefollowing" value="" autocomplete="off">
                                                        <div class="input-group-addon input-sm">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                    </div>
                                                    <div id="divErrorFollowing" class="txtLabel text-red" style="display: none;">Data is not empty please check and try agian..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Quantity</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtQuantity" name="txtQuantity" autocomplete="off" placeholder="" value="">
                                                    <div id="divErrorQuantity" class="txtLabel text-red" style="display: none;">Quantity is not empty please check and try agian..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Ref.MC/RF</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtRefMcRf" name="txtRefMcRf" autocomplete="off" placeholder="" value="">
                                                    <div id="divErrorRefMcRf" class="txtLabel text-red" style="display: none;">Quantity is not empty please check and try agian..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Contact.MC/RF</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtContactMcRf" name="txtContactMcRf" autocomplete="off" placeholder="" value="">
                                                    <div id="divErrorContactMcRf" class="txtLabel text-red" style="display: none;">Quantity is not empty please check and try agian..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-bottom: 5px">
                                                <div class="col-md-4 txtLabel">Remark</div>
                                                <div class="col-md-8">
                                                    <textarea cols="40" rows="3" id="txtRemark" name="txtRemark" class="form-control input input-sm txtLabel"></textarea>
                                                    <div id="divErrorRemark" class="txtLabel text-red" style="display: none;">Please enter your comment..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-top: 5px;">
                                                <div class="col-md-4">
                                                    <label class="txtLabel">Proess Step</label>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="txtLabel">
                                                        <select id="selectStep" name="selectStep" class="form-control input-sm" style="width: 100%">
                                                        </select>
                                                    </div>
                                                    <div id="divErrorStep" class="txtLabel text-red" style="display: none;">Please select at least one item..!</div>
                                                </div>
                                            </div>

                                            <div class="row" style="margin-top: 5px;">
                                                <div class="col-md-4">
                                                    <label class="txtLabel">Status</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="txtLabel">
                                                        <select id="selectStatus" name="selectStatus" class="form-control input-sm" style="width: 100%">
                                                        </select>
                                                    </div>
                                                    <div id="divErrorStatus" class="txtLabel text-red" style="display: none;">Please select at least one item..!</div>
                                                </div>

                                                <div class="col-md-1 ">
                                                    <label class="txtLabel">Ref#Inv.</label>
                                                </div>
                                                <div class="col-md-4 ">
                                                    <%-- <input type="text" class="form-control input input-sm txtLabel" id="txtRefDoc" name="txtRefDoc" readonly autocomplete="off" placeholder="" value="">
                                                    --%>
                                                    <div class="input-group">
                                                        <input type="text" id="txtRefDoc" name="txtRefDoc" readonly class="form-control  input ">
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-info btn-flat" id="btnRefInv" name="btnRefInv">Go!</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.post -->
                                    </div>


                                    <div class="tab-pane" id="history">
                                        <!-- Post -->


                                        <div class="post clearfix">
                                            <div id="divWeeklyHistory">
                                                <div class="row">

                                                    <span class="pull-right txtLabel">
                                                        <button id="btnHistoryExcel" type="button" class="btn btn-default btn-sm"
                                                            data-toggle="tooltip" title="Excel" onclick="exportexcel()">
                                                            <i class="fa fa-table"></i>
                                                        </button>


                                                    </span>

                                                    <div>
                                                    <table id="tableHistory" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <th>WeekDate</th>
                                                                <th>WeekTime</th>
                                                                <th>Following</th>
                                                                <th>TransName</th>
                                                                <th>StepName</th>
                                                                <th>ProdType</th>
                                                                <th>ProdName</th>
                                                                <th>BiddingName</th>
                                                                <th>AwardMC</th>
                                                                <th>AwardRF</th>
                                                                <th>Quantity</th>
                                                                <th>Remark</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                   </div>
                                                    

                                                </div>
                                            </div>

                                        </div>
                                        <!-- /.post -->
                                    </div>
                                </div>
                            </div>



                        </div>
                    </div>

                    <div class="modal-footer clearfix">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="btnSubmitUpdate" onclick="ValidateUpdate()" class="btn btn-primary">Update Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData" runat="server">Update Changes</button>
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
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="btnConfirmed" runat="server" onclick="sendMail()">Submit Request</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- /.modal reference invoice--%>
        <div class="modal modal-default fade" id="modal-refinvoice">
            <div class="modal-dialog" style="width: 60%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Reference Invoice</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">
                            <table id="tblemployee" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
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
                                <button type="button" id="btncheck" name="btncheck" class="btn btn-success btn-sm btn-flat pull-right">Confirmed</button>
                            </p>
                            <p id="example-result"></p>
                        </div>

                    </div>
                </div>
            </div>
        </div>



        <script>
            function ValidateUpdate() {
                var str1 = document.getElementById("txtid").value;
                var str2 = document.getElementById("txtVisitDate").value;
                var str3 = document.getElementById("txtTime").value;
                var str4 = document.getElementById("txtCompanyName").value;
                var str5 = document.getElementById("txtProjectName").value;
                var str6 = document.getElementById("selectArchitectName").value;
                var str7 = document.getElementById("txtLocation").value;
                var str8 = document.getElementById("selectProductType").value;
                var str9 = document.getElementById("selectProductName").value;
                var str10 = document.getElementById("txtProfile").value;
                var str11 = document.getElementById("datedelivery").value;
                var str12 = document.getElementById("datefollowing").value;
                var str13 = document.getElementById("txtQuantity").value;
                var str14 = document.getElementById("txtRemark").value;
                var str15 = document.getElementById("selectStep").value;
                var str16 = document.getElementById("txtRefMcRf").value;
                var str17 = document.getElementById("txtContactMcRf").value;
                var str18 = document.getElementById("selectStatus").value;
                var str19 = document.getElementById("txtRefDoc").value;

                var div1 = document.getElementById("divErrorArchitect");
                var div2 = document.getElementById("divErrorLocation");
                var div3 = document.getElementById("divErrorProductType");
                var div4 = document.getElementById("divErrorProductName");
                var div5 = document.getElementById("divErrorProfile");
                var div6 = document.getElementById("divErrorDelivery");
                var div7 = document.getElementById("divErrorFollowing");
                var div8 = document.getElementById("divErrorQuantity");
                var div9 = document.getElementById("divErrorRemark");
                var div10 = document.getElementById("divErrorStatus");


                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        if (str6 == '' || str6 == '-1') {
                            div1.style.display = "block";
                            alert('Architect is not empty..!');
                            return;
                        }
                        else { div1.style.display = "none"; }

                        if (str7 == '') {
                            div2.style.display = "block";
                            alert('Location is not empty..!');
                            return;
                        }
                        else { div2.style.display = "none"; }

                        if (str8 == '') {
                            div3.style.display = "block";
                            alert('Data is not empty..!');
                            return;
                        }
                        else { div3.style.display = "none"; }

                        if (str9 == '') {
                            div4.style.display = "block";
                            alert('Data is not empty..!');
                            return;
                        }
                        else { div4.style.display = "none"; }

                        if (str10 == '') {
                            div5.style.display = "block";
                            alert('Data is not empty..!');
                            return;
                        }
                        else { div5.style.display = "none"; }

                        var regEx = /^\d{4}-\d{2}-\d{2}$/;
                        var dateString = str11;

                        if (!dateString.match(regEx)) {
                            div6.style.display = "block";
                            alert('Format date is incorrect please check..!');
                            return;
                        }
                        else { div6.style.display = "none"; }

                        if (str11 == '') {
                            div6.style.display = "block";
                            alert('Data is not empty..!');
                            return;
                        }
                        else { div6.style.display = "none"; }


                        var dateString2 = str12;

                        if (!dateString2.match(regEx)) {
                            div7.style.display = "block";
                            alert('Format date is incorrect please check..!');
                            return;
                        }
                        else { div7.style.display = "none"; }

                        if (str12 == '') {
                            div7.style.display = "block";
                            alert('Data Following is incorrect..!');
                            return;
                        }
                        else { div7.style.display = "none"; }

                        if (str13 == '') {
                            div8.style.display = "block";
                            alert('Data Quantity is not empty..!');
                            return;
                        }
                        else { div8.style.display = "none"; }

                        if (str14 == '') {
                            div9.style.display = "block";
                            alert('Data details is not empty..!');
                            return;
                        }
                        else { div9.style.display = "none"; }

                        var strStatus = $('#selectStatus').val();
                        if (strStatus == 'S02' && str19 == '') {
                            
                            Swal.fire({
                                type: 'error',
                                title: 'Sold, Reference Invoice is not empty..!',                               
                                footer: 'Please try again..'
                            });
                            return;
                        } else if (strStatus == 'S03' && str19 == '') {
                            Swal.fire({
                                type: 'error',
                                title: 'Finished, Reference Invoice is not empty..!',                               
                                footer: 'Please try again..'
                            });
                            return;
                        } else if (strStatus == 'S06' && str19 == '') {
                            Swal.fire({
                                type: 'error',
                                title: 'SOS, Reference Invoice is not empty..!',                               
                                footer: 'Please try again..'
                            });
                            return;
                        } else {

                        }

                        

                        console.log('id: ' + str1 + '\n' +
                            'WeekDate: ' + str2 + '\n' +
                            'WeekTime: ' + str3 + '\n' +
                            'CompanyName: ' + str4 + '\n' +
                            'ArchitecID: ' + $('#selectArchitectName').val() + '\n' +
                            'Name: ' + $('#selectArchitectName option:selected').text() + '\n' +
                            'Location: ' + str7 + '\n' +
                            'ProdTypeID: ' + $('#selectProductType').val() + '\n' +
                            'ProdTypeNameEN: ' + $('#selectProductType option:selected').text() + '\n' +
                            'ProdID: ' + $('#selectProductName').val() + '\n' +
                            'ProdNameEN: ' + $('#selectProductName option:selected').text() + '\n' +
                            'ProfNameEN: ' + str10 + '\n' +
                            'DeliveryDate: ' + str11 + '\n' +
                            'NextVisitDate: ' + str12 + '\n' +
                            'Quantity: ' + str13 + '\n' + 
                            'StepNameEn: ' + $('#selectStep option:selected').text() + '\n' + 
                            'Ref1: ' + str16 + '\n' + 
                            'Ref2: ' + str17 + '\n' + 
                            'Remark: ' + str14 + '\n' + 
                            'StepID: ' + $('#selectStep').val() + '\n' +
                            'StatusID: ' + $('#selectStatus').val() + '\n' +
                            'ProjectID: ' + $('#ProjectID').val() + '\n' +
                            'RefDocuNo: ' + str19 + '\n');

                        //Get update weekly report succeseed...
                        $.ajax({
                            url: 'DataServicesReporting.asmx/GetUpdateWeeklyReportViaSupervisor',
                            method: 'POST',
                            data: {
                                ID: str1,
                                WeekDate: str2,
                                WeekTime: str3,
                                CompanyName: str4,
                                ArchitecID: $('#selectArchitectName').val(),
                                Name: $('#selectArchitectName option:selected').text(),
                                Location: str7,
                                ProdTypeID: $('#selectProductType').val(),
                                ProdTypeNameEN: $('#selectProductType option:selected').text(),
                                ProdID: $('#selectProductName').val(),
                                ProdNameEN: $('#selectProductName option:selected').text(),
                                ProfNameEN: str10,
                                DeliveryDate: str11,
                                NextVisitDate: str12,
                                Quantity: str13,
                                StepNameEn: $('#selectStep option:selected').text(),
                                Ref1: str16,
                                Ref2: str17,
                                Remark: str14,
                                StepID: $('#selectStep').val(),
                                StatusID: $('#selectStatus').val(),
                                ProjectID: $('#ProjectID').val(),
                                RefDocuNo: '',
                                jobname : ''
                            },
                            dataType: 'json',
                            complete: function (data) {
                                //alert('Update data succeseed please close and refresh..!');
                                $('#btnJsonReport').click();
                                $("#myModalEdit").modal("hide");
                            }
                        });



                       <%--document.getElementById("<%= btnUpdateData.ClientID %>").click();--%>


                    }
                }
            }

            function sendMail() {

                document.getElementById("<%= btnSendMail.ClientID %>").click();

                //Email.send({
                //    Host: "smtp.gmail.com",
                //    Username: "peantia.w@gmail.com",
                //    Password: "S@nti293024!",
                //    To: 'santi@ampelite.co.th',
                //    From: "peantia.w@gmail.com",
                //    Subject: "This is the subject",
                //    Body: "And this is the body"
                //}).then(
                //    message => alert(message)
                //);
            }

        </script>

    </section>


</asp:Content>
