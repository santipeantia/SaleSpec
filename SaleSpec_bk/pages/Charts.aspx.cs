using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;

namespace SaleSpec.pages
{
    public partial class Charts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object[] GetChartData()
        {
            List<adCharts> data = new List<adCharts>();
            //Here MyDatabaseEntities  is our dbContext
            using (DBSaleSpecEntities dc = new DBSaleSpecEntities())
            {
                data = dc.adCharts.ToList();
            }

            var chartData = new object[data.Count + 1];
            chartData[0] = new object[]{
                "Year",
                "VCA",
                "VCB",
                "VCC"
            };

            int j = 0;
            foreach (var i in data)
            {
                j++;
                chartData[j] = new object[] { i.cMonth.ToString(), i.VCA, i.VCB, i.VCC };
            }
            return chartData;
        }

    }
}