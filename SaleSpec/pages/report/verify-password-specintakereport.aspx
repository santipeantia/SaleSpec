<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="verify-password-specintakereport.aspx.cs" Inherits="SaleSpec.pages.report.verify_password_specintakereport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <title>Password Verification
    </title>
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- Google Font -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <link href="https://fonts.googleapis.com/css?family=Athiti" rel="stylesheet">

    <style>
        .txtLabel {
            font-family: 'Athiti', sans-serif;
            font-size: 14px;
            font-weight: normal;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>

<body class="txtLabel" style="background: #f2f9fe; padding-bottom: 50px">
    <form id="form1" runat="server">
        <div style="max-width: 500px; margin: auto; padding: 22px 50px 22px 0; box-sizing: border-box">
            <img src="http://203.154.45.40/salespec/image/Logo-ampel-Big.png" width="200px" />
        </div>
        <div style="background-color: #fff; max-width: 500px; box-sizing: border-box; padding-bottom: 35px; margin: auto;">
            <br />
                       
            <table width="100%" style="border-collapse: collapse; background-color: #FFFFFF;" cellspacing="0" cellpadding="0">
                <tbody>    
                     <tr>
                        <td style="text-align: left; color: #00a0e9; font-size: 20px; padding: 0px 30px;">
                            <span>Please enter your OTP password</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left; color: #00a0e9; font-size: 35px; padding: 0px 30px;">
                           <input type="text" id="txtVerify" name="txtVerify" value="<%= swid %>" class="form-control text-center" style="font-size: 40px; font-weight: bold; color: orangered;" autocomplete="off" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center; color: #00a0e9; font-size: 22px; padding: 5px 30px;">
                           <%--<input type="button" id="btnVerify" name="btnVerify" class="btn btn-success btn-block text-center" value="Verify and Download"/>--%>
                            <div class="row">
                                <div class="col-md-6">
                                    <a href="verify-password-projectstatus.aspx" class="btn btn-warning btn-block text-center">Reset Password</a>
                                </div>
                                <div class="col-md-6">
                                    <asp:Button ID="Button1" runat="server" class="btn btn-success btn-block text-center" Text="Verify and Download" OnClick="btnVerify_Click" />
                                </div>
                            </div>
                        </td>
                       
                    </tr>
                </tbody>
            </table>

        </div>
    </form>
</body>
</html>
