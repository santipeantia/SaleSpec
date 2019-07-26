<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architectprofile.aspx.cs" Inherits="SaleSpec.pages.report.architectprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
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
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtFirstNameEdit" name="txtFirstNameEdit" placeholder="" value="" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">LastName</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtLastNameEdit" name="txtLastNameEdit" placeholder="" value="" required>
                                            </div>                                            
                                        </div>

                                        <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                            <div class="col-md-4">
                                                <label class="txtLabel">Company</label>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="txtLabel">
                                                    <select id="selectCompanyEdit" name="selectCompanyEdit" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                            <div class="col-md-4">
                                                <label class="txtLabel">Grade</label>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="txtLabel">
                                                    <select id="selectGradeIDEdit" name="selectGradeIDEdit" class="form-control input-sm" style="width: 100%">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">NickName</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtNickNameEdit" name="txtNickNameEdit" placeholder="" value="" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Position</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtPositionEdit" name="txtPositionEdit" placeholder="" value="" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Address</div>
                                            <div class="col-md-8">
                                                <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                                <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit"></textarea>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Phone</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtPhoneEdit" name="txtPhoneEdit" placeholder="" value="" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Mobile</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtMobileEdit" name="txtMobileEdit" placeholder="" value="" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Email</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtEmailEdit" name="txtEmailEdit" placeholder="" value="" required>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="col-md-4">
                                                <label class="txtLabel">StatusConID</label>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="txtLabel">
                                                    <select id="selectStatusConIDEdit" name="selectStatusConIDEdit" class="form-control input-sm" style="width: 100%">
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
                                <div class="row" style="margin-left: 30px;">
                                    <div class="container">
                                        <table id="tableProject" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <%--<td>ProjID</td>--%>
                                                    <td>Project Name</td>
                                                    <%--<td>ComID</td>--%>
                                                    <td>Company Name</td>
                                                    <%--<td>Architec ID</td>--%>
                                                    <td>Architec Name</td>
                                                    <td>Location</td>
                                                    <td>ProdType</td>
                                                    <td>Step</td>
                                                    <td>Status</td>
                                                    <td>Delivery</td>
                                                    <td>Quantity</td>

                                                    <td>#</td>
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

                                    </span>
                                    <span class="description">Reward and Event</span>
                                </div>
                                <br />
                                <div class="row" style="margin-left: 30px; top: 50px;">
                                    <div class="container">
                                        <table id="tableReward" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <%--<td>ProjID</td>--%>
                                                    <td>Project Name</td>
                                                    <%--<td>ComID</td>--%>
                                                    <td>Company Name</td>
                                                    <%--<td>Architec ID</td>--%>
                                                    <td>Architec Name</td>
                                                    <td>Location</td>
                                                    <td>ProdType</td>
                                                    <td>Step</td>
                                                    <td>Status</td>
                                                    <td>Delivery</td>
                                                    <td>Quantity</td>
                                                    <td>CreatedBy</td>
                                                    <td>LastUpdate</td>
                                                    <td>#</td>
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
                                <div class="row" style="margin-left: 30px; top: 50px;">
                                    <div class="container">
                                        <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <%--<td>ProjID</td>--%>
                                                    <td>Project Name</td>
                                                    <%--<td>ComID</td>--%>
                                                    <td>Company Name</td>
                                                    <%--<td>Architec ID</td>--%>
                                                    <td>Architec Name</td>
                                                    <td>Location</td>
                                                    <td>ProdType</td>
                                                    <td>Step</td>
                                                    <td>Status</td>
                                                    <td>Delivery</td>
                                                    <td>Quantity</td>
                                                    <td>CreatedBy</td>
                                                    <td>LastUpdate</td>
                                                    <td>#</td>
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

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
