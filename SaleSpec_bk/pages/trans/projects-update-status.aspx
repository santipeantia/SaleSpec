<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="projects-update-status.aspx.cs" Inherits="SaleSpec.pages.trans.projects_update_status" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <h1>Projects Update Status
            <small>Control panel</small>
        </h1>
    </section>


    <!-- Main content -->
    <section class="content">
        <%= strMsgAlert %>

        <div class="row">
            <div class="col-xs-12">
                <div class="box box-success">
                    <%--<div class="box-header">
                        <h3 class="box-title txtLabel">Project Data Info</h3>
                    </div>--%>
                    <div class="box-body">

                        <div class="post clearfix">
                            <div class="user-block">
                                <img class="img-circle img-bordered-sm" src="../../dist/img/info.png" alt="User Image">
                                <span class="username">
                                    <a href="#">Project Data Info</a>
                                    <%--<a href="#" class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>--%>
                                    <a href="#" class="pull-right btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                                </span>
                                <span class="description">Please update your project status</span>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-2">
                                    <label class="txtLabel">ProjectID</label>
                                    <input type="text" id="ProjectID" name="ProjectID" class="form-control  input-sm" value="" readonly />
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="txtLabel">Project Name</label>
                                    <input type="text" id="ProjectName" name="ProjectName" class="form-control  input-sm" value="" readonly />
                                </div>

                                <div class="form-group col-md-2">
                                    <label class="txtLabel">Create Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left" id="datepickertrans">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-md-2">
                                    <label class="txtLabel">Start Date</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control input-sm pull-left" id="datepickerstart">
                                        <div class="input-group-addon input-sm">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                          </div>

                        

                        <div class="row">
                             <div class="form-group col-md-2">
                                <label class="txtLabel">CompanyID</label>
                                <input type="text" id="CompanyID" name="ArchitectID" class="form-control  input-sm" value="" />
                            </div>

                            <div class="form-group col-md-6">
                                <label class="txtLabel">Company Name</label>
                                <input type="text" id="CompanyName" name="ArchitectName" class="form-control  input-sm" value="" />
                            </div>

                            <div class="form-group col-md-2">
                                <label class="txtLabel">Overview</label>
                                <button class="btn btn-success btn-sm btn-flat btn-block txtLabel" id="btnCompanyInfo" 
                                        runat="server" >Show More Detials</button>
                            </div>
                        </div>

                        <div class="row">
                             <div class="form-group col-md-2">
                                <label class="txtLabel">ArchitectID</label>
                                <input type="text" id="ArchitectID" name="ArchitectID" class="form-control  input-sm" value="" />
                            </div>

                            <div class="form-group col-md-6">
                                <label class="txtLabel">Architect Name</label>
                                <input type="text" id="ArchitectName" name="ArchitectName" class="form-control  input-sm" value="" />
                            </div>

                            <div class="form-group col-md-2">
                                <label class="txtLabel">Overview</label>
                                <button class="btn btn-success btn-sm btn-flat btn-block txtLabel" id="btnArchitectInfo" 
                                        runat="server" >Show More Detials</button>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">Process Step</label>
                                    <select id="step" class="form-control txtLabel">
                                        <option value=""></option>
                                        <option value="PS01">Design</option>
                                        <option value="PS02">Bidding</option>
                                        <option value="PS03">Award MC</option>
                                        <option value="PS04">Award RF</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">Status</label>
                                    <select id="status" class="form-control txtLabel">
                                        <option value=""></option>
                                        <option value="S01">Intake</option>
                                        <option value="S02">Sold</option>
                                        <option value="S03">Finished</option>
                                        <option value="S04">Cancel</option>
                                        <option value="S05">Hold</option>
                                        <option value="S06">N/A</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                             <div class="form-group col-md-12">
                                <label class="txtLabel">Remark</label>
                                <textarea id="txtremark" rows="3" class="form-control input-sm txtLabel"></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group col-md-2 pull-right">
                                <button class="btn btn-primary btn-sm btn-flat btn-block txtLabel" id="btnUpdate"
                                    runat="server">
                                    Update Entry</button>
                            </div>
                            <div class="form-group col-md-2 pull-right">
                                <button class="btn btn-default btn-sm btn-flat btn-block txtLabel" id="btnBack"
                                    runat="server">
                                    Back to list</button>
                            </div>
                        </div>

                        <hr />

                        <div class="post clearfix">
                            <div class="user-block">
                                <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                <span class="username">
                                    <a href="#">Weekly Report</a>
                                    <%--<a href="#" class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>--%>
                                    <a href="#" class="pull-right btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                                </span>
                                <span class="description">Details for weekly report</span>
                            </div>
                            <!-- /.user-block -->

                            <div class="container-fluid">
                                <table id="tableActive" class="table table-bordered table-striped table-hover table-condensed">
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

                        <div class="post clearfix">
                            <div class="user-block">
                                <img class="img-circle img-bordered-sm" src="../../dist/img/document.png" alt="User Image">
                                <span class="username">
                                    <a href="#">Drawing & Documents</a>
                                    <a href="#" class="pull-right btn btn-default btn-sm" data-toggle="modal" data-target="#myModalAttachment"  ><i class="fa fa-plus"></i></a>
                                </span>
                                <span class="description">Please attach your document support</span>
                            </div>
                            <!-- /.user-block -->

                            <div class="container-fluid">
                                <table id="tableActive" class="table table-bordered table-striped table-hover table-condensed">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Description</th>
                                            <th>Files</th>
                                            <th>Owner</th>
                                            <th>Uploaded</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>เอกสารประกอบ TOR</td>
                                            <td>tordocs.pdf</td>
                                            <td>Somchai Saylom</td>
                                            <td>2019-01-01 12:30:00</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>เอกสารคู่สัญญา</td>
                                            <td>registration.pdf</td>
                                            <td>Somchai Saylom</td>
                                            <td>2019-01-01 12:30:00</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>บิลค่าอาหาร</td>
                                            <td>receipt.pdf</td>
                                            <td>Somchai Saylom</td>
                                            <td>2019-01-01 12:30:00</td>
                                            <td style="width: 20px; text-align: center;">
                                                <a href="#" title="Edit"><i class="fa fa-pencil-square-o text-green"></i></a>
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
    
    <div class="modal modal-default fade" id="myModalAttachment">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Attached</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                             <div class="form-group col-md-3 col-md-offset-1">
                                <label class="txtLabel">Filename</label>
                            </div>
                            <div class="form-group col-md-8">
                                <label class="custom-file">
                                    <input type="file" id="file" class="form-control custom-file-input">
                                    <span class="custom-file-control"></span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="row">
                             <div class="form-group col-md-3 col-md-offset-1">
                                <label class="txtLabel">Description</label>
                            </div>
                            <div class="form-group col-md-8">
                                <input type="text" id="ArchitectID" name="ArchitectID" class="form-control  input-sm" value="" />
                            </div>
                        </div> 

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-info btn-sm" >Update Changed</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

    <script>
        function openAttachment() {
            $("myModalAttachment").modal({ backdrop: false });
            $('[id=myModalAttachment]').modal('show');
        }

        

    </script>

</asp:Content>
