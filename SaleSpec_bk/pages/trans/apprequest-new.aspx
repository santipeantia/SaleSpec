<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="apprequest-new.aspx.cs" Inherits="SaleSpec.pages.trans.apprequest_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <h1>Application Request New
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->
        <%--   <%= strMsgAlert %>--%>
        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#information" data-toggle="tab">Overview</a></li>
                        <li><a href="#document" data-toggle="tab">Documents</a></li>
                        <li><a href="#notification" data-toggle="tab">Notifications</a></li>

                        <span class="pull-right" style="padding-top: 5px; padding-right: 5px;">
                            <a class="btn btn-default btn-sm checkbox-toggle" href="../../pages/masters/architect?opt=sarc"  data-toggle="tooltip" title="List View"><i class="fa fa-reply"></i></a>
                            <span class="btn-group">
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="Button1" runat="server" ><i class="fa fa-table"></i></button>
                            </span>
                        </span>
                    </ul>

                    <div class="tab-content">
                        <div class="active tab-pane" id="information">
                            <!-- Post -->
                            <div class="post">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/architect_person.png" alt="user image">
                                    <span class="username">
                                        <a href="#">Information</a>
                                        <a href="#" class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>
                                    </span>
                                    <span class="description">Enter more details, for contact in the future..</span>
                                </div>
                                <!-- /.user-block -->
                                <div class="row"  style="margin-left: 20px;" margin-bottom: 5px;>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputDocno" class="col-sm-4 txtLabel">เลขที่เอกสาร</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="inputDocno" value="PJ190001" placeholder="กำหนดเลขที่เอกสาร">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputDocno" class="col-sm-4 txtLabel">วันที่เอกสาร</label>
                                            <div class="col-sm-8">
                                                <%--<input type="text" class="form-control input-sm" id="datepicker" placeholder="ระบุวันที่ทำรายการ">--%>
                                                <div class="input-group date">

                                                    <input type="text" class="form-control input-sm pull-left" id="datepickertrans" value="2019-03-15">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputDocno" class="col-sm-4 txtLabel">กลุ่มลูกค้า</label>
                                            <div class="col-sm-8">
                                                <span class="txtLabel">
                                                    <select id="selectCustomer" class="form-control input input-sm " style="width: 100%">
                                                        <option value="NA01">ลูกค้าปกติ</option>
                                                        <option value="AA01">ลูกค้า AA</option>
                                                        <option value="AT01">ลูกค้า AA พิเศษ</option>
                                                    </select></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 20px; margin-bottom: 5px;">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inpuCust" class="col-sm-4 txtLabel">รหัสสถาปนิก</label>
                                            <div class="col-sm-8">
                                                <%--<input type="text" class="form-control input-sm" id="inpuCust" placeholder="รหัสลูกค้า">--%>
                                                <div class="input-group">
                                                    <input type="text" name="search" class="form-control input input-sm" placeholder="รหัสสถาปนิก" value="0008">
                                                    <div class="input-group-btn">
                                                        <button type="button" name="submit" onclick="openArchitectModal()" class="btn btn-info btn-sm btn-flat">
                                                            <%--<i class="fa fa-search"></i>--%>
                                                            <i class="fa fa-search"></i>
                                                        </button>
                                                    </div>
                                                </div>


                                               <%-- <div class="input-group input-group-sm">
                                                    <input type="text" class="form-control">
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-info btn-flat">Go!</button>
                                                    </span>
                                                </div>--%>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputDocno" class="col-sm-4 txtLabel">ประเภทลูกค้า</label>
                                            <div class="col-sm-8">
                                                <span class="txtLabel">
                                                    <select id="selectCustomer" class="form-control input input-sm " style="width: 100%">
                                                        <option value="C1">Architect (C1)</option>
                                                        <option value="C2">TurnKeyThai (C2)</option>
                                                        <option value="C3">TurnKeyNonThai (C3)</option>
                                                        <option value="C4">Owner (C4)</option>
                                                        <option value="C5">Government/University (C5)</option>
                                                        <option value="C6">Developer (C6)</option>
                                                        <option value="C7">HomeBilder (C7)</option>
                                                        <option value="C8">Factory Builder (C8)</option>
                                                    </select></span>
                                            </div>
                                        </div>
                                    </div>

                                     <div class="col-sm-4">
                                        <label class="col-sm-12 txtLabel text-red"> (*เพื่อนำข้อมูลอ้างอิงไปใช้งาน)</label>
                                    </div>

                                </div>

                                <div class="row" style="margin-left: 20px; margin-bottom: 5px;">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputFirstName" class="col-sm-4 txtLabel">ชื่อลูกค้า</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputCustName" placeholder="ชื่อลูกค้า" value="Asrin">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputFirstName" class="col-sm-4 txtLabel">นามสกุล</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputLastName" placeholder="นามสกุล" value="Sanguanwongwan">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputPhoneNo" class="col-sm-4 txtLabel">เบอร์โทรศัพท์</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputPhoneNo" placeholder="เบอร์โทรศัพท์" value="02-390-2934">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row" style="margin-left: 20px; margin-bottom: 5px;">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputPosition" class="col-sm-4 txtLabel">ตำแหน่ง</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputPosition" placeholder="ตำแหน่ง" value="Architect / Designer">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputDepartment" class="col-sm-4 txtLabel">แผนก</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputDepartment" placeholder="แผนก">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputNickName" class="col-sm-4 txtLabel">ชื่อเล่น</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputNickName" placeholder="ชื่อเล่น">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 20px; margin-bottom: 5px;">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputCompany" class="col-sm-4 txtLabel">ชื่อบริษัทลูกค้า</label>
                                            <div class="col-sm-8">
                                                <div class="input-group">
                                                    <input type="text" name="search" class="form-control input input-sm" placeholder="รหัสบริษัทลูกค้า" value="1041">
                                                    <div class="input-group-btn">
                                                        <button type="button" name="buttonComapny" class="btn btn-info btn-sm btn-flat">
                                                            <i class="fa fa-search"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                     <div class="col-sm-4">
                                        <div class="col-sm-12">
                                            <input type="text" class="form-control input-sm" id="inputCompanyTH" placeholder="ชื่อเรียกบริษัท ภาษาไทย" value="ออลโซน ดีไซน์ บจก.">
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="col-sm-12">
                                            <input type="text" class="form-control input-sm" id="inputCompanyEN" placeholder="ชื่อเรียกบริษัท ภาษาอังกฤษ" value="All Zone design Co.,Ltd.">
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 20px; margin-bottom: 5px;">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputPhone" class="col-sm-4 txtLabel">โทรศัพท์</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputPhone" placeholder="โทรศัพท์">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputFaxno" class="col-sm-4 txtLabel">โทรสาร</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputFaxno" placeholder="โทรสาร">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-4 txtLabel">อีเมล์</label>
                                            <div class="col-sm-8">
                                                <input type="email" class="form-control input-sm" id="inputEmail" placeholder="อีเมล์">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <br />
                            </div>
                            <!-- /.post -->
                           
                            <!-- Post -->
                            <div class="post clearfix">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/blue_box.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Products</a>
                                        <a href="#" class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>
                                    </span>
                                    <span class="description">Select product you are interested</span>
                                </div>
                                <!-- /.user-block -->
                                <div class="row" style="margin-left: 20px; margin-bottom: 5px;">
                                    <div class="col-sm-2">
                                            <label for="inputTaxId" class="col-sm-12 txtLabel">ชื่อโครงการ</label>
                                    </div>
                                    <div class="col-sm-10" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input-sm" id="inputPresident" placeholder="ชื่อโครงการ">
                                    </div>

                                    <div class="col-sm-2" >
                                            <label for="inputTaxId" class="col-sm-12 txtLabel">สนใจผลิตภัณฑ์</label>
                                    </div>

                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox">
                                                    FRP
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox">
                                                    D-Lite
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox">
                                                    Amperam
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox">
                                                    AmpelFlow
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox">
                                                    อื่นๆ
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-5">
                                        <input type="text" class="form-control input-sm" id="inputPresident" placeholder="ระบุชื่อหรือรายละเอียดผลิตภัณฑ์">
                                    </div>

                                </div>
                            </div>
                            <!-- /.post -->

                            <!-- Post -->
                            <div class="post clearfix">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/price-control.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Pricing</a>
                                        <a href="#" class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>
                                    </span>
                                    <span class="description">Select product you are interested</span>
                                </div>
                                <!-- /.user-block -->
                                <div class="row" style="margin-left: 20px;">
                                    <div class="col-sm-2">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">ราคาขาย</label>
                                    </div>
                                    <div class="col-sm-10">
                                        <label for="inputTaxId" class="txtLabel">FRP ตามประเภทลูกค้า</label>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 20px;">
                                    <div class="col-sm-2">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">Price List</label>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox" >
                                                    Architect
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    Contractor
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    Owner
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    อื่นๆ (ระบุจำนวน...)
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row" style="margin-left: 20px;">
                                    <div class="col-sm-2">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">ระบุจำนวน</label>
                                    </div>
                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                </div>

                                <br />

                                <div class="row" style="margin-left: 20px;">
                                    <div class="col-sm-2">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">ราคาขาย</label>
                                    </div>
                                    <div class="col-sm-10">
                                        <label for="inputTaxId" class="txtLabel">Amperam/AmpelFlow ตามประเภทลูกค้า</label>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 20px;">
                                    <div class="col-sm-2">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">Price List</label>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    Architect
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    Contractor
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    Owner
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <div class="checkbox txtLabel">
                                                <label>
                                                    <input type="checkbox">
                                                    อื่นๆ (ระบุจำนวน...)
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row" style="margin-left: 20px;">
                                    <div class="col-sm-2">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">ระบุจำนวน</label>
                                    </div>
                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                    <div class="col-sm-2" style="margin-bottom: 5px;">
                                        <input type="text" class="form-control input input-sm txtLabel" id="inputPresident" placeholder="0.00">
                                    </div>

                                </div>

                                <br />
                                <br />
                                <br />
                            </div>
                            <!-- /.post -->

                        </div>
                        <!-- /.tab-pane -->

                        <div class="tab-pane" id="document">
                             <div class="post">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/document.png" alt="user image">
                                    <span class="username">
                                        <a href="#">Document Attached</a>
                                        <a href="#" class="pull-right btn-box-tool" data-toggle="tooltip" title="New File"><i class="fa fa-plus"></i></a>
                                    </span>
                                    <span class="description">Keep your documents into here for easily in used</span>
                                </div>

                                 <div class="container-fluid">
                                     <table id="tableActive" class="table table-bordered table-striped table-hover table-condensed">
                                         <thead>
                                             <tr>
                                                 <th>ID</th>
                                                 <th>Descript</th>
                                                 <th>Details</th>
                                                 <th></th>
                                                 <th></th>
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
                        </div>
                        <!-- /.tab-pane -->

                        <div class="tab-pane" id="notification">
                            <div class="user-block">
                                <img class="img-circle img-bordered-sm" src="../../dist/img/e_mail.png" alt="user image">
                                <span class="username">
                                    <a href="#">Notification</a>
                                    <a href="#" class="pull-right btn-box-tool" ><i class="fa fa-times"></i></a>
                                </span>
                                <span class="description">Please take note for your reminder..</span>
                            </div>
                            <br />
                            <div class="container-fluid">
                                <div class="row" style="margin-left: 10px;">
                                    <div class="col-sm-2">
                                    </div>
                                    <div class="col-sm-7">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">หมายเหตุ(1)</label>
                                        <textarea cols="40" rows="5" class="form-control input input-sm txtLabel"></textarea>
                                    </div>
                                </div>
                                <br />
                                <div class="row" style="margin-left: 10px;">
                                    <div class="col-sm-2">
                                    </div>
                                    <div class="col-sm-7">
                                        <label for="inputTaxId" class="col-sm-12 txtLabel">หมายเหตุ(2)</label>
                                        <textarea cols="40" rows="5" class="form-control input input-sm txtLabel"></textarea>
                                    </div>
                                </div>
                            </div>

                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
         

                        </div>
                        <!-- /.tab-pane -->
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalNew -->
        <div class="modal modal-default fade" id="myModalNew">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">New Customer Type</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">GradeID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeID" name="txtGradeID" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDesc" name="txtGradeDesc" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetail" name="txtGradeDetail" class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                        <button type="button" class="btn btn-primary hidden" id="btnSaveNewData" runat="server">Save Changes</button>
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
                        <h4 class="modal-title">Edit Grade Details</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">GradeID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeIDEdit" name="txtGradeIDEdit" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDescEdit" name="txtGradeDescEdit" placeholder="" value="" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
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
                        <button type="button" class="btn btn-primary hidden" id="btnUpdateData" runat="server">Update Changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalDelete -->
        <div class="modal modal-default fade" id="myModalDelete">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Delete Grade</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">GradeID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeIDDelete" name="txtGradeIDDelete" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Description</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input input-sm" id="txtGradeDescDelete" name="txtGradeDescDelete" placeholder="" value="" readonly required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4">Details</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtGradeDetailDelete" name="txtGradeDetailDelete" disabled class="form-control input input-sm"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btnSubmitDelete" class="btn btn-danger" onclick="ValidateDelete()">Delete Confirme</button>
                        <button type="button" class="btn btn-danger hidden" id="btnDeleteData" runat="server">Delete Confirme</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal myModalActiveNew not in use -->
        <div class="modal modal-default fade" id="myModalActiveNew">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Selected Active Status</h4>
                    </div>
                    <div class="modal-body">

                        <table id="tableActiveNew" class="table table-bordered table-striped table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descript</th>
                                    <th>Details</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                               <%-- <%= strTblActive %>--%>
                            </tbody>
                        </table>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <!-- /.modal myModalActive not in use -->
        <div class="modal modal-default fade" id="myModalActive">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Selected Active Status</h4>
                    </div>
                    <div class="modal-body">

                        <table id="tableActive" class="table table-bordered table-striped table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descript</th>
                                    <th>Details</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%--<%= strTblActive %>--%>
                            </tbody>
                        </table>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <div class="modal modal-default fade" id="myArchitectModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Selected Architect</h4>
                    </div>
                    <div class="modal-body">
                        <table id="tableArchitect" class="table table-bordered table-striped table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descript</th>
                                    <th>Details</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%--<%= strTblActive %>--%>
                            </tbody>
                        </table>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <script>
            var myinput = document.getElementById('inputQuantity');
            myinput.addEventListener('keyup', function () {
                var val = this.value;
                val = val.replace(/[^0-9\.]/g, '');

                if (val != "") {
                    valArr = val.split('.');
                    valArr[0] = (parseInt(valArr[0], 10)).toLocaleString();
                    val = valArr.join('.');
                }

                this.value = val;
            });


            function setDecimal(input) {
                input.value = parseFloat(input.value).toFixed(2);
            }

            function openModal() {

                $("#myModalNew").modal({ backdrop: false });
                $('[id=myModalNew]').modal('show');
            }

            function openArchitectModal() {
                $("#myArchitectModal").modal({ backdrop: false });
                $('[id=myArchitectModal]').modal('show');
            }
            


            var table = document.getElementById("example1"), rIndex;
            for (var i = 1; i < table.rows.length; i++) {
                for (var j = 0; j < table.rows[i].cells.length; j++) {
                    table.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 3) {
                            var strID = table.rows[rIndex].cells[0].innerHTML;
                            var strDesc = table.rows[rIndex].cells[1].innerHTML;
                            var strDetail = table.rows[rIndex].cells[2].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtGradeIDEdit").value = strID;
                            document.getElementById("txtGradeDescEdit").value = strDesc;
                            document.getElementById("txtGradeDetailEdit").value = strDetail;

                            $("#myModalEdit").modal({ backdrop: false });
                            $("#myModalEdit").modal("show");

                        }

                        if (this.cellIndex == 4) {
                            var strGradeIDDelete = table.rows[rIndex].cells[0].innerHTML;
                            var stGradeDescDelete = table.rows[rIndex].cells[1].innerHTML;
                            var strGradeDetailDelete = table.rows[rIndex].cells[2].innerHTML;

                            //console.log(rIndex + "  :  " + cIndex + " : " + strCustID + " : " + strDesc + " : " + strCustStatusID);

                            document.getElementById("txtGradeIDDelete").value = strGradeIDDelete;
                            document.getElementById("txtGradeDescDelete").value = stGradeDescDelete;
                            document.getElementById("txtGradeDetailDelete").value = strGradeDetailDelete;


                            $("#myModalDelete").modal({ backdrop: false });
                            $("#myModalDelete").modal("show");

                        }
                    }
                }
            }



            var tableActive = document.getElementById("tableActive"), rIndex;
            for (var i = 1; i < tableActive.rows.length; i++) {
                for (var j = 0; j < tableActive.rows[i].cells.length; j++) {
                    tableActive.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 3) {
                            var strStatusID = tableActive.rows[rIndex].cells[0].innerHTML;
                            var strStatusDesc = tableActive.rows[rIndex].cells[1].innerHTML;
                            var strDetail = tableActive.rows[rIndex].cells[2].innerHTML;

                            document.getElementById("txtStatusID").value = strStatusID;
                            document.getElementById("txtStatusEdit").value = strStatusDesc;
                            $("#myModalActive").modal("hide");

                            //alert(strStatusID);
                        }

                    }
                }
            }

            var tableActiveNew = document.getElementById("tableActiveNew"), rIndex;
            for (var i = 1; i < tableActiveNew.rows.length; i++) {
                for (var j = 0; j < tableActiveNew.rows[i].cells.length; j++) {
                    tableActiveNew.rows[i].cells[j].onclick = function () {
                        rIndex = this.parentElement.rowIndex;
                        cIndex = this.cellIndex;
                        console.log(rIndex + "  :  " + cIndex);

                        if (this.cellIndex == 3) {
                            var strStatusID = tableActiveNew.rows[rIndex].cells[0].innerHTML;
                            var strStatusDesc = tableActiveNew.rows[rIndex].cells[1].innerHTML;
                            var strDetail = tableActiveNew.rows[rIndex].cells[2].innerHTML;

                            document.getElementById("txtStatusIDNew").value = strStatusID;
                            document.getElementById("txtStatusNew").value = strStatusDesc;
                            $("#myModalActiveNew").modal("hide");

                            //alert(strStatusID);
                        }

                    }
                }
            }

            $(function () {

                $("#myModalEdit").validate({
                    rules: {
                        txtCustTypeDesc: {
                            required: true,
                            minlength: 8
                        },
                        action: "required"
                    },
                    messages: {
                        txtCustTypeDesc: {
                            required: "Please enter some data",
                            minlength: "Your data must be at least 8 characters"
                        },
                        action: "Please provide some data"
                    }
                });
            });

            function ValidateSave() {
                var str1 = document.getElementById("txtGradeID").value;
                var str2 = document.getElementById("txtGradeDesc").value;
                var str3 = document.getElementById("txtGradeDetail").value;
                if (str1 != '' && str2 != '' && str3 != '') {
                    document.getElementById("<%=  btnSaveNewData.ClientID %>").click();
                }
            }

            function ValidateUpdate() {
                var str1 = document.getElementById("txtGradeIDEdit").value;
                var str2 = document.getElementById("txtGradeDescEdit").value;
                //var str3 = document.getElementById("txtGradeDetailEdit").value;
                if (str1 != '' && str2 != '') {
                    {
                        document.getElementById("<%= btnUpdateData.ClientID %>").click();
                    }
                }
            }


            function ValidateDelete() {
                var str = document.getElementById("txtGradeIDDelete").value;
                if (str != '') {
                    document.getElementById("<%= btnDeleteData.ClientID %>").click();
                }
            }
        </script>

       
    </section>

</asp:Content>
