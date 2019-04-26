<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PortChart.aspx.cs" Inherits="SaleSpec.pages.PortChart" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>

<%--    <script src="../Scripts/jquery-1.7.1.js"></script>
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

    </script>--%>

    <script>
        window.onload = function () {

            var options = {
                exportEnabled: true,
                animationEnabled: true,
                title: {
                    text: "Project Of Year"
                },
                subtitles: [{
                    text: "Summary Project In 2018"
                }],
                axisX: {
                    title: "States"
                },
                //axisY: {
                //    title: "Units Sold",
                //    titleFontColor: "#4F81BC",
                //    lineColor: "#4F81BC",
                //    labelFontColor: "#4F81BC",
                //    tickColor: "#4F81BC",
                //    includeZero: false
                //},
                //axisY2: {
                //    title: "Profit in USD",
                //    titleFontColor: "#C0504E",
                //    lineColor: "#C0504E",
                //    labelFontColor: "#C0504E",
                //    tickColor: "#C0504E",
                //    includeZero: false
                //},
                toolTip: {
                    shared: true
                },
                legend: {
                    cursor: "pointer",
                    itemclick: toggleDataSeries
                },
                data: [{
                    type: "spline",
                    name: "VCA",
                    //axisYType: "secondary",
                    showInLegend: true,
                    xValueFormatString: "MMMM YYYY",
                    yValueFormatString: "$#,##0",
                    dataPoints: [
                        { x: new Date(2018, 0, 1), y: 15034.5 },
                        { x: new Date(2018, 1, 1), y: 25015 },
                        { x: new Date(2018, 2, 1), y: 17342 },
                        { x: new Date(2018, 3, 1), y: 23088 },
                        { x: new Date(2018, 4, 1), y: 28234 },
                        { x: new Date(2018, 5, 1), y: 19034 },
                        { x: new Date(2018, 6, 1), y: 33487 },
                        { x: new Date(2018, 7, 1), y: 22523 },
                        { x: new Date(2018, 8, 1), y: 25234 },
                        { x: new Date(2018, 9, 1), y: 22234 },
                        { x: new Date(2018, 10, 1), y: 30548 },
                        { x: new Date(2018, 11, 1), y: 22534 }
                    ]
                },
                {
                    type: "spline",
                    name: "VCB",
                    axisYType: "secondary",
                    showInLegend: true,
                    xValueFormatString: "MMMM YYYY",
                    yValueFormatString: "$#,##0",
                    dataPoints: [
                        { x: new Date(2018, 0, 1), y: 19034.5 },
                        { x: new Date(2018, 1, 1), y: 20015 },
                        { x: new Date(2018, 2, 1), y: 27342 },
                        { x: new Date(2018, 3, 1), y: 20088 },
                        { x: new Date(2018, 4, 1), y: 20234 },
                        { x: new Date(2018, 5, 1), y: 29034 },
                        { x: new Date(2018, 6, 1), y: 30487 },
                        { x: new Date(2018, 7, 1), y: 32523 },
                        { x: new Date(2018, 8, 1), y: 20234 },
                        { x: new Date(2018, 9, 1), y: 27234 },
                        { x: new Date(2018, 10, 1), y: 33548 },
                        { x: new Date(2018, 11, 1), y: 32534 }
                    ]
                },
                {
                    type: "spline",
                    name: "VCC",
                    axisYType: "secondary",
                    showInLegend: true,
                    xValueFormatString: "MMMM YYYY",
                    yValueFormatString: "$#,##0",
                    dataPoints: [
                        { x: new Date(2018, 0, 1), y: 20000.5 },
                        { x: new Date(2018, 1, 1), y: 18652 },
                        { x: new Date(2018, 2, 1), y: 25640 },
                        { x: new Date(2018, 3, 1), y: 18665 },
                        { x: new Date(2018, 4, 1), y: 10234 },
                        { x: new Date(2018, 5, 1), y: 25034 },
                        { x: new Date(2018, 6, 1), y: 35487 },
                        { x: new Date(2018, 7, 1), y: 34523 },
                        { x: new Date(2018, 8, 1), y: 26234 },
                        { x: new Date(2018, 9, 1), y: 25234 },
                        { x: new Date(2018, 10, 1), y: 34548 },
                        { x: new Date(2018, 11, 1), y: 30534 }
                    ]
                },
                {
                    type: "spline",
                    name: "VCD",
                    axisYType: "secondary",
                    showInLegend: true,
                    xValueFormatString: "MMMM YYYY",
                    yValueFormatString: "$#,##0",
                    dataPoints: [
                        { x: new Date(2018, 0, 1), y: 25000.5 },
                        { x: new Date(2018, 1, 1), y: 28652 },
                        { x: new Date(2018, 2, 1), y: 20640 },
                        { x: new Date(2018, 3, 1), y: 28665 },
                        { x: new Date(2018, 4, 1), y: 13234 },
                        { x: new Date(2018, 5, 1), y: 20034 },
                        { x: new Date(2018, 6, 1), y: 30487 },
                        { x: new Date(2018, 7, 1), y: 30523 },
                        { x: new Date(2018, 8, 1), y: 20234 },
                        { x: new Date(2018, 9, 1), y: 20234 },
                        { x: new Date(2018, 10, 1), y: 30548 },
                        { x: new Date(2018, 11, 1), y: 20534 }
                    ]
                }
                ]
            };
            $("#chartContainer").CanvasJSChart(options);

            function toggleDataSeries(e) {
                if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                    e.dataSeries.visible = false;
                } else {
                    e.dataSeries.visible = true;
                }
                e.chart.render();
            }

        }
    </script>


</head>
<body>
    <%--<form id="form1" runat="server">
        <div id="chart_div" style="width: 100%; height: 400px;">
        </div>
    </form>--%>
    <div id="chartContainer" style="height: 400px; width: 100%;"></div>
    <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
    <script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
</body>
</html>
