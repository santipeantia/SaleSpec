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

            var selectUpdteProjectDDL = $('#selectUpdteProject');
            var selectupdateProjectStepDDL = $('#selectupdateProjectStep');
            var selectUpdateProductTypeDDL = $('#selectUpdateProductType');
            var selectUpdateProductDDL = $('#selectUpdateProduct');
            var selectUpdateProfileDDL = $('#selectUpdateProfile');
            var updateQuantity = $('#updateQuantity');
            var updatepickerdelivery = $('#updatepickerdelivery');
            var updatevisit = $('#updatevisit');
            var selectUpdateStatusDDL = $('#selectUpdateStatus');
            var updatedetail = $('#updatedetail');

            //var selecttimeDDL = $('#selecttime');

            var selectPortDDL = $('#selectPort');
            var userid0 = '<%= Session["UserID"]%>';

            var userid= userid0;

            $.ajax({
                url: 'DataServices.asmx/GetSpecPort',
                method: 'post',
                data: {
                    TypeID: userid
                },
                dataType: 'json',
                success: function (data) {
                    selectPortDDL.empty();
                    $(data).each(function (index, item) {
                        selectPortDDL.append($('<option/>', { value: item.SpecID, text: item.FullName }));
                    });
                }
            });


            selectCompanyDDL.prop('disabled', true);
            selectArchitectDDL.prop('disabled', true);
            selectTransEntryDDL.prop('disabled', true);
            btnCompany.prop('disabled', true);
            btnArchitect.prop('disabled', true);


            $('#updateLocation').prop('disabled', true);
            $('#selectUpdateTurnKey').prop('disabled', true);
            $('#updateProfile').prop('disabled', true);

            $('#selectupdateProjectStep').prop('disabled', true);
            selectUpdateProductTypeDDL.prop('disabled', true);
            selectUpdateProductDDL.prop('disabled', true);
            selectUpdateProfileDDL.prop('disabled', true);
            updateQuantity.prop('disabled', true);
            updatepickerdelivery.prop('disabled', true);
            updatevisit.prop('disabled', true);
            selectUpdateStatusDDL.prop('disabled', true);
            updatedetail.prop('disabled', true);


            //Get data company from table
            $.ajax({
                url: 'DataServices.asmx/GetDataCompany',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select Companies' }));
                    selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                    selectTransEntryDDL.append($('<option/>', { value: -1, text: 'Please select your transaction' }));
                    selectupdateProjectStepDDL.append($('<option/>', { value: -1, text: 'Please select project step' }));
                    selectUpdateProductTypeDDL.append($('<option/>', { value: -1, text: 'Please select product type' }));
                    selectUpdateProductDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                    selectUpdateProfileDDL.append($('<option/>', { value: -1, text: 'Please select profile' }));
                    selectUpdateStatusDDL.append($('<option/>', { value: -1, text: 'Please select project status' }));

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

            // ******* Start function create new project *******
            // When company select index change set cascading to architect
            selectCompanyDDL.change(function () {
                if ($(this).val() == "-1") {
                    btnArchitect.prop('disabled', true);

                    selectArchitectDDL.empty();
                    selectArchitectDDL.append($('<option/>', { value: -1, text: 'Select Architect' }));
                    selectArchitectDDL.val('-1');
                    selectArchitectDDL.prop('disabled', true);
                }
                else {
                    btnArchitect.prop('disabled', false);

                    $.ajax({
                        url: 'DataServices.asmx/GetDataArchitect',
                        method: 'post',
                        data: { CompanyID: $(this).val() },
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
                else {
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
                        data: { ProdTypeID: $(this).val() },
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
                            StatusConID: "1"
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
                                            StatusConID: "1"
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

            selectProjectStepDDL.change(function () {
                $('#biddingname1').val('');
                $('#owner1').val('');
                $('#biddingname2').val('');
                $('#owner2').val('');
                $('#biddingname3').val('');
                $('#owner3').val('');
                $('#awardmc').val('');
                $('#contactmc').val('');
                $('#awardrf').val('');
                $('#contactrf').val('');
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

                $('#btnSaveHistoryNewProject').prop('disabled', true);

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

                //if (selectProfile.val() == '-1') {
                //    document.getElementById("divErrorProfile").style.display = '';
                //    document.getElementById("divErrorProfile").style.display = 'normal';
                //    chkValidate = 'false';
                //    return;

                //} else {
                //    document.getElementById("divErrorProfile").style.display = '';
                //    document.getElementById("divErrorProfile").style.display = 'none';
                //    chkValidate = 'true';
                //}

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
                    var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                    var firstname = '<%= Session["sEmpEngFirstName"] %>';
                    var lastname = '<%= Session["sEmpEngLastName"] %>';
                    var engmane = '<%= Session["sEngName"] %>';
                    var empcode = '<%= Session["EmpCode"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                    var currentdate2 = yyyy + '-' + mm + '-' + dd;

                    var datepickertrans = $('#datepickertrans');
                    //datepickertrans

                    if (datepickertrans.val() > currentdate2) {

                        alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                        return;
                    }
                    //else {
                    //    alert('วันที่น้อยกว่า และเท่ากับวันที่ปัจจุบัน..');
                    //    return;
                    //}

                    if (($('#selectTransEntry').val() == 1) && ($('#selectProjectStep').val() == 0)) {

                        $.ajax({
                            url: 'DataServices.asmx/GetCountProject',
                            method: 'POST',
                            dataType: 'json',
                            success: function (data) {
                                var obj = jQuery.parseJSON(JSON.stringify(data));
                                if (obj != '') {
                                    $.each(obj, function (key, inval) {
                                        $("#ProjectID").val(inval["ProjectID"]);

                                        //Get insert new architech
                                        $.ajax({
                                            url: 'DataServices.asmx/GetInsertWeeklyReport',
                                            method: 'POST',
                                            data: {
                                                WeekDate: $('#datepickertrans').val(),
                                                //WeekTime: $('#inputtime').val(),
                                                WeekTime: $('#selecttime option:selected').text(),
                                                CompanyID: $('#selectCompany').val(),
                                                CompanyName: $('#selectCompany option:selected').text(),
                                                ArchitecID: $('#selectArchitect').val(),
                                                Name: $('#selectArchitect option:selected').text(),
                                                TransID: $('#selectTransEntry').val(),
                                                TransNameEN: $('#selectTransEntry option:selected').text(),
                                                ProjectID: $('#ProjectID').val(),
                                                ProjectName: $('#ProjName').val(),
                                                Location: $('#newLocation').val(),
                                                TurnKey: $('#selectTurnKey').val(),
                                                StepID: $('#selectProjectStep').val(),
                                                StepNameEn: $('#selectProjectStep option:selected').text(),
                                                BiddingName1: $('#biddingname1').val(),
                                                OwnerName1: $('#owner1').val(),
                                                BiddingName2: $('#biddingname2').val(),
                                                OwnerName2: $('#owner2').val(),
                                                BiddingName3: $('#biddingname3').val(),
                                                OwnerName3: $('#owner3').val(),
                                                AwardMC: $('#awardmc').val(),
                                                ContactMC: $('#contactmc').val(),
                                                AwardRF: $('#awardrf').val(),
                                                ContactRF: $('#contactrf').val(),
                                                ProdTypeID: $('#selectProductType').val(),
                                                ProdTypeNameEN: $('#selectProductType option:selected').text(),
                                                ProdID: $('#selectProduct').val(),
                                                ProdNameEN: $('#selectProduct option:selected').text(),
                                                //ProfID: $('#selectProfile').val(),
                                                //ProfNameEN: $('#selectProfile option:selected').text(),
                                                ProfID: '0',
                                                ProfNameEN: $('#Profile').val(),

                                                Quantity: $('#Quantity').val(),
                                                DeliveryDate: $('#datepickerdelivery').val(),
                                                NextVisitDate: $('#datevisit').val(),
                                                StatusID: $('#selectStatus').val(),
                                                StatusNameEn: $('#selectStatus option:selected').text(),
                                                Remark: $('#detail1').val(),
                                                UserID: userid,
                                                EmpCode: empcode,
                                                CreatedBy: firstname + ' ' + lastname,
                                                CreatedDate: currentdate
                                            },
                                            dataType: 'json',
                                            success: function (data) {

                                            }
                                        });

                                        /// to do here
                                        alert('Data saved successfully..!');

                                        document.getElementById("divSaveEntry").style.display = '';
                                        document.getElementById("divSaveEntry").style.display = 'none';

                                        document.getElementById("divNewProduct").style.display = '';
                                        document.getElementById("divNewProduct").style.display = 'normal';

                                         $('#btnSaveHistoryNewProject').prop('disabled', false);

                                    });
                                }
                            }
                        });

                    }
                    else {
                        alert('Warning, \n\When you create new transaction must be select step design only..!');
                        return;
                    }
                }
                else
                {
                    alert('Warnning, The data is not completed please check..!');
                }
            });

            var btnSaveHistoryNewProduct = $('#btnSaveHistoryNewProduct');
            btnSaveHistoryNewProduct.click(function () {
                $('#btnSaveHistoryNewProduct').prop('disabled', true);

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
                    var userid =  $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                    var firstname = '<%= Session["sEmpEngFirstName"] %>';
                    var lastname = '<%= Session["sEmpEngLastName"] %>';
                    var engmane = '<%= Session["sEngName"] %>';
                    var empcode = '<%= Session["EmpCode"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                    var currentdate2 = yyyy + '-' + mm + '-' + dd;

                    var datepickertrans = $('#datepickertrans');
                    //datepickertrans
                    if (datepickertrans.val() > currentdate2) {

                        alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                        return;
                    }

                    if (($('#selectTransEntry').val() == 1) && ($('#selectProjectStep').val() == 0)) {

                        //Get insert new architech
                        $.ajax({
                            url: 'DataServices.asmx/GetInsertWeeklyReportWithExtended',
                            method: 'POST',
                            data: {
                                WeekDate: $('#datepickertrans').val(),
                                //WeekTime: $('#inputtime').val(),
                                WeekTime: $('#selecttime option:selected').text(),
                                CompanyID: $('#selectCompany').val(),
                                CompanyName: $('#selectCompany option:selected').text(),
                                ArchitecID: $('#selectArchitect').val(),
                                Name: $('#selectArchitect option:selected').text(),
                                TransID: $('#selectTransEntry').val(),
                                TransNameEN: $('#selectTransEntry option:selected').text(),
                                ProjectID: $('#ProjectID').val(),
                                ProjectName: $('#ProjName').val(),
                                Location: $('#newLocation').val(),
                                StepID: $('#selectProjectStep').val(),
                                StepNameEn: $('#selectProjectStep option:selected').text(),
                                BiddingName1: $('#biddingname1').val(),
                                OwnerName1: $('#owner1').val(),
                                BiddingName2: $('#biddingname2').val(),
                                OwnerName2: $('#owner2').val(),
                                BiddingName3: $('#biddingname3').val(),
                                OwnerName3: $('#owner3').val(),
                                AwardMC: $('#awardmc').val(),
                                ContactMC: $('#contactmc').val(),
                                AwardRF: $('#awardrf').val(),
                                ContactRF: $('#contactrf').val(),
                                ProdTypeID: $('#selectProductType').val(),
                                ProdTypeNameEN: $('#selectProductType option:selected').text(),
                                ProdID: $('#selectProduct').val(),
                                ProdNameEN: $('#selectProduct option:selected').text(),
                                //ProfID: $('#selectProfile').val(),
                                //ProfNameEN: $('#selectProfile option:selected').text(),
                                ProfID: '0',
                                ProfNameEN: $('#Profile').val(),

                                Quantity: $('#Quantity').val(),
                                DeliveryDate: $('#datepickerdelivery').val(),
                                NextVisitDate: $('#datevisit').val(),
                                StatusID: $('#selectStatus').val(),
                                StatusNameEn: $('#selectStatus option:selected').text(),
                                Remark: $('#detail1').val(),
                                UserID: userid,
                                EmpCode: empcode,
                                CreatedBy: firstname + ' ' + lastname,
                                CreatedDate: currentdate
                            },
                            dataType: 'json',
                            success: function (data) {

                            }
                        });

                        /// to do here
                        alert('Data saved product extended successfully..!');

                        document.getElementById("divSaveEntry").style.display = '';
                        document.getElementById("divSaveEntry").style.display = 'none';

                        document.getElementById("divNewProduct").style.display = '';
                        document.getElementById("divNewProduct").style.display = 'normal';

                        $('#btnSaveHistoryNewProduct').prop('disabled', false);

                    } else {
                        alert('Warning, \n\When you create new transaction must be select step design only..!');
                        return;
                    }
                } else {
                    alert('Warnning, The data is not completed please check..!');
                }
            });
            // ******* End function create new project *******


            // ******* Start function update project status *******
            selectTransEntryDDL.change(function () {
                if ($(this).val() == '-1') {
                    selectUpdteProjectDDL.empty();
                    selectUpdteProjectDDL.append($('<option/>', { value: -1, text: 'Please select your project...!' }));
                }
                else {
                    var selectCompanyDDL = $('#selectCompany option:selected').val();
                    var selectArchitectDDL = $('#selectArchitect option:selected').val();
                    var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>

                    $.ajax({
                        url: 'DataServices.asmx/GetDataProjectWithPort',
                        method: 'post',
                        data: {
                            CompanyID: selectCompanyDDL,
                            ArchitecID: selectArchitectDDL,
                            TypeID: userid
                        },
                        dataType: 'json',
                        success: function (data) {
                            selectUpdteProjectDDL.empty();
                            selectUpdteProjectDDL.append($('<option/>', { value: -1, text: 'Please select your project...!' }));
                            $(data).each(function (index, item) {
                                selectUpdteProjectDDL.append($('<option/>', { value: item.ProjectID, text: item.ProjectName }));
                            });
                        }
                    });

                    // for transaction intake options
                    var selectIntakeProject = $('#selectIntakeProject');
                    $.ajax({
                        url: 'DataServices.asmx/GetDataProjectWithPort',
                        method: 'post',
                        data: {
                            CompanyID: selectCompanyDDL,
                            ArchitecID: selectArchitectDDL,
                            TypeID: userid
                        },
                        dataType: 'json',
                        success: function (data) {
                            selectIntakeProject.empty();
                            selectIntakeProject.append($('<option/>', { value: -1, text: 'Please select your project...!' }));
                            $(data).each(function (index, item) {
                                selectIntakeProject.append($('<option/>', { value: item.ProjectID, text: item.ProjectName }));
                            });
                        }
                    });
                    //Get project status
                    var selectIntakeStatus = $('#selectIntakeStatus');
                    $.ajax({
                        url: 'DataServices.asmx/GetStatus',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectIntakeStatus.append($('<option/>', { value: -1, text: 'Select status' }));
                            $(data).each(function (index, item) {
                                selectIntakeStatus.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                            });
                        }
                    });

                }
            });

            var selectIntakeProject = $('#selectIntakeProject');
            selectIntakeProject.change(function () {
                // get data table files attached here
                $.ajax({
                    url: 'DataServices.asmx/GetDocAttached',
                    method: 'post',
                    data: {
                        ProjectID: $('#selectIntakeProject').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        var items = [];
                        var trHTML = '';
                        $('#tableAttach tr:not(:first)').remove();
                        $(data).each(function (index, item) {
                            trHTML += '<tr><td>' + item.id + '</td><td>' + item.Description + '</td><td>' + item.FileName + '</td><td><a href="uploads/' + item.FileName + '" download target="_blank">Download</a></td></tr>';
                        });

                        $('#tableAttach').append(trHTML);
                    }
                });
            });

            selectUpdteProjectDDL.change(function () {
                if ($(this).val() == '-1') {
                    $('#updateLocation').prop('disabled', true);
                    $('#selectUpdateTurnKey').prop('disabled', true);
                    $('#updateProfile').prop('disabled', true);

                    $('#selectupdateProjectStep').prop('disabled', true);
                    selectupdateProjectStepDDL.empty();
                    selectupdateProjectStepDDL.append($('<option/>', { value: -1, text: 'Please select project step..' }));

                    selectUpdateProductTypeDDL.empty();
                    selectUpdateProductTypeDDL.prop('disabled', true);
                    selectUpdateProductTypeDDL.append($('<option/>', { value: -1, text: 'Please select product type' }));

                    selectUpdateProductDDL.empty();
                    selectUpdateProductDDL.prop('disabled', true);
                    selectUpdateProductDDL.append($('<option/>', { value: -1, text: 'Please select product' }));

                    selectUpdateProfileDDL.empty();
                    selectUpdateProfileDDL.prop('disabled', true);
                    selectUpdateProfileDDL.append($('<option/>', { value: -1, text: 'Please select profile' }));

                    updateProfile.val('');

                    updateQuantity.val('');
                    updateQuantity.prop('disabled', true);
                    updatepickerdelivery.val('');
                    updatepickerdelivery.prop('disabled', true);
                    updatevisit.val('');
                    updatevisit.prop('disabled', true);

                    selectUpdateStatusDDL.empty();
                    selectUpdateStatusDDL.prop('disabled', true);
                    selectUpdateStatusDDL.append($('<option/>', { value: -1, text: 'Please select project status' }));
                    updatedetail.prop('disabled', true);

                    document.getElementById("divUpdateBidding").style.display = 'none';
                    document.getElementById("divUpdateAwardMC").style.display = 'none';
                    document.getElementById("divUpdateAwardRF").style.display = 'none';

                    btnSaveHistoryUpdateProject.prop('disabled', true);
                    btnSaveHistoryUpdateProduct.prop('disabled', true);

                } else {
                    $('#updateLocation').prop('disabled', false);
                    $('#selectUpdateTurnKey').prop('disabled', false);
                    $('#updateProfile').prop('disabled', false);

                    $('#selectupdateProjectStep').prop('disabled', false);
                    //selectUpdateProductTypeDDL.prop('disabled', false);

                    btnSaveHistoryUpdateProject.prop('disabled', false);
                    btnSaveHistoryUpdateProduct.prop('disabled', false);

                    // get 
                    $.ajax({
                        url: 'DataServices.asmx/GetStepUpdate',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectupdateProjectStepDDL.empty();
                            selectupdateProjectStepDDL.append($('<option/>', { value: -1, text: 'Please select project step..' }));
                            $(data).each(function (index, item) {
                                selectupdateProjectStepDDL.append($('<option/>', { value: item.StepID, text: item.StepNameEn }));
                            });
                        }
                    });

                    // get 
                    $.ajax({
                        url: 'DataServices.asmx/GetProductTypeUpdate',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectUpdateProductTypeDDL.empty();
                            selectUpdateProductTypeDDL.append($('<option/>', { value: -1, text: 'Please select product type' }));
                            $(data).each(function (index, item) {
                                selectUpdateProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                            });
                        }
                    });

                    // get data binding last update
                    $.ajax({
                        url: 'DataServices.asmx/GetProjectLastUdate',
                        method: 'POST',
                        data: {
                            ProjectID: selectUpdteProjectDDL.val()
                        },
                        dataType: 'json',
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {
                                $.each(obj, function (key, inval) {
                                    $('#updateLocation').val(inval["Location"]);
                                    $('#selectUpdateTurnKey').val(inval["TurnKey"]).change();
                                    $('#updateProfile').val(inval["ProfNameEN"]);

                                    $('#selectupdateProjectStep').val(inval["ProjStep"]).change();

                                    //selectUpdateProductTypeDDL.val(inval["ProdTypeID"]).change();
                                    //selectUpdateProductDDL.val(inval["ProdID"]).change();
                                    //selectUpdateProfileDDL.val(inval["ProfID"]).change();

                                    //updateQuantity.prop('disabled', true);
                                    //updatepickerdelivery.prop('disabled', true);
                                    //updatevisit.prop('disabled', true);
                                    //selectUpdateStatusDDL.prop('disabled', true);
                                    //updatedetail.prop('disabled', true);

                                    //$('#selectupdateProjectStep').selectmenu('refresh');

                                    //selectupdateProjectStepDDL.append($('selected', { value: inval["StepID"], text: inval["StepNameEn"] }));
                                    //$('#selectupdateProjectStep option:selected').val(inval["StepID"]);
                                    //$('#selectupdateProjectStep').text(inval["StepNameEn"]);


                                });
                            }
                        }
                    });

                }
            });

            selectupdateProjectStepDDL.change(function () {
                if ($(this).val() == '-1') {
                    selectUpdateProductTypeDDL.empty();
                    selectUpdateProductTypeDDL.append($('<option/>', { value: -1, text: 'Please select product type' }));
                    selectUpdateProductTypeDDL.val('-1');
                    selectUpdateProductTypeDDL.prop('disabled', true);

                } else {

                    // get project step design, bidding, awardmc, awardrf 
                    $.ajax({
                        url: 'DataServices.asmx/GetProductTypeUpdate',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectUpdateProductTypeDDL.empty();
                            selectUpdateProductTypeDDL.prop('disabled', false);
                            selectUpdateProductTypeDDL.append($('<option/>', { value: -1, text: 'Please select product type' }));
                            $(data).each(function (index, item) {
                                selectUpdateProductTypeDDL.append($('<option/>', { value: item.ProdTypeID, text: item.ProdTypeNameEN }));
                            });

                            $.ajax({
                                url: 'DataServices.asmx/GetProjectLastUdate',
                                method: 'POST',
                                data: {
                                    ProjectID: selectUpdteProjectDDL.val()
                                },
                                dataType: 'json',
                                success: function (data) {
                                    var obj = jQuery.parseJSON(JSON.stringify(data));
                                    if (obj != '') {
                                        $.each(obj, function (key, inval) {

                                            selectUpdateProductTypeDDL.val(inval["ProdTypeID"]).change();

                                            selectUpdateProductDDL.val(inval["ProdID"]).change();
                                            selectUpdateProfileDDL.val(inval["ProfID"]).change();

                                            $('#updatebiddingname1').val('');
                                            $('#updateowner1').val('');

                                            //$('#updatebiddingname2').val('');
                                            //$('#updateowner2').val('');

                                            //$('#updatebiddingname3').val('');
                                            //$('#updateowner3').val('');

                                            //$('#updateawardmc').val('');
                                            //$('#updatecontactmc').val('');

                                            //$('#updateawardrf').val('');
                                            //$('#updatecontactrf').val('');

                                            //$('#updatebiddingname1').val(inval["BiddingName1"]);
                                            //$('#updateowner1').val(inval["OwnerName1"]);

                                            //$('#updatebiddingname2').val(inval["BiddingName2"]);
                                            //$('#updateowner2').val(inval["OwnerName2"]);

                                            //$('#updatebiddingname3').val(inval["BiddingName3"]);
                                            //$('#updateowner3').val(inval["OwnerName3"]);

                                            //$('#updateawardmc').val(inval["AwardMC"]);
                                            //$('#updatecontactmc').val(inval["ContactMC"]);

                                            //$('#updateawardrf').val(inval["AwardRF"]);
                                            //$('#updatecontactrf').val(inval["ContactRF"]);
                                        });
                                    }
                                }
                            });

                        }
                    });


                }
            });

            selectUpdateProductTypeDDL.change(function () {
                if ($(this).val() == '-1') {
                    selectUpdateProductDDL.prop('disabled', true);
                    selectUpdateProductDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                    selectUpdateProductDDL.val('-1');

                    selectUpdateProfileDDL.prop('disabled', true);
                    selectUpdateProfileDDL.append($('<option/>', { value: -1, text: 'Please select profile' }));
                    selectUpdateProfileDDL.val('-1');

                    updateQuantity.val('');
                    updateQuantity.prop('disabled', true);
                    updatepickerdelivery.val('');
                    updatepickerdelivery.prop('disabled', true);

                    updatevisit.val('');
                    updatevisit.prop('disabled', true);

                    selectUpdateStatusDDL.prop('disabled', true);
                    selectUpdateProfileDDL.append($('<option/>', { value: -1, text: 'Please select project stutus' }));

                } else {

                    $.ajax({
                        url: 'DataServices.asmx/GetProductsUpdate',
                        method: 'post',
                        data: {
                            ProdTypeID: $(this).val()
                        },
                        dataType: 'json',
                        success: function (data) {
                            selectUpdateProductDDL.prop('disabled', false);
                            selectUpdateProductDDL.empty();
                            selectUpdateProductDDL.append($('<option/>', { value: -1, text: 'Please select product' }));
                            $(data).each(function (index, item) {
                                selectUpdateProductDDL.append($('<option/>', { value: item.ProdID, text: item.ProdNameEN }));
                            });


                            $.ajax({
                                url: 'DataServices.asmx/GetProjectLastUdate',
                                method: 'POST',
                                data: {
                                    ProjectID: selectUpdteProjectDDL.val()
                                },
                                dataType: 'json',
                                success: function (data) {
                                    var obj = jQuery.parseJSON(JSON.stringify(data));
                                    if (obj != '') {
                                        $.each(obj, function (key, inval) {

                                            selectUpdateProductDDL.val(inval["ProdID"]).change();
                                            //selectUpdateProfileDDL.val(inval["ProfID"]).change();
                                            //selectUpdateStatusDDL.val(inval["StatusID"]).change();

                                            updateQuantity.val(inval["Quantity"]);
                                            updatepickerdelivery.val(inval["DeliveryDate"]);
                                            //updatevisit.val(inval["NextVisitDate"]);
                                            updatedetail.val(inval["Remark"]);
                                            $('#updateUsers').val(inval["SaleSpec"]);
                                            $('#updateLastdate').val(inval["LastUpdate"]);

                                        });
                                    }
                                }
                            });

                        }
                    });

                    $.ajax({
                        url: 'DataServices.asmx/GetProfileUpdate',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectUpdateProfileDDL.prop('disabled', false);
                            selectUpdateProfileDDL.empty();
                            selectUpdateProfileDDL.append($('<option/>', { value: -1, text: 'Please select profile' }));
                            $(data).each(function (index, item) {
                                selectUpdateProfileDDL.append($('<option/>', { value: item.ProfID, text: item.ProfNameEN }));
                            });

                            $.ajax({
                                url: 'DataServices.asmx/GetProjectLastUdate',
                                method: 'POST',
                                data: {
                                    ProjectID: selectUpdteProjectDDL.val()
                                },
                                dataType: 'json',
                                success: function (data) {
                                    var obj = jQuery.parseJSON(JSON.stringify(data));
                                    if (obj != '') {
                                        $.each(obj, function (key, inval) {

                                            //selectUpdateProductDDL.val(inval["ProdID"]).change();
                                            selectUpdateProfileDDL.val(inval["ProfID"]).change();
                                            //selectUpdateStatusDDL.val(inval["StatusID"]).change();

                                            updateQuantity.val(inval["Quantity"]);
                                            updatepickerdelivery.val(inval["DeliveryDate"]);
                                            //updatevisit.val(inval["NextVisitDate"]);
                                            updatedetail.val(inval["Remark"]);
                                            $('#updateUsers').val(inval["SaleSpec"]);
                                            $('#updateLastdate').val(inval["LastUpdate"]);

                                        });
                                    }
                                }
                            });
                        }
                    });

                    $.ajax({
                        url: 'DataServices.asmx/GetStatusUpdate',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectUpdateStatusDDL.empty();
                            selectUpdateStatusDDL.prop('disabled', false);
                            selectUpdateStatusDDL.append($('<option/>', { value: -1, text: 'Please select project stutus' }));
                            $(data).each(function (index, item) {
                                selectUpdateStatusDDL.append($('<option/>', { value: item.StatusID, text: item.StatusNameEn }));
                            });

                            $.ajax({
                                url: 'DataServices.asmx/GetProjectLastUdate',
                                method: 'POST',
                                data: {
                                    ProjectID: selectUpdteProjectDDL.val()
                                },
                                dataType: 'json',
                                success: function (data) {
                                    var obj = jQuery.parseJSON(JSON.stringify(data));
                                    if (obj != '') {
                                        $.each(obj, function (key, inval) {

                                            //selectUpdateProductDDL.val(inval["ProdID"]).change();
                                            //selectUpdateProfileDDL.val(inval["ProfID"]).change();
                                            selectUpdateStatusDDL.val(inval["StatusID"]).change();

                                            updateQuantity.val(inval["Quantity"]);
                                            updatepickerdelivery.val(inval["DeliveryDate"]);
                                            //updatevisit.val(inval["NextVisitDate"]);
                                            updatedetail.val(inval["Remark"]);
                                            $('#updateUsers').val(inval["SaleSpec"]);
                                            $('#updateLastdate').val(inval["LastUpdate"]);

                                        });
                                    }
                                }
                            });

                        }
                    });

                    updateQuantity.prop('disabled', false);
                    updatepickerdelivery.prop('disabled', false);
                    updatevisit.prop('disabled', false);
                    updatedetail.prop('disabled', false);
                }
            });


            // ****** click save update project ******
            var btnSaveHistoryUpdateProject = $('#btnSaveHistoryUpdateProject');
            btnSaveHistoryUpdateProject.click(function () {
                $('#btnSaveHistoryUpdateProject').prop('disabled', true);

                var chkValidate = 'false';
                var ProjectID = $('#selectUpdteProject').val();
                var ProjName = $('#selectUpdteProject option:selected').text();
                var updateLocation = $('#updateLocation');
                var selectupdateProjectStep = $('#selectupdateProjectStep');
                var selectUpdateProduct = $('#selectUpdateProduct');
                var selectUpdateProfile = $('#selectUpdateProfile');
                var updateQuantity = $('#updateQuantity');
                var updatepickerdelivery = $('#updatepickerdelivery');
                var updatevisit = $('#updatevisit');
                var selectUpdateStatus = $('#selectUpdateStatus');

                if (ProjName == '') {
                    document.getElementById("divErrorupProjName").style.display = '';
                    document.getElementById("divErrorupProjName").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupProjName").style.display = '';
                    document.getElementById("divErrorupProjName").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updateLocation.val() == '') {
                    document.getElementById("divErrorupLocation").style.display = '';
                    document.getElementById("divErrorupLocation").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupLocation").style.display = '';
                    document.getElementById("divErrorupLocation").style.display = 'none';
                    chkValidate = 'true';
                }

                if (selectupdateProjectStep.val() == '-1') {
                    document.getElementById("divErrorupProjectStep").style.display = '';
                    document.getElementById("divErrorupProjectStep").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupProjectStep").style.display = '';
                    document.getElementById("divErrorupProjectStep").style.display = 'none';
                    chkValidate = 'true';
                }

                if (selectUpdateProduct.val() == '-1') {
                    document.getElementById("divErrorupProduct").style.display = '';
                    document.getElementById("divErrorupProduct").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupProduct").style.display = '';
                    document.getElementById("divErrorupProduct").style.display = 'none';
                    chkValidate = 'true';;
                }

                if (selectUpdateProfile.val() == '-1') {
                    document.getElementById("divErrorupProfile").style.display = '';
                    document.getElementById("divErrorupProfile").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupProfile").style.display = '';
                    document.getElementById("divErrorupProfile").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updateQuantity.val() == '') {
                    document.getElementById("divErrorupQuantity").style.display = '';
                    document.getElementById("divErrorupQuantity").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupQuantity").style.display = '';
                    document.getElementById("divErrorupQuantity").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updatepickerdelivery.val() == '') {
                    document.getElementById("divErrorupDeliveryDate").style.display = '';
                    document.getElementById("divErrorupDeliveryDate").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupDeliveryDate").style.display = '';
                    document.getElementById("divErrorupDeliveryDate").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updatevisit.val() == '') {
                    document.getElementById("divErrorupNextVisit").style.display = '';
                    document.getElementById("divErrorupNextVisit").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupNextVisit").style.display = '';
                    document.getElementById("divErrorupNextVisit").style.display = 'none';
                    chkValidate = 'true';
                }

                if (selectUpdateStatus.val() == '-1') {
                    document.getElementById("divErrorupStatus").style.display = '';
                    document.getElementById("divErrorupStatus").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupStatus").style.display = '';
                    document.getElementById("divErrorupStatus").style.display = 'none';
                    chkValidate = 'true';
                }

                if (chkValidate == 'true') {
                    var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                    var firstname = '<%= Session["sEmpEngFirstName"] %>';
                    var lastname = '<%= Session["sEmpEngLastName"] %>';
                    var engmane = '<%= Session["sEngName"] %>';
                    var empcode = '<%= Session["EmpCode"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    var currentdate2 = yyyy + '-' + mm + '-' + dd;
                    var datepickertrans = $('#datepickertrans');
                    //datepickertrans
                    if (datepickertrans.val() > currentdate2) {

                        alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                        return;
                    }

                    $.ajax({
                        url: 'DataServices.asmx/GetInsertWeeklyReportUpdate',
                        method: 'POST',
                        data: {
                            WeekDate: $('#datepickertrans').val(),
                            //WeekTime: $('#inputtime').val(),
                            WeekTime: $('#selecttime option:selected').text(),
                            CompanyID: $('#selectCompany').val(),
                            CompanyName: $('#selectCompany option:selected').text(),
                            ArchitecID: $('#selectArchitect').val(),
                            Name: $('#selectArchitect option:selected').text(),
                            TransID: $('#selectTransEntry').val(),
                            TransNameEN: $('#selectTransEntry option:selected').text(),
                            ProjectID: $('#selectUpdteProject').val(),
                            ProjectName: $('#selectUpdteProject option:selected').text(),
                            Location: $('#updateLocation').val(),
                            TurnKey: $('#selectUpdateTurnKey').val(),

                            StepID: $('#selectupdateProjectStep').val(),
                            StepNameEn: $('#selectupdateProjectStep option:selected').text(),
                            BiddingName1: $('#updatebiddingname1').val(),
                            OwnerName1: $('#updateowner1').val(),
                            BiddingName2: $('#updatebiddingname2').val(),
                            OwnerName2: $('#updateowner2').val(),
                            BiddingName3: $('#updatebiddingname3').val(),
                            OwnerName3: $('#updateowner3').val(),
                            AwardMC: $('#updateawardmc').val(),
                            ContactMC: $('#updatecontactmc').val(),
                            AwardRF: $('#updateawardrf').val(),
                            ContactRF: $('#updatecontactrf').val(),
                            ProdTypeID: $('#selectUpdateProductType').val(),
                            ProdTypeNameEN: $('#selectUpdateProductType option:selected').text(),
                            ProdID: $('#selectUpdateProduct').val(),
                            ProdNameEN: $('#selectUpdateProduct option:selected').text(),
                            //ProfID: $('#selectUpdateProfile').val(),
                            //ProfNameEN: $('#selectUpdateProfile option:selected').text(),
                            ProfID: '0',
                            ProfNameEN: $('#updateProfile').val(),

                            Quantity: $('#updateQuantity').val(),
                            DeliveryDate: $('#updatepickerdelivery').val(),
                            NextVisitDate: $('#updatevisit').val(),
                            StatusID: $('#selectUpdateStatus').val(),
                            StatusNameEn: $('#selectUpdateStatus option:selected').text(),
                            Remark: $('#updatedetail').val(),
                            UserID: userid,
                            EmpCode: empcode,
                            CreatedBy: firstname + ' ' + lastname,
                            CreatedDate: currentdate
                        },
                        dataType: 'json',
                        success: function (data) {

                        }
                    });

                    /// to do here
                    alert('Data saved successfully..!');

                    document.getElementById("divUpdateEntry").style.display = '';
                    document.getElementById("divUpdateEntry").style.display = 'none';

                    document.getElementById("divUpdateNewProduct").style.display = '';
                    document.getElementById("divUpdateNewProduct").style.display = 'normal';

                    $('#btnSaveHistoryUpdateProject').prop('disabled', false);

                } else {
                    alert('Warnning, The data is not completed please check..!');
                }
            });

            // codding.......
            var btnSaveHistoryUpdateProduct = $('#btnSaveHistoryUpdateProduct');
            btnSaveHistoryUpdateProduct.click(function () {
                $('#btnSaveHistoryUpdateProduct').prop('disabled', true);

                var chkValidate = 'false';
                var ProjectID = $('#selectUpdteProject').val();
                var ProjName = $('#selectUpdteProject option:selected').text();
                var updateLocation = $('#updateLocation');
                var selectupdateProjectStep = $('#selectupdateProjectStep');
                var selectUpdateProduct = $('#selectUpdateProduct');
                var selectUpdateProfile = $('#selectUpdateProfile');
                var updateQuantity = $('#updateQuantity');
                var updatepickerdelivery = $('#updatepickerdelivery');
                var updatevisit = $('#updatevisit');
                var selectUpdateStatus = $('#selectUpdateStatus');

                if (ProjName == '') {
                    document.getElementById("divErrorupProjName").style.display = '';
                    document.getElementById("divErrorupProjName").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupProjName").style.display = '';
                    document.getElementById("divErrorupProjName").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updateLocation.val() == '') {
                    document.getElementById("divErrorupLocation").style.display = '';
                    document.getElementById("divErrorupLocation").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupLocation").style.display = '';
                    document.getElementById("divErrorupLocation").style.display = 'none';
                    chkValidate = 'true';
                }

                if (selectupdateProjectStep.val() == '-1') {
                    document.getElementById("divErrorupProjectStep").style.display = '';
                    document.getElementById("divErrorupProjectStep").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupProjectStep").style.display = '';
                    document.getElementById("divErrorupProjectStep").style.display = 'none';
                    chkValidate = 'true';
                }

                if (selectUpdateProduct.val() == '-1') {
                    document.getElementById("divErrorupProduct").style.display = '';
                    document.getElementById("divErrorupProduct").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorupProduct").style.display = '';
                    document.getElementById("divErrorupProduct").style.display = 'none';
                    chkValidate = 'true';;
                }

                //if (selectUpdateProfile.val() == '-1') {
                //    document.getElementById("divErrorupProfile").style.display = '';
                //    document.getElementById("divErrorupProfile").style.display = 'normal';
                //    chkValidate = 'false';
                //    return;

                //} else {
                //    document.getElementById("divErrorupProfile").style.display = '';
                //    document.getElementById("divErrorupProfile").style.display = 'none';
                //    chkValidate = 'true';
                //}

                if (updateQuantity.val() == '') {
                    document.getElementById("divErrorupQuantity").style.display = '';
                    document.getElementById("divErrorupQuantity").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupQuantity").style.display = '';
                    document.getElementById("divErrorupQuantity").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updatepickerdelivery.val() == '') {
                    document.getElementById("divErrorupDeliveryDate").style.display = '';
                    document.getElementById("divErrorupDeliveryDate").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupDeliveryDate").style.display = '';
                    document.getElementById("divErrorupDeliveryDate").style.display = 'none';
                    chkValidate = 'true';
                }

                if (updatevisit.val() == '') {
                    document.getElementById("divErrorupNextVisit").style.display = '';
                    document.getElementById("divErrorupNextVisit").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupNextVisit").style.display = '';
                    document.getElementById("divErrorupNextVisit").style.display = 'none';
                    chkValidate = 'true';
                }

                if (selectUpdateStatus.val() == '-1') {
                    document.getElementById("divErrorupStatus").style.display = '';
                    document.getElementById("divErrorupStatus").style.display = 'normal';
                    chkValidate = 'false';
                    return;

                } else {
                    document.getElementById("divErrorupStatus").style.display = '';
                    document.getElementById("divErrorupStatus").style.display = 'none';
                    chkValidate = 'true';
                }

                if (chkValidate == 'true') {
                    var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                    var firstname = '<%= Session["sEmpEngFirstName"] %>';
                    var lastname = '<%= Session["sEmpEngLastName"] %>';
                    var engmane = '<%= Session["sEngName"] %>';
                    var empcode = '<%= Session["EmpCode"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    var currentdate2 = yyyy + '-' + mm + '-' + dd;
                    var datepickertrans = $('#datepickertrans');
                    //datepickertrans
                    if (datepickertrans.val() > currentdate2) {

                        alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                        return;
                    }

                    $.ajax({
                        url: 'DataServices.asmx/GetInsertWeeklyReportWithExtendedUpdate',
                        method: 'POST',
                        data: {
                            WeekDate: $('#datepickertrans').val(),
                            //WeekTime: $('#inputtime').val(),
                            WeekTime: $('#selecttime option:selected').text(),
                            CompanyID: $('#selectCompany').val(),
                            CompanyName: $('#selectCompany option:selected').text(),
                            ArchitecID: $('#selectArchitect').val(),
                            Name: $('#selectArchitect option:selected').text(),
                            TransID: $('#selectTransEntry').val(),
                            TransNameEN: $('#selectTransEntry option:selected').text(),
                            ProjectID: $('#selectUpdteProject').val(),
                            ProjectName: $('#selectUpdteProject option:selected').text(),
                            Location: $('#updateLocation').val(),
                            TurnKey: $('#selectUpdateTurnKey').val(),

                            StepID: $('#selectupdateProjectStep').val(),
                            StepNameEn: $('#selectupdateProjectStep option:selected').text(),
                            BiddingName1: $('#updatebiddingname1').val(),
                            OwnerName1: $('#updateowner1').val(),
                            BiddingName2: $('#updatebiddingname2').val(),
                            OwnerName2: $('#updateowner2').val(),
                            BiddingName3: $('#updatebiddingname3').val(),
                            OwnerName3: $('#updateowner3').val(),
                            AwardMC: $('#updateawardmc').val(),
                            ContactMC: $('#updatecontactmc').val(),
                            AwardRF: $('#updateawardrf').val(),
                            ContactRF: $('#updatecontactrf').val(),
                            ProdTypeID: $('#selectUpdateProductType').val(),
                            ProdTypeNameEN: $('#selectUpdateProductType option:selected').text(),
                            ProdID: $('#selectUpdateProduct').val(),
                            ProdNameEN: $('#selectUpdateProduct option:selected').text(),
                            //ProfID: $('#selectUpdateProfile').val(),
                            //ProfNameEN: $('#selectUpdateProfile option:selected').text(),
                            ProfID: '0',
                            ProfNameEN: $('#updateProfile').val(),

                            Quantity: $('#updateQuantity').val(),
                            DeliveryDate: $('#updatepickerdelivery').val(),
                            NextVisitDate: $('#updatevisit').val(),
                            StatusID: $('#selectUpdateStatus').val(),
                            StatusNameEn: $('#selectUpdateStatus option:selected').text(),
                            Remark: $('#updatedetail').val(),
                            UserID: userid,
                            EmpCode: empcode,
                            CreatedBy: firstname + ' ' + lastname,
                            CreatedDate: currentdate
                        },
                        dataType: 'json',
                        success: function (data) {

                        }
                    });

                    /// to do here
                    alert('Data saved product extended successfully..!');

                    document.getElementById("divUpdateEntry").style.display = '';
                    document.getElementById("divUpdateEntry").style.display = 'none';

                    document.getElementById("divUpdateNewProduct").style.display = '';
                    document.getElementById("divUpdateNewProduct").style.display = 'normal';

                    $('#btnSaveHistoryUpdateProduct').prop('disabled', false);

                } else {
                    alert('Warnning, The data is not completed please check..!');
                }
            });



            var btnSaveNewArchitect = $('#btnSaveNewArchitect');
            btnSaveNewArchitect.click(function () {
                $('#btnSaveNewArchitect').prop('disabled', true);

                var chkValidate = 'false';
                var newarchitect = $('#newarchitect').val();
                var detailarchitect = $('#detailarchitect').val();

                if (newarchitect == '') {
                    document.getElementById("divErrorArchitect").style.display = '';
                    document.getElementById("divErrorArchitect").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorArchitect").style.display = '';
                    document.getElementById("divErrorArchitect").style.display = 'none';
                    chkValidate = 'true';
                }

                if (detailarchitect == '') {
                    document.getElementById("divErrorDetailarchitect").style.display = '';
                    document.getElementById("divErrorDetailarchitect").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorDetailarchitect").style.display = '';
                    document.getElementById("divErrorDetailarchitect").style.display = 'none';
                    chkValidate = 'true';
                }


                if (chkValidate == 'true') {
                    var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                    var firstname = '<%= Session["sEmpEngFirstName"] %>';
                    var lastname = '<%= Session["sEmpEngLastName"] %>';
                    var engmane = '<%= Session["sEngName"] %>';
                    var empcode = '<%= Session["EmpCode"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    var currentdate2 = yyyy + '-' + mm + '-' + dd;
                    var datepickertrans = $('#datepickertrans');
                    //datepickertrans
                    if (datepickertrans.val() > currentdate2) {

                        alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                        return;
                    }

                    alert(datepickertrans.val());

                    $.ajax({
                        url: 'DataServices.asmx/GetInsertWeeklyReportUpdateOther',
                        method: 'POST',
                        data: {
                            WeekDate: $('#datepickertrans').val(),
                            //WeekTime: $('#inputtime').val(),
                            WeekTime: $('#selecttime option:selected').text(),
                            CompanyID: $('#selectCompany').val(),
                            CompanyName: $('#selectCompany option:selected').text(),
                            ArchitecID: $('#selectArchitect').val(),
                            Name: $('#selectArchitect option:selected').text(),
                            TransID: $('#selectTransEntry').val(),
                            TransNameEN: $('#selectTransEntry option:selected').text(),
                            ProjectID: null,    // $('#selectTransEntry').val(),
                            ProjectName: null,  //$('#selectTransEntry option:selected').text(),
                            Location: null,     //$('#selectArchitect').val(),
                            TurnKey: null,
                            StepID: null,       //$('#selectArchitect').val(),
                            StepNameEn: null,   // $('#selectTransEntry option:selected').text(),
                            StatusID: null,     //$('#selectArchitect').val(),
                            StatusNameEn: null, //$('#selectTransEntry option:selected').text(),
                            NewArchitect: $('#newarchitect').val(),
                            HaveFiles: null,
                            FileName: null,
                            Remark: $('#detailarchitect').val(),
                            UserID: userid,
                            EmpCode: empcode,
                            CreatedBy: firstname + ' ' + lastname,
                            CreatedDate: currentdate
                        },
                        dataType: 'json',
                        success: function (data) {
                            /// to do here
                            alert('Data saved new architect successfully..!');
                            $('#btnSaveNewArchitect').prop('disabled', false);
                        }
                    });

                    

                    document.getElementById("divUpdateEntry").style.display = '';
                    document.getElementById("divUpdateEntry").style.display = 'none';

                    document.getElementById("divUpdateNewProduct").style.display = '';
                    document.getElementById("divUpdateNewProduct").style.display = 'normal';


                } else {
                    alert('Warnning, The data is not completed please check..!');
                }
            });

            var btnOtherDetail = $('#btnOtherDetail');
            btnOtherDetail.click(function () {
                $('#btnOtherDetail').prop('disabled', true);

                //var otherdetail = $('#otherdetail').val();
                var otherdetail = $('#otherdetail').val();
                if (otherdetail == '') {
                    document.getElementById("divErrorDetailOther").style.display = '';
                    document.getElementById("divErrorDetailOther").style.display = 'normal';
                    chkValidate = 'false';
                    return;
                } else {
                    document.getElementById("divErrorDetailOther").style.display = '';
                    document.getElementById("divErrorDetailOther").style.display = 'none';
                    chkValidate = 'true';
                }


                var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                var firstname = '<%= Session["sEmpEngFirstName"] %>';
                var lastname = '<%= Session["sEmpEngLastName"] %>';
                var engmane = '<%= Session["sEngName"] %>';
                var empcode = '<%= Session["EmpCode"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                var currentdate2 = yyyy + '-' + mm + '-' + dd;
                var datepickertrans = $('#datepickertrans');
                //datepickertrans
                if (datepickertrans.val() > currentdate2) {

                    alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                    return;
                }

                $.ajax({
                    url: 'DataServices.asmx/GetInsertWeeklyReportUpdateOther',
                    method: 'POST',
                    data: {
                        WeekDate: $('#datepickertrans').val(),
                        //WeekTime: $('#inputtime').val(),
                        WeekTime: $('#selecttime option:selected').text(),
                        CompanyID: $('#selectCompany').val(),
                        CompanyName: $('#selectCompany option:selected').text(),
                        ArchitecID: $('#selectArchitect').val(),
                        Name: $('#selectArchitect option:selected').text(),
                        TransID: $('#selectTransEntry').val(),
                        TransNameEN: $('#selectTransEntry option:selected').text(),
                        ProjectID: null,
                        ProjectName: null,
                        Location: null,
                        TurnKey: null,
                        StepID: null,
                        StepNameEn: null,
                        StatusID: null,
                        StatusNameEn: null,
                        NewArchitect: null,
                        HaveFiles: null,
                        FileName: null,
                        Remark: $('#otherdetail').val(),
                        UserID: userid,
                        EmpCode: empcode,
                        CreatedBy: firstname + ' ' + lastname,
                        CreatedDate: currentdate
                    },
                    dataType: 'json',
                    success: function (data) {
                         /// to do here
                        
                    }
                });
                alert('Data saved other details successfully..!');
                $('#btnOtherDetail').prop('disabled', false);
            });
            // ******* End function update project status *******



            $("body").on("click", "#btnUpload", function () {
                // validate object here first.....
                var selectIntakeProject = $('#selectIntakeProject').val();
                var selectIntakeStatus = $('#selectIntakeStatus').val();
                var intakeDetails = $('#intakeDetails').val();

                if (selectIntakeProject == '-1') {
                    document.getElementById("divErrorIntakeProject").style.display = '';
                    document.getElementById("divErrorIntakeProject").style.display = 'normal';
                    return;
                } else {
                    document.getElementById("divErrorIntakeProject").style.display = '';
                    document.getElementById("divErrorIntakeProject").style.display = 'none';
                }

                if (selectIntakeStatus == '-1') {
                    document.getElementById("divErrorIntakeStatus").style.display = '';
                    document.getElementById("divErrorIntakeStatus").style.display = 'normal';
                    return;
                } else {
                    document.getElementById("divErrorIntakeStatus").style.display = '';
                    document.getElementById("divErrorIntakeStatus").style.display = 'none';
                }

                if (intakeDetails == '') {
                    document.getElementById("divErrorIntakeDetail").style.display = '';
                    document.getElementById("divErrorIntakeDetail").style.display = 'normal';
                    return;
                } else {
                    document.getElementById("divErrorIntakeDetail").style.display = '';
                    document.getElementById("divErrorIntakeDetail").style.display = 'none';
                }



                var userid = $('#selectPort option:selected').val(); <%--'<%= Session["UserID"]%>';--%>
                var firstname = '<%= Session["sEmpEngFirstName"] %>';
                var lastname = '<%= Session["sEmpEngLastName"] %>';
                var engmane = '<%= Session["sEngName"] %>';
                var empcode = '<%= Session["EmpCode"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                var currentdate2 = yyyy + '-' + mm + '-' + dd;
                var datepickertrans = $('#datepickertrans');
                //datepickertrans
                if (datepickertrans.val() > currentdate2) {

                    alert(datepickertrans.val() + '  ไม่อนุญาติให้บันทึกข้อมูลเกินวันที่ปัจจุบัน โปรดตรวจสอบ..!  ' + currentdate2);
                    return;
                }

                var optionsRadios1 = $('#optionsRadios1');
                var postedFile = $('#postedFile').val();
                var havefile = '';
                if (document.getElementById("optionsRadios1").checked == true) {
                    havefile = postedFile;

                    // check file name is not empty
                    if (havefile == '') {
                        alert('Intake attached find not found file name..');
                    }
                    else {

                        $.ajax({
                            url: 'DataServices.asmx/GetInsertWeeklyReportUpdateOther',
                            method: 'POST',
                            data: {
                                WeekDate: $('#datepickertrans').val(),
                                //WeekTime: $('#inputtime').val(),
                                WeekTime: $('#selecttime option:selected').text(),
                                CompanyID: $('#selectCompany').val(),
                                CompanyName: $('#selectCompany option:selected').text(),
                                ArchitecID: $('#selectArchitect').val(),
                                Name: $('#selectArchitect option:selected').text(),
                                TransID: $('#selectTransEntry').val(),
                                TransNameEN: $('#selectTransEntry option:selected').text(),
                                ProjectID: $('#selectIntakeProject').val(),
                                ProjectName: $('#selectIntakeProject option:selected').text(),
                                Location: null,
                                TurnKey: null,
                                StepID: null,
                                StepNameEn: null,
                                StatusID: $('#selectIntakeStatus').val(),
                                StatusNameEn: $('#selectIntakeStatus option:selected').text(),
                                NewArchitect: null,
                                HaveFiles: null,
                                FileName: havefile.replace('C:\\fakepath\\', ''),
                                Remark: $('#intakeDetails').val(),
                                UserID: userid,
                                EmpCode: empcode,
                                CreatedBy: firstname + ' ' + lastname,
                                CreatedDate: currentdate
                            },
                            dataType: 'json',
                            success: function (data) {

                            }
                        });


                        $.ajax({
                            url: 'DataServices.asmx/GetInsertWeeklyReportIntakeUpdate',
                            method: 'POST',
                            data: {
                                CompanyID: $('#selectCompany').val(),
                                CompanyName: $('#selectCompany option:selected').text(),
                                ArchitecID: $('#selectArchitect').val(),
                                Name: $('#selectArchitect option:selected').text(),
                                ProjectID: $('#selectIntakeProject').val(),
                                ProjectName: $('#selectIntakeProject option:selected').text(),
                                StepID: $('#selectTransEntry').val(),
                                StatusID: $('#selectIntakeStatus').val(),
                                StatusNameEn: $('#selectIntakeStatus option:selected').text(),
                                UserID: userid,
                                EmpCode: empcode,
                                CreatedBy: firstname + ' ' + lastname,
                                CreatedDate: currentdate
                            },
                            dataType: 'json',
                            success: function (data) {

                            }
                        });

                        // when insert weekly report table succeed then upload file to server
                        $.ajax({
                            url: 'HandlerCS.ashx',
                            type: 'POST',
                            data: new FormData($('form')[0]),
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (file) {

                                $.ajax({
                                    url: 'DataServices.asmx/GetUploadDocAttached',
                                    method: 'post',
                                    data: {
                                        ProjectID: $('#selectIntakeProject').val(),
                                        ProjectName: $('#selectIntakeProject option:selected').text(),
                                        Description: $('#intakeDesc').val(),
                                        FileName: file.name,
                                        Remark: $('#intakeDetails').val(),
                                        UserID: userid,
                                        EmpCode: empcode,
                                        CreatedBy: firstname + ' ' + lastname,
                                        CreatedDate: currentdate
                                    },
                                    dataType: 'json',
                                    success: function (data) {
                                    }
                                });

                                $("#fileProgress").hide();
                                $("#lblMessage").html("<b>" + file.name + "</b> has been uploaded.");
                            },
                            xhr: function () {
                                var fileXhr = $.ajaxSettings.xhr();
                                if (fileXhr.upload) {
                                    $("progress").show();
                                    fileXhr.upload.addEventListener("progress", function (e) {
                                        if (e.lengthComputable) {
                                            $("#fileProgress").attr({
                                                value: e.loaded,
                                                max: e.total
                                            });
                                        }
                                    }, false);
                                }
                                return fileXhr;
                            }
                        });

                        alert('File has been uploaded...');

                    }
                }
                else {
                    havefile = 'Intake option request more file attached...';
                    alert(havefile);
                    return;
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

        #rcorners24 {
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
                                        <label class="txtLabel">Port</label>
                                        <div class="input-group col-md-12">
                                            <span class="txtLabel">
                                                <select id="selectPort" name="selectPort" class="form-control input input-sm " style="width: 100%;">
                                                </select>
                                            </span>
                                        </div>
                                    </div>
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
                                        <div class="">
                                            <div class="input-group">
                                                <label class="txtLabel">StartTime</label>
                                                <div class="input-group">
                                                    <input type="text" id="inputtime" class="form-control input-sm timepicker txtLabel hidden">
                                                    <div class="input-group-addon hidden">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>

                                                    <span class="txtLabel " style="width: 100%">
                                                        <select id="selecttime" class="form-control input-sm ">
                                                            <option value="600">6:00</option>
                                                            <option value="630">6:30</option>
                                                            <option value="700">7:00</option>
                                                            <option value="730">7:30</option>
                                                            <option value="800">8:00</option>
                                                            <option value="830">8:30</option>
                                                            <option value="900">9:00</option>
                                                            <option value="930">9:30</option>
                                                            <option value="1000">10:00</option>
                                                            <option value="1030">10:30</option>
                                                            <option value="1100">11:00</option>
                                                            <option value="1130">11:30</option>
                                                            <option value="1200">12:00</option>
                                                            <option value="1230">12:30</option>
                                                            <option value="1300">13:00</option>
                                                            <option value="1330">13:30</option>
                                                            <option value="1400">14:00</option>
                                                            <option value="1430">14:30</option>
                                                            <option value="1500">15:00</option>
                                                            <option value="1530">15:30</option>
                                                            <option value="1600">16:00</option>
                                                            <option value="1630">16:30</option>
                                                            <option value="1700">17:00</option>
                                                            <option value="1730">17:30</option>
                                                            <option value="1800">18:00</option>
                                                            <option value="1830">18:30</option>
                                                            <option value="1900">19:00</option>
                                                            <option value="1930">19:30</option>
                                                            <option value="2000">20:00</option>
                                                            <option value="2030">20:30</option>
                                                            <option value="2100">21:00</option>
                                                            <option value="2130">21:30</option>
                                                            <option value="2200">22:00</option>
                                                            <option value="2230">22:30</option>
                                                            <option value="2300">23:00</option>
                                                            <option value="2330">23:30</option>
                                                        </select>
                                                    </span>


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
                                        <label class="txtLabel">What Is Your Job</label>
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
                                                <label class="txtLabel">TurnKey</label>
                                                <div class="txtLabel">
                                                    <select id="selectTurnKey" name="selectTurnKey"  class="form-control input-sm" style="width: 100%">
                                                        <option value="Y">Yes</option>
                                                        <option value="N">No</option>
                                                    </select>
                                                </div>
                                                <div id="divErrorselectTurnKey" class="txtLabel text-red" style="display: none;">The project steps should be progressive ..!</div>
                                            </div>

                                            <div class="col-md-1 input-group hidden">
                                                <label class="txtLabel">View</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                </div>
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
                                                            <label class="txtLabel">Award Main Constructor</label>
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
                                                            <label class="txtLabel">Award Roll Former</label>
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
                                                <input type="text" class="form-control input-sm txtLabel" id="Profile" name="Profile">
                                                <div class="txtLabel hidden">
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
                                                <label class="txtLabel">Next/following</label>
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
                                            <div id="divSaveEntry" class="col-md-2 col-md-offset-2">
                                                <label class="txtLabel">Save Entry</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryNewProject">Save Entry</button>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-md-offset-2" id="divNewProduct" style="display: none">
                                                <label class="txtLabel">Add New Product</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-warning btn-flat btn-block btn-sm" id="btnSaveHistoryNewProduct">Save New Product</button>
                                                </div>
                                            </div>

                                            <div class="col-md-2" id="divNewEntry">
                                                <label class="txtLabel">Start New Entry</label>
                                                <div class="">
                                                    <a href="weeklyreport?opt=wkr" class="btn btn-success btn-flat btn-block btn-sm">New Entry</a>
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
                                                    <input type="text" class="form-control input-sm txtLabel" id="updateProjectID" name="updateProjectID">
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
                                                    <select id="selectUpdteProject" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProjName" class="txtLabel text-red" style="display: none;">Project name is not empty...!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Locations</label>
                                                <div class="">
                                                    <textarea cols="40" rows="2" class="form-control input-sm txtLabel" id="updateLocation" name="updateLocation"></textarea>
                                                </div>
                                                <div id="divErrorupLocation" class="txtLabel text-red" style="display: none;">Let's them know where is project locations..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">TurnKey</label>
                                                <div class="txtLabel">
                                                    <select id="selectUpdateTurnKey" name="selectUpdateTurnKey" class="form-control input-sm" style="width: 100%">
                                                        <option value="Y">Yes</option>
                                                        <option value="N">No</option>
                                                    </select>
                                                </div>
                                                <div id="divErrorupTurnKey" class="txtLabel text-red" style="display: none;">The project steps should be progressive ..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <label class="txtLabel">Step</label>
                                                <div class="txtLabel">
                                                    <select id="selectupdateProjectStep" name="selectupdateProjectStep" onchange="getUpdateProjectStep(this)" class="form-control input-sm" style="width: 100%">
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

                                        <div id="divUpdateBidding" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners22">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.1</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="updatebiddingname1" name="updatebiddingname1" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="updateowner1" name="updateowner1" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.2</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="updatebiddingname2" name="updatebiddingname2" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="updateowner2" name="updateowner2" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Bidding Name No.3</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="updatebiddingname3" name="updatebiddingname3" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Owner</label>
                                                            <div class="input-group">
                                                                <input type="text" id="updateowner3" name="updateowner3" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divUpdateAwardMC" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners23">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Award Main Constructor</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="updateawardmc" name="updateawardmc" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Contact</label>
                                                            <div class="input-group">
                                                                <input type="text" id="updatecontactmc" name="updatecontactmc" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divUpdateAwardRF" class="row" style="display: none;">
                                            <div class="col-md-6 col-md-offset-2">
                                                <div id="rcorners24">
                                                    <div class="row">
                                                        <div class="col-md-6 col-md-offset-1">
                                                            <label class="txtLabel">Award Roll Former</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" id="updateawardrf" name="updateawardrf" class="form-control input input-sm">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="txtLabel">Contact</label>
                                                            <div class="input-group">
                                                                <input type="text" id="updatecontactrf" name="updatecontactrf" class="form-control input input-sm">
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
                                                    <select id="selectUpdateProductType" onchange="getComboA(this)" class="form-control input-sm" style="width: 100%">
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
                                                    <select id="selectUpdateProduct" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProduct" class="txtLabel text-red" style="display: none;">Should choose at least 1 product of the project ..!</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Profile</label>
                                                <input type="text" class="form-control input-sm txtLabel" id="updateProfile" name="updateProfile">
                                                <div class="txtLabel hidden">
                                                    <select id="selectUpdateProfile" class="form-control input-sm " style="width: 100%">
                                                    </select>
                                                </div>
                                                <div id="divErrorupProfile" class="txtLabel text-red" style="display: none;">Should choose at least 1 profile of the project ..!</div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Quantity</label>
                                                <div class="txtLabel">
                                                    <input type="text" id="updateQuantity" name="updateQuantity" autocomplete="off" class="form-control input-sm txtLabel" />
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
                                                <label class="txtLabel">Next/following</label>
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
                                                    <select id="selectUpdateStatus" class="form-control input-sm" style="width: 100%">
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
                                                    <textarea id="updatedetail" cols="40" rows="2" class="form-control input-sm txtLabel"></textarea>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-3 col-md-offset-2">
                                                <label class="txtLabel">Updated by</label>
                                                <div class="txtLabel">
                                                    <input type="text" id="updateUsers" name="updateUsers" autocomplete="off" disabled class="form-control input-sm txtLabel" />
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="txtLabel">Last date</label>
                                                <div class="txtLabel">
                                                    <input type="text" id="updateLastdate" name="updateLastdate" autocomplete="off" disabled class="form-control input-sm txtLabel" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div id="divUpdateEntry" class="col-md-2 col-md-offset-2">
                                                <label class="txtLabel">Save Entry</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryUpdateProject">Save Entry</button>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-md-offset-2" id="divUpdateNewProduct" style="display: none">
                                                <label class="txtLabel">Add New Product</label>
                                                <div class="">
                                                    <button type="button" class="btn btn-warning btn-flat btn-block btn-sm" id="btnSaveHistoryUpdateProduct">Save New Product</button>
                                                </div>
                                            </div>

                                            <div class="col-md-2" id="divUpdateNewEntry">
                                                <label class="txtLabel">Start New Entry</label>
                                                <div class="">
                                                    <a href="weeklyreport?opt=wkr" class="btn btn-success btn-flat btn-block btn-sm">New Entry</a>
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
                                                <input id="newarchitect" type="text" class="form-control input-sm">
                                            </div>
                                            <div id="divErrorArchitect" class="txtLabel text-red" style="display: none;">Please enter architect name..!</div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Details</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="detailarchitect" cols="40" rows="3" class="form-control input-sm"></textarea>
                                            </div>
                                            <div id="divErrorDetailarchitect" class="txtLabel text-red" style="display: none;">Please enter comment for new architect name..!</div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveNewArchitect">Save Architect Entry</button>
                                            </div>
                                        </div>

                                        <div class="col-md-2" id="divArchitectNewEntry">
                                            <label class="txtLabel">Start New Entry</label>
                                            <div class="">
                                                <a href="weeklyreport?opt=wkr" class="btn btn-success btn-flat btn-block btn-sm">New Entry</a>
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
                                            <div id="divErrorIntakeProject" class="txtLabel text-red" style="display: none;">Please select a project...!</div>
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
                                                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="1" checked>
                                                    มีไฟล์เอกสารแนบ
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 ">
                                            <div class="radio txtLabel">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="0">
                                                    ไม่มีไฟล์แนบ
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 ">
                                            <%--<button class="btn btn-info btn-block btn-flat btn-sm">Browse</button>--%>
                                            <input class="btn btn-info btn-block btn-flat btn-sm hidden" type="file" id="exampleInputFile">
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <input class="btn btn-info btn-block btn-flat btn-sm" type="file" id="postedFile" name="postedFile" />

                                            <progress id="fileProgress" style="display: none"></progress>

                                            <span id="lblMessage" class="txtLabel" style="color: Green"></span>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Description</label>
                                            <div class="txtLabel">
                                                <input class="form-control input-sm" type="text" id="intakeDesc" name="intakeDesc" />
                                            </div>
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
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Details</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="intakeDetails" cols="40" rows="2" class="form-control input-sm txtLabel"></textarea>
                                            </div>
                                            <div id="divErrorIntakeDetail" class="txtLabel text-red" style="display: none;">Please select status..!</div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <input type="button" id="btnUpload" class="btn btn-info btn-flat btn-block btn-sm" value="Save and Upload" />
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm hidden" id="Button1">Save Entry</button>
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
                                                <textarea id="otherdetail" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                            <div id="divErrorDetailOther" class="txtLabel text-red" style="display: none;">Please enter your comment..!</div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnOtherDetail">Save Entry</button>
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
