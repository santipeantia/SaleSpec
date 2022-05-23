<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="mmreport.aspx.cs" Inherits="SaleSpec.pages.trans.mmreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>     
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




            });




        </script>

       <%=strMsgAlert %> 

        <h1 class="txtLabel">Metre to Mile Report
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
                                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="txtYearDesc" name="txtYearDesc" value="<%= Session["InYear"] %>"  onclick="modalArchitecture()" readonly required>
                                                            <input type="hidden" class="form-control input-sm pull-left txtLabel" id="selectTextInYear" name="selectTextInYear" value="<%= Session["InYear"] %>"> 
                                                             <div class="input-group-btn">
                                                             <button type="button" id="btnProjectname" class="btn btn-info btn-flat btn-sm" onclick="modalArchitecture()">Find..!</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                          </div>
                            </div>



                               <div class="modal modal-default fade" id="myModalActiveNew">
                                <div class="modal-dialog" style="width: 800px">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">Selected Year</h4>
                                        </div>
                                        <div class="modal-body">
                                            <table id="tbladArchitecture" class="table table-bordered table-striped table-hover table-condensed">
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
                                    <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel col-md-2" id="Button1" runat="server" onserverclick="btnSearch_click">เรียกดูข้อมูล</button>

                                </div>


                            </div>


                              <div class="col-md-2">

                                <div class="form-group">
                                    <label class="txtLabel">report</label>
                                    <button class="btn btn-danger btn-sm btn-flat btn-block txtLabel col-md-2" id="Button2" runat="server" onserverclick="btnDownloadPDF_click">Export PDF</button>

                                </div>


                            </div>



                               <div class="col-md-2">

                                <div class="form-group">
                                    <label class="txtLabel">report</label>
                                    <button class="btn btn-success btn-sm btn-flat btn-block txtLabel col-md-2" id="Button3" runat="server" onserverclick="btnExportExcel_click">Export Excel</button>

                                </div>


                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>


             <div class="row">
            <div class="col-xs-12" style="height: 50px;"></div>
        </div>


        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title txtLabel"><%=strVCA%></h3>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="box-body">
                        <table id="tblM2MVCA" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <thead class="bg-light-blue txtLabel text-center">
                                <tr>
                                    <th>ลำดับ</th>
                                    <th>AA ID</th>
                                    <th>ชื่อลูกค้า</th>
                                    <th>Company ID</th>
                                    <th>บริษัท</th>
                                    <th>ลำดับที่ใน AA+CLUB</th>
                                    <th style="text-align: center;"><%if (strmonth01 =="") { %> ต.ค. <% } %>  <%else{ %> <%=strmonth01%> <%} %> </th>    
                                    <th style="text-align: center;"><%if (strmonth02 =="") { %> พ.ย. <% } %>  <%else{ %> <%=strmonth02%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth03 =="") { %> ธ.ค. <% } %>  <%else{ %> <%=strmonth03%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth04 =="") { %> ม.ค. <% } %>  <%else{ %> <%=strmonth04%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth05 =="") { %> ก.พ. <% } %>  <%else{ %> <%=strmonth05%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth06 =="") { %> มี.ค. <% } %>  <%else{ %> <%=strmonth06%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth07 =="") { %> เม.ย. <% } %>  <%else{ %> <%=strmonth07%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth08 =="") { %> พ.ค. <% } %>  <%else{ %> <%=strmonth08%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth09 =="") { %> มิ.ย. <% } %>  <%else{ %> <%=strmonth09%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth10 =="") { %> ก.ค. <% } %>  <%else{ %> <%=strmonth10%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth11 =="") { %> ส.ค. <% } %>  <%else{ %> <%=strmonth11%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth12 =="") { %> ก.ย. <% } %>  <%else{ %> <%=strmonth12%> <%} %> </th>
                                    <th style="text-align: center;">Total</th>
                                </tr>
                            </thead>
                            <tbody class="txtLabel text-right">
                                <%=strTblVCA%>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>


             <div class="row">
            <div class="col-xs-12" style="height: 50px;"></div>
        </div>



           <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title txtLabel"><%=strVCB%></h3>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="box-body">
                        <table id="tblM2MVCB" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <thead class="bg-light-blue txtLabel text-center">
                                <tr>
                                    <th>ลำดับ</th>
                                    <th>AA ID</th>
                                    <th>ชื่อลูกค้า</th>
                                    <th>Company ID</th>
                                    <th>บริษัท</th>
                                    <th>ลำดับที่ใน AA+CLUB</th>
                                    <th style="text-align: center;"><%if (strmonth01 =="") { %> ต.ค. <% } %>  <%else{ %> <%=strmonth01%> <%} %> </th>    
                                    <th style="text-align: center;"><%if (strmonth02 =="") { %> พ.ย. <% } %>  <%else{ %> <%=strmonth02%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth03 =="") { %> ธ.ค. <% } %>  <%else{ %> <%=strmonth03%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth04 =="") { %> ม.ค. <% } %>  <%else{ %> <%=strmonth04%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth05 =="") { %> ก.พ. <% } %>  <%else{ %> <%=strmonth05%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth06 =="") { %> มี.ค. <% } %>  <%else{ %> <%=strmonth06%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth07 =="") { %> เม.ย. <% } %>  <%else{ %> <%=strmonth07%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth08 =="") { %> พ.ค. <% } %>  <%else{ %> <%=strmonth08%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth09 =="") { %> มิ.ย. <% } %>  <%else{ %> <%=strmonth09%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth10 =="") { %> ก.ค. <% } %>  <%else{ %> <%=strmonth10%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth11 =="") { %> ส.ค. <% } %>  <%else{ %> <%=strmonth11%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth12 =="") { %> ก.ย. <% } %>  <%else{ %> <%=strmonth12%> <%} %> </th>
                                    <th style="text-align: center;">Total</th>
                                </tr>
                            </thead>
                            <tbody class="txtLabel text-right">
                                <%=strTblVCB%>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>


             <div class="row">
            <div class="col-xs-12" style="height: 50px;"></div>
        </div>


          <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title txtLabel"><%=strVCC%></h3>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="box-body">
                        <table id="tblM2MVCC" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <thead class="bg-light-blue txtLabel text-center">
                                <tr>
                                    <th>ลำดับ</th>
                                    <th>AA ID</th>
                                    <th>ชื่อลูกค้า</th>
                                    <th>Company ID</th>
                                    <th>บริษัท</th>
                                    <th>ลำดับที่ใน AA+CLUB</th>
                                    <th style="text-align: center;"><%if (strmonth01 =="") { %> ต.ค. <% } %>  <%else{ %> <%=strmonth01%> <%} %> </th>    
                                    <th style="text-align: center;"><%if (strmonth02 =="") { %> พ.ย. <% } %>  <%else{ %> <%=strmonth02%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth03 =="") { %> ธ.ค. <% } %>  <%else{ %> <%=strmonth03%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth04 =="") { %> ม.ค. <% } %>  <%else{ %> <%=strmonth04%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth05 =="") { %> ก.พ. <% } %>  <%else{ %> <%=strmonth05%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth06 =="") { %> มี.ค. <% } %>  <%else{ %> <%=strmonth06%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth07 =="") { %> เม.ย. <% } %>  <%else{ %> <%=strmonth07%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth08 =="") { %> พ.ค. <% } %>  <%else{ %> <%=strmonth08%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth09 =="") { %> มิ.ย. <% } %>  <%else{ %> <%=strmonth09%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth10 =="") { %> ก.ค. <% } %>  <%else{ %> <%=strmonth10%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth11 =="") { %> ส.ค. <% } %>  <%else{ %> <%=strmonth11%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth12 =="") { %> ก.ย. <% } %>  <%else{ %> <%=strmonth12%> <%} %> </th>
                                    <th style="text-align: center;">Total</th>
                                </tr>
                            </thead>
                            <tbody class="txtLabel text-right">
                                <%=strTblVCC%>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>




           <div class="row">
            <div class="col-xs-12" style="height: 50px;"></div>
        </div>


          <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title txtLabel"><%=strVCD%></h3>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="box-body">
                        <table id="tblM2MVCD" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <thead class="bg-light-blue txtLabel text-center">
                                <tr>                                  
                                     <th>ลำดับ</th>
                                    <th>AA ID</th>
                                    <th>ชื่อลูกค้า</th>
                                    <th>Company ID</th>
                                    <th>บริษัท</th>
                                    <th>ลำดับที่ใน AA+CLUB</th>
                                    <th style="text-align: center;"><%if (strmonth01 =="") { %> ต.ค. <% } %>  <%else{ %> <%=strmonth01%> <%} %> </th>    
                                    <th style="text-align: center;"><%if (strmonth02 =="") { %> พ.ย. <% } %>  <%else{ %> <%=strmonth02%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth03 =="") { %> ธ.ค. <% } %>  <%else{ %> <%=strmonth03%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth04 =="") { %> ม.ค. <% } %>  <%else{ %> <%=strmonth04%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth05 =="") { %> ก.พ. <% } %>  <%else{ %> <%=strmonth05%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth06 =="") { %> มี.ค. <% } %>  <%else{ %> <%=strmonth06%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth07 =="") { %> เม.ย. <% } %>  <%else{ %> <%=strmonth07%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth08 =="") { %> พ.ค. <% } %>  <%else{ %> <%=strmonth08%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth09 =="") { %> มิ.ย. <% } %>  <%else{ %> <%=strmonth09%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth10 =="") { %> ก.ค. <% } %>  <%else{ %> <%=strmonth10%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth11 =="") { %> ส.ค. <% } %>  <%else{ %> <%=strmonth11%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth12 =="") { %> ก.ย. <% } %>  <%else{ %> <%=strmonth12%> <%} %> </th>
                                    <th style="text-align: center;">Total</th>
                                </tr>
                            </thead>
                            <tbody class="txtLabel text-right">
                                <%=strTblVCD%>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>





          <div class="row">
            <div class="col-xs-12" style="height: 50px;"></div>
        </div>



          <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title txtLabel"><%=strVCE%></h3>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="box-body">
                        <table id="tblM2MVCE" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <thead class="bg-light-blue txtLabel text-center">
                                <tr>
                                   <th>ลำดับ</th>
                                    <th>AA ID</th>
                                    <th>ชื่อลูกค้า</th>
                                    <th>Company ID</th>
                                    <th>บริษัท</th>
                                    <th>ลำดับที่ใน AA+CLUB</th>
                                    <th style="text-align: center;"><%if (strmonth01 =="") { %> ต.ค. <% } %>  <%else{ %> <%=strmonth01%> <%} %> </th>    
                                    <th style="text-align: center;"><%if (strmonth02 =="") { %> พ.ย. <% } %>  <%else{ %> <%=strmonth02%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth03 =="") { %> ธ.ค. <% } %>  <%else{ %> <%=strmonth03%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth04 =="") { %> ม.ค. <% } %>  <%else{ %> <%=strmonth04%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth05 =="") { %> ก.พ. <% } %>  <%else{ %> <%=strmonth05%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth06 =="") { %> มี.ค. <% } %>  <%else{ %> <%=strmonth06%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth07 =="") { %> เม.ย. <% } %>  <%else{ %> <%=strmonth07%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth08 =="") { %> พ.ค. <% } %>  <%else{ %> <%=strmonth08%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth09 =="") { %> มิ.ย. <% } %>  <%else{ %> <%=strmonth09%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth10 =="") { %> ก.ค. <% } %>  <%else{ %> <%=strmonth10%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth11 =="") { %> ส.ค. <% } %>  <%else{ %> <%=strmonth11%> <%} %> </th>   
                                    <th style="text-align: center;"><%if (strmonth12 =="") { %> ก.ย. <% } %>  <%else{ %> <%=strmonth12%> <%} %> </th>
                                    <th style="text-align: center;">Total</th>
                                </tr>
                            </thead>
                            <tbody class="txtLabel text-right">
                                <%=strTblVCE%>
                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>



        <script>

 function modalArchitecture() {   

      
              
            $.ajax({
                //url: '../trans/Dataservices.asmx/GetadArchitecture',     
                url: '../trans/Dataservices.asmx/GetDataYearly',
                method: 'post',
                datatype: 'json',
                success: function (data) {
                    var table;
                    table = $('#tbladArchitecture').DataTable();
                    table.clear();

                    if (data != '') {
                        $.each(data, function (i, item) {
                            table.row.add([data[i].id
                                , data[i].year_desc
                                , data[i].urlview]);    

                        })

                        table.draw();




                        
                        $('#tbladArchitecture tbody').on('click', 'td', function (e) {
                            e.preventDefault();

                            var strid = $(this).parent().children().eq(0).text();   //this.parentElement.rowIndex;
                            var year_desc = $(this).parent().children().eq(1).text(); // this.cellIndex;                        
                         


                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            if (rIndex != 0 & cIndex == 2) {

                                //console.log(id + "  :  " + project_name + " rowindex : " + rIndex + " cellindex : " + cIndex);                                                             
                                //var id = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', '');
                                //console.log(id);
                                var strid = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(0)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[1].innerHTML;
                                var year_desc = $('#tbladArchitecture').find('tr:eq(' + rIndex + ')').find('td:eq(1)').text().replace(' ', ''); //tableActiveNew.rows[rIndex].cells[2].innerHTML;
                                
                                document.getElementById("selectTextInYear").value = strid;
                                document.getElementById("txtYearDesc").value = year_desc;                              
                      

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
