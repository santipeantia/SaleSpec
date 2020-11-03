<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="architectprofile.aspx.cs" Inherits="SaleSpec.pages.report.architectprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="jquery-1.11.2.min.js"></script>
        <script>
            $(document).ready(function () {

                var strEvent = '0';

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

                //$("#divgift").hide();

                var btnShowResult = $('#btnShowResult');
                btnShowResult.click(function () {
                    $.ajax({
                        url: 'DataServicesReporting.asmx/GetDataspGetProjectInfoByid2',
                        method: 'post',
                        data: {
                            ArchitecID: $('#txtArchitectIDEdit').val(),
                            StartYearDate: $('#datepickerstart').val(),
                            EndYearDate: $('#datepickerend').val(),
                            Search: $('#txtsearch').val()
                        },
                        dataType: 'json',
                        success: function (data) {

                            //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                            var trHTML = '';
                            $('#tableProject tr:not(:first)').remove();
                            $(data).each(function (index, item) {
                                trHTML += '<tr>' +

                                    '<td>' + item.No + '</td>' +
                                    '<td>' + item.ProjectYear + '</td>' +
                                    '<td>' + item.ProjectMonth + '</td>' +
                                    '<td>' + item.ProjectID + '</td>' +
                                    '<td>' + item.ProjectName + '</td>' +
                                    '<td class="hidden">' + item.CompanyID + '</td>' +
                                    '<td>' + item.CompanyName + '</td>' +
                                    '<td class="hidden">' + item.Architect + '</td>' +
                                    '<td class="hidden">' + item.Name + '</td>' +
                                    '<td>' + item.Location + '</td>' +
                                    '<td>' + item.ProdTypeNameEN + '</td>' +
                                    '<td>' + item.ProdNameEN + '</td>' +
                                    '<td>' + item.ProfNameEN + '</td>' +
                                    '<td>' + item.StatusNameEn + '</td>' +
                                    '<td>' + item.DeliveryDate + '</td>' +
                                    '<td>' + item.Quantity + '</td>' +
                                    '<td>' + item.LastUpdate + '</td>' +
                                    '<td>' + item.TypeID + '</td>' +
                                    '</tr > ';
                            });

                            $('#tableProject').append(trHTML);


                            //********** Get Sum Quantity ***********//
                            $.ajax({
                                url: 'DataServicesReporting.asmx/GetSumProjectInfoByid2',
                                method: 'post',
                                data: {
                                    ArchitecID: $('#txtArchitectIDEdit').val(),
                                    StartYearDate: $('#datepickerstart').val(),
                                    EndYearDate: $('#datepickerend').val(),
                                    Search: $('#txtsearch').val()
                                },
                                dataType: 'json',
                                success: function (data) {

                                    var obj = jQuery.parseJSON(JSON.stringify(data));
                                    if (obj != '') {
                                        $.each(obj, function (key, inval) {
                                            $('#test').text(inval["SumQuantity"]);
                                            $('#txtSumQuantity').val(inval["SumQuantity"]);
                                        });
                                    }
                                }
                            });
                        }
                    });
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

                    }
                    //else if ($('textarea#txtremark').val() == "") {
                    //    Swal.fire({
                    //        type: 'error',
                    //        title: '',
                    //        text: 'Remark is no empty...!',
                    //        footer: 'Please contact system administrator..'
                    //    })
                    //}
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

                        var selectActivity = $('#selectActivity').val()
                        var selectEvent = $('#selectEvent').val();
                        var inv_id = $('#selectInvitation').val();
                        var inv_desc = $('#selectInvitation option:selected').text();
                        var attn_id = $('#selectAttendance').val();
                        var attn_desc = $('#selectAttendance option:selected').text();

                        if (selectActivity == "2") {
                            inv_id = null;
                            inv_desc = null;
                            attn_id = null;
                            attn_desc = null;
                        }

                        //if ((selectEvent == "1") && (txtgift == "")) {
                        //    Swal.fire({
                        //        type: 'error',
                        //        title: '',
                        //        text: 'Get a gift, find not found ..!',
                        //        footer: 'Please check get a gift..'
                        //    })
                        //    $('#selectEvent').val('');
                        //    return;
                        //}
                                         

                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetInsertRewardEvent',
                            method: 'POST',
                            data: {
                                tran_id: $('#txtid').val(),
                                event_id: $('#selectActivity').val(),
                                event_desc: $('#selectActivity option:selected').text(),
                                title_id: $('#selectEvent').val(),
                                title_desc: $('#selectEvent option:selected').text(),
                                trans_date: $('#datepickertrans').val(),
                                architect_id: '<%= id %>',
                                details: $('#txtdetails').val(),
                                inv_id: inv_id,
                                inv_desc: inv_desc,
                                attn_id: attn_id,
                                attn_desc: attn_desc,
                                remark: $('#txtremark').val(),
                                userid: userid,
                                created_date: currentdate,
                                lasted_date: currentdate,
                                isdelete: '1'
                            },
                            dataType: 'json',
                            complete: function (data) {
                                Swal.fire({
                                    type: 'success',
                                    title: 'Data saved successfully..',
                                    text: 'Data has been saved.',
                                    footer: 'Please contact system administrator..'
                                })
                            }
                        });

                        

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
                    if (rIndex != 0 & cIndex == 3 || cIndex == 5 || cIndex == 16 || cIndex == 17 || cIndex == 18) {
                        $(this).css('cursor', 'pointer');
                    }
                });

                $('#tableReward td').click(function () {


                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;

                    if (rIndex != 0 & cIndex == 3 || cIndex == 5 || cIndex == 16 || cIndex == 17) {

                       //openEvent();                        
                        
                        var strval1 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(1)'); //id
                        var strval2 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(2)'); //event_id	
                        var strval3 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(3)'); //event_desc	
                        var strval4 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(4)'); //title_id	
                        var strval5 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(5)'); //title_desc	
                        var strval6 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(6)'); //xyear	
                        var strval7 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(7)'); //architect_id	
                        var strval8 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(8)'); //inv_id	
                        var strval9 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(9)'); //inv_desc	
                        var strval10 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(10)'); //attn_id	
                        var strval11 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(11)'); //attn_desc	
                        var strval12 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(12)'); //YEAR4	
                        var strval13 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(13)'); //YEAR3	
                        var strval14 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(14)'); //YEAR2	
                        var strval15 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(15)'); //YEAR1	
                        var strval16 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(16)'); //YEAR	
                        var strval17 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(17)'); //trans_date	remark

                        //console.log(strval1.text() + '\n' + strval2.text() + '\n' + strval3.text() + '\n' + strval4.text() + '\n' + strval5.text() + '\n' +strval6.text() + strval7.text() + '\n' + strval8.text() + '\n' + strval9.text() + '\n' + strval10.text() + '\n' + strval11.text() + strval12.text() + strval13.text() + '\n' + strval14.text() + '\n' + strval15.text() + '\n' + strval16.text() + '\n' + strval17.text());

                        var selectActivity = $('#selectActivity');
                        //strEvent = strval4.text().replace(' ', '');
                        $('#txtid').val(strval1.text().replace(' ', ''));
                        $('#txteventid').val(strval4.text().replace(' ', ''));

                        var invid = strval11.text().replace(' ', '');
                        var attid = strval13.text().replace(' ', '');


                        //alert(strEvent.text());

                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetEventActivity',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectActivity.empty();
                                $(data).each(function (index, item) {
                                    selectActivity.append($('<option/>', { value: item.act_id, text: item.act_desc }));
                                    selectActivity.val(strval2.text().replace(' ', ''));
                                    selectActivity.change();                                    
                                });
                            }
                        });

                        getAttendance();
                       
                        $('#txtdetails').val(strval6.text() + strval7.text() + strval8.text() + strval9.text() + strval10.text());
                        $('#datepickertrans').val(strval15.text().replace(' ', ''));   
                                               
                        var selectInvitation = $('#selectInvitation');
                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetInvitation',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectInvitation.empty();
                                $(data).each(function (index, item) {
                                    selectInvitation.append($('<option/>', { value: item.id, text: item.inv_desc }));
                                    selectInvitation.val(invid);
                                    selectInvitation.change();
                                });
                            }
                        });

                        var selectAttendance = $('#selectAttendance');
                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetAttendance',
                            method: 'post',
                            dataType: 'json',
                            success: function (data) {
                                selectAttendance.empty();
                                $(data).each(function (index, item) {
                                    selectAttendance.append($('<option/>', { value: item.id, text: item.attn_desc }));
                                    selectAttendance.val(attid);
                                    selectAttendance.change();
                                });
                            }
                        });

                        $('#txtremark').val(strval16.text().replace(' ', ''));


                        //alert(attid);

                        $("#modal-event").modal({ backdrop: false });
                        $('[id=modal-event]').modal('show');
                                              

                


                    } else if (rIndex != 0 & cIndex == 18) {

                        Swal.fire({
                            title: 'Are you sure?',
                            text: "You won't be able to revert this!",
                            type: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, delete it!'
                        }).then((result) => {
                            if (result.value) {

                                var strVal1 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                $.ajax({
                                    url: 'DataServicesArchitectProfile.asmx/GetRewardEventUpdate',
                                    method: 'POST',
                                    data: {
                                        id: strVal1.text()
                                    },
                                    dataType: 'json',
                                    complete: function (data) {
                                        Swal.fire(
                                            'Deleted!',
                                            'Your file has been deleted.',
                                            'success'
                                        )

                                        setTimeout(function () {
                                            document.getElementById("<%= btnCallRewardEvent.ClientID %>").click();
                                            }, 1000);
                                        }
                                    });
                                
                                }
                            })
                        <%--var strVal1 = $("#tableReward").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                        //alert(strVal1.text());
                        $.ajax({
                            url: 'DataServicesArchitectProfile.asmx/GetRewardEventUpdate',
                            method: 'POST',
                            data: {
                                id: strVal1.text()
                            },
                            dataType: 'json',
                            complete: function (data) {
                                Swal.fire(
                                    'Deleted!',
                                    'Your file has been deleted.',
                                    'success'
                                )

                                setTimeout(function () {
                                    document.getElementById("<%= btnCallRewardEvent.ClientID %>").click();
                                }, 1000);
                            }
                        });     --%>                                       
                    }
                });


                var btnSaveLevel = $('#btnSaveLevel');
                btnSaveLevel.click(function () {
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    //alert('click update..');

                    $.ajax({
                        url: 'DataServicesArchitectProfile.asmx/GetInsertHistoryLevel',
                        method: 'POST',
                        data: {
                            inYear: $('#selectLevelYear').val(),
                            ArchitecID: $('#txtLevelArchitect').val(),
                            FirstName: $('#txtLevelFirstname').val(),
                            LastName: $('#txtLevelLastname').val(),
                            level_id: $('#selectLevel').val(),
                            level_desc: $('#selectLevel option:selected').text(),
                            isactive: '1',
                            last_update: currentdate
                        },
                        dataType: 'json',
                        complete: function (response) {
                           // alert("Data was succesfully captured");
                            getLevelHistory();
                            $('[id=modal-level]').modal('hide');
                        }
                    });

                })


                var selectActivity = $('#selectActivity');
                selectActivity.change(function () {
                    var strid = $('#selectActivity').val();
                    var streventid = $('#txteventid').val();

                    //alert(strid);

                    if (strid == 1) {
                        $('#divinvite').fadeIn(300);
                        $('#divattend').fadeIn(300);
                        //$("#divinvite").show();
                        //$("#divattend").show();                       
                    } else {
                        $('#divinvite').fadeOut(300);
                        $('#divattend').fadeOut(300);
                        //$("#divinvite").hide();
                        //$("#divattend").hide();
                    }

                    var selectEventDDL = $('#selectEvent');
                    $.ajax({
                        url: 'DataServicesArchitectProfile.asmx/GetEventTypeID',
                        data: { strid: strid
                        },
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {
                            selectEventDDL.empty();
                            $(data).each(function (index, item) {
                                selectEventDDL.append($('<option/>', { value: item.id, text: item.event_desc }));
                                selectEventDDL.val(streventid);
                                selectEventDDL.change();
                            });
                        }
                    });                   

                });

                getLevelHistory();
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
                                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectIDEdit" name="txtArchitectIDEdit" placeholder="" value="<%= ArchitecID %>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Port Owner</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtPortEdit" name="txtPortEdit" placeholder="" readonly>
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
                                                <label class="txtLabel">Grade</label>
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
                                                <textarea cols="40" rows="2" class="form-control input input-sm txtLabel" id="txtAddressEdit" name="txtAddressEdit"><%= Address %></textarea>
                                            </div>
                                        </div>
                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-md-4 txtLabel">Birthday</div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input input-sm txtLabel" id="txtBirthday" name="txtBirthday" placeholder="" value="<%= Birthday %>" required>
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


                                    <div class="col-md-6">

                                        <div class="nav-tabs-custom">
                                            <ul class="nav nav-tabs">
                                                <li class="active txtLabel"><a href="#activity" data-toggle="tab">Level history</a></li>
                                                <%--<li><a href="#timeline" data-toggle="tab">Timeline</a></li>
              <li><a href="#settings" data-toggle="tab">Settings</a></li>--%>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="active tab-pane" id="activity">
                                                    <!-- Post -->
                                                    <div class="post">
                                                        <div class="user-block">
                                                            <img class="img-circle img-bordered-sm" src="../../dist/img/info.png" alt="user image">
                                                            <span class="username">
                                                                <a href="#">
                                                                    <label id="fullname" class="txtLabel"></label>
                                                                </a>
                                                                <button id="Button3" runat="server" type="button" class="btn btn-success btn-sm pull-right"
                                                                    onclick="openLevel()" title="เพิ่มรายการ">
                                                                    <i class="fa fa-plus"></i>
                                                                </button>
                                                            </span>
                                                            <span class="description">good member history</span>
                                                        </div>
                                                        <!-- /.user-block -->


                                                        <p>
                                                            <table id="tblLevelHistory" name="tblLevelHistory" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                                                                <thead>
                                                                    <tr>
                                                                        <td class="hidden">id</td>
                                                                        <td>Year</td>
                                                                        <td class="hidden">ArchitecID</td>
                                                                        <td class="hidden">FirstName</td>
                                                                        <td class="hidden">LastName</td>
                                                                        <td class="hidden">Level</td>
                                                                        <td>Description</td>
                                                                        <td>Lasted</td>
                                                                        <td>Port</td>
                                                                        <td style="width: 50px; text-align: center;">#</td>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <%-- <%= strTblWeeklyReport %>--%>
                                                                    <%--<tr>
                                      <td>2018</td>
                                      <td>A</td>
                                      <td>Member is A level.</td>
                                      <td>2018-12-31 17:30:30</td>
                                      <td style="width: 20px; text-align: center;">
                                          <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td>2019</td>
                                      <td>AA</td>
                                      <td>Member is AA level.</td>
                                      <td>2019-12-31 16:30:30</td>
                                      <td style="width: 20px; text-align: center;">
                                          <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td>2020</td>
                                      <td>AAA</td>
                                      <td>Member is AAA level.</td>
                                      <td>2020-12-31 16:30:30</td>
                                      <td style="width: 20px; text-align: center;">
                                          <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                      </td>
                                  </tr>--%>
                                                                </tbody>
                                                            </table>
                                                        </p>

                                                    </div>
                                                    <!-- /.post -->

                                                </div>
                                                <!-- /.tab-pane -->
                                            </div>
                                            <!-- /.tab-content -->
                                        </div>
                                        <!-- /.nav-tabs-custom -->
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
                                    <div class="row" style="margin-left: 0px;">

                                        <div class="col-md-2">
                                            <label class="txtLabel">From Date</label>
                                            <div class="input-group date">
                                                <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerstart" name="datepickerstart" value="" autocomplete="off">
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

                                        <div class="col-md-4">
                                            <label class="txtLabel">Key Search [Enter your word need to know..]</label>
                                            <div class="">
                                                <input type="text" class="form-control input-sm pull-left txtLabel" id="txtsearch" name="txtsearch" value="" autocomplete="off">
                                            </div>
                                        </div>

                                        <div class="clo-md-2">
                                            <label class="txtLabel">Show Data Result</label>
                                            <div class="">
                                                <button type="button" id="btnShowResult" name="btnShowResult" class="btn btn-primary">Show Result</button>
                                            </div>
                                        </div>
                                    </div>
                                    <br />

                                    <div class="box-body" style="overflow: scroll;">
                                        <table id="tableProject" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
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
                                                    <td>ProductName</td>
                                                    <td>Profile</td>
                                                    <td>Status</td>
                                                    <td>Delivery</td>
                                                    <td>Quantity</td>
                                                    <td>LastUpdate</td>
                                                    <td>Port</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%= strTblDetail %>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="row">

                                        <div class="col-md-8">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="txtLabel">
                                                Sum Total Quantity :
                                            </label>
                                        </div>
                                        <div class="col-md-2">
                                            <b>
                                                <label id="test" class="txtLabel" style="margin-left: 40px"></label>
                                            </b>
                                            <input type="text" class="form-control input-sm pull-left txtLabel hidden" id="txtSumQuantity" name="txtSumQuantity" value="" autocomplete="off" />
                                        </div>
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
                                    <div class="box-body" style="overflow: scroll;">
                                        <table id="tableReward" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <td>No</td>
                                                    <td class="hidden">id</td>
                                                    <td class="hidden">event_id</td>
                                                    <td>Reward and Event</td>
                                                    <td class="hidden">title_id</td>
                                                    <td>Title Description</td>
                                                    <td>Year <%= gyear4 %></td>
                                                    <td>Year <%= gyear3 %></td>
                                                    <td>Year <%= gyear2 %></td>
                                                    <td>Year <%= gyear1 %></td>
                                                    <td>Year <%= gyear %></td>
                                                    <td class="hidden">inv_id</td>
                                                    <td>Invitation</td>
                                                    <td class="hidden">attn_id</td>
                                                    <td>Attendance</td>
                                                    <td>Dated</td>
                                                    <td>Remark</td>
                                                    <td class="">#</td>
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
                                    <div class="box-body">
                                        <table id="tableWeeklyReportx" class="table table-bordered table-striped table-hover table-condensed txtLabel" style="width: 100%">
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
                            <div class="col-md-4 txtLabel">Activities</div>
                            <div class="col-md-8">
                                <span class="txtLabel">
                                    <select class="form-control input-sm" style="width: 100%" id="selectActivity" name="selectActivity">
                                </select>
                                </span>
                            </div>
                        </div>

                        <div id="divgift" class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Title</div>
                            <div class="col-md-8">
                                <input type="text" class="hidden" id="txtid" name="txtid" value="" />
                                <input type="text" class="hidden" id="txteventid" name="txteventid" value="" />
                                <span class="txtLabel">
                                    <select class="form-control input-sm" style="width: 100%" id="selectEvent" name="selectEvent">
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
                                <%--<input type="text" class="form-control input-sm txtLabel" id="txtdetails" name="txtdetails" value="" />--%>
                                <textarea class="form-control input-sm txtLabel" cols="40" rows="3" id="txtdetails" name="txtdetails"></textarea>
                            </div>
                        </div>

                        <div id="divinvite" class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Invitation</div>
                            <div class="col-md-8">
                                <span class="txtLabel">
                                    <select class="form-control input-sm" style="width: 100%" id="selectInvitation" name="selectInvitation">
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div id="divattend" class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Attendance</div>
                            <div class="col-md-8">
                                <span class="txtLabel">
                                    <select class="form-control input-sm" style="width: 100%" id="selectAttendance" name="selectAttendance">
                                    </select>
                                </span>
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


        <div class="modal fade" id="modal-level">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Addnew Level</h4>
                    </div>
                    <div class="modal-body">
                        <%--<p>One fine body&hellip;</p>--%>

                        <div class="row hidden" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Architect Name</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm txtLabel" id="txtLevelArchitect" name="txtLevelArchitect" value="" />
                            </div>
                        </div>

                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Firstname</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm txtLabel" id="txtLevelFirstname" name="txtLevelFirstname" value="" readonly />
                            </div>
                        </div>

                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Lastname</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm txtLabel" id="txtLevelLastname" name="txtLevelLastname" value="" readonly />
                            </div>
                        </div>

                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Year</div>
                            <div class="col-md-8">
                                <span class="txtLabel">
                                    <select class="form-control input-sm" style="width: 100%" id="selectLevelYear" name="selectLevelYear">
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 txtLabel">Level</div>
                            <div class="col-md-8">
                                <span class="txtLabel">
                                    <select class="form-control input-sm" style="width: 100%" id="selectLevel" name="selectLevel">
                                    </select>


                                </span>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnSaveLevel" name="btnSaveLevel" class="btn btn-primary">Save changes</button>
                        <button type="button" id="Button2" name="btnCallRewardEvent" runat="server" onserverclick="btnCallRewardEvent_click" class="btn btn-primary hidden">Call Reward Event</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function openEvent() {

                $('#txtid').val('');
                $('#txtdetails').val('');
                $('#txtremark').val('');
                $('#datepickertrans').val('');

                var selectActivity= $('#selectActivity');
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetEventActivity',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectActivity.empty();
                        $(data).each(function (index, item) {
                            selectActivity.append($('<option/>', { value: item.act_id, text: item.act_desc }));
                            selectActivity.change();
                        });
                    }
                });


                getAttendance();



                //var selectEventDDL = $('#selectEvent');
                //$.ajax({
                //    url: 'DataServicesArchitectProfile.asmx/GetEventType',
                //    method: 'post',
                //    dataType: 'json',
                //    success: function (data) {
                //        selectEventDDL.empty();
                //        $(data).each(function (index, item) {
                //            selectEventDDL.append($('<option/>', { value: item.id, text: item.event_desc }));
                //            //$('#selectProductType').val(strVal9.text());
                //            //$('#selectProductType').change();
                //        });


                //    }
                //});


                $("#modal-event").modal({ backdrop: false });
                $('[id=modal-event]').modal('show');
            }

            function getAttendance() {
                var selectInvitation= $('#selectInvitation');
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetInvitation',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectInvitation.empty();
                        $(data).each(function (index, item) {
                            selectInvitation.append($('<option/>', { value: item.id, text: item.inv_desc }));
                            //selectInvitation.change();
                        });
                    }
                });

                var selectAttendance= $('#selectAttendance');
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetAttendance',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectAttendance.empty();
                        $(data).each(function (index, item) {
                            selectAttendance.append($('<option/>', { value: item.id, text: item.attn_desc }));
                            //selectInvitation.change();
                        });
                    }
                });
            }



            function openLevel() {

                var selectLevelYear = $('#selectLevelYear');
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetDataPreviousYear',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectLevelYear.empty();
                        $(data).each(function (index, item) {
                            selectLevelYear.append($('<option/>', { value: item.iYear, text: item.nYear }));

                        });
                    }
                });


                var selectLevel = $('#selectLevel');
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetDataLevel',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        selectLevel.empty();
                        $(data).each(function (index, item) {
                            selectLevel.append($('<option/>', { value: item.level_id, text: item.level_desc }));

                        });
                    }
                });

                var txtArchitectID = $('#txtArchitectIDEdit');
                var txtFirstName = $('#txtFirstNameEdit');
                var txtLastName = $('#txtLastNameEdit');

                var txtLevelArchitect = $('#txtLevelArchitect');
                var txtLevelFirstname = $('#txtLevelFirstname')
                var txtLevelLastname = $('#txtLevelLastname')


                txtLevelArchitect.val(txtArchitectID.val());
                txtLevelFirstname.val(txtFirstName.val());
                txtLevelLastname.val(txtLastName.val());

                $("#modal-level").modal({ backdrop: false });
                $('[id=modal-level]').modal('show');
            }


            function getLevelHistory() {
                var txtArchitectID = $('#txtArchitectIDEdit');
                var txtFirstName = $('#txtFirstNameEdit');
                var txtLastName = $('#txtLastNameEdit');
                var fullname = $('#fullname');                

                fullname.text(txtFirstName.val() + ' ' + txtLastName.val());

                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetLevelHistory',
                    method: 'post',
                    data: {
                        id: txtArchitectID.val()
                    },
                    dataType: 'json',
                    success: function (data) {

                        //alert(selectSaleport + ' ' + datepickertrans + ' ' + datepickerend);

                        var trHTML = '';
                        $('#tblLevelHistory tr:not(:first)').remove();
                        $(data).each(function (index, item) {
                            trHTML += '<tr>' +
                                '<td class="hidden">' + item.id + '</td>' +
                                '<td class="">' + item.inYear + '</td>' +
                                '<td class="hidden">' + item.ArchitecID + '</td>' +
                                '<td class="hidden">' + item.FirstName + '</td>' +
                                '<td class="hidden">' + item.LastName + '</td>' +
                                '<td class="hidden">' + item.level_id + '</td>' +
                                '<td class="">' + item.level_desc + '</td>' +
                                '<td class="">' + item.last_update + '</td>' +
                                '<td class="">' + item.Port + '</td>' +
                                '<td style="width: 50px; text-align: center;"> <button  type="button" onClick="onDeleteLevel(' + item.id + ')" class="btn btn-danger btn-sm"><i class="fa fa-trash-o fa-sm"></i> </button></td>' +
                                '</tr > ';

                        });

                        $('#tblLevelHistory').append(trHTML);

                        getArchitectPortOwner(txtArchitectID.val());
                    }
                })

            }

            function getArchitectPortOwner(id) {
                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetArchitectPortOwner',
                    method: 'POST',
                    data: {
                        id: id
                    },
                    dataType: 'json',
                    success: function (data) {
                        $(data).each(function (index, item) {
                            var xport = item.Port;
                            //alert(xport);
                            $('#txtPortEdit').val(xport);
                        });
                    }
                });
            }


            function onDeleteLevel(id) {
                // alert(id);

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                $.ajax({
                    url: 'DataServicesArchitectProfile.asmx/GetUpdateHistoryLevel',
                    method: 'POST',
                    data: {
                        id: id
                    },
                    dataType: 'json',
                    complete: function (response) {
                        //alert("Data was succesfully captured");
                        getLevelHistory();
                    }
                });
            }


        </script>

    </section>
</asp:Content>
