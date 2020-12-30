<%@ Page Title="" Language="C#" MasterPageFile="~/SaleSpec.Master" AutoEventWireup="true" CodeBehind="changepassword.aspx.cs" Inherits="SaleSpec.pages.users.changepassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header content -->
    <section class="content-header">
        <h1>Change Password
            <small>Control panel</small>
        </h1>
    </section>


    <!-- Main content -->
    <section class="content">
          
        <!-- Small boxes (Stat box) -->
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-body">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="../../dist/img/passwordreset.png" alt="User Image">
                            <span class="username">
                                <a href="#">Change Password</a>
                            </span>
                            <span class="description">Do you want to change profile password..!</span>
                        </div>
                        <hr />
                        
                        <%= strMsgAlert %>

                        <div class="col-md-3 col-md-offset-4">
                            <div class="">
                                <label class="txtLabel">Old Password</label>
                                <div class="form-group">
                                    <input type="password" id="oldpasssword" name="oldpasssword" class="form-control input-sm" value="" />
                                </div>
                            </div>
                            <div class="">
                                <label class="txtLabel">New Password</label>
                                <div class="form-group">
                                    <input type="password" id="newpasssword" name="newpasssword" class="form-control input-sm" value="" />
                                </div>
                            </div>
                            <div class="">
                                <label class="txtLabel">Confirm Password</label>
                                <div class="form-group">
                                    <input type="password" id="confirmpasssword" name="confirmpasssword" class="form-control input-sm" value="" />
                                </div>
                            </div>

                            <div class="">
                                <div class="form-group">
                                    <button type="button" id="confirmChange" name="confirmChange" runat="server" onserverclick="confirmChange_click" class="btn btn-info btn-block btn-flat">Confirm Change</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                </div>
            </div>
        </div>
    </section>

</asp:Content>
