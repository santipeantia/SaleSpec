<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="weeklyreport_backup.aspx.cs" Inherits="SaleSpec.pages.trans.weeklyreport" %>
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
                        <div class="container-fluid">
                            <div class="col-sm-2">
                                <label class="txtLabel">txtLabel</label>

                            </div>
                        </div>

                        <asp:Button ID="btnClosePage" runat="server" Text="ClosePage"/>

                        <br />
                        <br />

                        <%--<a href="#" onclick="window.open('webform1.aspx', '_blank', 'height=200, width=200, top=200, left=300'); return false;"> content </a>--%>
                        <a href="#" onclick="popupwindow('webform1.aspx', 'OpenSearch', 600, 500)"  >OpenWindow</a>

                        <input class="form-control input-sm" type="text" id="txtName" name="txtName" value="" />
                        
                        <br />
                        <br />

                        <a href="#" onclick="ShowModalWindow();"> Click </a>


                        <a href="javascript:CloseWindow();">Close Window</a>

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
