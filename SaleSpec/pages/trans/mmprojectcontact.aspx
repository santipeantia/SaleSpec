<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="mmprojectcontact.aspx.cs" Inherits="SaleSpec.pages.trans.mmprojectcontact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1 class="txtLabel">Project Contract
            <small>Control panel</small>
        </h1>
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>

        <style>
            #tblprojectcontact i:hover {
                cursor: pointer;
            }

            #btnSelect i:hover {
                cursor: pointer;
            }

               #btndelete i:hover {
                cursor: pointer;
            }

        </style>

        <script>
            $(document).ready(function () {

                $("#tblprojectcontact").on('click', '.btnSelect', function () {
                    var currentRow = $(this).closest("tr");
                    var xno = currentRow.find("td:eq(1)").html();
                    var DocuDate = currentRow.find("td:eq(1)").html();
                    var DocuNo = currentRow.find("td:eq(2)").html();
                    var CustCode = currentRow.find("td:eq(3)").html();
                    var CustName = currentRow.find("td:eq(4)").html();
                    var ArchitecID = currentRow.find("td:eq(5)").html();
                    var Name = currentRow.find("td:eq(6)").html();
                    var GoodName = currentRow.find("td:eq(7)").html();
                    var QAmount = currentRow.find("td:eq(8)").html();
                    var NetRF_B = currentRow.find("td:eq(9)").html();
                    var Net = currentRow.find("td:eq(10)").html();
                    var SaleCode = currentRow.find("td:eq(11)").html();
                    var SaleName = currentRow.find("td:eq(12)").html();
                    var Netcheck = currentRow.find("td:eq(13)").html();

                    $('#TextDocuDate').val(DocuDate);
                    $('#TextInvoice').val(DocuNo);
                    $('#TextCustCode').val(CustCode);
                    $('#TextRollformer').val(CustName);
                    $('#TextArchitecID').val(ArchitecID);
                    $('#TextModel').val(GoodName);
                    $('#TextName').val(Name);
                    $('#TxtAcQty').val(QAmount);
                    $('#TextNetRF_B').val(NetRF_B);
                    $('#TextNet').val(Net);
                    $('#TextNetR').val(Netcheck);
                    $('#TxtSaleCode').val(SaleCode);
                    $('#TextSaleName').val(SaleName);

                    $('#myModalEdit').modal({ backdrop: false });
                    $('#myModalEdit').modal('show');



                });


                   var btnupdatenetproject = $('#btnupdatenetproject');
                       btnupdatenetproject.click(function () {
                  var str1 = document.getElementById("TextNet").value;
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
                            updateNetProject();
                        }
                    });
                }

                else {

                    Swal.fire({
                        icon: 'error',
                        title: 'บันทึกข้อมูลไม่สำเร็จ',
                        text: 'กรูณา Net(%)',
                    
                    })

                }


                });







                $("#tblprojectcontact").on('click', '.btndelete', function () {
                    var currentRow = $(this).closest("tr");
                    var xno = currentRow.find("td:eq(1)").html();
                    var DocuDate = currentRow.find("td:eq(1)").html();
                    var DocuNo = currentRow.find("td:eq(2)").html();
                    var CustCode = currentRow.find("td:eq(3)").html();
                    var CustName = currentRow.find("td:eq(4)").html();
                    var ArchitecID = currentRow.find("td:eq(5)").html();
                    var Name = currentRow.find("td:eq(6)").html();
                    var GoodName = currentRow.find("td:eq(7)").html();
                    var QAmount = currentRow.find("td:eq(8)").html();
                    var NetRF_B = currentRow.find("td:eq(9)").html();
                    var net = currentRow.find("td:eq(10)").html();
                    var SaleCode = currentRow.find("td:eq(11)").html();
                    var SaleName = currentRow.find("td:eq(12)").html();
                    var netcheck = currentRow.find("td:eq(13)").html();                 
                    var created_by = '';
                    var create_date = '';
                 

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
                           url: '../trans/Dataservices.asmx/spsave_mmProjectcontract',
                            method: 'post',
                            data: {
                             typeupdate: '2',
                            DocuDate,
                            DocuNo,
                            QAmount,
                            net,
                            netcheck,
                            ArchitecID,
                            CustCode,
                            Name,
                            CustName,
                            GoodName,
                            NetRF_B,
                            SaleCode,
                            SaleName,
                            created_by,
                            create_date
                          
                            },
                            dataType: 'json',
                            complete: function (data) {
                                Swal.fire(
                                    'Deleted!',
                                    'Your file has been deleted.',
                                    'success'
                                )
                               reload();
                            }

                        });

                    }
                })

                });



            })



            function reload()
            {
              document.getElementById("<%=button2.ClientID %>").click();

            }
 

</script>

           <script>


            function updateNetProject() {
                var empcode = '<%= Session["EmpCode"] %>';
                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                $.ajax({

                 url: '../trans/Dataservices.asmx/spsave_mmProjectcontract',
                 method: 'post',
                   data: {
                            typeupdate: '1',
                            DocuDate: $('#TextDocuDate').val(),
                            DocuNo: $('#TextInvoice').val(),
                            QAmount: $('#TxtAcQty').val(),
                            net: $('#TextNet').val(),
                            netcheck: $('#TextNetR').val(),
                            ArchitecID: $('#TextArchitecID').val(),
                            CustCode: $('#TextCustCode').val(),
                            Name: $('#TextName').val(),
                            CustName: $('#TextRollformer').val(),
                            GoodName: $('#TextModel').val(),
                            NetRF_B: $('#TextNetRF_B').val(),
                            SaleCode: $('#TxtSaleCode').val(),
                            SaleName: $('#TextSaleName').val(),
                            created_by: empcode,
                            create_date: currentdate,
                   

                   },
                      datatype: 'json',
                      success: function (data) {
                             $('#myModalEdit').modal('hide');                                      

                                Swal.fire(
                                          'Saved!',
                                          'Your file has been save changes.',
                                          'success'
                                                       
                                           )

                           reload();
                      }


                });


   



            }




</script>


    </section >
        
    <!--Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->

        <%= strMsgAlert %>

        <div class="row">

            <div class="col-xs-12">
                <div class="box box-success">
                    <div class="box-header">
                        <h3 class="box-title">Select Data</h3>
                    </div>
                    <div class="box-body">



                        <div class="col-md-2">
                            <label class="txtLabel">From Date</label>
                            <div class="input-group date">
                                <input type="text" class="form-control input-sm pull-left" id="datepickertrans" name="datepickertrans" value="<%= Session["Datestart"] %>" autocomplete="off">
                                <div class="input-group-addon input-sm">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <label class="txtLabel">End Date</label>
                            <div class="input-group date">
                                <input type="text" class="form-control input-sm pull-left" id="datepickerend" name="datepickerend" value="<%= Session["DateEnd"] %>" autocomplete="off">
                                <div class="input-group-addon input-sm">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>


                        <div class="form-group col-sm-2">
                            <label class="txtLabel">คลิกเพื่อเรียกดูข้อมูล</label>
                            <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel" id="btnSearch" runat="server" onserverclick="btnSearch_click">เรียกดูข้อมูล</button>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title txtLabel">Project Contract</h3>
                        <div class="pull-right">
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="tblprojectcontact" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <%--pagination pagination-sm--%>
                            <thead class="bg-light-blue txtLabel">
                                <tr>
                                    <th class="text-center">ลำดับ</th>
                                    <th class="text-center">DocuDate</th>
                                    <th class="text-center">Invoice</th>
                                    <th class="text-center">CustCode</th>
                                    <th class="text-center">Rollformer</th>
                                    <th class="text-center">ArchitecID</th>
                                    <th class="text-center">Name</th>
                                    <th class="text-center">Model</th>
                                    <th class="text-center">AcQty</th>
                                    <th class="text-center">NetRF_B</th>
                                    <th class="text-center">Net(%)</th>
                                    <th class="text-center">SaleCode</th>
                                    <th class="text-center">SaleName</th>
                                    <th class="hidden">NetCheck</th>
                                    <th class="text-center">#</th>
                                    <th class="text-center">#</th>

                                </tr>
                            </thead>
                            <tbody class="txtLabel">
                                <%= strTblDetail %>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>


        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog" style="width: 70%;">
                <div class="box box-info">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><b><span style="color: #23527c;">Net Project Contact</span></b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-6">


                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">CustCode</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextDocuDate" name="TextDocuDate" value="" autocomplete="off">
                                        </div>



                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">CustCode</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextCustCode" name="TextCustCode" value="" autocomplete="off">
                                        </div>






                                    </div>
                                    <!-- /.col -->



                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">Invoice</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextInvoice" name="TextInvoice" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->
                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">Rollformer</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextRollformer" name="TextRollformer" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->





                                    </div>
                                    <!-- /.col -->

                                    <div class="col-md-6">

                                        <!-- /.form-group -->
                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">ArchitecID</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextArchitecID" name="TextArchitecID" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->

                                        <!-- /.form-group -->
                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">Model</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextModel" name="TextModel" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->



                                    </div>
                                    <!-- /.col -->


                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">Name</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextName" name="TextName" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->


                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">AcQty</span></label>

                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TxtAcQty" name="TxtAcQty" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->

                                    </div>
                                    <!-- /.col -->


                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">NetRF_B</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextNetRF_B" name="TextNetRF_B" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->


                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">SalesCode</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TxtSaleCode" name="TxtSaleCode" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->

                                    </div>
                                    <!-- /.col -->

                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">Net(%)</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="TextNet" name="TextNet" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->

                                        <div class="form-group">
                                            <label class="txtLabel"><span style="color: #23527c;">SaleName</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" readonly id="TextSaleName" name="TextSaleName" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->

                                    </div>
                                    <!-- /.col -->




                                    <div class="col-md-6">

                                        <div class="form-group hidden">
                                            <label class="txtLabel"><span style="color: #23527c;">Net(%) (Check)</span></label>
                                            <input type="text" class="form-control input-sm pull-left txtLabel" hidden id="TextNetR" name="TextNetR" value="" autocomplete="off">
                                        </div>
                                        <!-- /.form-group -->





                                    </div>
                                    <!-- /.col -->


                                </div>





                                <div class="modal-footer">
                                    <button type="button" id="btnupdatenetproject" name="btnupdatenetproject" class="btn btn-primary">Update</button>
                                    <button type="button" class="btn btn-danger hidden" id="Button10" runat="server">Update</button>
                                    <button type="button" id="button2" name="button2" runat="server" onserverclick="button2_click" class="btn btn-primary btn-sm btn-block hidden">Save</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            
                                </div>
                            </div>
                            <!-- /.modal-content -->

                        </div>
                    </div>
                </div>
            </div>





        </div>



    </section>


</asp:Content>
