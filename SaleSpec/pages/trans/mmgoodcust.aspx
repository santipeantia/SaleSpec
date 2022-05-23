<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="mmgoodcust.aspx.cs" Inherits="SaleSpec.pages.trans.mmgoodcust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>


        <style>
            .hide_column {
                display: none;
            }

            #tbladArchitecture i:hover {
                cursor: pointer;
            }
            
            #tblEmpGood i:hover {
                cursor: pointer;
            }
           
            #tblYearly i:hover {
                cursor: pointer;
            }
        </style>

        <script>
            $(document).ready(function () {
              
                var selectTextInYear = $('#selectTextInYear');
                var selectTextInYearEdit = $('#selectTextInYearEdit');

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

                   $.ajax({
                    url: '../trans/Dataservices.asmx/GetDataYearly',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectTextInYearEdit.append($('<option/>', { value: -1, text: 'Select Year' }));
                        $(data).each(function (index, item) {
                            selectTextInYearEdit.append($('<option/>', { value: item.id, text: item.year_desc }));
                        });
                    }
                });


                var btnSavechanges = $('#btnSavechanges');
                btnSavechanges.click(function () {
                    var str1 = document.getElementById("txtArchitecID").value;
                    var str2 = $('#selectTextInYear').val();  
                  
                    $.ajax({
                        url: '../trans/Dataservices.asmx/check_GoodCustomer',
                        method: 'post',
                        dataType: 'json',
                        data: {
                           ArchitecID: str1,
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
                                        if (str1 != '' && str2 != '-1') {
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
                                if (str1 != '' && str2 != '-1') {
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
                   url: '../trans/Dataservices.asmx/spsave_adGoodCustomer',
                    method: 'post',
                    data: {
                        typeupdate: '2',
                        id: $('#txtID').val(),  
                        InYear: $('#selectTextInYearEdit').val(),        
                        AACLUB: $('#txtAAClubEdit').val(),       
                        strName: $('#txtNameEdit').val(),
                        strFirstName: $('#txtFirstNameEdit').val(),
                        strLastName: $('#txtLastNameEdit').val(),
                        strArchitecID: $('#txtArchitecIDEdit').val(),
                        strCompanyID: $('#txtCompanyIDEdit').val(),
                        strSpecID: $('#txtSpecIDEdit').val(), 
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        $('#myModalEdit').modal('hide');
                        $('#selectTextInYearEdit').val('-1');
                        $('#selectTextInYearEdit').change();
                        $('#txtID').val('');
                        $('#txtAAClubEdit').val('');
                        $('#txtNameEdit').val('');
                        $('#txtFirstNameEdit').val('');
                        $('#txtLastNameEdit').val('');
                        $('#txtArchitecIDEdit').val('');
                        $('#txtCompanyIDEdit').val('');
                        $('#txtSpecIDEdit').val('');
                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                    reloadEdit();
                    }
                });
            }





           






                $("#tblEmpGood").on('click', '.btndelete', function () {
                    var currentRow = $(this).closest("tr");
                    var id = currentRow.find("td:eq(0)").html();
                    var typeupdate = 3;                
                    var InYear = '';   
                    var AACLUB = ''; 
                    var strName = '';
                    var strFirstName = '';
                    var strLastName = '';
                    var strArchitecID = '';
                    var strCompanyID = '';
                    var strSpecID = '';
                    var created_by = '';
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
                                url: '../trans/Dataservices.asmx/spsave_adGoodCustomer',
                                method: 'post',
                                data: {
                                    id: id, typeupdate: typeupdate, InYear,AACLUB, strName, strFirstName,strLastName, strLastName, strArchitecID, strCompanyID,strSpecID,created_by,create_date,update_by,update_date
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
                $('#txtName').val('');
                $('#txtAAClub').val('');
                $('#txtFirstName').val('');
                $('#txtLastName').val('');
                $('#txtArchitecID').val('');
                $('#txtCompanyID').val('');
                $('#txtSpecID').val('');  
                });


                var btnCloseup = $('#btnCloseup');
                btnCloseup.click(function () {       
                $('#selectTextInYear').val('-1');
                $('#selectTextInYear').change();
                $('#txtName').val('');
                $('#txtAAClub').val('');
                $('#txtFirstName').val('');
                $('#txtLastName').val('');
                $('#txtArchitecID').val('');
                $('#txtCompanyID').val('');
                $('#txtSpecID').val('');  
                });




                 $("#tblEmpGood").on('click', '.btnSelect', function () {
                    var currentRow = $(this).closest("tr");           
                    var id = currentRow.find("td:eq(0)").html();
                    var xno = currentRow.find("td:eq(1)").html();  
                    var InYear = currentRow.find("td:eq(2)").html();                       
                    var AAList = currentRow.find("td:eq(3)").html();  
                    var ArchitecID = currentRow.find("td:eq(4)").html(); 
                    var CompanyID = currentRow.find("td:eq(5)").html(); 
                    var FirstName = currentRow.find("td:eq(6)").html(); 
                    var LastName = currentRow.find("td:eq(7)").html(); 
                    var CustName = currentRow.find("td:eq(8)").html(); 
                    var Name =  currentRow.find("td:eq(9)").html(); 
                    var CompanyName = currentRow.find("td:eq(10)").html(); 
                    var SpecID = currentRow.find("td:eq(11)").html(); 
                    var level_desc = currentRow.find("td:eq(12)").html(); 
                    var Salename = currentRow.find("td:eq(13)").html(); 
               

                
                    $('#txtID').val(id); 
                    $('#selectTextInYearEdit').val(InYear);
                    $('#selectTextInYearEdit').change();
                    $('#txtAAClubEdit').val(AAList);
                    $('#txtNameEdit').val(Name);
                    $('#txtFirstNameEdit').val(FirstName);
                    $('#txtLastNameEdit').val(LastName);
                    $('#txtArchitecIDEdit').val(ArchitecID);
                    $('#txtCompanyIDEdit').val(CompanyID);
                    $('#txtSpecIDEdit').val(SpecID);
                    $('#myModalEdit').modal({ backdrop: false });
                    $('#myModalEdit').modal('show');

               



                });


            });





            function getExpLists() {
                $.ajax({
                    url: '../trans/DataServices.asmx/GetadGoodCustomer',
                    method: 'post',
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblEmpGood').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id
                                              ,data[i].xno
                                              ,data[i].inYear
                                              ,data[i].AAList
                                              ,data[i].ArchitecID
                                              ,data[i].CompanyID
                                              ,data[i].FirstName
                                              ,data[i].LastName
                                              ,data[i].CustName
                                              ,data[i].Name
                                              ,data[i].CompanyName
                                              ,data[i].SpecID
                                              ,data[i].level_desc
                                              ,data[i].Salename    
                                              ,data[i].urlview
                                              ,data[i].urldelete]);
                            });
                        }
                        table.draw();
                        //getExpLists();
                    }
                });
            }





            function validatesave() {

                Swal.fire({
                    title: 'Are you sure?',
                    text: "Are you sure you want to save changes?!",
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, save changes.!'
                }).then((result) => {
                    if (result.value) {
                        savedatachanges();
                    }
                });

                //return;
            }


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
                    url: '../trans/Dataservices.asmx/spsave_adGoodCustomer',
                    method: 'post',
                    data: {
                        typeupdate: '1',
                        id:'',
                        InYear: $('#selectTextInYear').val(),        
                        AACLUB: $('#txtAAClub').val(),       
                        strName: $('#txtName').val(),
                        strFirstName: $('#txtFirstName').val(),
                        strLastName: $('#txtLastName').val(),
                        strArchitecID: $('#txtArchitecID').val(),
                        strCompanyID: $('#txtCompanyID').val(),
                        strSpecID: $('#txtSpecID').val(), 
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        $('#myModalNew').modal('hide');
                        $('#selectTextInYear').val('-1');
                        $('#selectTextInYear').change();
                        $('#txtAAClub').val('');
                        $('#txtName').val('');
                        $('#txtFirstName').val('');
                        $('#txtLastName').val('');
                        $('#txtArchitecID').val('');
                        $('#txtCompanyID').val('');
                        $('#txtSpecID').val('');
                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                          reload();
                    }
                });
            }




            function reload()  {   document.getElementById("<%=Button3.ClientID %>").click(); }
 
            function reloadEdit() { document.getElementById("<%=ButtonEdit.ClientID %>").click(); }

        </script>



        <h1 class="txtLabel">Good Customer
            <small>Control panel</small>
        </h1>

    </section>


    <section class="content">


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
                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="txtYearDesc" name="txtYearDesc" value="<%= Session["YearDesc"] %>"  onclick="modalDataYearly()" readonly required>
                                                            <input type="hidden" class="form-control input-sm pull-left txtLabel" id="TextInYear" name="TextInYear" value="<%= Session["InYear"] %>"> 
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
                                   <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                      </button>
                                        </span>

                         </div>


                  
                                <table id="tblEmpGood" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                    <thead class="bg-light-blue txtLabel txtLabel">
                                        <tr>
                                            <th>ID</th>
                                             <th>ลำดับ</th>
                                            <th>Year</th>
                                            <th>ลำดับที่ใน AA+CLUB</th>
                                            <th>ArchitecID</th>
                                            <th style="text-align: center;">CompanyID</th>
                                            <th style="text-align: center;">FirstName</th>
                                            <th style="text-align: center;">LastName</th>
                                            <th style="text-align: center;">CustName</th>
                                            <th style="text-align: center;">Name</th>
                                            <th style="text-align: center;">CompanyName</th>
                                            <th style="text-align: center;">SpecID</th>
                                            <th style="text-align: center;">Level_desc</th>
                                            <th style="text-align: center;">Salename</th>
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
                        <h4 class="modal-title">เพิ่มข้อมูล AA First</h4>
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
                                <div class="col-md-4 txtLabel">ลำดับใน AA+CLUB</div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <input type="text" id="txtAAClub" name="txtAAClub"  autocomplete="off"   class="form-control input input-sm" style="width: 100%" value="">
                                    </div>
                                </div>
                            </div>



                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ชื่อลูกค้า</div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                <div class="input-group date">
                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="txtName" name="txtName" value="" onclick="modalArchitecture()" readonly required>
                                                            <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtFirstName" name="txtFirstName" value="">  
                                                             <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtLastName" name="txtLastName" value="">
                                                            <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtArchitecID" name="txtArchitecID" value="">    
                                                             <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtCompanyID" name="txtCompanyID" value="">    
                                                              <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtSpecID" name="txtSpecID" value="">  
                                                             <div class="input-group-btn">
                                                             <button type="button" id="btnProjectname" class="btn btn-info btn-flat btn-sm" onclick="modalArchitecture()">Find..!</button>
                                                            </div>
                                            </div>
                                    </div>
                                </div>
                            </div>

                  

                        </div>
                    </div>
                    <div class="modal-footer">
                       <button type="button" id="btnSavechanges" name="btnSavechanges" class="btn btn-info">Save</button>
                       <button type="button" class="btn btn-danger hidden" id="Button1" runat="server">Save New</button>
                       <button type="button" id="Button3" name="Button3" runat="server" onserverclick="button3_click" class="btn btn-primary btn-sm btn-block hidden">Save</button>
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
                        <button type="button" id="btnCloseEdit1" name="btnCloseEdit1" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">แก้ไขข้อมูล AA First</h4>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">     
                            
                          <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Year</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                       <select id="selectTextInYearEdit" name="selectTextInYearEdit" class="form-control input-sm col-md-4" style="width: 100%">
                                           </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ลำดับใน AA+CLUB</div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <input type="text" id="txtAAClubEdit" name="txtAAClubEdit"  autocomplete="off"   class="form-control input input-sm" style="width: 100%" value="">
                                    </div>
                                </div>
                            </div>



                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ชื่อลูกค้า</div>
                                <div class="col-md-8">
                                    <div class="txtLabel">                              
                                  <input type="text" class="form-control input-sm pull-left txtLabel" id="txtNameEdit" name="txtNameEdit" style="width: 100%"  value="" readonly required>
                                  <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtFirstNameEdit" name="txtFirstNameEdit" value="">  
                                  <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtLastNameEdit" name="txtLastNameEdit" value="">
                                  <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtArchitecIDEdit" name="txtArchitecIDEdit" value="">    
                                   <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtCompanyIDEdit" name="txtCompanyIDEdit" value="">    
                                   <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtSpecIDEdit" name="txtSpecIDEdit" value="">  
                                   <input type="hidden" class="form-control input-sm pull-left txtLabel" id="txtID" name="txtID" value="">                                                     
                                    
                                    </div>
                                </div>
                            </div>

                  

                        </div>
                    </div>
                    <div class="modal-footer">
                       <button type="button" id="btnUpdatechanges" name="btnUpdatechanges" class="btn btn-info">Save</button>
                       <button type="button" class="btn btn-danger hidden" id="Button2" runat="server">Save New</button>
                       <button type="button" id="ButtonEdit" name="ButtonEdit" runat="server" onserverclick="button3_click" class="btn btn-primary btn-sm btn-block hidden">Save</button>
                            &nbsp;&nbsp;  
                       <button type="button" id="btnCloseEdit" name="btnCloseEdit" class="btn btn-default" data-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="myModalActiveNew">
                                <div class="modal-dialog" style="width: 800px">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">Selected Employee</h4>
                                        </div>
                                        <div class="modal-body">
                                            <table id="tbladArchitecture" class="table table-bordered table-striped table-hover table-condensed">
                                                <thead class="txtLabel">
                                                    <tr>
                                                        <th>ArchitecID</th>
                                                        <th>CompanyID</th>                                                   
                                                        <th>FirstName</th>
                                                        <th>LastName</th>
                                                         <th>Name</th>
                                                        <th>SpecID</th>
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

        <script>

            function openModal() {

                $('#myModalNew').modal({ backdrop: false });
                $('#myModalNew').modal('show');
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




            function modalArchitecture() {   

      
              
            $.ajax({
                url: '../trans/Dataservices.asmx/GetadArchitecture',          
                method: 'post',
                datatype: 'json',
                success: function (data) {
                    var table;
                    table = $('#tbladArchitecture').DataTable();
                    table.clear();

                    if (data != '') {
                        $.each(data, function (i, item) {
                            table.row.add([data[i].ArchitecID
                                , data[i].CompanyID                               
                                , data[i].FirstName
                                , data[i].LastName
                                , data[i].Name
                                , data[i].SpecID
                                , data[i].urlview]);    

                        })

                        table.draw();




                        
                        $('#tbladArchitecture tbody').on('click', 'td', function (e) {
                            e.preventDefault();

                            var strArchitecID = $(this).parent().children().eq(0).text();   //this.parentElement.rowIndex;
                            var strCompanyID = $(this).parent().children().eq(1).text(); // this.cellIndex;                        
                            var strFirstName = $(this).parent().children().eq(2).text(); // this.cellIndex;
                            var strLastName = $(this).parent().children().eq(3).text(); // this.cellIndex;
                            var strName = $(this).parent().children().eq(4).text(); // this.cellIndex;
                            var strSpecID = $(this).parent().children().eq(5).text(); // this.cellIndex;
                      


                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            if (rIndex != 0 & cIndex == 6) {

                                //console.log(id + "  :  " + project_name + " rowindex : " + rIndex + " cellindex : " + cIndex);                                                             
                                //var id = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', '');
                                //console.log(id);
                                var strArchitecID = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[1].innerHTML;
                                var strCompanyID = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(1)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;
                                var strFirstName = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(2)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;
                                var strLastName = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(3)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;
                                var strName = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(4)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;
                                var strSpecID = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(5)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;

                                document.getElementById("txtArchitecID").value = strArchitecID;
                                document.getElementById("txtCompanyID").value = strCompanyID;                              
                                document.getElementById("txtFirstName").value = strFirstName; 
                                document.getElementById("txtLastName").value = strLastName;
                                document.getElementById("txtName").value = strName; 
                                document.getElementById("txtSpecID").value = strSpecID; 

                                $("#myModalActiveNew").modal("hide");

                            }

                        })

                    }

                }

            });
                       
        
            $('[id=myModalActiveNew]').modal('show');


            }

        </script>

    </section>





</asp:Content>
