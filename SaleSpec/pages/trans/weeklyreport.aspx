<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="weeklyreport.aspx.cs" Inherits="SaleSpec.pages.trans.weeklyreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <script src="jquery-1.11.2.min.js"></script>
        <script>
            $(document).ready(function () {
                //declare variable 
                var datepickertrans = ('#datepickertrans');
                var selectCompanyDDL = $('#selectCompany');
                var selectArchitectDDL = $('#selectArchitect');
                var selectTransEntryDDL = $('#selectTransEntry');
                var selectArcCompanyDDL = $('#selectArcCompany');
                var selectArcPositionDDL = $('#selectArcPosition');
                var arcArchitecIDtxt = $('#arcArchitecID');
                var selectProjectStepDDL = $('#selectProjectStep');
                var selectProductTypeDDL = $('#selectProductType');
                var selectProductDDL = $('#selectProduct');
                var selectProfileDDL = $('#selectProfile');
                var selectStatusDDL = $('#selectStatus');
                var btnCompany = $('#btnCompany');
                var btnArchitect = $('#btnArchitect');

                selectCompanyDDL.prop('disabled', true);
                selectArchitectDDL.prop('disabled', true);
                selectTransEntryDDL.prop('disabled', true);
                btnCompany.prop('disabled', true);
                btnArchitect.prop('disabled', true);

                //Get data company from table
                $.ajax({
                    url: 'DataServices.asmx/GetDataCompany',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select Companies' }));
                        selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                        selectTransEntryDDL.append($('<option/>', { value: -1, text: 'Please select your transaction' }));
                        $(data).each(function (index, item) {
                            selectCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                        });
                    }
                });

                //Get data position from position table
                $.ajax({
                    url: 'DataServices.asmx/GetPositions',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectArcPositionDDL.append($('<option/>', { value: -1, text: 'Select Position' }));
                        $(data).each(function (index, item) {
                            selectArcPositionDDL.append($('<option/>', { value: item.PositionID, text: item.PositionNameEN }));
                        });
                    }
                });

                //Get data company from adcompany table for update architect
                $.ajax({
                    url: 'DataServices.asmx/GetDataCompany',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectArcCompanyDDL.append($('<option/>', { value: -1, text: 'Select Company' }));
                        $(data).each(function (index, item) {
                            selectArcCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                        });
                    }
                });

                //Get data step of sale spec project
                $.ajax({
                    url: 'DataServices.asmx/GetStepSpec',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectProjectStepDDL.append($('<option/>', { value: -1, text: 'Select project step' }));
                        $(data).each(function (index, item) {
                            selectProjectStepDDL.append($('<option/>', { value: item.StepID, text: item.StepNameEn }));
                        });
                    }
                });

                //Get Product type such as Ampelite, Ampelram
                $.ajax({
                    url: 'DataServices.asmx/GetProductType',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectProductTypeDDL.append($('<option/>', { value: -1, text: 'Select product type of project' }));
                        selectProductDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                        selectProductDDL.prop('disabled', true);
                        selectProfileDDL.prop('disabled', true);
                        $(data).each(function (index, item) {
                            selectProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                        });
                    }
                });

                //Get data profile of products
                $.ajax({
                    url: 'DataServices.asmx/GetProfile',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectProfileDDL.append($('<option/>', { value: -1, text: 'Select product profile' }));
                        $(data).each(function (index, item) {
                            selectProfileDDL.append($('<option/>', { value: item.ProfID, text: item.ProfNameEN }));
                        });
                    }
                });

                //Get project status
                $.ajax({
                    url: 'DataServices.asmx/GetStatus',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectStatusDDL.append($('<option/>', { value: -1, text: 'Select status' }));
                        $(data).each(function (index, item) {
                            selectStatusDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                        });
                    }
                });

                //When company select index change set cascading to architect
                selectCompanyDDL.change(function () {
                    if ($(this).val() == "-1") {
                        btnArchitect.prop('disabled', true);

                        selectArchitectDDL.empty();
                        selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                        selectArchitectDDL.val('-1');
                        selectArchitectDDL.prop('disabled', true);
                    }
                    else
                    {
                        btnArchitect.prop('disabled', false);

                        $.ajax({
                            url: 'DataServices.asmx/GetDataArchitect',
                            method: 'post',
                            data: {CompanyID: $(this).val()},
                            dataType: 'json',
                            success: function (data) {
                                selectArchitectDDL.empty();
                                selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                                selectArchitectDDL.prop('disabled', false);
                                $(data).each(function (index, item) {
                                    selectArchitectDDL.append($('<option/>', { value: item.ArchitecID, text: item.FullName }));
                                });
                            }
                        });
                    }
                });

                //When select architect changed enable trransaction options
                selectArchitectDDL.change(function () {
                    if ($(this).val() == '-1') {
                        selectTransEntryDDL.empty();
                        selectTransEntryDDL.append($('<option/>', { value: -1, text: 'Please select your transaction' }));
                        selectTransEntryDDL.val('-1');
                        selectTransEntryDDL.prop('disabled', true);
                    }
                    else
                    {
                        $.ajax({
                            url: 'DataServices.asmx/GetTransEntry',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectTransEntryDDL.empty();
                                selectTransEntryDDL.append($('<option/>', { value: -1, text: 'Please select your transaction' }));
                                selectTransEntryDDL.prop('disabled', false);
                                $(data).each(function (index, item) {
                                    selectTransEntryDDL.append($('<option/>', { value: item.TransID, text: item.TransNameEN }));
                                });
                            }
                        });
                    }
                });

                //When product type changed cascading of product
                selectProductTypeDDL.change(function () {
                    if ($(this).val() == "-1") {
                        selectProductDDL.empty();
                        selectProductDDL.append($('<option/>', { value: -1, text: "Please select product" }));
                        selectProductDDL.val('-1');
                        selectProductDDL.prop('disabled', true);
                        selectProfileDDL.prop('disabled', true);
                    } else {
                        $.ajax({
                            url: 'DataServices.asmx/GetProducts',
                            method: 'post',
                            data: {ProdTypeID: $(this).val()},
                            dataType: 'json',
                            success: function (data) {
                                selectProductDDL.prop('disabled', false);
                                selectProfileDDL.prop('disabled', false);
                                selectProductDDL.empty();
                                selectProductDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                                $(data).each(function (index, item) {
                                    selectProductDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                                });
                            }
                        });
                    }
                });

                //client click add new company insert into data to table
                var btnNewCompany = $('#btnNewCompany');
                var CompanyName = $('#CompanyName');
                btnNewCompany.click(function () {
                    if (CompanyName.val() == "") {
                        //todo something you coding
                    }
                    else {
                        $.ajax({
                            url: 'DataServices.asmx/GetInsertCompanies',
                            method: 'POST',
                            data: {
                                CompanyName: $('#CompanyName').val(),
                                CompanyName2: $('#CompanyName2').val(),
                                Address: $('#comAddress').val(),
                                ProvinceID: $('#ProvinceID').val(),
                                ContactName: $('#ContactPerson').val(),
                                Phone: $('#comPhone').val(),
                                Mobile: $('#comMobile').val(),
                                Email: $('#Email').val(),
                                StatusConID: "0"
                            },
                            dataType: 'json',
                            success: function (data) {
                            }
                        });
                        //alert message show successfully
                        alert("Data saved successfully");
                        $('#myModalCompany').modal('hide');

                        //clear all data input
                        $('#CompanyName').val('');
                        $('#CompanyName2').val('');
                        $('#comAddress').val('');
                        $('#ProvinceID').val('');
                        $('#ContactPerson').val('');
                        $('#comPhone').val('');
                        $('#comMobile').val('');
                        $('#Email').val('');

                        //calling function for refresh data update again
                        $.ajax({
                            url: 'DataServices.asmx/GetDataCompany',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select Companies' }));
                                selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                                $(data).each(function (index, item) {
                                    selectCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                                });
                            }
                        });

                        //calling function get company for add new architect
                        $.ajax({
                            url: 'DataServices.asmx/GetDataCompany',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectArcCompanyDDL.append($('<option/>', { value: -1, text: 'Select Companies' }));
                                $(data).each(function (index, item) {
                                    selectArcCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                                });
                            }
                        });
                    }
                });

                //client click add new architect insert into data to table
                var btnNewArchitect = $('#btnNewArchitect');
                btnNewArchitect.click(function () {
                    var arcFirstName = $('#arcFirstName');
                    var arcLastName = $('#arcLastName');
                    var selectArcCompany = $('#selectArcCompany');
                    var selectArcPosition = $('#selectArcPosition');
                    var arcPhone = $('#arcMobile');
                    var arcMobile = $('#arcMobile');
                    var arcEmail = $('#arcEmail');

                    //alert(arcFirstName.val() + ' ' + arcLastName.val() + ' ' + selectArcCompany.val());
                    if (arcFirstName.val() == '') {
                        alert('Please enter architect name..!');
                        arcFirstName.focus();
                        return;
                    } else if (arcLastName.val() == '') {
                        alert('Please enter architect surname..!');
                        arcLastName.focus();
                        return;
                    } else if (selectArcCompany.val() == "-1") {
                        alert('Please select company');
                        selectArcCompany.focus();
                        return;
                    } else if (selectArcPosition.val() == "-1") {
                        alert('Please select architect position');
                        selectArcPosition.focus();
                        return;
                    } else if (arcPhone.val() == '') {
                        alert('Please enter phone number..!');
                        arcPhone.focus();
                        return;
                    } else if (arcMobile.val() == '') {
                        alert('Please enter mobile number..!');
                        arcMobile.focus();
                        return;
                    } else if (arcEmail.val() == '') {
                        alert('Please enter contact email..!');
                        arcEmail.focus();
                        return;
                    } else {
                        //validate all passed into data to table

                        //Get last update running architect number
                        $.ajax({
                            url: 'DataServices.asmx/GetDataCountArchitect',
                            method: 'POST',
                            dataType: 'json',
                            success: function (data) {
                                var obj = jQuery.parseJSON(JSON.stringify(data));
                                if (obj != '') {
                                    $.each(obj, function (key, inval) {
                                        $("#arcArchitecID").val(inval["ArchitecID"]);

                                        //Get insert new architech
                                        $.ajax({
                                            url: 'DataServices.asmx/GetDataInsertArchitect',
                                            method: 'POST',
                                            data: {
                                                ArchitecID: $('#arcArchitecID').val(),
                                                CompanyID: $('#selectArcCompany').val(),
                                                Name: $('#arcFirstName').val() + ' ' + $('#arcLastName').val(),
                                                FirstName: $('#arcFirstName').val(),
                                                LastName: $('#arcLastName').val(),
                                                NickName: $('#arcNickName').val(),
                                                Position: $('#selectArcPosition').val(),
                                                Address: $('#arcAddress').val(),
                                                Phone: $('#arcPhone').val(),
                                                Mobile: $('#arcMobile').val(),
                                                Email: $('#arcEmail').val(),
                                                StatusConID: "0"
                                            },
                                            dataType: 'json',
                                            success: function (data) {

                                            }
                                        });

                                        /// to do here
                                        //alert(selectCompanyDDL.val());
                                        alert('Data saved successfully..!');

                                        $.ajax({
                                            url: 'DataServices.asmx/GetDataArchitect',
                                            method: 'post',
                                            data: { CompanyID: $('#selectArcCompany').val() },
                                            dataType: 'json',
                                            success: function (data) {
                                                selectArchitectDDL.empty();
                                                selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                                                $(data).each(function (index, item) {
                                                    selectArchitectDDL.append($('<option/>', { value: item.ArchitecID, text: item.FullName }));
                                                });
                                            }
                                        });

                                        $('#myModalArchitect').modal('hide');

                                        $('#arcArchitecID').val('');
                                        $('#selectArcCompany').val('0');
                                        $('#arcFirstName').val('');
                                        $('#arcLastName').val('');
                                        $('#arcNickName').val('');
                                        $('#selectArcPosition').val('0');
                                        $('#arcAddress').val('');
                                        $('#arcPhone').val('');
                                        $('#arcMobile').val('');
                                        $('#arcEmail').val('');
                                    });
                                }
                            }
                        });
                    }
                });

                //Validate option not allow when transaction date is empty
                $('#datepickertrans').change(function () {
                    //alert($('#datepickertrans').val());
                    var strval = $('#datepickertrans').val();
                    if (strval == '') {
                        btnCompany.prop('disabled', true);

                        selectCompanyDDL.empty();
                        selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select Companies' }));
                        selectCompanyDDL.prop('disabled', true);
                        selectArchitectDDL.empty();
                        selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                        selectArchitectDDL.prop('disabled', true);
                        selectTransEntryDDL.empty();
                        selectTransEntryDDL.append($('<option/>', { value: -1, text: 'Please select your transaction' }));
                        selectTransEntryDDL.prop('disabled', true);

                        document.getElementById("divNewProject").style.display = 'none';

                    } else {
                        btnCompany.prop('disabled', false);

                        $.ajax({
                            url: 'DataServices.asmx/GetDataCompany',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectCompanyDDL.empty();
                                selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select Companies' }));
                                selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                                selectCompanyDDL.prop('disabled', false);
                                $(data).each(function (index, item) {
                                    selectCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameEN }));
                                });
                            }
                        });
                    }
                });

                var btnSaveHistoryNewProject = $('#btnSaveHistoryNewProject');
                btnSaveHistoryNewProject.click(function () {
                    var chkValidate = 'false';
                    var ProjName = $('#ProjName');
                    var newLocation = $('#newLocation');
                    var selectProjectStep = $('#selectProjectStep');
                    var selectProduct = $('#selectProduct');
                    var selectProfile = $('#selectProfile');
                    var Quantity = $('#Quantity');
                    var datepickerdelivery = $('#datepickerdelivery');
                    var datevisit = $('#datevisit');
                    var selectStatus = $('#selectStatus');

                    if (ProjName.val() == '') {
                        document.getElementById("divErrorProjName").style.display = '';
                        document.getElementById("divErrorProjName").style.display = 'normal';
                        chkValidate = 'false';
                        return;
                    } else {
                        document.getElementById("divErrorProjName").style.display = '';
                        document.getElementById("divErrorProjName").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (newLocation.val() == '') {
                        document.getElementById("divErrorLocation").style.display = '';
                        document.getElementById("divErrorLocation").style.display = 'normal';
                        chkValidate = 'false';
                        return;
                    } else {
                        document.getElementById("divErrorLocation").style.display = '';
                        document.getElementById("divErrorLocation").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (selectProjectStep.val() == '-1') {
                        document.getElementById("divErrorProjectStep").style.display = '';
                        document.getElementById("divErrorProjectStep").style.display = 'normal';
                        chkValidate = 'false';
                        return;
                    } else {
                        document.getElementById("divErrorProjectStep").style.display = '';
                        document.getElementById("divErrorProjectStep").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (selectProduct.val() == '-1') {
                        document.getElementById("divErrorProduct").style.display = '';
                        document.getElementById("divErrorProduct").style.display = 'normal';
                        chkValidate = 'false';
                        return;
                        //alert(selectProduct.val());

                    } else {
                        document.getElementById("divErrorProduct").style.display = '';
                        document.getElementById("divErrorProduct").style.display = 'none';
                        chkValidate = 'true';
                        //alert(selectProduct.val());
                    }
                    
                    if (selectProfile.val() == '-1') {
                        document.getElementById("divErrorProfile").style.display = '';
                        document.getElementById("divErrorProfile").style.display = 'normal';
                        chkValidate = 'false';
                        return;

                    } else {
                        document.getElementById("divErrorProfile").style.display = '';
                        document.getElementById("divErrorProfile").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (Quantity.val() == '') {
                        document.getElementById("divErrorQuantity").style.display = '';
                        document.getElementById("divErrorQuantity").style.display = 'normal';
                        chkValidate = 'false';
                        return;

                    } else {
                        document.getElementById("divErrorQuantity").style.display = '';
                        document.getElementById("divErrorQuantity").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (datepickerdelivery.val() == '') {
                        document.getElementById("divErrorDeliveryDate").style.display = '';
                        document.getElementById("divErrorDeliveryDate").style.display = 'normal';
                        chkValidate = 'false';
                        return;

                    } else {
                        document.getElementById("divErrorDeliveryDate").style.display = '';
                        document.getElementById("divErrorDeliveryDate").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (datevisit.val() == '') {
                        document.getElementById("divErrorNextVisit").style.display = '';
                        document.getElementById("divErrorNextVisit").style.display = 'normal';
                        chkValidate = 'false';
                        return;

                    } else {
                        document.getElementById("divErrorNextVisit").style.display = '';
                        document.getElementById("divErrorNextVisit").style.display = 'none';
                        chkValidate = 'true';
                    }

                    if (selectStatus.val() == '-1') {
                        document.getElementById("divErrorStatus").style.display = '';
                        document.getElementById("divErrorStatus").style.display = 'normal';
                        chkValidate = 'false';
                        return;

                    } else {
                        document.getElementById("divErrorStatus").style.display = '';
                        document.getElementById("divErrorStatus").style.display = 'none';
                        chkValidate = 'true';
                    }


                    if (chkValidate == 'true') {
                        alert($('#selectCompany option:selected').text());
                        //to do save weekly report option new Projects
                        // $.ajax({
                        //    url: 'DataServices.asmx/GetCountProject',
                        //    method: 'POST',
                        //    dataType: 'json',
                        //    success: function (data) {
                        //        var obj = jQuery.parseJSON(JSON.stringify(data));
                        //        if (obj != '') {
                        //            $.each(obj, function (key, inval) {
                        //                $("#ProjectID").val(inval["ProjectID"]);

                        //                //Get insert new architech
                        //                $.ajax({
                        //                    url: 'DataServices.asmx/GetInsertWeeklyReport',
                        //                    method: 'POST',
                        //                    data: {
                        //                        WeekDate: $('#datepickertrans').val(),
                        //                        WeekTime: $('#inputtime').val(),
                        //                        CompanyID: $('#selectCompany').val(),
                        //                        CompanyName: $('#selectCompany option:selected').text(),
                        //                        ArchitecID: $('#').val(),
                        //                        Name: $('#').val(),
                        //                        TransID: $('#').val(),
                        //                        TransNameEN: $('#').val(),
                        //                        ProjectID: $('#').val(),
                        //                        ProjectName: $('#').val(),
                        //                        Location: $('#').val(),
                        //                        StepID: $('#').val(),
                        //                        StepNameEn: $('#').val(),
                        //                        BiddingName1: $('#').val(),
                        //                        OwnerName1: $('#').val(),
                        //                        BiddingName2: $('#').val(),
                        //                        OwnerName2: $('#').val(),
                        //                        BiddingName3: $('#').val(),
                        //                        OwnerName3: $('#').val(),
                        //                        AwardMC: $('#').val(),
                        //                        ContactMC: $('#').val(),
                        //                        AwardRF: $('#').val(),
                        //                        ContactRF: $('#').val(),
                        //                        ProdTypeID: $('#').val(),
                        //                        ProdTypeNameEN: $('#').val(),
                        //                        ProdID: $('#').val(),
                        //                        ProdNameEN: $('#').val(),
                        //                        Quantity: $('#').val(),
                        //                        DeliveryDate: $('#').val(),
                        //                        NextVisitDate: $('#').val(),
                        //                        StatusID: $('#').val(),
                        //                        StatusNameEn: $('#').val(),
                        //                        NewArchitect: $('#').val(),
                        //                        HaveFiles: $('#').val(),
                        //                        FileName: $('#').val(),
                        //                        Remark: $('#').val(),
                        //                        UserID: $('#').val(),
                        //                        EmpCode: $('#').val(),
                        //                        CreatedBy: $('#').val(),
                        //                        CreatedDate: $('#').val()
                        //                    },
                        //                    dataType: 'json',
                        //                    success: function (data) {

                        //                    }
                        //                });

                        //                /// to do here
                        //                alert('Data saved successfully..!');

                        //            });
                        //        }
                        //    }
                        //});


                    } else {
                        alert('Warnning, The data is not completed please check..!');
                    }
                });





            });
        </script>
    
    <style>
        .select2-container .select2-selection--multiple {
            font-family: 'Arial', Verdana;
            font-size: 12px;
            box-sizing: border-box;
            display: block;
            height: 27px;
        }

        #rcorners1 {
            border-radius: 10px;
            border: 1px solid #73AD21;
            padding: 20px 0 20px 0;
        }

        #rcorners12 {
            border-radius: 0 0 10px 10px;
            background: #e2f7c4;
            border: 1px solid #73AD21;
            padding: 20px 0 20px 0;
        }

         #rcorners13 {
            border-radius: 0 0 10px 10px;
            background: #e2f7c4;
            border: 1px solid #73AD21;
            padding: 20px 0 20px 0;
        }

         #rcorners14 {
            border-radius: 0 0 10px 10px;
            background: #e2f7c4;
            border: 1px solid #73AD21;
            padding: 20px 0 20px 0;
        }

          #rcorners2 {
            border-radius: 10px;
            border: 1px solid #339eeb;
            padding: 20px 0 20px 0;
        }

        #rcorners21 {
            border-radius: 0 0 10px 10px;
            background: #d4ebfc;
            border: 1px solid #339eeb;
            padding: 20px 0 20px 0;
        }

         #rcorners22 {
            border-radius: 0 0 10px 10px;
            background: #d4ebfc;
            border: 1px solid #339eeb;
            padding: 20px 0 20px 0;
        }

         #rcorners23 {
            border-radius: 0 0 10px 10px;
            background: #d4ebfc;
            border: 1px solid #339eeb;
            padding: 20px 0 20px 0;
        }
    </style>

    <!-- Header content -->
    <section class="content-header">
        <h1>Weekly Report
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <%--   <%= strMsgAlert %>--%>

        <%-- Application Forms--%>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">

                        <div class="box-body">
                            <div class="post clearfix">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Weekly Report</a>
                                    </span>
                                    <span class="description">Details for weekly report</span>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 col-md-offset-2">
                                        <label class="txtLabel">Visit Date</label>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickertrans" value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="bootstrap-timepicker">
                                            <div class="input-group">
                                                <label class="txtLabel">StartTime</label>
                                                <div class="input-group">
                                                    <input type="text" id="inputtime" class="form-control input-sm timepicker txtLabel">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-6 col-md-offset-2">
                                        <label class="txtLabel">Company</label>
                                        <div class="input-group col-md-12">
                                            <span class="txtLabel">
                                                <select id="selectCompany" class="form-control input input-sm " style="width: 100%;">
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-1 input-group">
                                        <label class="txtLabel">Company</label>
                                        <div class="">
                                            <button type="button" class="btn btn-info btn-block btn-flat btn-sm" id="btnCompany" onclick="openCompany()">New</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-6 col-md-offset-2">
                                        <label class="txtLabel">Architect</label>
                                        <div class="input-group col-md-12">
                                            <span class="txtLabel">
                                                <select id="selectArchitect" class="form-control input input-sm " style="width: 100%;">
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-1 input-group">
                                        <label class="txtLabel">Architect</label>
                                        <div class="">
                                            <button type="button" class="btn btn-info btn-block btn-flat btn-sm" id="btnArchitect" onclick="openArchitect()">New</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-6 col-md-offset-2">
                                        <label class="txtLabel">What do you do...</label>
                                        <div class="input-group col-md-12">
                                            <span class="txtLabel">
                                                <select id="selectTransEntry" onchange="getTransEntry(this)" class="form-control input input-sm " style="width: 100%;">
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-1 input-group hidden">
                                        <label class="txtLabel">Entry</label>
                                        <div class="">
                                            <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">Entry</button>
                                        </div>
                                    </div>
                                </div>

                                <hr />

                                <div id="divNewProject" style="display: none;">
                                    <div id="rcorners1">
                                        <div class="row hidden" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">ProjectID</label>
                                                <div class="input-group col-md-12">
                                                    <input type="text" class="form-control input-sm txtLabel" id="ProjectID" name="ProjectID">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">New Project</label>
                                                <div class="input-group col-md-12">
                                                    <input type="text" class="form-control input-sm txtLabel" id="ProjName" name="ProjName">
                                                </div>
                                                <div id="divErrorProjName" class="txtLabel text-red" style="display: none;">Project name is not empty...!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Locations</label>
                                                <div class="">
                                                    <textarea cols="40" rows="2" class="form-control input-sm txtLabel" id="newLocation" name="newLocation"></textarea>
                                                </div>
                                                <div id="divErrorLocation" class="txtLabel text-red" style="display: none;">Let's them know where is project locations..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Step</label>
                                                <div class="txtLabel">
                                                    <select id="selectProjectStep" name="selectProjectStep" onchange="getProjectStep(this)" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorProjectStep" class="txtLabel text-red" style="display: none;">The project steps should be progressive ..!</div>
                                            </div>

                                            <div class="col-md-1 input-group hidden">
                                                <label class="txtLabel">View</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divBidding" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners12">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.1</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="biddingname1" name="biddingname1" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="owner1" name="owner1" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.2</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="biddingname2" name="biddingname2" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="owner2" name="owner2" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.3</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="biddingname3" name="biddingname3" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="owner3" name="owner3" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divAwardMC" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners13">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Award Main Cons(MC)</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="awardmc" name="awardmc" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Contact</label>
                                                            <div class="input-group">
                                                                <input type="text" id="contactmc" name="contactmc" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divAwardRF" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners14">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Award Roll Forming(RF)</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="awardrf" name="awardrf" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Contact</label>
                                                            <div class="input-group">
                                                                <input type="text" id="contactrf" name="contactrf" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Product Type</label>
                                                <div class="txtLabel">
                                                    <select id="selectProductType" onchange="getComboA(this)" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-1 input-group hidden">
                                                <label class="txtLabel">View</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Product</label>
                                                <div class="txtLabel">
                                                    <%--<input type="text" class="form-control input-sm" />--%>
                                                    <select id="selectProduct" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorProduct" class="txtLabel text-red" style="display: none;">Should choose at least 1 product of the project ..!</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Profile</label>
                                                <div class="txtLabel">
                                                    <select id="selectProfile" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorProfile" class="txtLabel text-red" style="display: none;">Should choose at least 1 profile of the project ..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Quantity</label>
                                                <div class="txtLabel">
                                                    <input type="text" id="Quantity" name="Quantity" autocomplete="off" class="form-control input-sm txtLabel" />
                                                </div>
                                                <div id="divErrorQuantity" class="txtLabel text-red" style="display: none;">Did you know quantity used of project..?</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Delivery Date</label>
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdelivery" value="" autocomplete="off">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                                <div id="divErrorDeliveryDate" class="txtLabel text-red" style="display: none;">Please specify the delivery date..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Next Visit</label>
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="datevisit" value="" autocomplete="off">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                                <div id="divErrorNextVisit" class="txtLabel text-red" style="display: none;">Please specify the next visit date..!</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Status</label>
                                                <div class="txtLabel">
                                                    <select id="selectStatus" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorStatus" class="txtLabel text-red" style="display: none;">Please select status..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Details</label>
                                                <div class="">
                                                    <%--<input type="text" class="form-control input-sm" />--%>
                                                    <textarea id="detail1" cols="40" rows="2" class="form-control input-sm txtLabel"></textarea>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-2 col-md-offset-2">
                                                <label class="txtLabel">Save Entry</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryNewProject">Save Entry</button>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <label class="txtLabel">Add New Product</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryNewProduct">Save New Product</button>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <label class="txtLabel">Start New Entry</label>
                                                <div class="">
                                                    <a href="weeklyreport?opt=wkr" class="btn btn-info btn-flat btn-block btn-sm">New Entry</a>
                                                    <%--<button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryNewProduct">Save Entry</button>--%>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div id="divUpdate" style="display: none;">
                                    <div id="rcorners2">
                                        <div class="row hidden" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">ProjectID</label>
                                                <div class="input-group col-md-12">
                                                    <input type="text" class="form-control input-sm txtLabel" id="upProjectID" name="upProjectID">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Update Project</label>
                                               <%-- <div class="input-group col-md-12">
                                                    <input type="text" class="form-control input-sm txtLabel" id="upProjName" name="upProjName">
                                                </div>--%>
                                                <div class="txtLabel">
                                                    <select id="selectupProject" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProjName" class="txtLabel text-red" style="display: none;">Project name is not empty...!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Locations</label>
                                                <div class="">
                                                    <textarea cols="40" rows="2" class="form-control input-sm txtLabel" id="upLocation" name="upLocation"></textarea>
                                                </div>
                                                <div id="divErrorupLocation" class="txtLabel text-red" style="display: none;">Let's them know where is project locations..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Step</label>
                                                <div class="txtLabel">
                                                    <select id="selectupProjectStep" name="selectProjectStep" onchange="getProjectStep(this)" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProjectStep" class="txtLabel text-red" style="display: none;">The project steps should be progressive ..!</div>
                                            </div>

                                            <div class="col-md-1 input-group hidden">
                                                <label class="txtLabel">View</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divupBidding" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners22">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.1</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="upbiddingname1" name="upbiddingname1" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="upowner1" name="upowner1" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.2</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="upbiddingname2" name="upbiddingname2" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="upowner2" name="upowner2" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.3</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="upbiddingname3" name="upbiddingname3" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="upowner3" name="upowner3" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divupAwardMC" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners23">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Award Main Cons(MC)</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="upawardmc" name="upawardmc" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Contact</label>
                                                            <div class="input-group">
                                                                <input type="text" id="upcontactmc" name="upcontactmc" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divupAwardRF" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners24">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Award Roll Forming(RF)</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="upawardrf" name="upawardrf" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Contact</label>
                                                            <div class="input-group">
                                                                <input type="text" id="upcontactrf" name="upcontactrf" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Product Type</label>
                                                <div class="txtLabel">
                                                    <select id="selectupProductType" onchange="getComboA(this)" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-1 input-group hidden">
                                                <label class="txtLabel">View</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Product</label>
                                                <div class="txtLabel">
                                                    <%--<input type="text" class="form-control input-sm" />--%>
                                                    <select id="selectupProduct" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProduct" class="txtLabel text-red" style="display: none;">Should choose at least 1 product of the project ..!</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Profile</label>
                                                <div class="txtLabel">
                                                    <select id="selectupProfile" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProfile" class="txtLabel text-red" style="display: none;">Should choose at least 1 profile of the project ..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Quantity</label>
                                                <div class="txtLabel">
                                                    <input type="text" id="upQuantity" name="upQuantity" autocomplete="off" class="form-control input-sm txtLabel" />
                                                </div>
                                                <div id="divErrorupQuantity" class="txtLabel text-red" style="display: none;">Did you know quantity used of project..?</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Delivery Date</label>
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="updatepickerdelivery" value="" autocomplete="off">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                                <div id="divErrorupDeliveryDate" class="txtLabel text-red" style="display: none;">Please specify the delivery date..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Next Visit</label>
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-sm pull-left txtLabel" id="updatevisit" value="" autocomplete="off">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                                <div id="divErrorupNextVisit" class="txtLabel text-red" style="display: none;">Please specify the next visit date..!</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Status</label>
                                                <div class="txtLabel">
                                                    <select id="selectupStatus" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupStatus" class="txtLabel text-red" style="display: none;">Please select status..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Details</label>
                                                <div class="">
                                                    <%--<input type="text" class="form-control input-sm" />--%>
                                                    <textarea id="updetail1" cols="40" rows="2" class="form-control input-sm txtLabel"></textarea>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-2 col-md-offset-2">
                                                <label class="txtLabel">Save Entry</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryupProject">Save Entry</button>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <label class="txtLabel">Add New Product</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryupProduct">Save New Product</button>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <label class="txtLabel">Start New Entry</label>
                                                <div class="">
                                                    <a href="weeklyreport?opt=wkr" class="btn btn-info btn-flat btn-block btn-sm">New Entry</a>
                                                    <%--<button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryNewProduct">Save Entry</button>--%>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div id="divNewArchitect" style="display: none;">
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">New Architect</label>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control input-sm">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Details</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="inputreason" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="divSpecIntake" style="display: none;">
                                    <div class="row" style="margin-top: 5px;">
                                     <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Project Name</label>
                                                <div class="txtLabel">
                                                    <select id="selectIntakeProject" name="selectIntakeProject" onchange="getProjectStep(this)" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorIntakeProject" class="txtLabel text-red" style="display: none;">The project steps should be progressive ..!</div>
                                            </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Status</label>
                                            <div class="txtLabel">
                                                <select id="selectIntakeStatus" class="form-control input-sm" style="width: 100%">
                                                </select>
                                            </div>
                                            <div id="divErrorIntakeStatus" class="txtLabel text-red" style="display: none;">Please select status..!</div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2 col-md-offset-2">
                                            <div class="radio txtLabel">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                                    มีไฟล์เอกสารแนบ
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 ">
                                            <div class="radio txtLabel">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                                    ไม่มีไฟล์แนบ
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 ">
                                            <%--<button class="btn btn-info btn-block btn-flat btn-sm">Browse</button>--%>
                                            <input class="btn btn-info btn-block btn-flat btn-sm" type="file" id="exampleInputFile">
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <table id="tableAttach" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Descript</th>
                                                        <th>Details</th>
                                                        <th>#</th>
                                                        <th>#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>1</td>
                                                        <td>document support no.1</td>
                                                        <td>Details document support no.1</td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td>document support no.2</td>
                                                        <td>Details document support no.2</td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></td>
                                                    </tr>
                                                    <tr>
                                                        <td>3</td>
                                                        <td>document support no.3</td>
                                                        <td>Details document support no.3</td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Details</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="Details3" cols="40" rows="2" class="form-control input-sm txtLabel"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="divOther" style="display: none;">
                                    
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Details</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="dettail4" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="post clearfix hidden">
                                    <div class="user-block">
                                        <img class="img-circle img-bordered-sm" src="../../dist/img/document.png" alt="User Image">
                                        <span class="username">
                                            <a href="#">Visit History</a>
                                            <div class="btn-group pull-right ">
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel" runat="server"><i class="fa fa-print"></i></button>
                                            </div>
                                        </span>
                                        <span class="description">Please attach your document support</span>
                                    </div>
                                    <!-- /.user-block -->

                                    <div class="container-fluid">
                                        <table id="tableDetails" class="table table-bordered table-striped table-hover table-condensed">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Time</th>
                                                    <th>Copany</th>
                                                    <th>Architect</th>
                                                    <th>Project</th>
                                                    <th>Contact</th>
                                                    <th>Mobile</th>
                                                    <th>Reason</th>
                                                    <th>Updated</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>2018-12-25</td>
                                                    <td>10:00</td>
                                                    <td>Planet Studio Co.,Ltd.</td>
                                                    <td>Amornrat	Eursirirattanaphisan</td>
                                                    <td>ปรับปรุงอาคาร บจก.ปัจจพล ไฟเบอร์</td>
                                                    <td>K.Somchai</td>
                                                    <td>0899999959</td>
                                                    <td>Make Relationship</td>
                                                    <td>2018-12-28 09:45:25 AM
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>2018-12-28</td>
                                                    <td>14:00</td>
                                                    <td>Planet Studio Co.,Ltd.</td>
                                                    <td>Amornrat	Eursirirattanaphisan</td>
                                                    <td>คลังสินค้า บ.หาดทิพย์</td>
                                                    <td>K.Somchai</td>
                                                    <td>0899999959</td>
                                                    <td>Make Relationship</td>
                                                    <td>2018-12-18 11:49:15 AM
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>2019-01-10</td>
                                                    <td>09:00</td>
                                                    <td>Planet Studio Co.,Ltd.</td>
                                                    <td>Amornrat	Eursirirattanaphisan</td>
                                                    <td>รถไฟฟ้าความเร็วสูง หัวหิน</td>
                                                    <td>K.Somchai</td>
                                                    <td>0899999959</td>
                                                    <td>Make Relationship</td>
                                                    <td>2018-12-15 11:30:20 AM
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>2019-01-15</td>
                                                    <td>11:00</td>
                                                    <td>Amornrat	Eursirirattanaphisan</td>
                                                    <td>Planet Studio Co.,Ltd.</td>
                                                    <td>กาฬสินธุ์</td>
                                                    <td>K.Somchai</td>
                                                    <td>0899999959</td>
                                                    <td>Make Relationship</td>
                                                    <td>2018-12-10 08:30:30 AM
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <br />
                                </div>

                                <div class="row hidden">
                                    <div class="col-md-4 col-md-offset-4">
                                        <div class="form-group">
                                            <label class="txtLabel">Please select a transaction</label>
                                            <span class="txtLabel">
                                                <select id="selectTrans" name="selectTrans" runat="server" class="form-control select2 " style="width: 100%">
                                                    <option value="" selected>Please select a item..</option>
                                                    <option value="0">New Project</option>
                                                    <option value="1">Update Project Status</option>
                                                    <option value="2">New Architect</option>
                                                    <option value="3">Event Update</option>
                                                    <option value="4">Weekly Report</option>
                                                </select>
                                            </span>
                                        </div>
                                        <div class="form-group">
                                            <input type="button" name="btnSelect" id="btnSelect" class="btn btn-primary btn-flat btn-block" value="Click to Go..!" runat="server" onserverclick="btnSelect_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- /.modal myModalCompany -->
            <div class="modal modal-default fade" id="myModalCompany">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">New Company</h4>
                        </div>

                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4">CompanyID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="CompanyID" name="CompanyID" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">CompanyNameTH</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="CompanyName" name="CompanyName" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">CompanyNameEN</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="CompanyName2" name="CompanyName2" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">Address</div>
                                    <div class="col-md-8">
                                        <textarea cols="40" rows="3" id="comAddress" name="comAddress" class="form-control input input-sm"></textarea>
                                        <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">ProvinceID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="ProvinceID" name="ProvinceID" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">ContactPerson</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="ContactPerson" name="ContactPerson" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">Phone</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="comPhone" name="comPhone" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                 <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">Mobile</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="comMobile" name="comMobile" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4">Email</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm" id="Email" name="Email" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <%--<button type="submit" id="btnSubmitNew" class="btn btn-primary hidden" onclick="ValidateSave()">Save Changes</button>
                            <button type="button" class="btn btn-primary " id="btnSaveNewData" runat="server">Save Changes</button>--%>
                            <button type="submit" id="btnNewCompany" class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- /.modal myModalArchitect -->
            <div class="modal modal-default fade" id="myModalArchitect">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">New Architect</h4>
                        </div>

                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Architect ID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcArchitecID" name="arcArchitecID" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">FirstName</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcFirstName" name="arcFirstName" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">LastName</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcLastName" name="arcLastName" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Company</div>
                                    <div class="col-md-8">
                                        <span class="txtLabel">
                                            <select id="selectArcCompany" class="form-control input input-sm " style="width: 100%;">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">NickName</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcNickName" name="arcNickName" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Position</div>
                                    <div class="col-md-8">
                                        <span class="txtLabel">
                                            <select id="selectArcPosition" class="form-control input input-sm " style="width: 100%;">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Address</div>
                                    <div class="col-md-8">
                                        <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="arcAddress" name="arcAddress"></textarea>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Phone</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcPhone" name="arcPhone" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Mobile</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcMobile" name="arcMobile" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Email</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="arcEmail" name="arcEmail" placeholder="" value="" required>
                                    </div>
                                </div>


                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <%--<button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                            <button type="button" class="btn btn-primary hidden" id="Button2" runat="server">Save Changes</button>--%>
                            <button type="button" id="btnNewArchitect" class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- /.modal myModalProject -->
            <div class="modal modal-default fade" id="myModalProject">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">New Project</h4>
                        </div>

                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="projectID" name="projectID" placeholder="" value="" readonly required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProjectName</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="projectName" name="projectName" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">CompanyName</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="projCompanyName" name="projCompanyName" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Location</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="Location" name="Location" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProductGroup</div>
                                    <div class="col-md-8">
                                        <span class="txtLabel">
                                            <select class="form-control input-sm" style="width: 100%;">
                                                <option value="01">Sealex Duragel</option>
                                                <option value="02">Cool Lite</option>
                                                <option value="03">WonderCOOL IR</option>
                                                <option value="04">Sealex Duragel</option>
                                                <option value="05">Sealex Duragel</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">ProductCategory</div>
                                    <div class="col-md-8">
                                        <span class="txtLabel input-xs">
                                            <select id="selectCategory" class="form-control input-small" style="width: 100%;">
                                                <option value="01">PF0001 AC Louvre</option>
                                                <option value="01">PF0002 Ajiya Mega Rib 35</option>
                                                <option value="01">PF0003 AR 364</option>
                                                <option value="01">PF0004 AS 760</option>
                                                <option value="01">PF0005 AS 780-56</option>
                                                <option value="01">PF0006 BBC-750</option>
                                                <option value="01">PF0007 BBC-800</option>
                                                <option value="01">PF0008 BBC-940</option>
                                                <option value="01">PF0009 BBC-U760</option>
                                                <option value="01">PF0010 BBC-U760 (SW)</option>
                                                <option value="01">PF0011 BK 1000</option>
                                                <option value="01">PF0012 BK 760 A</option>
                                                <option value="01">PF0013 BK 762</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Quantity</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input input-sm txtLabel" id="quantity" name="quantity" placeholder="" value="" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel">Remark</div>
                                    <div class="col-md-8">
                                        <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                        <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="Remark" name="Remark"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                            <button type="button" class="btn btn-primary hidden" id="Button3" runat="server">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>

            </div>  

        <script>

                function getTransEntry(trans) {
                    var t = trans.value;

                    var div1 = document.getElementById("divNewProject");
                    var div2 = document.getElementById("divUpdate");
                    var div3 = document.getElementById("divNewArchitect");
                    var div4 = document.getElementById("divSpecIntake");
                    var div5 = document.getElementById("divOther");
                    
                    if (t == "1") { div1.style.display = "block"; } else { div1.style.display = "none"; }
                    if (t == "2") { div2.style.display = "block"; } else { div2.style.display = "none"; }
                    if (t == "3") { div3.style.display = "block"; } else { div3.style.display = "none"; }
                    if (t == "4") { div4.style.display = "block"; } else { div4.style.display = "none"; }
                    if (t == "5") { div5.style.display = "block"; } else { div5.style.display = "none"; }
                }

                function getProjectStep(step) {
                    var s = step.value;

                    var dv1 = document.getElementById("divBidding");
                    var dv2 = document.getElementById("divAwardMC");
                    var dv3 = document.getElementById("divAwardRF");

                    if (s == "1") { dv1.style.display = "block"; } else { dv1.style.display = "none"; }
                    if (s == "2") { dv2.style.display = "block"; } else { dv2.style.display = "none"; }
                    if (s == "3") { dv3.style.display = "block"; } else { dv3.style.display = "none"; }
                    //alert(s);
                }

                function getUpdateProjectStep(step) {
                    var s = step.value;

                    var dv1 = document.getElementById("divUpdateBidding");
                    var dv2 = document.getElementById("divUpdateAwardMC");
                    var dv3 = document.getElementById("divUpdateAwardRF");

                    if (s == "1") { dv1.style.display = "block"; } else { dv1.style.display = "none"; }
                    if (s == "2") { dv2.style.display = "block"; } else { dv2.style.display = "none"; }
                    if (s == "3") { dv3.style.display = "block"; } else { dv3.style.display = "none"; }
                }


                function getComboA(sel) {
                    var value = sel.value;
                    //alert(value);


                }


                function myFunction() {

                    var s = document.getElementById("selectTransEntry");
                    var div1 = document.getElementById("divNewProject");
                    var div2 = document.getElementById("divUpdate");
                    var div3 = document.getElementById("divNewArchitect");
                    var div4 = document.getElementById("divSpecIntake");
                    var div5 = document.getElementById("divOther");

                    //if (x.style.display === "none") {
                    //    x.style.display = "block";
                    //} else {
                    //    x.style.display = "none";
                    //}

                    //alert(s.value);

                    if (s.value == "1") { div1.style.display = "block"; } else { div1.style.display = "none"; }
                    if (s.value == "2") { div2.style.display = "block"; } else { div2.style.display = "none"; }
                    if (s.value == "3") { div3.style.display = "block"; } else { div3.style.display = "none"; }
                    if (s.value == "4") { div4.style.display = "block"; } else { div4.style.display = "none"; }
                    if (s.value == "5") { div5.style.display = "block"; } else { div5.style.display = "none"; }

                }

                function onChangeClick() {
                    document.getElementById("button").click();
                }

                function openCompany() {

                    $("#myModalCompany").modal({ backdrop: false });
                    $('[id=myModalCompany]').modal('show');
                }

                function openArchitect() {

                    $("#myModalArchitect").modal({ backdrop: false });
                    $('[id=myModalArchitect]').modal('show');
                }

                function openProject() {

                    $("#myModalProject").modal({ backdrop: false });
                    $('[id=myModalProject]').modal('show');
                }

                function ShowModalWindow() {
                    // true to refresh the parent after popup closed
                    RefreshParent(false);
                    window.showModalDialog("www.google.com", "",
                        "dialogHeight:600px;dialogWidth:990px;resizable:no;status:no;");
                    return false;
                }

                function CloseWindow() {
                    if (confirm("Are you sure do you want to delete..?")) {
                        close();
                    }
                }


                function popupwindow(url, title, w, h) {
                    var left = (screen.width / 2) - (w / 2);
                    var top = (screen.height / 2) - (h / 2);
                    var param = '?id=001&sr=es5';
                    var url2 = url + param;
                    return window.open(url2, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
                }
            </script>


        
    </section>
</asp:Content>
