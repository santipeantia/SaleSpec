<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="SaleSpec.pages.trans.WebForm3" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <script src="jquery-1.11.2.min.js"></script>
    <script>
        $(document).ready(function () {
           //var selectCompanyDDL = $('#selectCompany');
           var selectCompanyDDL = document.getElementById('<%= selectCompany.ClientID %>');

            $.ajax({
                url: 'DataServices.asmx/GetDataCompany',
                method: 'POST',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    selectCompanyDDL.append($('<option/>', { value: -1, text: 'Select companies' }));
                    $(data).each(function (index, item) {
                        selectCompanyDDL.append($('<option/>', { value: item.CompanyID, text: item.CompanyNameTH }));
                    });
                }
            });

            //alert(selectCompanyDDL.value);
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <select id="selectCompany" name="selectCompany" runat="server">
            </select>
        </div>
    </form>
</body>
</html>
