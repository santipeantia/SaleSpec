<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="weeklyreport.aspx.cs" Inherits="SaleSpec.pages.trans.weeklyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                        <h3 class="box-title">Weekly Report</h3>
                        <div class="pull-right">
                            <%--<button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                <i class="fa fa-plus"></i>
                            </button>--%>
                            <a class="btn btn-default btn-sm checkbox-toggle" href="../../pages/masters/architect?opt=sarc"  data-toggle="tooltip" title="List View"><i class="fa fa-reply"></i></a>

                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel" runat="server" ><i class="fa fa-table"></i></button>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="row">

                        </div>


                        <div class="row">
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

       
        <script>
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
