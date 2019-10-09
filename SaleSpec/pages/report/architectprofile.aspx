<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architectprofile.aspx.cs" Inherits="SaleSpec.pages.report.architectprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
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
                var currentdate3 = yyyy + '-' + mm + '-' + dd;


                var datepickertrans = $('#datepickertrans');
                var datepickerend = $('#datepickerend');
                datepickertrans.val(currentdate3);
                //datepickerend.val(currentdate);

                var btnJsonReport = $('#btnJsonReport');
                btnJsonReport.click(function () {
                    var selectSaleport = $('#selectSalePort').val();
                    var strStatus = 'S01'; //$('#selectSalePort').val();
                    var datepickertrans = $('#datepickertrans').val();
                    var datepickerend = $('#datepickerend').val();
                    var strqtystrat = $('#QtyStart').val();
                    var strqtyend = $('#QtyEnd').val();
                    var strsearch = $('#Search').val();

                    //alert(selectSaleport);

                    if (selectSaleport != "SELECTED ALL") {
                        $.ajax({
                            url: 'DataServicesReporting.asmx/GetDataProjectByPortStatus',
                            method: 'post',
                            data: {
                                strUserID: selectSaleport,
                                strStatus: strStatus,
                                strStartDate: datepickertrans,
                                strEndDate: datepickerend,
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
                                        '<td>' + item.No + '</td>' +
                                        //'<td>' + item.ProjectID + '</td>' +
                                        '<td> ' + item.ProjectName + '</td>' +
                                        //'<td>' + item.CompanyID + '</td>' +
                                        '<td>' + item.CompanyName + '</td>' +
                                        //'<td>' + item.ArchitecID + '</td>' +
                                        '<td>' + item.Name + '</td>' +
                                        '<td>' + item.Location + '</td>' +
                                        '<td>' + item.ProdTypeNameEN + '</td>' +
                                        '<td>' + item.StepNameEn + '</td>' +
                                        '<td>' + item.StatusNameEn + '</td>' +
                                        '<td>' + item.DeliveryDate + '</td>' +
                                        '<td>' + item.Quantity + '</td>' +
                                        '<td>' + item.CreatedBy + '</td>' +
                                        '<td>' + item.CreatedDate + '</td>' +
                                        '<td><a href="../report/specintakeview?opt=itk&projid=' + item.ProjectID + '" title="View"><i class="fa fa-search text-green"></i></a></td>' +
                                        '</tr > ';

                                    //No
                                    //WeekDate
                                    //WeekTime
                                    //CompanyID
                                    //CompanyName
                                    //ArchitecID
                                    //Name
                                    //TransID
                                    //TransNameEN
                                    //ProjectID
                                    //ProjectName
                                    //Location
                                    //TurnKey
                                    //StepID
                                    //StepNameEn
                                    //BiddingName1
                                    //OwnerName1
                                    //BiddingName2
                                    //OwnerName2
                                    //BiddingName3
                                    //OwnerName3
                                    //AwardMC
                                    //ContactMC
                                    //AwardRF
                                    //ContactRF
                                    //ProdTypeID
                                    //ProdTypeNameEN
                                    //ProdID
                                    //ProdNameEN
                                    //ProfID
                                    //ProfNameEN
                                    //Quantity
                                    //DeliveryDate
                                    //NextVisitDate
                                    //StatusID
                                    //StatusNameEn
                                    //Remark
                                    //UserID
                                    //EmpCode
                                    //CreatedBy
                                    //CreatedDate
                                });

                                $('#tableWeeklyReportx').append(trHTML);
                            }
                        });
                    } else {
                        //alert('You select Get Data All')

                        $.ajax({
                            url: 'DataServicesReporting.asmx/GetDataProjectByPortStatusAll',
                            method: 'post',
                            data: {
                                strUserID: selectSaleport,
                                strStatus: strStatus,
                                strStartDate: datepickertrans,
                                strEndDate: datepickerend,
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
                                        '<td>' + item.No + '</td>' +
                                        //'<td>' + item.ProjectID + '</td>' +
                                        '<td> ' + item.ProjectName + '</td>' +
                                        //'<td>' + item.CompanyID + '</td>' +
                                        '<td>' + item.CompanyName + '</td>' +
                                        //'<td>' + item.ArchitecID + '</td>' +
                                        '<td>' + item.Name + '</td>' +
                                        '<td>' + item.Location + '</td>' +
                                        '<td>' + item.ProdTypeNameEN + '</td>' +
                                        '<td>' + item.StepNameEn + '</td>' +
                                        '<td>' + item.StatusNameEn + '</td>' +
                                        '<td>' + item.DeliveryDate + '</td>' +
                                        '<td>' + item.Quantity + '</td>' +
                                        '<td>' + item.CreatedBy + '</td>' +
                                        '<td>' + item.CreatedDate + '</td>' +
                                        '<td><a href="../report/specintakeview?opt=itk&projid=' + item.ProjectID + '" title="View"><i class="fa fa-search text-green"></i></a></td>' +
                                        '</tr > ';
                                });

                                $('#tableWeeklyReportx').append(trHTML);
                            }
                        });
                    }


                });






                 //client click btnSaveEvent add new event to table
                var btnSaveEvent = $('#btnSaveEvent');
                var txtdetails = $('#txtdetails');
                btnSaveEvent.click(function () {
                    if (txtdetails.val() == "") {
                        //todo something you coding

                        Swal.fire({
                            type: 'error',
                            title: '',
                            text: 'Details is no empty please check...!',
                            footer: 'Please contact system administrator..'
                        })

                    } else if ($('textarea#txtremark').val() == "")
                    {
                         Swal.fire({
                            type: 'error',
                            title: '',
                            text: 'Remark is no empty...!',
                            footer: 'Please contact system administrator..'
                        })
                    }
                    else {
                        var userid = '<%= Session["UserID"]%>';
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

                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetInsertRewardEvent',
                            method: 'POST',
                            data: {
                                event_id: $('#selectEvent').val(),
                                event_desc: $('#selectEvent option:selected').text(),
                                trans_date: $('#datepickertrans').val(),
                                architect_id: '<%= id %>',
                                details: $('#txtdetails').val(),
                                remark: $('#txtremark').val(),
                                userid: userid,
                                created_date: currentdate,
                                lasted_date: currentdate
                                },                
                            dataType: 'json',
                            success: function (data) {

                            }                            
                        });

                        Swal.fire({
                            type: 'success',
                            title: 'Data saved successfully..',
                            text: 'Data has been saved.',
                            footer: 'Please contact system administrator..'
                        })                

                        $('#modal-event').modal('hide');

                        //clear all data input
                        $('#txtdetails').val('');
                        $('#txtremark').val('');


                        //var btnCallRewardEvent = $('#btnCallRewardEvent');
                        //btnCallRewardEvent.click();

                        setTimeout(function () {
                            document.getElementById("<%= btnCallRewardEvent.ClientID %>").click();
                        }, 1000);
                                              
                       
                    }
                });


                var tableReward = $('#tableReward');

                $('#tableReward td').hover(function () {
                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;
                    if (rIndex != 0 & cIndex == 11) {
                        $(this).css('cursor', 'pointer');
                    }
                });

                $('#tableReward td').click(function () {


                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;

                    if (rIndex != 0 & cIndex == 11) {

                        var strVal1 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                        //alert(strVal1.text());


                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetRewardEventUpdate',
                            method: 'POST',
                            data: {
                                id: strVal1.text()
                                },                
                            dataType: 'json',
                            success: function (data) {

                            }                            
                        });

                        Swal.fire({
                            type: 'success',
                            title: 'Deleted successfully..',
                            text: 'Data has been saved.',
                            footer: 'Please contact system administrator..'
                        })

                        setTimeout(function () {
                            document.getElementById("<%= btnCallRewardEvent.ClientID %>").click();
                        }, 1000);

                    }
                });

            })
        </script>




        <h1>Architect Profile
            <small>Control panel</small>
        </h1>
    </section>

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
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/architect_person.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Architect Profile</a>
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
                                    <span class="description">Details for weekly report</span>
                                </div>
                                <br />

                                <div class="row" style="margin-left: 35px;">

                                    <div class="col-md-6 offset-md-3">
                                        <div class="row hidden" style="margin-bottom: 5px">
                                            <div class="col-md-6">
                                                <div class="col-md-4 txtLabel">Architect ID</div>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectIDEdit" name="txtArchitectIDEdit" placeholder="" value="">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">FirstName</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtFirstNameEdit" name="txtFirstNameEdit" placeholder="" value="<%= FirstName %>" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">LastName</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtLastNameEdit" name="txtLastNameEdit" placeholder="" value="<%= LastName %>" required>
                                            </div>                                            
                                        </div>

                                        <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                            <div class="col-md-4">
                                                <label class="txtLabel">Company</label>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="txtLabel">
                                                    <select id="selectCompanyEdit" name="selectCompanyEdit" class="form-control input-sm" style="width: 100%">
                                                        <%= strCompany %>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                            <div class="col-md-4">
                                                <label class="txtLabel">Type</label>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="txtLabel">
                                                    <select id="selectGradeIDEdit" name="selectGradeIDEdit" class="form-control input-sm" style="width: 100%">
                                                        <%= strGrade %>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">NickName</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtNickNameEdit" name="txtNickNameEdit" placeholder="" value="<%= Name %>" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Position</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtPositionEdit" name="txtPositionEdit" placeholder="" value="<%=Position %>" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Address</div>
                                            <div class="col-md-8">
                                                <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                                <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit"><%= Address %></textarea>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Phone</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneEdit" name="txtPhoneEdit" placeholder="" value="<%= Phone %>" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Mobile</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtMobileEdit" name="txtMobileEdit" placeholder="" value="<%= Mobile %>" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Email</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtEmailEdit" name="txtEmailEdit" placeholder="" value="<%= Email %>" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-4">
                                                <label class="txtLabel">StatusConID</label>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="txtLabel">
                                                    <select id="selectStatusConIDEdit" name="selectStatusConIDEdit" class="form-control input-sm" style="width: 100%">
                                                        <%= strStatus %>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row" style="margin-left: 30px;">
                                </div>
                            </div>
                            <hr />

                            <%--Details of Projects--%>
                            <div id="divProjects">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/blue_box.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Summary Project</a>

                                    </span>
                                    <span class="description">Details of all projecs</span>
                                </div>
                                <br />
                                <div class="row" style="">
                                    <div class="">
                                        <table id="tableProject" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <td>Year</td>
                                                    <td>Month</td>
                                                    <td>ProjectID</td>
                                                    <td>ProjectName</td>
                                                    <td class="hidden">CompanyID</td>
                                                    <td>CompanyName</td>
                                                    <td class="hidden">Architect</td>
                                                    <td class="hidden">Name</td>
                                                    <td>Location</td>
                                                    <td>ProdType</td>
                                                    <td>Status</td>
                                                    <td>Delivery</td>
                                                    <td>Quantity</td>
                                                    <td>LastUpdate</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%= strTblDetail %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                            <hr />

                            <%--Details of Reward--%>
                            <div id="divReward">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Reward and Event</a>
                                        <span class="pull-right">

                                            <span class="btn-group">
                                                <button id="Button1" runat="server" type="button" class="btn btn-success btn-sm"
                                                    onclick="openEvent()" title="เพิ่มรายการ">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </span>
                                        </span>
                                    </span>
                                    <span class="description">Reward and Event</span>
                                </div>
                                <br />
                                <div class="row" style="top: 50px;">
                                    <div class="">
                                        <table id="tableReward" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <td class="hidden">id</td>
                                                    <td class="hidden">event_id</td>
                                                    <td>Reward and Event</td>
                                                    <td>Year <%= gyear4 %></td>
                                                    <td>Year <%= gyear3 %></td>
                                                    <td>Year <%= gyear2 %></td>
                                                    <td>Year <%= gyear1 %></td>
                                                    <td>Year <%= gyear %></td>
                                                    <td>Dated</td>
                                                    <td>Remark</td>
                                                    <td>#</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                               <%= strTblReward %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <hr />

                            <%--Details of Weekly Report--%>
                            <div id="divWeeklyReport">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/price-control.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Visiting</a>
                                    </span>
                                    <span class="description">Weekly Report</span>
                                </div>
                                <br />
                                <div class="row" style="top: 50px;">
                                    <div class="">
                                        <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <td>WeekDate</td>
                                                    <td>WeekTime</td>
                                                    <td>ProjectName</td>
                                                    <td>CompanyName</td>
                                                    <td>Location</td>
                                                    <td>Name</td>
                                                    <td>Step</td>
                                                    <td>Remark</td>
                                                    <td>Port</td>
                                                    <td>Updated</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%= strTblWeeklyReport %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <hr />

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-event">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Reward and Event</h4>
              </div>
              <div class="modal-body">
                <%--<p>One fine body&hellip;</p>--%>

                <div class="row" style="padding-bottom: 5px">
                    <div class="col-md-4 txtLabel">Reward/Event</div>
                    <div class="col-md-8">
                        <span class="txtLabel">
                            <select class="form-control input-sm"  style="width: 100%" id="selectEvent" name="selectEvent">
                            </select>
                        </span>
                    </div>
                </div>
                  <div class="row" style="padding-bottom: 5px">
                    <div class="col-md-4 txtLabel">inYear</div>
                    <div class="col-md-8">
                        <%--<span class="txtLabel">
                            <select class="form-control input-sm" style="width: 100%" id="selectYear" name="selectYear">
                            </select>     
                                    
                        </span>--%>

                        <div class="input-group date">
                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickertrans" value="" autocomplete="off">
                            <div class="input-group-addon input-sm">
                                <i class="fa fa-calendar"></i>
                            </div>
                        </div>
                    </div>
                </div>

                  <div class="row" style="padding-bottom: 5px">
                    <div class="col-md-4 txtLabel">Details</div>
                    <div class="col-md-8">
                        <input type="text" class="form-control input-sm txtLabel" id="txtdetails" name="txtdetails" value="" />
                    </div>
                </div>

                  <div class="row" style="padding-bottom: 5px">
                    <div class="col-md-4 txtLabel">Remark</div>
                    <div class="col-md-8">
                        <textarea class="form-control input-sm txtLabel" cols="40" rows="3" id="txtremark" name="txtremark"></textarea>
                    </div>
                </div>


            </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" id="btnSaveEvent" name="btnSaveEvent" class="btn btn-primary">Save changes</button>
                  <button type="button" id="btnCallRewardEvent" name="btnCallRewardEvent" runat="server" onserverclick="btnCallRewardEvent_click" class="btn btn-primary hidden">Call Reward Event</button>
              </div>
            </div>
          </div>
        </div>

        <script>
            function openEvent() {
                
                var selectEventDDL = $('#selectEvent');
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetEventType',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectEventDDL.empty();
                        $(data).each(function (index, item) {
                            selectEventDDL.append($('<option/>', { value: item.id, text: item.event_desc }));
                            //$('#selectProductType').val(strVal9.text());
                            //$('#selectProductType').change();
                        });


                    }
                });




                $("#modal-event").modal({ backdrop: false });
                $('[id=modal-event]').modal('show');
            }


            //function alertMessage(strtype, strtitle, strttext, strfooter) {
            //    Swal.fire({
            //        type: 'success',
            //        title: 'Data saved successfully..',
            //        text: 'Data has been saved.',
            //        footer: 'Please contact system administrator..'
            //    })
            //}

        </script>

    </section>
</asp:Content>
