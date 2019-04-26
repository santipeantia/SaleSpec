<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PortChart.aspx.cs" Inherits="SaleSpec.pages.PortChart" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>

    <script src="../Scripts/jquery-1.7.1.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script>
        var chartData; // globar variable for hold chart data
        google.load("visualization", "1", { packages: ["corechart"] });

        // Here We will fill chartData

        $(document).ready(function () {

            $.ajax({
                url: "Charts.aspx/GetChartData",
                data: "",
                dataType: "json",
                type: "POST",
                contentType: "application/json; chartset=utf-8",
                success: function (data) {
                    chartData = data.d;
                },
                error: function () {
                    alert("Error loading data! Please try again.");
                }
            }).done(function () {
                // after complete loading data
                google.setOnLoadCallback(drawChart);
                drawChart();
            });
        });


        function drawChart() {
            var data = google.visualization.arrayToDataTable(chartData);

            var options = {
                title: "Final Year Project",
                pointSize: 5
            };

            var lineChart = new google.visualization.LineChart(document.getElementById('chart_div'));
            lineChart.draw(data, options);

        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="chart_div" style="width: 100%; height: 400px;">
        </div>
    </form>
</body>
</html>
