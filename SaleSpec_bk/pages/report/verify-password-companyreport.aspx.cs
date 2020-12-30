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

namespace SaleSpec.pages.report
{
    public partial class verify_password_companyreport : System.Web.UI.Page
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
        public string swid = "";

        public string strUser = "sa";
        public string strPassword = "AmpelCloud@2020";
        public string strServer = "203.154.45.40";
        public string strSource = "DB_SaleSpec";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                 //swid = Request.QueryString["wid"].ToString();
            }
            catch {
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string strVerify = Request.Form["txtVerify"];

            if (strVerify != "")
            {
                varidateRequesetData(strVerify);
            }
            else
            {
                Response.Write("<script>alert('Verify Password do not empty..!')</script>");
            }
        }

        protected void varidateRequesetData(string strVerifyCode)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("sp_varidateRequestCompanyReport", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter() { ParameterName = "@VerifyCode", Value = strVerifyCode };
                Comm.Parameters.Add(param1);

                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;

                dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    string strUserID = dt.Rows[0]["UserID"].ToString();
                    string strEmpCode = dt.Rows[0]["EmpCode"].ToString();
                    string strOpt = dt.Rows[0]["RepOpt"].ToString();
                    string strOptName = dt.Rows[0]["RepOptName"].ToString();

                    string strPort = dt.Rows[0]["sPort"].ToString();

                    if (strOpt == "EXCEL")
                    {
                        exportExcelReport(strPort);
                    }
                    else {
                        // export pdf report
                        exportPDFReport(strPort);
                    }                    
                }
                else
                {
                    Response.Write("<script>alert('Verify Password is incorrect please try again..!')</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert(' " + ex.Message + " ')</script>");
            }
        }

        protected void exportExcelReport(string strPort)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlParameter param1 = new SqlParameter();

                if (strPort != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetReportExpCompany", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    Comm.Parameters.Add(param1);

                    adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);
                }
                else
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetReportExpCompanyAll", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);
                }

                GridView GridviewExport = new GridView();
                if (dt.Rows.Count != 0)
                {
                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=ExportCompanyWith_" + strPort + ".xls");
                    Response.ContentType = "application/ms-excel";
                    Response.ContentEncoding = System.Text.Encoding.Unicode;
                    Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                    System.IO.StringWriter sw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

                    GridviewExport.RenderControl(hw);
                    string style = @"<style> td { mso-number-format:\@;} </style>";
                    Response.Write(style);
                    Response.Write(sw.ToString());
                    Response.End();
                }
                Response.Write("<script>alert('Data find not found please check...')</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert(' " + ex.Message + " ')</script>");
            }
        }

        protected void exportPDFReport(string strUserID)
        {
            try
            {
                
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                            "      <strong>Error Download..!</strong> " + ex.Message + " " +
                            "</div>";
                return;
            }
        }
    }
}