<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="mmproducts.aspx.cs" Inherits="SaleSpec.pages.trans.mmproducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>
        <style>
            .hide_column {
                display: none;
            }

            #tblYearly i:hover {
                cursor: pointer;
            }

            #tblYearlyoption i:hover {
                cursor: pointer;
            }

            #tblpoinmaster i:hover {
                cursor: pointer;
            }

            #tblStepNewOption i:hover {
                cursor: pointer;
            }

           #tblpoinoption i:hover {
                cursor: pointer;
           }

           #btnSelectoption i:hover {
                cursor: pointer;
           }

        </style>



        <script>
            $(document).ready(function () {

                var selectTextInYear = $('#selectTextInYear');
               

                $.ajax({
                    url: '../trans/Dataservices.asmx/GetDataYearly',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectTextInYear.append($('<option/>', { value: -1, text: 'Select Year' }));
                        $(data).each(function (index, item) {
                            selectTextInYear.append($('<option/>', { value: item.id, text: item.year_desc }));
                        });
                    }
                });



                var selectsteptypeText = $('#selectsteptypeText');


                $.ajax({
                    url: '../trans/Dataservices.asmx/GetmmSteptype',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectsteptypeText.append($('<option/>', { value: -1, text: 'Select Type' }));
                        $(data).each(function (index, item) {
                            selectsteptypeText.append($('<option/>', { value: item.steptype, text: item.steptype }));
                        });
                    }
                });




                var selectTextoption = $('#selectTextoption');
                    $.ajax({
                    url: '../trans/Dataservices.asmx/Getmmoptionmaster',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectTextoption.append($('<option/>', { value: -1, text: 'Select Option' }));
                        $(data).each(function (index, item) {
                            selectTextoption.append($('<option/>', { value: item.option_id, text: item.optiondetail }));
                        });
                    }
                });



                 



                var btnSavechanges = $('#btnSavechanges');
                btnSavechanges.click(function () {
                    var str1 = $("#selectsteptypeText").val();
                    var str2 = $('#selectTextInYear').val();

                    $.ajax({
                        url: '../trans/Dataservices.asmx/check_Pointmaster',
                        method: 'post',
                        dataType: 'json',
                        data: {
                            stepetype: str1,
                            inYear: str2
                        },
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {
                                $.each(obj, function (key, inval) {
                                    var xcount = data[key].xcount;
                                    if (xcount > 0) {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'บันทึกข้อมูลไม่สำเร็จ',

                                            footer: '<a href>Why do I have this issue?</a>'
                                        })
                                    }
                                    else {
                                        if (str1 != '-1' && str2 != '-1') {
                                            savedatachanges();
                                        }
                                        else {

                                            Swal.fire({
                                                icon: 'error',
                                                title: 'บันทึกข้อมูลไม่สำเร็จ',
                                                text: 'กรุณากรอกข้อมูลให้ครบถ้วน !',
                                                footer: '<a href>Why do I have this issue?</a>'
                                            })

                                        }
                                    }

                                });

                            }
                            else {
                                if (str1 != '-1' && str2 != '-1') {
                                    savedatachanges();
                                }

                                else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'บันทึกข้อมูลไม่สำเร็จ',
                                        text: 'กรุณากรอกข้อมูลให้ครบถ้วน!',
                                        footer: '<a href>Why do I have this issue?</a>'
                                    })

                                }

                            }
                        }
                    });
                });





                $("#tblpoinmaster").on('click', '.btndelete', function () {
                    var currentRow = $(this).closest("tr");
                    var id = currentRow.find("td:eq(0)").html();
                    var typeupdate = '3';
                    var InYear = '';
                    var steptype = '';
                    var pointmin = currentRow.find("td:eq(4)").html();
                    var pointmax = currentRow.find("td:eq(5)").html();
                    var descvoucher = '';
                    var remark = '';
                    var create_by = '';
                    var create_date = '';
                    var update_by = '';
                    var update_date = '';




                    Swal.fire({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, delete it!'
                    }).then((result) => {
                        if (result.value) {
                            $.ajax({
                                url: '../trans/Dataservices.asmx/spsave_mmpointmaster',
                                method: 'post',
                                data: {
                                    typeupdate: typeupdate, id: id, InYear, steptype, pointmin, pointmax, descvoucher, remark, create_by, create_date, update_by, update_date
                                },
                                dataType: 'json',
                                complete: function (data) {
                                    Swal.fire(
                                        'Deleted!',
                                        'Your file has been deleted.',
                                        'success'
                                    )
                                    //getExpLists();
                                    reload();
                                }

                            });

                        }
                    })

                });





                var btnClose = $('#btnClose');
                btnClose.click(function () {
                    $('#selectTextInYear').val('-1');
                    $('#selectTextInYear').change();
                    $('#selectsteptypeText').val('-1');
                    $('#selectsteptypeText').change();
                    $('#txtpointmin').val('');
                    $('#txtpointmax').val('');
                    $('#txtdescvoucher').val('');
                    $('#textremark').val('');
                });



                  var  btnCloseoption = $('#btnCloseoption');
                 btnCloseoption.click(function () {
                    $('#selectTextoption').val('-1');
                    $('#selectTextoption').change();                  
                    $('#InYearNewoption').val('');
                    $('#TextsteptypeID').val('');
                    $('#Txtsteptype').val('');
                    $('#TextCost').val('');
                    $('#TextProductName').val('');
                });

               
                 var  btnCloseoptionup = $('#btnCloseoptionup');
                 btnCloseoptionup.click(function () {
                    $('#selectTextoption').val('-1');
                    $('#selectTextoption').change();                  
                    $('#InYearNewoption').val('');
                    $('#TextsteptypeID').val('');
                    $('#Txtsteptype').val('');
                    $('#TextCost').val('');
                    $('#TextProductName').val('');
                });



                var btnCloseup = $('#btnCloseup');
                btnCloseup.click(function () {
                    $('#selectTextInYear').val('-1');
                    $('#selectTextInYear').change();
                    $('#selectsteptypeText').val('-1');
                    $('#selectsteptypeText').change();
                    $('#txtpointmin').val('');
                    $('#txtpointmax').val('');
                    $('#txtdescvoucher').val('');
                    $('#textremark').val('');
                });




                $("#tblpoinmaster").on('click', '.btnSelect', function () {
                    var currentRow = $(this).closest("tr");
                    var id = currentRow.find("td:eq(0)").html();
                    var xno = currentRow.find("td:eq(1)").html();
                    var InYear = currentRow.find("td:eq(2)").html();
                    var steptype = currentRow.find("td:eq(3)").html();
                    var pointmin = currentRow.find("td:eq(4)").html();
                    var pointmax = currentRow.find("td:eq(5)").html();
                    var descvoucher = currentRow.find("td:eq(6)").html();
                    var remark = currentRow.find("td:eq(7)").html();

                    $('#txtID').val(id);
                    $('#selectTextInYearEdit').val(InYear);
                    $('#selectTextInYearEdit').change();
                    $('#selectsteptypeTextEdit').val(steptype);
                    $('#selectsteptypeTextEdit').change;
                    $('#txtpointminEdit').val(pointmin);
                    $('#txtpointmaxEdit').val(pointmax);
                    $('#txtdescvoucherEdit').val(descvoucher);
                    $('#textremarkEdit').val(remark);

                    $('#myModalEdit').modal({ backdrop: false });
                    $('#myModalEdit').modal('show');

                });



                $("#tblpoinoption").on('click', '.btnSelectoption', function () {
                    var currentRow = $(this).closest("tr");
                    var id = currentRow.find("td:eq(0)").html();
                    var xno = currentRow.find("td:eq(1)").html();
                    var InYear = currentRow.find("td:eq(2)").html();
                    var steptype_id = currentRow.find("td:eq(3)").html();
                    var step_type = currentRow.find("td:eq(4)").html();
                    var step = currentRow.find("td:eq(5)").html();
                    var option_id = currentRow.find("td:eq(6)").html();
                    var optiondetail = currentRow.find("td:eq(7)").html();
                    var images = currentRow.find("td:eq(8)").html();
                    var detailcost = currentRow.find("td:eq(9)").html();
                    var productname = currentRow.find("td:eq(10)").html();                   
                    //var pic = currentRow.find("td:eq(11)").html();
                


                    $('#TxtIDEditOption').val(id);
                    $('#InYearNewoptionEdit').val(InYear);
                    $('#TxtsteptypeEdit').val(step_type);
                    //$('#Txtimg').val(pic);
                    $('#TextsteptypeIDEdit').val(steptype_id);
                    $('#TextCostEdit').val(detailcost);
                    $('#TextProductNameEdit').val(productname);
                    $('#selectTextoptionEdit').val(option_id);
                    $('#selectTextoptionEdit').change();


                 
                  

                    $('#myModalNewoptionEdit').modal({ backdrop: false });
                    $('#myModalNewoptionEdit').modal('show');

                });



                  $("#tblpoinoption").on('click', '.btndeleteoption', function () {
                    var currentRow = $(this).closest("tr");
                    var id = currentRow.find("td:eq(0)").html();
                    var xno = currentRow.find("td:eq(1)").html();
                    var InYear = currentRow.find("td:eq(2)").html();
                    var steptype_id = currentRow.find("td:eq(3)").html();
                    var step_type = currentRow.find("td:eq(4)").html();
                    var step = currentRow.find("td:eq(5)").html();
                    var option_id = currentRow.find("td:eq(6)").html();
                    var optiondetail = currentRow.find("td:eq(7)").html();
                    var images = currentRow.find("td:eq(8)").html();
                    var detailcost = currentRow.find("td:eq(9)").html();
                    var productname = currentRow.find("td:eq(10)").html();                 
                    //var pic = currentRow.find("td:eq(11)").html();
                


                    $('#TxtIDOptionDEL').val(id);
                    $('#InYearNewoptionDEL').val(InYear);
                    $('#TxtsteptypeDEL').val(step_type);
                    //$('#TxtimgDEL').val(pic);
                    $('#TextsteptypeIDDEL').val(steptype_id);
                    $('#TextCostDEL').val(detailcost);
                    $('#TextProductNameDEL').val(productname);
                    $('#selectTextoptionDEL').val(option_id);
                    $('#selectTextoptionDEL').change();


                    $('#myModalNewoptiondelete').modal({ backdrop: false });
                    $('#myModalNewoptiondelete').modal('show');

                });



                var btnSaveOptionhanges = $('#btnSaveOptionchanges');
                    btnSaveOptionhanges.click(function () {
                    var str1 = document.getElementById("TextsteptypeID").value;
                    var str2 = document.getElementById("selectTextoption").value;
                    var str3 = document.getElementById("TextCost").value;
                    var str4 = document.getElementById("TextProductName").value;
                  
                     

                    if (str1 != '' & str2 != -1 & str3 != '' & str4 != '') {
                        
                        SaveOption();  
                         Swal.fire(

                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                          )


                    }

                    else {

                        Swal.fire({
                            icon: 'error',
                            title: 'บันทึกข้อมูลไม่สำเร็จ',
                            text: 'กรูณากรอกข้อมูลให้ครบถ้วน!',
                      
                        })

                    }

                     

                });




                var btnUpdatechanges = $('#btnUpdatechanges');
                btnUpdatechanges.click(function () {
                    var str1 = document.getElementById("txtID").value;
                    if (str1 != '') {
                        Swal.fire({
                            title: 'Are you sure?',
                            text: "Are you sure you want to update changes?!",
                            icon: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, update changes.!'
                        }).then((result) => {
                            if (result.value) {
                                updatedatachanges();
                            }
                        });
                    }

                    else {

                        Swal.fire({
                            icon: 'error',
                            title: 'บันทึกข้อมูลไม่สำเร็จ',
                            text: 'กรูณากรอกข้อมูลให้ครบถ้วน!',
                            footer: '<a href>Why do I have this issue?</a>'
                        })

                    }


                });




                function updatedatachanges() {
                    var empcode = '<%= Session["EmpCode"] %>';
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                    var currentdate2 = yyyy + '-' + mm + '-' + dd;

                    $.ajax({
                        url: '../trans/Dataservices.asmx/spsave_mmpointmaster',
                        method: 'post',
                        data: {
                            typeupdate: '2',
                            id: $('#txtID').val(),
                            InYear: $('#selectTextInYearEdit').val(),
                            steptype: $('#selectsteptypeTextEdit').val(),
                            pointmin: $('#txtpointminEdit').val(),
                            pointmax: $('#txtpointmaxEdit').val(),
                            descvoucher: $('#txtdescvoucherEdit').val(),
                            remark: $('#textremarkEdit').val(),
                            create_by: empcode,
                            create_date: currentdate,
                            update_by: empcode,
                            update_date: currentdate

                        },
                        datatype: 'json',
                        success: function (data) {
                            $('#myModalEdit').modal('hide');
                            $('#txtID').val('');
                            $('#selectTextInYearEdit').val('');
                            $('#selectsteptypeTextEdit').val('');
                            $('#txtpointminEdit').val('');
                            $('#txtpointmaxEdit').val('');
                            $('#txtdescvoucherEdit').val('');
                            $('#textremarkEdit').val('');
                            Swal.fire(
                                'Saved!',
                                'Your file has been save changes.',
                                'success'
                            )
                            reloadEdit();
                        }
                    });
                }






            });





            function savedatachanges() {
                var empcode = '<%= Session["EmpCode"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                $.ajax({

                    url: '../trans/Dataservices.asmx/spsave_mmpointmaster',
                    method: 'post',
                    data: {
                        typeupdate: '1',
                        id: '',
                        InYear: $('#selectTextInYear').val(),
                        steptype: $('#selectsteptypeText').val(),
                        pointmin: $('#txtpointmin').val(),
                        pointmax: $('#txtpointmax').val(),
                        descvoucher: $('#txtdescvoucher').val(),
                        remark: $('#textremark').val(),
                        create_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate

                    },
                    datatype: 'json',
                    success: function (data) {
                        $('#myModalNew').modal('hide');
                        $('#selectTextInYear').val('-1');
                        $('#selectTextInYear').change();
                        $('#selectsteptypeText').val('-1');
                        $('#selectsteptypeText').change();
                        $('#txtpointmin').val('');
                        $('#txtpointmax').val('');
                        $('#txtdescvoucher').val('');
                        $('#textremark').val('');
                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                        reload();
                    }
                });
            }



            function reload() { document.getElementById("<%=Buttonpoint.ClientID %>").click(); }

            function reloadEdit() { document.getElementById("<%=ButtonpointEdit.ClientID %>").click(); }

            function SaveOption() { document.getElementById("<%=btnSaveOption.ClientID %>").click(); }


        </script>



        <h1>Products
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary" style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">
                            <div class="col-md-12">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs">
                                        <li class="<%= strClassActiveOption %> txtLabel"><a href="#option" data-toggle="tab">Metre to Mile Option </a></li>
                                        <li class=" <%= strClassActivePoint %> txtLabel"><a href="#Pointmaster" data-toggle="tab">Pointmaster</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <%--       <div class="active tab-pane" id="option">--%>

                                        <div class="tab-pane <%= strClassActiveOption %>" id="option">

                                            <!-- Post -->


                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="box box-primary" style="height: 100%;">
                                                        <div class="box-header">
                                                            <div class="box-body">
                                                                <div class="col-md-2">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">Year</label>
                                                                        <div class="txtLabel">
                                                                            <div class="input-group date">
                                                                                <input type="text" class="form-control input-sm pull-left txtLabel" id="txtYearDescoption" name="txtYearDescoption" value="<%= Session["YearDescoption"] %>" onclick="modalDataYearlyoption()" readonly required>
                                                                                <input type="hidden" class="form-control input-sm pull-left txtLabel" id="TextInYearoption" name="TextInYearoption" value="<%= Session["Yearoption"] %>">
                                                                                <div class="input-group-btn">
                                                                                    <button type="button" id="btnYeardesc" class="btn btn-info btn-flat btn-sm" onclick="modalDataYearlyoption()">Find..!</button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>



                                                                <div class="modal modal-default fade" id="myModalYearlyoption">
                                                                    <div class="modal-dialog" style="width: 800px">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                                <h4 class="modal-title">Selected Year</h4>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <table id="tblYearlyoption" class="table table-bordered table-striped table-hover table-condensed">
                                                                                    <thead class="txtLabel">
                                                                                        <tr>
                                                                                            <th>ID</th>
                                                                                            <th>Year Desc</th>
                                                                                            <th></th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody class="txtLabel">
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                            <div class="modal-footer">
                                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>


                                                                <div class="col-md-2">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">เรียกดูข้อมูล</label>
                                                                        <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel col-md-2" id="Button2" runat="server" onserverclick="btnSearchmmoption_click">เรียกดูข้อมูล</button>
                                                                    </div>
                                                                </div>


                                 <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">report</label>
                                    <button class="btn btn-danger btn-sm btn-flat btn-block txtLabel col-md-2" id="Button4" runat="server" onserverclick="btnExportPDF_click">Export PDF</button>
                                </div>
                            </div>



                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>






                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="box box-primary" style="height: 100%;">
                                                        <div class="box-header">
                                                            <div class="box-body">
                                                                <span class="pull-right">
                                                                    <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModaloption()" data-toggle="tooltip" title="New Entry!">
                                                                        <i class="fa fa-plus"></i>
                                                                    </button>
                                                                </span>
                                                            </div>


                                                            <table id="tblpoinoption" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;">
                                                                <thead class="bg-light-blue txtLabel txtLabel" style="width: 100%;">
                                                                    <tr>
                                                                        <%--<th class="hide">ID</th>--%>
                                                                        <th class="hide">ID</th>
                                                                        <th style="text-align: center;">ลำดับ</th>
                                                                        <th style="text-align: center;">Year</th>
                                                                        <th class="hide">steptype_id</th>
                                                                        <th class="hide">steptype</th>
                                                                        <th style="text-align: center;">Step</th>
                                                                        <th class="hide">OptionID</th>                                                                      
                                                                        <th style="text-align: center;">Option</th>
                                                                        <th style="text-align: center;">Images</th>
                                                                        <th style="text-align: center;">Price Product</th>
                                                                        <th style="text-align: center;">Productname</th> 
                                                                        <th style="width: 20px; text-align: center;">#</th>
                                                                        <th style="width: 20px; text-align: center;">#</th>

                                                                    </tr>
                                                                </thead>

                                                                <tbody class="txtLabel" style="text-align: center;">
                                                                    <%= strTblmmoption %>
                                                                </tbody>

                                                            </table>

                                                        </div>
                                                    </div>
                                                </div>


                                            </div>


     

                               <div class="modal modal-default fade" id="myModalNewoption">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" id="btnCloseoptionup" name="btnCloseoptionup" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">เพิ่มข้อมูล metre to mile Option</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">

                                                             <div class="row" style="margin-bottom: 20px">
                                                          
                                                              <div class="col-md-11">
                                                            <div class="txtLabel">Type <span style="color:red;">*</span></div>
                                                            <div class="input-group date">
                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="Txtsteptype" name="Txtsteptype" value="" onclick="modalDataYearNewoption()" readonly required>
                                                              <input type="hidden" class="form-control input-sm pull-left txtLabel" id="TextsteptypeID" name="TextsteptypeID" value=""> 
                                                                <input type="hidden" class="form-control input-sm pull-left txtLabel" id="InYearNewoption" name="InYearNewoption" value=""> 
                                                                  <div class="input-group-btn">
                                                              <button type="button" id="btnProjectname" class="btn btn-info btn-flat btn-sm" onclick="modalDataYearNewoption()">Find..!</button>                                                           
                                                                </div>      
                                                                  
                                                     </div>
                                           
                                
                                </div>
                            </div> 

                                                        
                                                                
                                                            <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Option <span style="color:red;">*</span></div>
                                                                    <div class="txtLabel">
                                                                   <select id="selectTextoption" name="selectTextoption" class="form-control input-sm col-md-4 txtLabel" style="width:100%">
                                                                   </select>
                                                                    </div>
                                                                    </div>
                                                               
                                                            </div>


                                                          

                                                            <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Price Product <span style="color:red;">*</span></div>
                                                                        <textarea class="form-control input input-sm" id="TextCost" name="TextCost" style="width: 100%;"> </textarea>
                                                               </div>
                                                               
                                                            </div>



                                                             <div class="row" style="margin-bottom: 20px">                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Name Product<span style="color:red;">*</span></div>
                                                                  <textarea class="form-control input input-sm" id="TextProductName" name="TextProductName"> </textarea>
                                                               </div>
                                                               
                                                            </div>




                                                            <div class="row">                                                             
                                                                <div class="col-md-11">
                                                                    <div class="txtLabel">pic</div>                                                   
                                                                         <asp:FileUpload ID="FileUpload"  runat="server" />                                                                                                                        
                                                                </div>
                                                            </div>
                                                   



                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" id="btnSaveOptionchanges" name="btnSaveOptionchanges" class="btn btn-info">Save</button>
                                                           <asp:Button ID="btnSaveOption" runat="server" Text="Save" class="btn btn-info hidden"  OnClick="btnSavemmoption_Click" />
                                                           &nbsp;&nbsp;  
                                                        <button type="button" id="btnCloseoption" name="btnCloseoption" class="btn btn-default" data-dismiss="modal">Close</button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                             <div class="modal modal-default fade" id="myModalNewoptionEdit">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" id="btnCloseupoptionEdit" name="btnCloseup" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">แก้ไขข้อมูล metre to mile Option</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">

                                                             <div class="row">
                                                  
                                                                <div class="col-md-11 hidden">
                                                            <div class="txtLabel">ID</div>
                                                              <textarea class="form-control input input-sm" id="TxtIDEditOption" name="TxtIDEditOption" style="width: 100%;"> </textarea>
                                                                                        
                                                                </div>





                                                               
                                                            </div>

                                                             <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Cost</div>
                                                                    <div class="txtLabel">
                                                                       <input type="text" id="TxtsteptypeEdit" name="TxtsteptypeEdit" readonly class="form-control input input-sm"  style="width: 100%;" value="">
                                                                       <input type="hidden" id="TextsteptypeIDEdit" name="TextsteptypeIDEdit"  class="form-control input input-sm"  style="width: 100%;" value="">
                                                                      <input type="hidden" id="InYearNewoptionEdit" name="InYearNewoptionEdit"  class="form-control input input-sm"  style="width: 100%;" value="">
                                                                    
                                                                    </div>
                                                                    </div>
                                                               
                                                            </div>


                                                                
                                                            <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Option</div>
                                                                    <div class="txtLabel">  
                                                                  <input type="text" id="selectTextoptionEdit" name="selectTextoptionEdit" readonly autocomplete="off" class="form-control input input-sm"  style="width: 100%;" value="">

                                                                    </div>
                                                                    </div>
                                                               
                                                            </div>


                                                          
                                                            <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Price Product</div>
                                                                        <textarea class="form-control input input-sm" id="TextCostEdit" name="TextCostEdit" style="width: 100%;"> </textarea>

                                                                    </div>
                                                               
                                                            </div>




                                                            <div class="row" style="margin-bottom:20px; text-align:left;">
                                                             
                                                                <div class="col-md-11">
                                                                <div class="txtLabel"> Name Product</div>

                                                                    <textarea class="form-control input input-sm" id="TextProductNameEdit" name="TextProductNameEdit" style="width: 100%;"> </textarea>
                                                                   
                                                                 
                                                                        </div>
                                                             
                                                            </div>



                                                            <div class="row">                                                             
                                                                <div class="col-md-11">
                                                                    <div class="txtLabel">pic</div>
                                                                 <%--      <label class="file txtLabel">--%>
                                                                         <asp:FileUpload ID="FileUploadEdit"  runat="server" />    
                                                            <%--  <span class="file-custom"></span>
                                                                   </label>      --%>                                                               
                                                                </div>
                                                            </div>

                                                            
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">                                                  
                                                           <asp:Button ID="btnUpdateOption" runat="server" Text="Update" class="btn btn-info"  OnClick="btnUpdatemmoption_Click" />
                                                        &nbsp;&nbsp;  
                                                        <button type="button" id="btnCloseoptionEdit" name="btnCloseoptionEdit" class="btn btn-default" data-dismiss="modal">Close</button>
                                                   </div>
                                                </div>
                                            </div>
                                        </div>


                                              <div class="modal modal-default fade" id="myModalNewoptiondelete">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button"  name="btnCloseup" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">Delete</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">

                                                             <div class="row">
                                                  
                                                                <div class="col-md-11 hidden">
                                                            <div class="txtLabel">ID</div>
                                                              <textarea class="form-control input input-sm" id="TxtIDOptionDEL" name="TxtIDOptionDEL" style="width: 100%;"> </textarea>                                                       
                                                                    
                                                                </div>


                                                               
                                                            </div>

                                                             <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Cost</div>
                                                                    <div class="txtLabel">
                                                                       <input type="text" id="TxtsteptypeDEL" name="TxtsteptypeDEL" readonly class="form-control input input-sm"  style="width: 100%;" value="">
                                                                       <input type="hidden" id="TextsteptypeIDDEL" name="TextsteptypeIDDEL"  class="form-control input input-sm"  style="width: 100%;" value="">
                                                                      <input type="hidden" id="InYearNewoptionDEL" name="InYearNewoptionDEL"  class="form-control input input-sm"  style="width: 100%;" value="">
                                                                    
                                                                    </div>
                                                                    </div>
                                                               
                                                            </div>


                                                                
                                                            <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Option</div>
                                                                    <div class="txtLabel">  
                                                                  <input type="text" id="selectTextoptionDEL" name="selectTextoptionDEL" readonly autocomplete="off" class="form-control input input-sm"  style="width: 100%;" value="">

                                                                    </div>
                                                                    </div>
                                                               
                                                            </div>


                                                          


                                                            <div class="row" style="margin-bottom: 20px">
                                                  
                                                                <div class="col-md-11">
                                                            <div class="txtLabel">Cost</div>
                                                                        <textarea class="form-control input input-sm" id="TextCostDEL" name="TextCostDEL" style="width: 100%;"> </textarea>

                                                                    </div>
                                                               
                                                            </div>




                                                            <div class="row" style="margin-bottom:20px; text-align:left;">
                                                             
                                                                <div class="col-md-11">
                                                                <div class="txtLabel"> Name Product</div>
                                                                        <input type="text" id="TextProductNameDEL" name="TextProductNameDEL" autocomplete="off" class="form-control input input-sm"  style="width: 100%;" value="">
                                                                 
                                                                        </div>
                                                             
                                                            </div>


                                                            
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                           <asp:Button ID="Button3" runat="server" Text="Delete" class="btn btn-danger"  OnClick="btnDelete_Click" />
                                                        &nbsp;&nbsp;  
                                                        <button type="button" id="btnCloseoptionDEL" name="btnCloseoptionEdit" class="btn btn-default" data-dismiss="modal">Close</button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="modal modal-default fade" id="myModalstepNewoption">
                                            <div class="modal-dialog" style="width: 800px">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">Selected Year</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <table id="tblStepNewOption" class="table table-bordered table-striped table-hover table-condensed">
                                                            <thead class="txtLabel">
                                                                <tr>
                                                                    <th>ID</th>
                                                                    <th>steptype</th>
                                                                     <th>มูลค่าของรางวัล</th>
                                                                     <th>Year</th>
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="txtLabel">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>




                       



                                    </div> <!-- end tab1 -->
                                          














                                    <div class="tab-pane <%= strClassActivePoint %>" id="Pointmaster">
                                        <!-- Post -->


                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="box box-primary" style="height: 100%;">
                                                    <div class="box-header">
                                                        <div class="box-body">
                                                            <div class="col-md-2">
                                                                <div class="form-group">
                                                                    <label class="txtLabel">Year</label>
                                                                    <div class="txtLabel">
                                                                        <div class="input-group date">
                                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="txtYearDesc" name="txtYearDesc" value="<%= Session["PointYearDesc"] %>" onclick="modalDataYearly()" readonly required>
                                                                            <input type="hidden" class="form-control input-sm pull-left txtLabel" id="TextInYear" name="TextInYear" value="<%= Session["PointYear"] %>">
                                                                            <div class="input-group-btn">
                                                                                <button type="button" id="btnProjectname1" class="btn btn-info btn-flat btn-sm" onclick="modalDataYearly()">Find..!</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>



                                                            <div class="modal modal-default fade" id="myModalYearly">
                                                                <div class="modal-dialog" style="width: 800px">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                            <h4 class="modal-title">Selected Year</h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <table id="tblYearly" class="table table-bordered table-striped table-hover table-condensed">
                                                                                <thead class="txtLabel">
                                                                                    <tr>
                                                                                        <th>ID</th>
                                                                                        <th>Year Desc</th>
                                                                                        <th></th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody class="txtLabel">
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-2">
                                                                <div class="form-group">
                                                                    <label class="txtLabel">เรียกดูข้อมูล</label>
                                                                    <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel col-md-2" id="btnSearch" runat="server" onserverclick="btnSearch_click">เรียกดูข้อมูล</button>
                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="box box-primary" style="height: 100%;">
                                                    <div class="box-header">
                                                        <div class="box-body">
                                                            <span class="pull-right">
                                                                <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                                    <i class="fa fa-plus"></i>
                                                                </button>
                                                            </span>


                                                        </div>


                                                        <table id="tblpoinmaster" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;">
                                                            <thead class="bg-light-blue txtLabel txtLabel" style="width: 100%;">
                                                                <tr>
                                                                    <th class="hide">ID</th>
                                                                    <th style="text-align: center;">ลำดับ</th>
                                                                    <th style="text-align: center;">Year</th>
                                                                    <th style="text-align: center;">Type</th>
                                                                    <th style="text-align: center;">Mile Start</th>
                                                                    <th style="text-align: center;">Mile End</th>
                                                                    <th style="text-align: center;">มูลค่าของรางวัล</th>
                                                                    <th style="text-align: center;">หมายเหตุ</th>
                                                                    <th style="width: 20px; text-align: center;">#</th>
                                                                    <th style="width: 20px; text-align: center;">#</th>

                                                                </tr>
                                                            </thead>

                                                            <tbody class="txtLabel" style="text-align: center;">
                                                                <%= strTblDetail %>
                                                            </tbody>

                                                        </table>





                                                    </div>
                                                </div>
                                            </div>
                                        </div>






                                        <div class="modal modal-default fade" id="myModalNew">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" id="btnCloseup" name="btnCloseup" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">เพิ่มข้อมูล Point Master</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">

                                                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label class="txtLabel">Year</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <select id="selectTextInYear" name="selectTextInYear" class="form-control input-sm col-md-4" style="width: 100%">
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>



                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">TYPE</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <select id="selectsteptypeText" name="selectsteptypeText" class="form-control input-sm col-md-4" style="width: 100%">
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>




                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">Mile Start</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtpointmin" name="txtpointmin" autocomplete="off" class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>




                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">Mile Eand</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtpointmax" name="txtpointmax" autocomplete="off" class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>



                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">มูลค่าของรางวัล</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtdescvoucher" name="txtdescvoucher" autocomplete="off" class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>



                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">หมายเหตุ</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <textarea id="textremark" name="textremark" class="form-control input input-sm"></textarea>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" id="btnSavechanges" name="btnSavechanges" class="btn btn-info">Save</button>
                                                        <button type="button" class="btn btn-danger hidden" id="Button1" runat="server">Save New</button>
                                                        <button type="button" id="Buttonpoint" name="Buttonpoint" runat="server" onserverclick="btnpointdetail_click" class="btn btn-primary btn-sm btn-block hidden">Save</button>
                                                        &nbsp;&nbsp;  
                                                        <button type="button" id="btnClose" name="btnClose" class="btn btn-default" data-dismiss="modal">Close</button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="modal modal-default fade" id="myModalEdit">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" id="btnCloseupEdit" name="btnCloseup" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">แก้ไขข้อมูล Point Master</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">

                                                            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label class="txtLabel">Year</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="selectTextInYearEdit" name="selectTextInYearEdit" autocomplete="off" readonly class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">TYPE</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="selectsteptypeTextEdit" name="selectsteptypeTextEdit" autocomplete="off" readonly class="form-control input input-sm " style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel hidden">ID</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtID" name="txtID" autocomplete="off" class="form-control input input-sm hidden" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>




                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">Mile Start</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtpointminEdit" name="txtpointminEdit" autocomplete="off" class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>




                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">Mile Eand</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtpointmaxEdit" name="txtpointmaxEdit" autocomplete="off" class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>



                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">มูลค่าของรางวัล</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <input type="text" id="txtdescvoucherEdit" name="txtdescvoucherEdit" autocomplete="off" class="form-control input input-sm" style="width: 100%" value="">
                                                                    </div>
                                                                </div>
                                                            </div>



                                                            <div class="row" style="margin-bottom: 5px">
                                                                <div class="col-md-4 txtLabel">หมายเหตุ</div>
                                                                <div class="col-md-8">
                                                                    <div class="txtLabel">
                                                                        <textarea id="textremarkEdit" name="textremarkEdit" class="form-control input input-sm"></textarea>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" id="btnUpdatechanges" name="btnUpdatechanges" class="btn btn-info">Save</button>

                                                        <button type="button" id="ButtonpointEdit" name="ButtonpointEdit" runat="server" onserverclick="btnpointdetail_click" class="btn btn-primary btn-sm btn-block hidden">Save</button>
                                                        &nbsp;&nbsp;  
                       <button type="button" id="btnCloseEdit" name="btnClose" class="btn btn-default" data-dismiss="modal">Close</button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>






                                    </div>

                                    <!-- endtab2 -->






                                </div>






                            </div>
                        </div>






                    </div>
                </div>
            </div>
        </div>
        </div>


                <script>


                    function openModal() {

                        $('#myModalNew').modal({ backdrop: false });
                        $('#myModalNew').modal('show');
                    }




                    function openModaloption() {

                        $('#myModalNewoption').modal({ backdrop: false });
                        $('#myModalNewoption').modal('show');


                    }

                    function modalDataYearly() {

                        $.ajax({
                            url: '../trans/Dataservices.asmx/GetDataYearly',
                            method: 'post',
                            datatype: 'json',
                            success: function (data) {
                                var table;
                                table = $('#tblYearly').DataTable();
                                table.clear();

                                if (data != '') {
                                    $.each(data, function (i, item) {
                                        table.row.add([data[i].id
                                            , data[i].year_desc
                                            , data[i].urlview]);

                                    })

                                    table.draw();


                                    $('#tblYearly tbody').on('click', 'td', function (e) {
                                        e.preventDefault();

                                        var strid = $(this).parent().children().eq(0).text();   //this.parentElement.rowIndex;
                                        var year_desc = $(this).parent().children().eq(1).text(); // this.cellIndex;                        



                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;

                                        if (rIndex != 0 & cIndex == 2) {

                                            //console.log(id + "  :  " + project_name + " rowindex : " + rIndex + " cellindex : " + cIndex);                                                             
                                            //var id = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', '');
                                            //console.log(id);
                                            var strid = $('#tblYearly').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[1].innerHTML;
                                            var year_desc = $('#tblYearly').find('tr:eq(' + rIndex + ')').find('td:eq(1)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;

                                            document.getElementById("TextInYear").value = strid;
                                            document.getElementById("txtYearDesc").value = year_desc;


                                            $("#myModalYearly").modal("hide");

                                        }

                                    })

                                }

                            }

                        });


                        $('[id=myModalYearly]').modal('show');


                    }


                    function modalDataYearlyoption() {

                        $.ajax({
                            url: '../trans/Dataservices.asmx/GetDataYearly',
                            method: 'post',
                            datatype: 'json',
                            success: function (data) {
                                var table;
                                table = $('#tblYearlyoption').DataTable();
                                table.clear();

                                if (data != '') {
                                    $.each(data, function (i, item) {
                                        table.row.add([data[i].id
                                            , data[i].year_desc
                                            , data[i].urlview]);

                                    })

                                    table.draw();


                                    $('#tblYearlyoption tbody').on('click', 'td', function (e) {
                                        e.preventDefault();

                                        var strid = $(this).parent().children().eq(0).text();   //this.parentElement.rowIndex;
                                        var year_desc = $(this).parent().children().eq(1).text(); // this.cellIndex;                        



                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;

                                        if (rIndex != 0 & cIndex == 2) {

                                            //console.log(id + "  :  " + project_name + " rowindex : " + rIndex + " cellindex : " + cIndex);                                                             
                                            //var id = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', '');
                                            //console.log(id);
                                            var strid = $('#tblYearlyoption').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[1].innerHTML;
                                            var year_desc = $('#tblYearlyoption').find('tr:eq(' + rIndex + ')').find('td:eq(1)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;

                                            document.getElementById("TextInYearoption").value = strid;
                                            document.getElementById("txtYearDescoption").value = year_desc;


                                            $("#myModalYearlyoption").modal("hide");

                                        }

                                    })

                                }

                            }

                        });


                        $('[id=myModalYearlyoption]').modal('show');


                    }



                     function modalDataYearNewoption() {

                        $.ajax({
                            url: '../trans/Dataservices.asmx/GetmmSteptypeoption',
                            method: 'post',
                            datatype: 'json',
                            success: function (data) {
                                var table;
                                table = $('#tblStepNewOption').DataTable();
                                table.clear();

                                if (data != '') {
                                    $.each(data, function (i, item) {
                                        table.row.add([data[i].id
                                            , data[i].steptype
                                            , data[i].descvoucher
                                            , data[i].InYear
                                            , data[i].urlview]);

                                    })

                                    table.draw();


                                    $('#tblStepNewOption tbody').on('click', 'td', function (e) {
                                        e.preventDefault();

                                        var strid = $(this).parent().children().eq(0).text();   //this.parentElement.rowIndex;
                                        var steptype = $(this).parent().children().eq(1).text(); // this.cellIndex;                        
                                        var descvoucher = $(this).parent().children().eq(2).text(); // this.cellIndex;     
                                        var InYear = $(this).parent().children().eq(3).text(); // this.cellIndex;     
                                      


                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;

                                        if (rIndex != 0 & cIndex == 4) {

                                            //console.log(id + "  :  " + project_name + " rowindex : " + rIndex + " cellindex : " + cIndex);                                                             
                                            //var id = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', '');
                                            //console.log(id);
                                            var strid = $('#tblStepNewOption').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[1].innerHTML;
                                            var year_desc = $('#tblStepNewOption').find('tr:eq(' + rIndex + ')').find('td:eq(1)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;

                                            document.getElementById("Txtsteptype").value = steptype;
                                            document.getElementById("TextsteptypeID").value = strid;
                                            document.getElementById("InYearNewoption").value = InYear;


                                            $("#myModalstepNewoption").modal("hide");

                                        }

                                    })

                                }

                            }

                        });


                        $('[id=myModalstepNewoption]').modal('show');


                    }

                </script>






    </section>






</asp:Content>
