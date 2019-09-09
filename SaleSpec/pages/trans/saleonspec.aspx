<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="saleonspec.aspx.cs" Inherits="SaleSpec.pages.trans.saleonspec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <h1>Sale On Spec (SOS)
            <small>Control panel</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->
        <%= strMsgAlert %>

        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Sale On Spec</h3>
                        <div class="pull-right">
                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                <i class="fa fa-plus"></i>
                            </button>

                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Download"><i class="fa fa-download"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel" id="btnExportExcel" runat="server" onserverclick="btnExportExcel_click"><i class="fa fa-table"></i></button>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="example1" class="table table-bordered table-striped table-hover table-condensed" style="width: 100%">
                            <%--pagination pagination-sm--%>
                            <thead>
                                <tr>
                                    <td>ProjectID</td>
                                        <td class="hidden">ProjectYear</td>
                                        <td class="hidden">ProjectMonth</td>
                                        <td>ProjectName</td>
                                        <td class="hidden">ArchitecID</td>
                                        <td class="hidden">CompanyID</td>
                                        <td>CompanyName</td>
                                        <td>strLocation</td>
                                        <td class="hidden">ProvinceID</td>
                                        <td class="hidden">ProvinceName</td>
                                        <td class="hidden">strMainCons</td>
                                        <td class="hidden">RefRfDf</td>
                                        <td>RefProfile</td>
                                        <td>Quantity</td>
                                        <td class="hidden">RefType</td>
                                        <td>DeliveryDate</td>
                                        <td>ProcID</td>
                                        <td>StepID</td>
                                        <td class="hidden">EmpCode</td>
                                        <td class="hidden">sEmFirstName</td>
                                        <td class="hidden">sEmLastName</td>
                                        <td class="hidden">CreatedDate</td>
                                        <td class="hidden">CreatedBy</td>
                                        <td class="hidden">LastedUpdate</td>
                                        <td class="hidden">UpdatedBy</td>
                                        <td class="hidden">StatusConID</td>
                                        <td>ConDesc2</td>
                                    <th style="width: 20px; text-align: center;">#</th>
                                    <th style="width: 20px; text-align: center;">#</th>
                                </tr>
                            </thead>
                            <tbody>

                                <%= strTblDetail %>

                            </tbody>

                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>
    </section>

</asp:Content>
