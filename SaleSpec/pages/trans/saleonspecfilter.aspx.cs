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
using System.Net;
using System.Net.Mail;


namespace SaleSpec.pages.trans
{
    public partial class saleonspecfilter : System.Web.UI.Page
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
        public string strStatus = "";

        public string strFullName = "";
        public string strRequestDate = "";
        public string strExpireDate = "";

        public string sPage = "trans/saleonspecfilter";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //string strUserID = Session["UserID"].ToString();
                if (Session["UserID"] == null)
                {
                    Response.Redirect("../../pages/users/login");
                }
            }
            catch
            {                
            }
        }

        protected void btnDownload_click(object sender, EventArgs e)
        {
            try
            {
                
            }
            catch (Exception ex)
            {
            }
        }

        protected void btnExportExcelOption_click(object sender, EventArgs e)
        {
            try
            {
               
            }
            catch (Exception ex)
            {

            }
        }

    }
}