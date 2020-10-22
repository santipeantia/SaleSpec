using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.IO;
using System.Text;
using CrystalDecisions.CrystalReports.Engine;
using System.Security.Cryptography;


namespace SaleSpec.pages.report
{
    public partial class activity_event : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        ReportDocument rpt = new ReportDocument();

        string ssql;
        DataTable dt = new DataTable();

        public static string strErorConn = "";

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        public string strMsgAlert = "";
        public string strTblDetail = "";
        public string strPortOption = "";

        public string sPage = "report/activity_event";

        protected void Page_Load(object sender, EventArgs e)
        {
            //string strUserID = Session["UserID"].ToString();
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }

            if (!IsPostBack)
            {
                GetDataSalePort();
            }
        }

        protected void GetDataSalePort()
        {
            try
            {
                int eyear = int.Parse(DateTime.Now.ToString("yyyy"));
                int syear = eyear - 10;

                if (eyear != 0)
                {
                    for (int i = eyear; i >= syear; i--)
                    {
                        strPortOption += "<option value=\"" + i + "\">" + "Activities of " + i + "</option>";
                    }
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }
    }
}