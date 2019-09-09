<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="SaleSpec.pages.trans.WebForm2" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AMPS</title>

    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../../bower_components/Ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="../../bower_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="../../bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="../../plugins/iCheck/all.css">
    <link rel="stylesheet" href="../../bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="../../plugins/timepicker/bootstrap-timepicker.min.css">
    <link rel="stylesheet" href="../../bower_components/select2/dist/css/select2.min.css">

    <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="../../dist/css/skins/_all-skins.min.css">

    <link rel="stylesheet" href="../../bower_components/morris.js/morris.css">

    <link rel="stylesheet" href="../../bower_components/jvectormap/jquery-jvectormap.css">

    <link rel="stylesheet" href="../../bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">

    <link rel="stylesheet" href="../../bower_components/bootstrap-daterangepicker/daterangepicker.css">

    <link rel="stylesheet" href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

    <link rel="stylesheet" href="../../bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">



    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <link href="https://fonts.googleapis.com/css?family=Athiti" rel="stylesheet">

    <style>
        .txtLabel {
            font-family: 'Athiti', sans-serif;
            font-size: 14px;
            font-weight: normal;
        }

        .table-condensed {
            font-size: 12px;
        }

        .loadingMessageFrame {
            background-color: #dcdcdc; /*#ffffff;*/
            filter: alpha(opacity=40);
            opacity: 0.4;
            position: relative;
            z-index: 500;
            top: 0px;
            left: 0px;
            border-top: dashed 1px black;
            border-bottom: dashed 1px black;
            border-left: dashed 1px black;
            border-right: dashed 1px black;
        }

        .Loading_Message {
            font-size: medium;
            font-weight: normal;
            color: Maroon;
        }

        #loading {
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            position: fixed;
            display: block;
            opacity: 0.7;
            background-color: #fff;
            z-index: 99;
            text-align: center;
        }


        div#spinner {
            display: none;
            width: 100px;
            height: 100px;
            position: fixed;
            top: 50%;
            left: 50%;
            background: url(spinner.gif) no-repeat center #fff;
            text-align: center;
            padding: 10px;
            font: normal 16px Tahoma, Geneva, sans-serif;
            border: 1px solid #666;
            margin-left: -50px;
            margin-top: -50px;
            z-index: 2;
            overflow: auto;
        }


        .loader {
            position: fixed;
            z-index: 99;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: white;
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .loader > img {
                width: 32px;
            }

            .loader.hidden {
                animation: fadeOut 0.5s;
                animation-fill-mode: forwards;
            }

        @keyframes fadeOut {
            100% {
                opacity: 0;
                visibility: hidden;
            }
        }

        .thumb {
            height: 100px;
            border: 1px solid black;
            margin: 10px;
        }
    </style>
</head>

<body onselect="return true" class="hold-transition skin-blue-light sidebar-mini fixed ">
    <div class="loader">
        <img src="../../dist/img/loader3.gif" alt="Loading..." />
    </div>

    <div id="dvMain">
        <div class="wrapper">
            <header class="main-header">
                <!-- Logo -->
                <a href="../../default" class="logo">
                    <span class="logo-mini"><b>SSP</b>S</span>
                    <span class="logo-lg"><b>SALE SPEC</b></span>
                </a>
                <nav class="navbar navbar-static-top">
                    <!-- Sidebar toggle button-->
                    <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="../../dist/img/User_96px.png" class="user-image" alt="User Image" width="160" />
                                    <span class="hidden-xs">
                                        <label id="label2"></label>
                                        Sarunya  Leelalers</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li class="user-header">
                                        <img src="../../dist/img/User_96px.png" class="img-circle" alt="User Image" width="160" />
                                        <p>
                                            Sarunya  Leelalers
                                            <small>Department of : SPC</small>
                                        </p>
                                    </li>

                                    <!-- Menu Footer-->
                                    <li class="user-footer">
                                        <div class="pull-left">
                                            <a href="../../pages/users/changepassword" class="btn btn-default btn-flat">Change Password</a>
                                        </div>
                                        <div class="pull-right">
                                            <a href="../../pages/users/login" class="btn btn-default btn-flat">Sign out</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>

                        </ul>
                    </div>
                </nav>
            </header>

            <!-- Left side column. contains the logo and sidebar -->
            <aside class="main-sidebar">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">

                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header" style="text-align: center">
                            <img src="../../image/Logo-ampel-Big.png" class="user-image" alt="User Image" width="120" /></li>


                        <li id="mnuDashboard" class="&lt;%= strActiveDashboard.ToString() %>" style="border-top: 1px solid #dddddd;">

                            <a href="../../pages/">
                                <i class="fa fa-dashboard"></i>
                                <span class="txtLabel ">Dashboard</span>
                            </a>
                        </li>

                        <li class=" treeview" style="border-top: 1px solid #dddddd;">
                            <a href="#">
                                <i class="fa fa-gear treeview"></i><span class="txtLabel">Enterprise Master</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li class=" ">
                                    <a href="../../pages/masters/customergrade?opt=cusg"><i class="fa fa-angle-right "></i><span class="txtLabel ">Customer Grade</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/masters/customertype?opt=cus"><i class="fa fa-angle-right "></i><span class="txtLabel ">Customer Type</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/masters/productgroup?opt=prdg"><i class="fa fa-angle-right "></i><span class="txtLabel ">Product Group</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/masters/specifier?opt=spc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Specifier Setup</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/masters/company?opt=comp"><i class="fa fa-angle-right "></i><span class="txtLabel ">Company Setup</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/masters/architect?opt=sarc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Architect Setup</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/masters/projectsetup?opt=prjs"><i class="fa fa-angle-right "></i><span class="txtLabel ">Projects Setup</span></a>
                                </li>

                            </ul>
                        </li>

                        <li class="active treeview" style="border-top: 1px solid #dddddd;">
                            <a href="#">
                                <i class="fa fa-group treeview"></i><span class="txtLabel">Transaction Entry</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li class="active ">
                                    <a href="../../pages/trans/weeklyreport?opt=wkr"><i class="fa fa-angle-right text-red"></i><span class="txtLabel text-red">Weekly Report</span></a>
                                </li>
                                <li class="active ">
                                    <a href="../../pages/trans/projects?opt=pjc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Project Update</span></a>
                                </li>
                                <li class="active ">
                                    <a href="../../pages/trans/apprequest-new?opt=reqf"><i class="fa fa-angle-right "></i><span class="txtLabel ">Application Request</span></a>
                                </li>
                                <li class="active ">
                                    <a href="../../pages/trans/apprequest?opt=arc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Application Center</span></a>
                                </li>
                                <li class="active ">
                                    <a href="../../pages/trans/saleonspec?opt=sos"><i class="fa fa-angle-right "></i><span class="txtLabel ">Sale On Spec</span></a>
                                </li>
                            </ul>
                        </li>

                        <li class=" treeview" style="border-top: 1px solid #dddddd;">
                            <a href="#">
                                <i class="fa fa-table treeview"></i><span class="txtLabel">Reporting</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li class=" ">
                                    <a href="../../pages/report/saleweeklyreport?opt=rptswr"><i class="fa fa-angle-right "></i><span class="txtLabel ">Sale Weekly Report</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/report/companyreport?opt=rcom"><i class="fa fa-angle-right "></i><span class="txtLabel ">Company Report</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/report/architectreport?opt=rarc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Architect Report</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/report/projectreport?opt=rpjc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Project Report</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/report/forecastingreport?opt=rfoc"><i class="fa fa-angle-right "></i><span class="txtLabel ">Forecasting Report</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/report/specintakereport?opt=itk"><i class="fa fa-angle-right "></i><span class="txtLabel ">Spec Intake Report</span></a>
                                </li>

                            </ul>
                        </li>

                        <li class=" treeview" style="border-top: 1px solid #dddddd;">
                            <a href="#">
                                <i class="fa fa-coffee treeview"></i><span class="txtLabel">Activities</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li class=" ">
                                    <a href="../../pages/activity/eventactivity?opt=evt"><i class="fa fa-angle-right "></i><span class="txtLabel ">Event / Activity</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/activity/premiumgift?opt=preg"><i class="fa fa-angle-right "></i><span class="txtLabel ">Gift / Premium</span></a>
                                </li>

                                <li class=" ">
                                    <a href="../../pages/activity/surprisegift?opt=spg"><i class="fa fa-angle-right "></i><span class="txtLabel ">Surprise Gift</span></a>
                                </li>

                            </ul>
                        </li>

                        <li style="border-top: 1px solid #dddddd;">
                            <a href="../../pages/users/logout">
                                <i class="fa fa-power-off"></i>
                                <span class="txtLabel">Sign Out</span>
                            </a>
                        </li>
                        <li style="border-top: 1px solid #dddddd;"></li>
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <form method="post" action="./weeklyreport?opt=wkr" id="form1">
                    <div class="aspNetHidden">
                        <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
                        <input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
                        <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTU1MjM2MTQ1OGRkZAIvYdSSSkvsi8u5sTyRcMORhD0QsQUUTZ8GDvgEM4I=" />
                    </div>

                    <script type="text/javascript">
                        //<![CDATA[
                        var theForm = document.forms['form1'];
                        if (!theForm) {
                            theForm = document.form1;
                        }
                        function __doPostBack(eventTarget, eventArgument) {
                            if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
                                theForm.__EVENTTARGET.value = eventTarget;
                                theForm.__EVENTARGUMENT.value = eventArgument;
                                theForm.submit();
                            }
                        }
//]]>
                    </script>


                    <div class="aspNetHidden">

                        <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="EEA275F7" />
                        <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAAManAUCufkaDHDJ3ql/lIQtMM2oap/cBkffm/1t6uv5GV6vIdESsJUxMHYEEa+j70ItnjhNHtI/eJvIqufBOGZ1WZNGCxMAp3StIBB2gUrUgQ==" />
                    </div>
                    <div>




                        <style>
                            .select2-container .select2-selection--multiple {
                                font-family: 'Arial', Verdana;
                                font-size: 12px;
                                box-sizing: border-box;
                                display: block;
                                height: 27px;
                            }

                            #rcorners1 {
                                border-radius: 10px;
                                border: 1px solid #73AD21;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners12 {
                                border-radius: 0 0 10px 10px;
                                background: #e2f7c4;
                                border: 1px solid #73AD21;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners13 {
                                border-radius: 0 0 10px 10px;
                                background: #e2f7c4;
                                border: 1px solid #73AD21;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners14 {
                                border-radius: 0 0 10px 10px;
                                background: #e2f7c4;
                                border: 1px solid #73AD21;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners2 {
                                border-radius: 10px;
                                border: 1px solid #339eeb;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners21 {
                                border-radius: 0 0 10px 10px;
                                background: #d4ebfc;
                                border: 1px solid #339eeb;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners22 {
                                border-radius: 0 0 10px 10px;
                                background: #d4ebfc;
                                border: 1px solid #339eeb;
                                padding: 20px 0 20px 0;
                            }

                            #rcorners23 {
                                border-radius: 0 0 10px 10px;
                                background: #d4ebfc;
                                border: 1px solid #339eeb;
                                padding: 20px 0 20px 0;
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
                                                        <div class="col-md-4 col-md-offset-2">
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
                                                    </div>

                                                    <div class="row" style="margin-top: 5px;">
                                                        <div class="col-md-6 col-md-offset-2">
                                                            <label class="txtLabel">Company</label>
                                                            <div class="input-group col-md-12">
                                                                <span class="txtLabel">
                                                                    <select id="selectCompany" class="form-control input input-sm " style="width: 100%;">
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
                                                                        <option value="1556">Kittaphol	 Onsri</option>
                                                                        <option value="1668">Kittipat	Sirijumpar</option>
                                                                        <option value="1523">Kittiphop	Watthong</option>
                                                                        <option value="1665">Kritsada	 Pengwantana</option>
                                                                        <option value="1536">Laddawan	Panta</option>
                                                                        <option value="1233">Napasawan	Bhongbhibhat</option>
                                                                        <option value="1651">Nares	unphikul</option>
                                                                        <option value="1182">Narin	 Bunjun</option>
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
                                                                    <select id="selectTransEntry" onchange="getTransEntry(this)" class="form-control input input-sm " style="width: 100%;">
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

                                                    <div id="divNewProject" style="display: none;">
                                                        <div id="rcorners1">
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
                                                                        <textarea cols="40" rows="2" class="form-control input-sm"></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Step</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectProjectStep" onchange="getProjectStep(this)" class="form-control input-sm" style="width: 100%">
                                                                            <option value="0">Design</option>
                                                                            <option value="1">Bidding</option>
                                                                            <option value="2">Award MC</option>
                                                                            <option value="3">Award RF</option>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-1 input-group">
                                                                    <label class="txtLabel">View</label>
                                                                    <div class="">
                                                                        <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="divBidding" class="row" style="display: none;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <div id="rcorners12">
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Bidding Name No.1</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Owner</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Bidding Name No.2</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Owner</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Bidding Name No.3</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Owner</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="divAwardMC" class="row" style="display: none;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <div id="rcorners13">
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Award Main Cons(MC)</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Contact</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <br />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="divAwardRF" class="row" style="display: none;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <div id="rcorners14">
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Award Roll Forming(RF)</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Contact</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <br />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Product Type</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectProductType" onchange="getComboA(this)" class="form-control input-sm" style="width: 100%">
                                                                            <option value="value1">รุ่นของสินค้า Ampelite</option>
                                                                            <option value="value2">รุ่นของสินค้า Amperam</option>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-1 input-group">
                                                                    <label class="txtLabel">View</label>
                                                                    <div class="">
                                                                        <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-3 col-md-offset-2">
                                                                    <label class="txtLabel">Product</label>
                                                                    <div class="txtLabel">

                                                                        <select id="selectProduct" class="form-control input-sm" style="width: 100%">
                                                                            <option value="Product1">Sealex DuraGel</option>
                                                                            <option value="Product1">TopLite Plus</option>
                                                                            <option value="Product1">RoofLite</option>
                                                                            <option value="Product1">SL Frie Retardant</option>
                                                                            <option value="Product1">ChemBlok</option>
                                                                            <option value="Product1">AmpGLAZE 3/600</option>
                                                                            <option value="Product1">AmpPAL 10/600</option>
                                                                            <option value="Product1">WebGLAS</option>
                                                                            <option value="Product1">WonderCOOL IR</option>
                                                                            <option value="Product1">COOL-LITE</option>
                                                                            <option value="Product1">SupraGlas</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label class="txtLabel">Profile</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectProfile" class="form-control input-sm" style="width: 100%">
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
                                                                <div class="col-md-3 col-md-offset-2">
                                                                    <label class="txtLabel">Next Visit</label>
                                                                    <div class="input-group date">
                                                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdelivery" value="" autocomplete="off">
                                                                        <div class="input-group-addon input-sm">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label class="txtLabel">Status</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectStatus" class="form-control input-sm" style="width: 100%">
                                                                            <option value="value">Status 1</option>
                                                                            <option value="value">Status 2</option>
                                                                            <option value="value">Status 3</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Details</label>
                                                                    <div class="">

                                                                        <textarea id="inputreason" cols="40" rows="2" class="form-control input-sm"></textarea>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-2 col-md-offset-2">
                                                                    <label class="txtLabel">Save Entry</label>
                                                                    <div class="">
                                                                        <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryNewProject">Save Entry</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="divUpdate" style="display: none;">
                                                        <div id="rcorners2">
                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Update Project</label>
                                                                    <div class="input-group col-md-12">
                                                                        <span class="txtLabel">
                                                                            <select id="selectUpdateProject" class="form-control input input-sm " style="width: 100%;">
                                                                                <option value=""></option>
                                                                                <option value="1">Project 1</option>
                                                                                <option value="2">Project 2</option>
                                                                                <option value="3">Project 3</option>
                                                                                <option value="4">Project 4</option>
                                                                                <option value="5">Project 5</option>
                                                                            </select>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Locations</label>
                                                                    <div class="">
                                                                        <textarea cols="40" rows="2" class="form-control input-sm"></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Step</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectUpdateProjectStep" onchange="getUpdateProjectStep(this)" class="form-control input-sm" style="width: 100%">
                                                                            <option value="0">Design</option>
                                                                            <option value="1">Bidding</option>
                                                                            <option value="2">Award MC</option>
                                                                            <option value="3">Award RF</option>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-1 input-group">
                                                                    <label class="txtLabel">View</label>
                                                                    <div class="">
                                                                        <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="divUpdateBidding" class="row" style="display: none;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <div id="rcorners21">
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Bidding Name No.1</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Owner</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Bidding Name No.2</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Owner</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Bidding Name No.3</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Owner</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="divUpdateAwardMC" class="row" style="display: none;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <div id="rcorners22">
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Award Main Cons(MC)</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Contact</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <br />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="divUpdateAwardRF" class="row" style="display: none;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <div id="rcorners23">
                                                                        <div class="row">
                                                                            <div class="col-md-6 col-md-offset-1">
                                                                                <label class="txtLabel">Award Roll Forming(RF)</label>
                                                                                <div class="input-group col-md-12">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <label class="txtLabel">Contact</label>
                                                                                <div class="input-group">
                                                                                    <input type="text" class="form-control input input-sm">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <br />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Product Type</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectUpdateProductType" onchange="getComboA(this)" class="form-control input-sm" style="width: 100%">
                                                                            <option value="value1">รุ่นของสินค้า Ampelite</option>
                                                                            <option value="value2">รุ่นของสินค้า Amperam</option>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-1 input-group">
                                                                    <label class="txtLabel">View</label>
                                                                    <div class="">
                                                                        <button type="button" class="btn btn-info btn-block btn-flat btn-sm" onclick="myFunction()">View</button>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-3 col-md-offset-2">
                                                                    <label class="txtLabel">Product</label>
                                                                    <div class="txtLabel">

                                                                        <select id="selectUpdateProduct" class="form-control input-sm" style="width: 100%">
                                                                            <option value="Product1">Sealex DuraGel</option>
                                                                            <option value="Product1">TopLite Plus</option>
                                                                            <option value="Product1">RoofLite</option>
                                                                            <option value="Product1">SL Frie Retardant</option>
                                                                            <option value="Product1">ChemBlok</option>
                                                                            <option value="Product1">AmpGLAZE 3/600</option>
                                                                            <option value="Product1">AmpPAL 10/600</option>
                                                                            <option value="Product1">WebGLAS</option>
                                                                            <option value="Product1">WonderCOOL IR</option>
                                                                            <option value="Product1">COOL-LITE</option>
                                                                            <option value="Product1">SupraGlas</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label class="txtLabel">Profile</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectUpdateProfile" class="form-control input-sm" style="width: 100%">
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
                                                                <div class="col-md-3 col-md-offset-2">
                                                                    <label class="txtLabel">Next Visit</label>
                                                                    <div class="input-group date">
                                                                        <input type="text" class="form-control input-sm pull-left txtLabel" id="datepickerdelivery" value="" autocomplete="off">
                                                                        <div class="input-group-addon input-sm">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label class="txtLabel">Status</label>
                                                                    <div class="txtLabel">
                                                                        <select id="selectUpateStatus" class="form-control input-sm" style="width: 100%">
                                                                            <option value="value">Status 1</option>
                                                                            <option value="value">Status 2</option>
                                                                            <option value="value">Status 3</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-6 col-md-offset-2">
                                                                    <label class="txtLabel">Details</label>
                                                                    <div class="">

                                                                        <textarea id="inputreason" cols="40" rows="2" class="form-control input-sm"></textarea>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row" style="margin-top: 5px;">
                                                                <div class="col-md-2 col-md-offset-2">
                                                                    <label class="txtLabel">Save Entry</label>
                                                                    <div class="">
                                                                        <button type="button" class="btn btn-info btn-flat btn-block btn-sm" id="btnSaveHistoryUpdateProject">Save Entry</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="divNewArchitect" style="display: none;">
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

                                                    <div id="divSpecIntake" style="display: none;">
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
                                                                        <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                                                        ไม่มีไฟล์แนบ
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2 ">

                                                                <input class="btn btn-info btn-block btn-flat btn-sm" type="file" id="exampleInputFile">
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

                                                    <div id="divOther" style="display: none;">
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


                                                    <div class="post clearfix hidden">
                                                        <div class="user-block">
                                                            <img class="img-circle img-bordered-sm" src="../../dist/img/document.png" alt="User Image">
                                                            <span class="username">
                                                                <a href="#">Visit History</a>
                                                                <div class="btn-group pull-right ">
                                                                    <button id="ContentPlaceHolder1_btnExportExcel" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-print"></i></button>
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
                                                                    <select name="ctl00$ContentPlaceHolder1$selectTrans" id="ContentPlaceHolder1_selectTrans" class="form-control select2 " style="width: 100%">
                                                                        <option selected="selected" value="">Please select a item..</option>
                                                                        <option value="0">New Project</option>
                                                                        <option value="1">Update Project Status</option>
                                                                        <option value="2">New Architect</option>
                                                                        <option value="3">Event Update</option>
                                                                        <option value="4">Weekly Report</option>
                                                                    </select>
                                                                </span>
                                                            </div>
                                                            <div class="form-group">
                                                                <input onclick="__doPostBack('ctl00$ContentPlaceHolder1$btnSelect', '')" name="ctl00$ContentPlaceHolder1$btnSelect" type="button" id="ContentPlaceHolder1_btnSelect" class="btn btn-primary btn-flat btn-block" value="Click to Go..!" />
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
                                                <button id="ContentPlaceHolder1_btnSaveNewData" type="button" class="btn btn-primary ">Save Changes</button>
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
                                                <button id="ContentPlaceHolder1_Button2" type="button" class="btn btn-primary hidden">Save Changes</button>
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
                                                                <select class="form-control input-sm" style="width: 100%;">
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
                                                                <select id="selectCategory" class="form-control input-small" style="width: 100%;">
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

                                                            <textarea cols="40" rows="3" class="form-control input input-sm txtLabel" id="Remark" name="Remark"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="submit" id="btnSubmitNew" class="btn btn-primary" onclick="ValidateSave()">Save Changes</button>
                                                <button id="ContentPlaceHolder1_Button3" type="button" class="btn btn-primary hidden">Save Changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <script src="jquery-1.11.2.min.js"></script>
                            <script>
                                $(document).ready(function () {
                                    var selectCompanyDDL = $('selectCompany');

                                    $.ajax({
                                        url: 'DataServices.asmx/GetDataCompany',
                                        method: 'post',
                                        dataType: 'json',
                                        success: function (data) {
                                            selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select continents' }));

                                            $(data).each(function (index, item) {
                                                selectCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameTH }));
                                            });
                                        }
                                    });
                                });
                            </script>

                            <script>

                                function getTransEntry(trans) {
                                    var t = trans.value;

                                    var div1 = document.getElementById("divNewProject");
                                    var div2 = document.getElementById("divUpdate");
                                    var div3 = document.getElementById("divNewArchitect");
                                    var div4 = document.getElementById("divSpecIntake");
                                    var div5 = document.getElementById("divOther");

                                    if (t == "1") { div1.style.display = "block"; } else { div1.style.display = "none"; }
                                    if (t == "2") { div2.style.display = "block"; } else { div2.style.display = "none"; }
                                    if (t == "3") { div3.style.display = "block"; } else { div3.style.display = "none"; }
                                    if (t == "4") { div4.style.display = "block"; } else { div4.style.display = "none"; }
                                    if (t == "5") { div5.style.display = "block"; } else { div5.style.display = "none"; }
                                }

                                function getProjectStep(step) {
                                    var s = step.value;

                                    var dv1 = document.getElementById("divBidding");
                                    var dv2 = document.getElementById("divAwardMC");
                                    var dv3 = document.getElementById("divAwardRF");

                                    if (s == "1") { dv1.style.display = "block"; } else { dv1.style.display = "none"; }
                                    if (s == "2") { dv2.style.display = "block"; } else { dv2.style.display = "none"; }
                                    if (s == "3") { dv3.style.display = "block"; } else { dv3.style.display = "none"; }
                                    //alert(s);
                                }

                                function getUpdateProjectStep(step) {
                                    var s = step.value;

                                    var dv1 = document.getElementById("divUpdateBidding");
                                    var dv2 = document.getElementById("divUpdateAwardMC");
                                    var dv3 = document.getElementById("divUpdateAwardRF");

                                    if (s == "1") { dv1.style.display = "block"; } else { dv1.style.display = "none"; }
                                    if (s == "2") { dv2.style.display = "block"; } else { dv2.style.display = "none"; }
                                    if (s == "3") { dv3.style.display = "block"; } else { dv3.style.display = "none"; }
                                }


                                function getComboA(sel) {
                                    var value = sel.value;
                                    //alert(value);


                                }


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

                            </script>
                        </section>

                    </div>
                </form>
            </div>
            <div class="control-sidebar-bg"></div>
        </div>
        <div id="dvLoading" class="loadingMessageFrame" style="height: 270px; display: none;">
            <table style="height: 100%; width: 100%; table-layout: fixed;">
                <tr>
                    <td style="height: 100%;">
                        <span id="lblLoadingMessage" class="Loading_Message">Loading...</span>
                    </td>
                </tr>
            </table>
        </div>


        <!-- ./wrapper -->
        <!-- jQuery 3 -->
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="../../bower_components/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
            $.widget.bridge('uibutton', $.ui.button);
        </script>

        <script src="../../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../../bower_components/select2/dist/js/select2.full.min.js"></script>
        <script src="../../bower_components/raphael/raphael.min.js"></script>
        <script src="../../bower_components/morris.js/morris.min.js"></script>
        <script src="../../bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
        <script src="../../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="../../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
        <script src="../../bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
        <script src="../../bower_components/moment/min/moment.min.js"></script>
        <script src="../../bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script src="../../bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="../../bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
        <script src="../../bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
        <script src="../../bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="../../bower_components/fastclick/lib/fastclick.js"></script>
        <script src="../../dist/js/adminlte.min.js"></script>
        <script src="../../dist/js/pages/dashboard.js"></script>
        <script src="../../dist/js/demo.js"></script>
        <script src="../../plugins/input-mask/jquery.inputmask.js"></script>
        <script src="../../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
        <script src="../../plugins/input-mask/jquery.inputmask.extensions.js"></script>
        <script src="../../bower_components/moment/min/moment.min.js"></script>
        <script src="../../bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script src="../../bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="../../bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
        <script src="../../plugins/timepicker/bootstrap-timepicker.min.js"></script>
        <script src="../../bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="../../plugins/iCheck/icheck.min.js"></script>

        <script src="../../bower_components/Chart.js/Chart.js"></script>


        <script>
            window.addEventListener("load", function () {
                const loader = document.querySelector(".loader");
                loader.className += " hidden"; // class "loader hidden"
            });
        </script>


    </div>
</body>
</html>

