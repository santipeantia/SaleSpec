<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="weeklyreport.aspx.cs" Inherits="SaleSpec.pages.trans.weeklyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .select2-container .select2-selection--multiple {
            font-family: 'Arial', Verdana;
            font-size: 12px;
            box-sizing: border-box;
            display: block;
            height: 27px;
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
                                    <div class="col-md-2 col-md-offset-2">
                                        <label class="txtLabel">Visit Date</label>
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left" id="datepickertrans" value="" autocomplete="off">
                                            <div class="input-group-addon input-sm">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="bootstrap-timepicker">
                                            <div class="input-group">
                                                <label class="txtLabel">StartTime</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm timepicker">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="bootstrap-timepicker">
                                            <div class="input-group">
                                                <label class="txtLabel">ToTime</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm timepicker">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="col-md-1 input-group">
                                        <label class="txtLabel">Event</label>
                                        <div class="">
                                            <button type="button" class="btn btn-info btn-block btn-flat btn-sm">Event View</button>
                                        </div>
                                    </div>--%>
                                </div>
                               
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Company</label>
                                            <div class="input-group col-md-12">
                                                <span class="txtLabel">
                                                    <select id="selectCustomer" class="form-control input input-sm " style="width: 100%;">
                                                        <option value=""></option>
                                                        <option value="1675">Vortech Architek Co.,Ltd</option>
                                                        <option value="1676">Weapons Decoration Co.,Ltd</option>
                                                        <option value="1677">Wirach & Associate Co.,Ltd</option>
                                                        <option value="1678">Wise Line Co.,Ltd</option>
                                                        <option value="1679">Wolves Design Co.,Ltd</option>
                                                        <option value="1680">Work- aholic architect Co.,Ltd</option>
                                                        <option value="1681">Work Of Work Co.,Ltd</option>
                                                        <option value="1682">Workspace Architecture Studio Co.,Ltd</option>
                                                        <option value="1683">Xayaburi Power Co.,Ltd</option>
                                                        <option value="1684">Zamil Steel Co.,Ltd</option>
                                                        <option value="1685">Zpacez Co.,Ltd</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-1 input-group">
                                            <label class="txtLabel">Company</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="openCompany()">New</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Architect</label>
                                            <div class="input-group col-md-12">
                                                <span class="txtLabel">
                                                    <select id="selectArchitect" class="form-control input input-sm " style="width: 100%;">
                                                        <option value=""></option>
                                                        <option value="1556">Kittaphol	 Onsri</option>
                                                        <option value="1668">Kittipat	Sirijumpar</option>
                                                        <option value="1523">Kittiphop	Watthong</option>
                                                        <option value="1665">Kritsada	 Pengwantana</option>
                                                        <option value="1536">Laddawan	Panta</option>
                                                        <option value="1233">Napasawan	Bhongbhibhat</option>
                                                        <option value="1651">Nares	unphikul</option>
                                                        <option value="1182">Narin	 Bunjun</option>
                                                        <option value="1349">Narongrit	Veerakul</option>

                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-1 input-group">
                                            <label class="txtLabel">Architect</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="openArchitect()">New</button>
                                            </div>
                                        </div>
                                    </div>

                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-6 col-md-offset-2">
                                        <label class="txtLabel">What do you do...</label>
                                        <div class="input-group col-md-12">
                                            <span class="txtLabel">
                                                <select id="selectTransEntry" class="form-control input input-sm " style="width: 100%;">
                                                    <option value=""></option>
                                                    <option value="1">New Project</option>
                                                    <option value="2">Update Project</option>
                                                    <option value="3">New Architect </option>
                                                    <option value="4">Spec Intake</option>
                                                    <option value="5">ผลการปฏิบัติงานอื่นๆ</option>
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-1 input-group">
                                        <label class="txtLabel">Entry</label>
                                        <div class="">
                                            <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">Entry</button>
                                        </div>
                                    </div>
                                </div>
                                <hr />

                                <div id="divNewProject"  style="display: none;"  >
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">New Project</label>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control input-sm">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Locations</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea cols="40" rows="3" class="form-control input-sm"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Process</label>
                                            <div class="txtLabel">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <select id="selectProcess" class="form-control input-sm" style="width: 100%">
                                                    <option value="value">Process 1</option>
                                                    <option value="value">Process 2</option>
                                                    <option value="value">Process 3</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="txtLabel">Step</label>
                                            <div class="txtLabel">
                                                <select id="selectStep" class="form-control input-sm"  style="width: 100%">
                                                    <option value="value">Step 1</option>
                                                    <option value="value">Step 2</option>
                                                    <option value="value">Step 3</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Product</label>
                                            <div class="txtLabel">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <select id="selectProduct" class="form-control input-sm" style="width: 100%">
                                                    <option value="value">Product 1</option>
                                                    <option value="value">Product 2</option>
                                                    <option value="value">Product 3</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="txtLabel">Profile</label>
                                            <div class="txtLabel">
                                                <select id="selectProfile" class="form-control input-sm"  style="width: 100%">
                                                    <option value="value">Profile 1</option>
                                                    <option value="value">Profile 2</option>
                                                    <option value="value">Profile 3</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Quantity</label>
                                            <div class="txtLabel">
                                                <input type="text" class="form-control input-sm" />                                                
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="txtLabel">Delivery Date</label>
                                            <div class="input-group date">
                                                <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdelivery" value="" autocomplete="off">
                                                <div class="input-group-addon input-sm">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                        </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Reason</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="inputreason" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Status</label>
                                            <div class="txtLabel">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <select id="selectStatus" class="form-control input-sm" style="width: 100%">
                                                    <option value="value">Status 1</option>
                                                    <option value="value">Status 2</option>
                                                    <option value="value">Status 3</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2  col-md-offset-1">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="divUpdate" style="display: none;">
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Update Project</label>
                                            <div class="input-group col-md-12">
                                                <span class="txtLabel">
                                                    <select id="selectProject" class="form-control input input-sm " style="width: 100%;">
                                                        <option value=""></option>
                                                        <option value="PJ0190">โรงงานสยามคาคิฮาระ</option>
                                                        <option value="PJ0191">Renovate Showa</option>
                                                        <option value="PJ0192">Sankyu </option>
                                                        <option value="PJ0193">Hino สมุทรสาคร</option>
                                                        <option value="PJ0194">SHL พาราวูด แคราย</option>
                                                        <option value="PJ0195">Thai sanei นิคมเวลโก</option>
                                                        <option value="PJ0196">NEW TEMPORARY MIXING ROOM</option>
                                                        <option value="PJ0197">Sumitomo missing</option>
                                                        <option value="PJ0198">โรงงานเออิโย</option>
                                                        <option value="PJ0199">โรงงานเค ไลน์</option>
                                                        <option value="PJ0200">โรงงานมโนยนต์ชัย</option>

                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Locations</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea cols="40" rows="3" class="form-control input-sm"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">MainCon</label>
                                            <div class="">
                                                <input type="text" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Process</label>
                                            <div class="txtLabel">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <select id="selectProcess" class="form-control input-sm" style="width: 100%">
                                                    <option value="value">Process 1</option>
                                                    <option value="value">Process 2</option>
                                                    <option value="value">Process 3</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="txtLabel">Step</label>
                                            <div class="txtLabel">
                                                <select id="selectStep" class="form-control input-sm"  style="width: 100%">
                                                    <option value="value">Step 1</option>
                                                    <option value="value">Step 2</option>
                                                    <option value="value">Step 3</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Product</label>
                                            <div class="txtLabel">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <select id="selectProduct" class="form-control input-sm" style="width: 100%">
                                                    <option value="value">Product 1</option>
                                                    <option value="value">Product 2</option>
                                                    <option value="value">Product 3</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="txtLabel">Profile</label>
                                            <div class="txtLabel">
                                                <select id="selectProfile" class="form-control input-sm"  style="width: 100%">
                                                    <option value="value">Profile 1</option>
                                                    <option value="value">Profile 2</option>
                                                    <option value="value">Profile 3</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Quantity</label>
                                            <div class="txtLabel">
                                                <input type="text" class="form-control input-sm" />                                                
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="txtLabel">Delivery Date</label>
                                            <div class="input-group date">
                                                <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdelivery1" value="" autocomplete="off">
                                                <div class="input-group-addon input-sm">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                        </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Reason</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="inputreason" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-3 col-md-offset-2">
                                            <label class="txtLabel">Status</label>
                                            <div class="txtLabel">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <select id="selectStatus2" class="form-control input-sm" style="width: 100%">
                                                    <option value="value">Status 1</option>
                                                    <option value="value">Status 2</option>
                                                    <option value="value">Status 3</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2  col-md-offset-1">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="divNewArchitect"  style="display: none;"  >
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">New Architect</label>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control input-sm">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Reason</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="inputreason" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="divSpecIntake"  style="display: none;"  >
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2 col-md-offset-2">
                                            <div class="radio txtLabel">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                                    มีไฟล์เอกสารแนบ
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 ">
                                            <div class="radio txtLabel">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2" >
                                                    ไม่มีไฟล์แนบ
                                                </label>
                                            </div>
                                        </div>
                                         <div class="col-md-2 ">
                                            <button class="btn btn-info btn-block btn-flat btn-sm">Browse</button>
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
                                                        <th>#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>1</td>
                                                        <td>document support no.1</td>
                                                        <td>Details document support no.1</td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td>document support no.2</td>
                                                        <td>Details document support no.2</td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></td>
                                                    </tr>
                                                    <tr>
                                                        <td>3</td>
                                                        <td>document support no.3</td>
                                                        <td>Details document support no.3</td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a></td>
                                                        <td style="width: 20px; text-align: center;"><a href="#" title="Delete"><i class="fa fa-trash text-red"></i></a></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Reason</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="inputreason" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div id="divOther"  style="display: none;"  >
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Other</label>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control input-sm">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-6 col-md-offset-2">
                                            <label class="txtLabel">Reason</label>
                                            <div class="">
                                                <%--<input type="text" class="form-control input-sm" />--%>
                                                <textarea id="inputreason" cols="40" rows="3" class="form-control input-sm"></textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-md-2  col-md-offset-2">
                                            <label class="txtLabel">Save Entry</label>
                                            <div class="">
                                                <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="Button1">Save Entry</button>
                                            </div>
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
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CompanyID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCompanyID" name="txtCompanyID" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CompanyName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCompanyName" name="txtCompanyName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">CompanyName2</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtCompanyName2" name="txtCompanyName2" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Address	</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtAddress" name="txtAddress" class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">ContactPerson</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtContactPerson" name="txtContactPerson" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtPhone" name="txtPhone" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">Status</div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <input type="text" id="txtStatusNew" name="txtStatusNew" class="form-control input input-sm txtLabel" value="" required readonly>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-warning btn-flat btn-sm" data-toggle="modal" data-target="#myModalActiveNew"><i class="fa fa-search"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary hidden" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary " id="btnSaveNewData" runat="server">Save Changes</button>
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
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Architect ID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtArchitectID" name="txtArchitectID" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">FirstName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtFirstName" name="txtFirstName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">LastName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtLastName" name="txtLastName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">NickName</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtNickName" name="txtNickName" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Position</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPosition" name="txtPosition" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Address</div>
                                <div class="col-md-8">
                                    <%--<input type="text" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress" placeholder="" value="" required>--%>
                                    <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="txtAddress" name="txtAddress"></textarea>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Phone</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtPhone" name="txtPhone" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Mobile</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtMobile" name="txtMobile" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel">Email</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm txtLabel" id="txtEmail" name="txtEmail" placeholder="" value="" required>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="Button2" runat="server">Save Changes</button>
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
                                    <input type="text" class="form-control input input-sm txtLabel" id="CompanyName" name="CompanyName" placeholder="" value="" required>
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
                                        <select class="form-control input-sm" style="width:  100%;">
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
                                        <select id="selectCategory" class="form-control input-small" style="width:  100%;">
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


        <script>

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
