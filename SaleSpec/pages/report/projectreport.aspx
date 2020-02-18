<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projectreport.aspx.cs" Inherits="SaleSpec.pages.report.projectreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="jquery-1.11.2.min.js"></script>
        <script src="jquery.table2excel.js"></script>
        <script>

            function validateExcel() {
                var selectSaleport = $('#selectSalePort').val();
                var empcode = '<%= Session["EmpCode"] %>';

                if (selectSaleport == 'SELECTED ALL') {

                    if (empcode == '118052' || empcode == '316010' || empcode == '506009') {
                         document.getElementById("<%=  btnDownloadExcel.ClientID %>").click();
                    }
                    else {
                        successalert();
                        return;
                    }
                }
                else {
                    document.getElementById("<%=  btnDownloadExcel.ClientID %>").click();
                }

            }

             function successalert() {
                    Swal.fire({
                                type: 'error',
                                title: 'You do not have permission print all.',
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


        </script>
        <script>
            $(document).ready(function () {

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                var firstdate = (yyyy-2) + '-' + mm + '-01';
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
                    if (selectStatus.val() == 'S02') {

                        //alert('Please enter reference invoice ');
                        txtRefDoc.focus().select();
                        txtRefDoc.css('background-color', '#00aaff');
                        $('#txtRefDoc').prop('readonly', false);
                        //txtRefDoc.css('visibility', '');
                        txtRefDoc.val('');

                    } else {
                        txtRefDoc.css('background-color', '');
                        $('#txtRefDoc').prop('readonly', true);
                        //txtRefDoc.css('visibility', 'hidden');
                        txtRefDoc.val('');
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

                    //alert(selectSaleport);

                    selectReportOptionDDL.change();

                    if (selectSaleport == 'SELECTED ALL') {

                        if (empcode == '118052' || empcode == '316010' || empcode == '506009') {
                            $.ajax({
                                url: 'DataServicesReporting.asmx/GetDataProjectByPortByOption',
                                method: 'post',
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

                                    //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                                    var trHTML = '';
                                    $('#tableWeeklyReportx tr:not(:first)').remove();
                                    $(data).each(function (index, item) {
                                        trHTML += '<tr>' +
                                            '<td class="hidden">' + item.ID + '</td>' +
                                            '<td class="hidden">' + item.WeekDate + '</td>' +
                                            '<td class="hidden">' + item.WeekTime + '</td>' +
                                            '<td>' + item.CompanyName + '</td>' +
                                            '<td class="hidden">' + item.ArchitectID + '</td>' +
                                            '<td>' + item.Name + '</td>' +
                                            '<td class="hidden">' + item.ProjectID + '</td>' +
                                            '<td class="text-blue">' + item.ProjectName + '</td>' +
                                            '<td>' + item.Location + '</td>' +
                                            '<td class="hidden">' + item.ProdTypeID + '</td>' +
                                            '<td>' + item.ProdTypeNameEN + '</td>' +
                                            '<td class="hidden">' + item.ProdID + '</td>' +
                                            '<td>' + item.ProdNameEN + '</td>' +
                                            '<td>' + item.ProfNameEN + '</td>' +
                                            '<td>' + item.DeliveryDate + '</td>' +
                                            '<td>' + item.NextVisitDate + '</td>' +
                                            '<td>' + item.Quantity + '</td>' +
                                            '<td>' + item.StepNameA + '</td>' +
                                            '<td>' + item.StepNameB + '</td>' +
                                            '<td>' + item.RefWeekDate + '</td>' +
                                            '<td>' + item.Ref1 + '</td>' +
                                            '<td>' + item.Ref2 + '</td>' +
                                            '<td>' + item.Ref3 + '</td>' +
                                            '<td>' + item.RefRemark + '</td>' +
                                            '<td class="hidden">' + item.StepID + '</td>' +
                                            '</tr > ';

                                    });

                                    $('#tableWeeklyReportx').append(trHTML);

                                    $(function () {


                                        $('#tableWeeklyReportx td').hover(function () {
                                            rIndex = this.parentElement.rowIndex;
                                            cIndex = this.cellIndex;
                                            if (rIndex != 0 & cIndex == 7) {
                                                $(this).css('cursor', 'pointer');
                                            }
                                        });


                                        var table = $('#tableWeeklyReportx');
                                        $('#tableWeeklyReportx td').click(function () {

                                            rIndex = this.parentElement.rowIndex;
                                            cIndex = this.cellIndex;

                                            if (rIndex != 0 & cIndex == 7) {
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



                                                var strVal0 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                                var strVal1 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                                var strVal2 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                                var strVal3 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                                var strVal4 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                                var strVal5 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                                var strVal6 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                                var strVal7 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                                var strVal8 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                                var strVal9 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                                var strVal11 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(11)');

                                                var strVal13 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                                var strVal14 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                                var strVal15 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                                var strVal16 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                                var strVal20 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(20)');
                                                var strVal21 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(21)');
                                                var strVal22 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(22)');
                                                var strVal23 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(23)');
                                                var strVal24 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(24)');

                                                //alert(strVal24.text());

                                                //document.getElementById("txtid").value = strVal0.text();
                                                $('#txtid').val(strVal0.text());
                                                $('#txtVisitDate').val(strVal1.text());
                                                $('#txtTime').val(strVal2.text());
                                                $('#txtCompanyName').val(strVal3.text());

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

                                                            $('#selectArchitectName').val(strVal4.text());
                                                            $('#selectArchitectName').change();

                                                            //selectArchitectNameDDL.text = strVal4.text();
                                                            //selectArchitectNameDDL.change();
                                                        });
                                                    }

                                                });

                                                $('#txtProjectName').val(strVal7.text());
                                                $('#txtLocation').val(strVal8.text());


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
                                                            $('#selectProductType').val(strVal9.text());
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
                                                                selectProductNameDDL.val(strVal11.text());
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
                                                            $('#selectStep').val(strVal24.text());
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
                                                                ProjectID: strVal6.text()
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


                                                $('#txtProfile').val(strVal13.text());
                                                $('#datedelivery').val(strVal14.text());
                                                $('#datefollowing').val(strVal15.text());
                                                $('#txtQuantity').val(strVal16.text());

                                                if (strVal24.text() == '1') {
                                                    $('#txtRefMcRf').val(strVal20.text());
                                                    $('#txtContactMcRf').val(strVal21.text());
                                                }
                                                else if (strVal24.text() == '2') {
                                                    $('#txtRefMcRf').val(strVal21.text());
                                                    $('#txtContactMcRf').val(strVal22.text());
                                                }
                                                else {
                                                    $('#txtRefMcRf').val(strVal22.text());
                                                    //$('#txtContactMcRf').val(strVal22.text());
                                                }



                                                $('#txtRemark').val(strVal23.text());


                                                $.ajax({
                                                    url: 'DataServicesReporting.asmx/GetDataProjectHistory',
                                                    method: 'post',
                                                    data: { ProjectID: strVal6.text() },
                                                    dataType: 'json',
                                                    success: function (data) {
                                                        var trHTML2 = '';
                                                        $('#tableHistory tr:not(:first)').remove();

                                                        $(data).each(function (index, item) {
                                                            trHTML2 += '<tr>' +
                                                                '<td class="">' + item.WeekDate + '</td>' +
                                                                '<td class="">' + item.WeekTime + '</td>' +
                                                                '<td class="">' + item.NextVisitDate + '</td>' +
                                                                '<td class="">' + item.TransNameEN + '</td>' +
                                                                '<td class="">' + item.StepNameEn + '</td>' +
                                                                '<td class="hidden">' + item.ProdTypeNameEN + '</td>' +
                                                                '<td class="">' + item.ProdNameEN + '</td>' +
                                                                '<td class="">' + item.BiddingName1 + '</td>' +
                                                                '<td class="">' + item.AwardMC + '</td>' +
                                                                '<td class="">' + item.AwardRF + '</td>' +
                                                                '<td class="">' + item.Quantity + '</td>' +
                                                                '<td class="">' + item.Remark + '</td>' +
                                                                '</tr > ';
                                                        });
                                                        $('#tableHistory').append(trHTML2);
                                                    }
                                                });



                                                setTimeout(function () {
                                                    $("#myModalEdit").modal({ backdrop: false });
                                                    $("#myModalEdit").modal("show");
                                                }, 1500);


                                            }


                                            //$('table tbody tr:not(:first)').on('click', function () {

                                            //    alert($(this).html()); // or .text()
                                            //});
                                        });

                                    });

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

                                //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                                var trHTML = '';
                                $('#tableWeeklyReportx tr:not(:first)').remove();
                                $(data).each(function (index, item) {
                                    trHTML += '<tr>' +
                                        '<td class="hidden">' + item.ID + '</td>' +
                                        '<td class="hidden">' + item.WeekDate + '</td>' +
                                        '<td class="hidden">' + item.WeekTime + '</td>' +
                                        '<td>' + item.CompanyName + '</td>' +
                                        '<td class="hidden">' + item.ArchitectID + '</td>' +
                                        '<td>' + item.Name + '</td>' +
                                        '<td class="hidden">' + item.ProjectID + '</td>' +
                                        '<td class="text-blue">' + item.ProjectName + '</td>' +
                                        '<td>' + item.Location + '</td>' +
                                        '<td class="hidden">' + item.ProdTypeID + '</td>' +
                                        '<td>' + item.ProdTypeNameEN + '</td>' +
                                        '<td class="hidden">' + item.ProdID + '</td>' +
                                        '<td>' + item.ProdNameEN + '</td>' +
                                        '<td>' + item.ProfNameEN + '</td>' +
                                        '<td>' + item.DeliveryDate + '</td>' +
                                        '<td>' + item.NextVisitDate + '</td>' +
                                        '<td>' + item.Quantity + '</td>' +
                                        '<td>' + item.StepNameA + '</td>' +
                                        '<td>' + item.StepNameB + '</td>' +
                                        '<td>' + item.RefWeekDate + '</td>' +
                                        '<td>' + item.Ref1 + '</td>' +
                                        '<td>' + item.Ref2 + '</td>' +
                                        '<td>' + item.Ref3 + '</td>' +
                                        '<td>' + item.RefRemark + '</td>' +
                                        '<td class="hidden">' + item.StepID + '</td>' +
                                        '</tr > ';

                                });

                                $('#tableWeeklyReportx').append(trHTML);

                                $(function () {


                                    $('#tableWeeklyReportx td').hover(function () {
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;
                                        if (rIndex != 0 & cIndex == 7) {
                                            $(this).css('cursor', 'pointer');
                                        }
                                    });


                                    var table = $('#tableWeeklyReportx');
                                    $('#tableWeeklyReportx td').click(function () {

                                        
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;

                                        if (rIndex != 0 & cIndex == 7) {
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


                                            var strVal0 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                            var strVal1 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                            var strVal2 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                            var strVal3 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                            var strVal4 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                            var strVal5 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                            var strVal6 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                            var strVal7 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                            var strVal8 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                            var strVal9 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                            var strVal11 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(11)');

                                            var strVal13 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                            var strVal14 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                            var strVal15 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                            var strVal16 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                            var strVal20 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(20)');
                                            var strVal21 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(21)');
                                            var strVal22 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(22)');
                                            var strVal23 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(23)');
                                            var strVal24 = $("#tableWeeklyReportx").find('tr:eq(' + rIndex + ')').find('td:eq(24)');

                                           
                                            document.getElementById("ProjectID").value = strVal6.text();

                                            $('#txtid').val(strVal0.text());
                                            $('#txtVisitDate').val(strVal1.text());
                                            $('#txtTime').val(strVal2.text());
                                            $('#txtCompanyName').val(strVal3.text());

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

                                                        $('#selectArchitectName').val(strVal4.text());
                                                        $('#selectArchitectName').change();

                                                        //selectArchitectNameDDL.text = strVal4.text();
                                                        //selectArchitectNameDDL.change();
                                                    });
                                                }

                                            });

                                            $('#txtProjectName').val(strVal7.text());
                                            $('#txtLocation').val(strVal8.text());


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
                                                        $('#selectProductType').val(strVal9.text());
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
                                                            selectProductNameDDL.val(strVal11.text());
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
                                                        $('#selectStep').val(strVal24.text());
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
                                                            ProjectID: strVal6.text()
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





                                            $('#txtProfile').val(strVal13.text());
                                            $('#datedelivery').val(strVal14.text());
                                            $('#datefollowing').val(strVal15.text());
                                            $('#txtQuantity').val(strVal16.text());

                                            if (strVal24.text() == '1') {
                                                $('#txtRefMcRf').val(strVal20.text());
                                                $('#txtContactMcRf').val(strVal21.text());
                                            }
                                            else if (strVal24.text() == '2') {
                                                $('#txtRefMcRf').val(strVal21.text());
                                                $('#txtContactMcRf').val(strVal22.text());
                                            }
                                            else {
                                                $('#txtRefMcRf').val(strVal22.text());
                                                //$('#txtContactMcRf').val(strVal22.text());
                                            }



                                            $('#txtRemark').val(strVal23.text());


                                            

                                            


                                            $.ajax({
                                                url: 'DataServicesReporting.asmx/GetDataProjectHistory',
                                                method: 'post',
                                                data: { ProjectID: strVal6.text() },
                                                dataType: 'json',
                                                success: function (data) {
                                                    var trHTML2 = '';
                                                    $('#tableHistory tr:not(:first)').remove();

                                                    $(data).each(function (index, item) {
                                                        trHTML2 += '<tr>' +
                                                            '<td class="">' + item.WeekDate + '</td>' +
                                                            '<td class="">' + item.WeekTime + '</td>' +
                                                            '<td class="">' + item.NextVisitDate + '</td>' +
                                                            '<td class="">' + item.TransNameEN + '</td>' +
                                                            '<td class="">' + item.StepNameEn + '</td>' +
                                                            '<td class="hidden">' + item.ProdTypeNameEN + '</td>' +
                                                            '<td class="">' + item.ProdNameEN + '</td>' +
                                                            '<td class="">' + item.BiddingName1 + '</td>' +
                                                            '<td class="">' + item.AwardMC + '</td>' +
                                                            '<td class="">' + item.AwardRF + '</td>' +
                                                            '<td class="">' + item.Quantity + '</td>' +
                                                            '<td class="">' + item.Remark + '</td>' +
                                                            '</tr > ';
                                                    });
                                                    $('#tableHistory').append(trHTML2);
                                                }
                                            });

                                            setTimeout(function () {
                                                $("#myModalEdit").modal({ backdrop: false });
                                                $("#myModalEdit").modal("show");
                                            }, 1500);


                                        }
                                    });

                                });

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



                

            })
        </script>

        <h1>Project Status
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
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
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
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
                                    <div class="txtLabel">
                                        <select id="selectReportOption" name="selectReportOption" class="form-control input-sm" style="width: 100%">
                                            <%--<%= strReportOption %>--%>
                                            <option value="R001">Design</option>
                                            <option value="R002">Bidding</option>
                                            <option value="R003">Award Main Cons</option>
                                            <option value="R006">Award Roll Formers</option>
                                            <option value="R004">Next Following</option>
                                            <option value="R005">On Delivery Date</option>
                                            <option value="R011">Design --> Bidding</option>
                                            <option value="R012">Bidding --> Award Main Cons</option>
                                            <option value="R013">Award Main Cons --> Award RF</option>
                                            <option value="R099">View all</option>
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
                                            <button type="button" id="alert" name="alert" class="btn btn-success btn-flat btn-block btn-sm " onclick="validateExcel();" ><i class="fa fa-file-excel-o"></i> Print Excel</button>

                                            <button id="btnDownloadExcel" runat="server" onserverclick="btnExportExcelOption_click" type="button" class="btn btn-success btn-flat btn-block btn-sm hidden" data-toggle="tooltip" title="Print Excel">
                                                <i class="fa fa-file-excel-o"></i> Print Excel</button>

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

                            <div id="divWeeklyReport">
                                <div class="row">
                                    <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <td class="hidden">ID</td>
                                                <td class="hidden">WeekDate</td>
                                                <td class="hidden">WeekTime</td>
                                                <td>CompanyName</td>
                                                <td class="hidden">ArchitectID</td>
                                                <td>Name</td>
                                                <td class="hidden">ProjectID</td>
                                                <td>ProjectName</td>
                                                <td>Location</td>
                                                <td class="hidden">ProdTypeID</td>
                                                <td>ProdType</td>
                                                <td>ProdID</td>
                                                <td class="hidden">ProdName</td>
                                                <td>Profile</td>
                                                <td>Delivery</td>
                                                <td>Following</td>
                                                <td>Quantity</td>
                                                <td>StepNameA</td>
                                                <td>StepNameB</td>
                                                <td>RefWeekDate</td>
                                                <td>BD</td>
                                                <td>MC</td>
                                                <td>RF</td>
                                                <td>RefRemark</td>
                                                <td class="hidden">StepID</td>
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

        <!-- /.modal myModalEdit -->
        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog"  style="width: 60%">
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
                                                <div class="col-md-4">
                                                    <div class="txtLabel">
                                                        <select id="selectStatus" name="selectStatus" class="form-control input-sm" style="width: 100%">
                                                        </select>
                                                    </div>
                                                    <div id="divErrorStatus" class="txtLabel text-red" style="display: none;">Please select at least one item..!</div>
                                                </div>

                                                <div class="col-md-1">
                                                    <label class="txtLabel">Ref#Doc.</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtRefDoc" name="txtRefDoc" style="color: white; text-transform: uppercase;" autocomplete="off" placeholder="" value="">
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


                                                    <table id="tableHistory" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <td class="">WeekDate</td>
                                                                <td class="">WeekTime</td>
                                                                <td class="">Following</td>
                                                                <td class="">TransName</td>
                                                                <td class="">StepName</td>
                                                                <td class="hidden">ProdType</td>
                                                                <td class="">ProdName</td>
                                                                <td class="">BiddingName</td>
                                                                <td class="">AwardMC</td>
                                                                <td class="">AwardRF</td>
                                                                <td class="">Quantity</td>
                                                                <td class="">Remark</td>
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
                var str19 =  document.getElementById("txtRefDoc").value;

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


                        if (str19 == '') {
                            //alert('Data is empty..');
                            Swal.fire('Reference invoice is do not empty..!');
                            return;

                        } else {
                            //alert('Data is ' + str19.toUpperCase());
                            //Swal.fire('Are you sure compare this project with invoice..? ' + str19.toUpperCase());
                            //check invoice from winspeed

                            $.ajax({
                                url: 'DataServicesSaleOnSpec.asmx/GetDataProjectWithInvoice',
                                method: 'post',
                                data: {
                                    strInvNo: str19
                                },
                                dataType: 'json',
                                success: function (data) {


                                },
                                error: function (data) {
                                     return;
                                }
                            })

                        }

                        return;

                        //Get update weekly report succeseed...
                        $.ajax({
                            url: 'DataServicesReporting.asmx/GetUpdateWeeklyReportViaSupervisor',
                            method: 'POST',
                            data: {
                                ID: str1,
                                WeekDate:  str2,
                                WeekTime:  str3,
                                CompanyName:  str4,
                                ArchitecID: $('#selectArchitectName').val(),
                                Name:  $('#selectArchitectName option:selected').text(),
                                Location:  str7,
                                ProdTypeID:  $('#selectProductType').val(),
                                ProdTypeNameEN:  $('#selectProductType option:selected').text(),
                                ProdID:  $('#selectProductName').val(),
                                ProdNameEN:  $('#selectProductName option:selected').text(),
                                ProfNameEN:  str10,
                                DeliveryDate:  str11,
                                NextVisitDate:  str12,
                                Quantity:  str13,
                                StepNameEn:  $('#selectStep option:selected').text(),
                                Ref1:  str16,
                                Ref2:  str17,
                                Remark:  str14,
                                StepID: $('#selectStep').val(),
                                StatusID: $('#selectStatus').val(),
                                ProjectID:  $('#ProjectID').val()
                            },
                            dataType: 'json',
                            complete: function (data) {
                               alert('Update data succeseed..!');
                            }
                        });

                         



                       <%--document.getElementById("<%= btnUpdateData.ClientID %>").click();--%>


                    }
                }
            }

        </script>

    </section>
</asp:Content>
