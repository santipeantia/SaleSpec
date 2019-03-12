<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="weeklyreport-update.aspx.cs" Inherits="SaleSpec.pages.trans.weeklyreport_update" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <h1>Weekly Report Update
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->

        <%= strMsgAlert %>

        <div class="row">
            <div class="col-xs-12">
                <div class="box box-success">
                    <div class="box-body">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                            <span class="username">
                                <a href="#">Weekly Report Update</a>
                                <%--<a href="#" class="pull-right btn btn-default btn-sm"><i class="fa fa-plus"></i></a>--%>
                            </span>
                            <span class="description">Details for weekly report</span>
                        </div>
                        <br />

                        <div class="container">
                            <div class="row" style="margin-left: 20px;">
                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Project Name</label>
                                    <%--<input type="text" id="ProjectID" name="ProjectID" class="form-control  input-sm" value="" />--%>
                                    <span class="txtLabel input-mini">
                                    <select class="form-control input-sm" title="Please select" >
                                        <option value="">Please select a project</option>
                                        <option value="01">Project name no.1</option>
                                        <option value="02">Project name no.2</option>
                                        <option value="03">Project name no.3</option>
                                        <option value="04">Project name no.4</option>
                                        <option value="05">Project name no.5</option>
                                    </select>
                                        </span>
                                </div>

                                 <div class="form-group col-md-2">
                                    <label class="txtLabel">Query History</label>
                                     <div class="form-group">
                                         <button type="button" class="btn btn-primary btn-flat btn-sm col-md-6" title="Show project visit history" id="Button1" runat="server">History</button>
                                         <a href="apprequest-new?opt=reqf" target="_blank" class="btn btn-success btn-flat btn-sm col-md-6" title="Create new project entry">New Project</a>
                                     </div>
                                </div>
                            </div>

                            <div class="row" style="margin-left: 20px;">
                                <div class="form-group col-md-2">
                                    <label class="txtLabel">Start Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left" id="datepickertrans">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-md-2">
                                    <label class="txtLabel">To Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left" id="datepickerstart">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label class="txtLabel">Query Info..</label>
                                    <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel" id="btnSearch" runat="server">Ontime History</button>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="post clearfix">
                            <div class="user-block">
                                <img class="img-circle img-bordered-sm" src="../../dist/img/document.png" alt="User Image">
                                <span class="username">
                                    <a href="#">Visit History</a>
                                    <div class="btn-group pull-right ">
                                        <a href="#" class="btn btn-default btn-sm" onclick="openModal()"><i class="fa fa-plus"></i></a>
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel" runat="server"><i class="fa fa-table"></i></button>
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
                                            <th>StartTime</th>
                                            <th>ToTime</th>
                                            <th>Architect</th>
                                            <th>Copany</th>
                                            <th>Location</th>
                                            <th>Contact</th>
                                            <th>Tel</th>
                                            <th>Remark</th>
                                            <th>Result</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>2018-12-25</td>
                                            <td>10:00</td>
                                            <td>11:00</td>
                                            <td>Amornrat	Eursirirattanaphisan</td>
                                            <td>Planet Studio Co.,Ltd.</td>
                                            <td>กาฬสินธุ์</td>
                                            <td>K.Somchai</td>
                                            <td>0899999959</td>
                                            <td>Make Relationship</td>
                                            <td>Great Feedback</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2018-12-28</td>
                                            <td>14:00</td>
                                            <td>15:30</td>
                                            <td>Amornrat	Eursirirattanaphisan</td>
                                            <td>Planet Studio Co.,Ltd.</td>
                                            <td>กาฬสินธุ์</td>
                                            <td>K.Somchai</td>
                                            <td>0899999959</td>
                                            <td>Make Relationship</td>
                                            <td>Great Feedback</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2019-01-10</td>
                                            <td>09:00</td>
                                            <td>10:00</td>
                                            <td>Amornrat	Eursirirattanaphisan</td>
                                            <td>Planet Studio Co.,Ltd.</td>
                                            <td>กาฬสินธุ์</td>
                                            <td>K.Somchai</td>
                                            <td>0899999959</td>
                                            <td>Make Relationship</td>
                                            <td>Great Feedback</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2019-01-15</td>
                                            <td>11:00</td>
                                            <td>15:45</td>
                                            <td>Amornrat	Eursirirattanaphisan</td>
                                            <td>Planet Studio Co.,Ltd.</td>
                                            <td>กาฬสินธุ์</td>
                                            <td>K.Somchai</td>
                                            <td>0899999959</td>
                                            <td>Make Relationship</td>
                                            <td>Great Feedback</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Modal" data-dismiss="modal"><i class="fa fa-pencil-square-o text-green"></i></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="modal modal-default fade" id="myModalNew">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Visit Review</h4>
                </div>

                <div class="modal-body">
                    <div class="container-fluid">

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Project</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeID" name="txtGradeID" placeholder="" value="Project name no.1 or Someting project" readonly required>
                                <%--<asp:DropDownList ID="ddlProject" runat="server" ClientIDMode="Static" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged">
                                    <asp:ListItem Value="0">0000</asp:ListItem>
                                    <asp:ListItem Value="1">1111</asp:ListItem>
                                    <asp:ListItem Value="2">2222</asp:ListItem>
                                    <asp:ListItem Value="3">3333</asp:ListItem>
                                    <asp:ListItem Value="4">4444</asp:ListItem>
                                    <asp:ListItem Value="5">5555</asp:ListItem>
                                    <asp:ListItem Value="6">6666</asp:ListItem>
                                </asp:DropDownList>--%>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Visit Date</div>
                            <div class="col-md-8">
                                <div class="input-group date">
                                    <input type="text" class="form-control input-sm pull-left" id="datevisit">
                                    <div class="input-group-addon input-sm">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">StartTime</div>
                            <div class="col-md-8">
                                <div class="input-group date">
                                    <input type="text" id="txtTime" class="form-control input-sm pull-left ">
                                    <div class="input-group-addon input-sm">
                                        <i class="fa fa-clock-o"></i>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">To Time</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDesc" name="txtGradeDesc" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Architect</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDesc" name="txtGradeDesc" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Company</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Location</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Contact</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Tel</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Visit Result</div>
                            <div class="col-md-8">
                                <textarea cols="40" rows="3" id="txtGradeDetailEdit" name="txtGradeDetailEdit" class="form-control input input-sm"></textarea>
                                <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Remark</div>
                            <div class="col-md-8">
                                <textarea cols="40" rows="3" id="txtGradeDetailEdit" name="txtGradeDetailEdit" class="form-control input input-sm"></textarea>
                                <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                    <button type="button" class="btn btn-primary hidden" id="Button2" runat="server">Update Changes</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-default fade" id="myModalEdit">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Visit Review</h4>
                </div>

                <div class="modal-body">
                    <div class="container-fluid">

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Project</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeIDEdit" name="txtGradeIDEdit" placeholder="" value="Project name no.1" readonly required>
                                <%--<asp:DropDownList ID="ddlProject" runat="server" ClientIDMode="Static" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged">
                                    <asp:ListItem Value="0">0000</asp:ListItem>
                                    <asp:ListItem Value="1">1111</asp:ListItem>
                                    <asp:ListItem Value="2">2222</asp:ListItem>
                                    <asp:ListItem Value="3">3333</asp:ListItem>
                                    <asp:ListItem Value="4">4444</asp:ListItem>
                                    <asp:ListItem Value="5">5555</asp:ListItem>
                                    <asp:ListItem Value="6">6666</asp:ListItem>
                                </asp:DropDownList>--%>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Visit Date</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeIDEdit" name="txtGradeIDEdit" placeholder="" value="2019-01-01" readonly required>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">StartTime</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="9:00 AM" required>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">To Time</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="11:00 AM" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Architect</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="Amornrat	Eursirirattanaphisan" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Company</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="Planet Studio Co.,Ltd." required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Location</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="กาฬสินธุ์" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Contact</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="K.Somchai" required>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Tel</div>
                            <div class="col-md-8">
                                <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="0899999959" required>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Visit Result</div>
                            <div class="col-md-8">
                                <textarea cols="40" rows="3" id="txtGradeDetailEdit" name="txtGradeDetailEdit" class="form-control input input-sm">Great Feedback</textarea>
                                <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 5px">
                            <div class="col-md-4">Remark</div>
                            <div class="col-md-8">
                                <textarea cols="40" rows="3" id="txtGradeDetailEdit" name="txtGradeDetailEdit" class="form-control input input-sm">Make Relationship</textarea>
                                <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" id="btnSubmitUpdate" class="btn btn-primary" onclick="ValidateUpdate()">Update Changes</button>
                    <button type="button" class="btn btn-primary hidden" id="btnUpdateData" runat="server">Update Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script>
       
        function openModal() {

            $("#myModalNew").modal({ backdrop: false });
            $('[id=myModalNew]').modal('show');
        }

        var table = document.getElementById("tableDetails"), rIndex;
        for (var i = 1; i < table.rows.length; i++) {
            for (var j = 0; j < table.rows[i].cells.length; j++) {
                table.rows[i].cells[j].onclick = function () {
                    rIndex = this.parentElement.rowIndex;
                    cIndex = this.cellIndex;
                    console.log(rIndex + "  :  " + cIndex);

                    if (this.cellIndex == 10) {

                        var strID = table.rows[rIndex].cells[0].innerHTML;
                        var strDesc = table.rows[rIndex].cells[1].innerHTML;
                        var strDetail = table.rows[rIndex].cells[2].innerHTML;

                        //window.open('webform1.aspx?id=' + strID + '&ref=' + strDesc, '_blank', 'height=200, width=200, top=200, left=300, toolbar=no, titlebar=no,location=no,status=no,menubar=no');

                        //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                        //document.getElementById("txtGradeIDEdit").value = strID;
                        //document.getElementById("txtGradeDescEdit").value = strDesc;
                        //document.getElementById("txtGradeDetailEdit").value = strDetail;

                        $("#myModalEdit").modal({ backdrop: false });
                        $("#myModalEdit").modal("show");

                    }
                }
            }
        }

    </script>

</asp:Content>
