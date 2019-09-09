<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleweeklyreport.aspx.cs" Inherits="SaleSpec.pages.report.saleweeklyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    
    <script src="jquery-1.11.2.min.js"></script>

    <script>
       

        $(document).ready(function () {

            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

            var firstdate = yyyy + '-' + mm + '-01';
            var currentdate = yyyy + '-' + mm + '-' + dd;
           

            var datepickertrans = $('#datepickertrans');
            var datepickerend = $('#datepickerend');
            datepickertrans.val(firstdate);
            datepickerend.val(currentdate);

            var selecttimeDDL = $('#selecttime');

             selecttimeDDL.change(function () {
                 var strchange = $('#selecttime option:selected').text();
                $('#txtVisitTime').val(strchange);
            });



            var btnJsonReport = $('#btnJsonReport');
            btnJsonReport.click(function () {
                var selectSaleport = $('#selectSalePort').val();
                var datepickertrans = $('#datepickertrans').val();
                var datepickerend = $('#datepickerend').val();

                $.ajax({
                    url: 'DataServicesReporting.asmx/GetWeeklyReporting',
                    method: 'post',
                    data: {
                        strUserID: selectSaleport,
                        strStartDate: datepickertrans,
                        strEndDate: datepickerend
                    },
                    dataType: 'json',
                    success: function (data) {

                        //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                        var trHTML = '';
                        $('#tableWeeklyReportx tr:not(:first)').remove();
                        $(data).each(function (index, item) {
                            trHTML += '<tr>' +
                                '<td>' + item.WeekDate + '</td>' +
                                '<td> ' + item.WeekTime + '</td>' +
                                '<td>' + item.CompanyID + '</td>' +
                                '<td>' + item.CompanyName + '</td>' +
                                '<td>' + item.ArchitecID + '</td>' +
                                '<td>' + item.Name + '</td>' +
                                '<td>' + item.ProjectID + '</td>' +
                                '<td>' + item.ProjectName + '</td>' +
                                '<td>' + item.Location + '</td>' +
                                '<td class="hidden">' + item.StatusID + '</td>' +
                                '<td>' + item.StatusNameEn + '</td>' +
                                '<td class="hidden">' + item.StepID + '</td>' +
                                '<td>' + item.StepNameEn + '</td>' +
                                '<td>' + item.Remark + '</td>' +
                                '<td>' + item.CreatedBy + '</td>' +
                                '<td>' + item.CreatedDate + '</td>' +
                                '</tr > ';
                        });

                        $('#tableWeeklyReportx').append(trHTML);
                    }
                });
            });

            //var btnExportExcel = $('#btnExportExcel');

        })
    </script>

   

     <!-- Header content -->
    <section class="content-header">
        <h1>Sale Weekly Report
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
           <%= strMsgAlert %>

        <%-- Application Forms--%>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Weekly Report</a>
                                        <span class="pull-right">
                                        <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                        <span class="btn-group">
                                            <button id="btnDownload" runat="server" onserverclick="btnDownload_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Screen" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                            <button id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                        </span>
                                    </span>

                                    </span>
                                    <span class="description">Details for weekly report</span>
                                </div>


                                <%--<div class="row" style="margin-left: 30px;">
                                    <div class="col-md-4">
                                        <label class="txtLabel">Select Reports</label>
                                        <div class="txtLabel">
                                            <select id="selectReportType" name="selectReportType" class="form-control input-sm" style="width: 100%">
                                                <option value="1">New Project</option>
                                                <option value="2">Spec Intake</option>
                                                <option value="3">Step Design > Bidding </option>
                                                <option value="4">Step Bidding > Award MC</option>
                                                <option value="5">Step Award MC > Award RF </option>
                                                <option value="6">Project Bidding </option>
                                                <option value="7">Project Award MC</option>
                                                <option value="8">Project Award RF</option>
                                                <option value="9">Weekly Report</option>
                                                <option value="10">Next Visit</option>
                                            </select>
                                        </div>
                                        <div id="divErrorselectReportType" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                    </div>
                                </div>--%>

                                <div class="row" style="margin-left: 30px;">
                                    <div class="col-md-4 hidden">
                                        <label class="txtLabel">Project</label>
                                        <div class="txtLabel">
                                            <select id="selectProject" name="selectProject" class="form-control input-sm" style="width: 100%">
                                            </select>
                                        </div>
                                        <div id="divErrorSelectProject" class="txtLabel text-red" style="display: none;">Please select a project...!</div>
                                    </div>

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
                                        <label class="txtLabel">Search</label>
                                        <div class="txtLabel">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="Search" name="Search" value="" autocomplete="off" placeholder="Can you search data in here..">
                                         </div>
                                        <div id="divErrorSearch" class="txtLabel text-red" style="display: none;">Please select a owner...!</div>
                                    </div>

                                     <div class="col-md-2">
                                        <label class="txtLabel">Query Info</label>
                                        <div class="">
                                            <button type="button" id="btnQuery" runat="server" onserverclick="btnQuery_Click" class="btn btn-info btn-flat btn-block btn-sm" >Show Report</button>
                                            <%--<button type="button" id="btnJsonReport" class="btn btn-info btn-flat btn-block btn-sm " >Show Report</button>--%>

                                             <%--<button type="button" class="btn btn-default" onclick="alerterror()" data-dismiss="modal">click alert</button>--%>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <label class="txtLabel">Reporting</label>
                                        <div>
                                            <span class="">
                                               
                                                <button id="btnDownloadExcel" runat="server" onserverclick="btnExportExcel_click" type="button" class="btn btn-success btn-flat btn-block btn-sm " data-toggle="tooltip" title="Print Excel">
                                                    <i class="fa fa-file-excel-o"></i> Print Excel</button>
                                            </span>
                                        </div>
                                    </div>

                                    
                                </div>
                            </div>
                            <hr />
                            <div id="divWeeklyReport">
                                <div class="row">
                                    <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th style="width: 70px;">Date</th>
                                                <th>Time</th>
                                                <th class="hidden">ComID</th>
                                                <th>ComName</th>
                                                <th class="hidden">ArchID</th>
                                                <th>ArchName</th>
                                                <th class="hidden">ProjID</th>
                                                <th>ProjName</th>
                                                <th>Location</th>
                                                <th class="hidden">StatusID</th>
                                                <th>Status</th>
                                                <th class="hidden">StepID</th>
                                                <th>StepNameEn</th>
                                                <th>Details</th>
                                                <th>Updated</th>
                                                <th>View</th>
                                                <th class="hidden">ID</th>
                                                <th class="hidden">STB</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%= strTblDetail %>
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
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Weekly Report</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtID" name="txtID" placeholder="" readonly value="" required>
                                </div>
                            </div>

                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">STB</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtSTB" name="txtSTB" placeholder="" readonly value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Visit Date</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtVisitDate" name="txtVisitDate" readonly placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Time</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel hidden" id="txtVisitTime" name="txtVisitTime" placeholder="" value="" >
                                    <span class="txtLabel">
                                                        <select id="selecttime" name="selecttime" class="form-control input-sm " style="width: 100%">
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

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Company</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtCompany" name="txtCompany" readonly placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitect" name="txtArchitect" readonly placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Project</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProject" name="txtProject" readonly placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Location</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLocation" name="txtLocation" placeholder="" value="" >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Description</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="10" id="txtDesc" name="txtDesc" class="form-control input input-sm txtLabel"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>






                            <%--<div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Company</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectCompany" name="selectCompany" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>--%>

                            <%--<div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">Architect</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectArchitect" name="selectArchitect" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>--%>


                           
                           <%-- <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address	</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtAddressEdit" name="txtAddressEdit" class="form-control input input-sm txtLabel"></textarea>
                                    <input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>
                                </div>
                            </div>--%>
                            
                            <%--<div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ProvinceID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtProvinceIDEdit" name="txtProvinceIDEdit" placeholder="" value="" >
                                </div>
                            </div>--%>

                            <%--<div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">ContactName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtContactNameEdit" name="txtContactNameEdit" placeholder="" value="" >
                                </div>
                            </div>--%>
                           
                            <%--<div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneEdit" name="txtPhoneEdit" placeholder="" value="" >
                                </div>
                            </div>--%>

                             <%--<div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobileEdit" name="txtMobileEdit" placeholder="" value="" >
                                </div>
                            </div>--%>

                            <%--<div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmailEdit" name="txtEmailEdit" placeholder="" value="" >
                                </div>
                            </div>--%>

                             <%--<div class="row" style="margin-top: 5px;">
                                <div class="col-md-4">
                                    <label class="txtLabel">StatusConID</label></div>
                                <div class="col-md-8">
                                    <div class="txtLabel">
                                        <select id="selectStatusConIDEdit" name="selectStatusConIDEdit" class="form-control input-sm"  style="width: 100%">
                                        </select>
                                    </div>
                                </div>
                            </div>--%>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                        <%--<button type="button" class="btn btn-primary" id="btnUpdateData"  runat="server" onserverclick="btnUpdateData_click">Update Changes</button>--%>
                        
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData1" onserverclick="btnUpdateData_click" runat="server" >Update Confirme</button>
                        
                        <%--<asp:Button Text="text" runat="server" ID="btnUpdateData" OnClick="btnUpdateData_click" ClientIDMode="Static" />--%>
                    </div>
                </div>
            </div>
        </div>


        <script>
            var table = document.getElementById("tableWeeklyReportx"), rIndex;
            for (var i = 1; i < table.rows.length; i++) {
                for (var j = 0; j < table.rows[i].cells.length; j++) {
                    table.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 14) {
                            var strVal0 = table.rows[rIndex].cells[0].innerHTML;
                            var strVal1 = table.rows[rIndex].cells[1].innerHTML;
                            var strVal2 = table.rows[rIndex].cells[2].innerHTML;
                            var strVal3 = table.rows[rIndex].cells[3].innerHTML;
                            var strVal4 = table.rows[rIndex].cells[4].innerHTML;
                            var strVal5 = table.rows[rIndex].cells[5].innerHTML;
                            var strVal6 = table.rows[rIndex].cells[6].innerHTML;
                            var strVal7 = table.rows[rIndex].cells[7].innerHTML;
                            var strVal8 = table.rows[rIndex].cells[8].innerHTML;
                            var strVal9 = table.rows[rIndex].cells[9].innerHTML;
                            var strVal10 = table.rows[rIndex].cells[10].innerHTML;
                            var strVal11 = table.rows[rIndex].cells[11].innerHTML;
                            var strVal12 = table.rows[rIndex].cells[12].innerHTML;
                            var strVal13 = table.rows[rIndex].cells[13].innerHTML;
                            var strVal14 = table.rows[rIndex].cells[14].innerHTML;
                            var strVal15 = table.rows[rIndex].cells[15].innerHTML;
                            var strVal16 = table.rows[rIndex].cells[16].innerHTML;


                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtID").value = strVal15;
                            document.getElementById("txtSTB").value = strVal16;
                            //document.getElementById("txtCompanyName2Edit").value = strVal2;

                            var str = strVal1;
                            var array = str.split(':');

                            var str0 = array[0];
                            var str1 = array[1];

                            var strep = '';

                            if (str0 == '00') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '01') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '02') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '03') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '04') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '05') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '06') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '07') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '08') {
                                strep = str0.replace('0', '');
                            } else if (str0 == '09') {
                                strep = str0.replace('0', '');
                            } else {
                                strep = str0;
                            }

                           
                            var strcom = strep + '' + str1;

                            $('#selecttime').val(strcom);
                            $('#selecttime').change();

                            document.getElementById("txtVisitDate").value = strVal0;
                            document.getElementById("txtVisitTime").value = $('#selecttime option:selected').text(),
                            document.getElementById("txtCompany").value = strVal3;
                            document.getElementById("txtArchitect").value = strVal5;
                            document.getElementById("txtProject").value = strVal7;
                            document.getElementById("txtLocation").value = strVal8;
                            document.getElementById("txtDesc").value = strVal11;

                            //document.getElementById("selectStatusConID").value = strDetail;
                            //$('#selectStatusConIDEdit').val(strVal10);
                            //$('#selectStatusConIDEdit').change();

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }
                    }
                }
            }


            function ValidateUpdate() {
                var str1 = document.getElementById("txtID").value;
                var str2 = document.getElementById("txtSTB").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        document.getElementById("<%= btnUpdateData1.ClientID %>").click();
                    }
                }
            }

            function alerterror() {
                Swal.fire({
                    type: 'error',
                    html: 'Do not get data selected all..!'
                });
            }

            
        </script>


    </section>

    

</asp:Content>
