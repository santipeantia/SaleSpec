<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SaleSpec.pages.trans.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Show WebForm 2</h1>
        <br />
        <a href="#" onclick="CloseWindow();return false;">content</a>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

        <input type="text" id="txtbx" name="txtbx" value="" />

        <input type="button" name="name" value="Return" onclick="copyFunc()"/>


    </div>
    </form>

    <script>
        function CloseWindow() {
            if (confirm("Are you sure do you want to closing..?")) {
                close();
            }
        }

        function copyFunc() {
            if (window.opener != null && !window.opener.closed) {
                var txtName = window.opener.document.getElementById("txtName");
                txtName.value = document.getElementById("txtbx").value;
            }
            window.close();
        }

    </script>
</body>
</html>

