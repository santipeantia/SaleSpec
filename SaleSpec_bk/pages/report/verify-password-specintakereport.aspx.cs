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
    public partial class verify_password_specintakereport : System.Web.UI.Page
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

                Comm = new SqlCommand("sp_varidateRequesetSpecIntakeReport", Conn);
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
                    string strSdate = dt.Rows[0]["sdate"].ToString();
                    string strEdate = dt.Rows[0]["edate"].ToString();
                    string foQty = dt.Rows[0]["foQty"].ToString();
                    string toQty = dt.Rows[0]["toQty"].ToString();
                    string strSearch = dt.Rows[0]["sSearch"].ToString();

                    if (strOpt == "EXCEL")
                    {
                        exportExcelReport(strPort, strSdate, strEdate, foQty, toQty, strSearch);
                    }
                    else {
                        // export pdf report
                        exportPDFReport(strPort, strSdate, strEdate, foQty, toQty, strSearch);
                    }                    
                }
                else
                {
                    Response.Write("<script>alert('Verify Password is incorrect try again..!')</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert(' " + ex.Message + " ')</script>");
            }
        }

        protected void exportExcelReport(string strPort, string strStart, string strEnd, string foQty, string toQty, string strSearch)
        {
            try
            {              
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                if (strPort != "SELECTED ALL")
                {
                    Comm = new SqlCommand("sp_GetDataProjectByPortStatusOption", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = "S01" };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                    SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyStart", Value = foQty };
                    SqlParameter param6 = new SqlParameter() { ParameterName = "@QtyEnd", Value = toQty };
                    SqlParameter param7 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    Comm.Parameters.Add(param3);
                    Comm.Parameters.Add(param4);
                    Comm.Parameters.Add(param5);
                    Comm.Parameters.Add(param6);
                    Comm.Parameters.Add(param7);
                }
                else
                {
                    Comm = new SqlCommand("sp_GetDataProjectByPortStatusAllOption", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = "S01" };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                    SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyStart", Value = foQty };
                    SqlParameter param6 = new SqlParameter() { ParameterName = "@QtyEnd", Value = toQty };
                    SqlParameter param7 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    Comm.Parameters.Add(param3);
                    Comm.Parameters.Add(param4);
                    Comm.Parameters.Add(param5);
                    Comm.Parameters.Add(param6);
                    Comm.Parameters.Add(param7);
                }
                
               

                //conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=ExportIntakeReport_" + strPort + ".xls");
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

        protected void exportPDFReport(string strPort, string strStart, string strEnd, string foQty, string toQty, string strSearch)
        {
            try
            {
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");

                //ssql = "spNewProjectReportingWithSearch";

                //Conn = dbConn.OpenConn();
                //Comm = new SqlCommand(ssql);
                //Comm.Connection = Conn;
                //Comm.CommandType = CommandType.StoredProcedure;

                //SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                //SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                //SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                //SqlParameter param4 = new SqlParameter() { ParameterName = "@QtyStart", Value = foQty };
                //SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyEnd", Value = toQty };
                //SqlParameter param6 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

                //Comm.Parameters.Add(param1);
                //Comm.Parameters.Add(param2);
                //Comm.Parameters.Add(param3);
                //Comm.Parameters.Add(param4);
                //Comm.Parameters.Add(param5);
                //Comm.Parameters.Add(param6);

                //da = new SqlDataAdapter(Comm);

                //dt = new DataTable();
                //da.Fill(dt);

                //if (dt.Rows.Count != 0)
                //{
                //    rpt.Load(Server.MapPath("../reports/rptPrintNewProjectReportWithOption.rpt"));

                //    reports.dsCompanies dsCompanies = new reports.dsCompanies();
                //    dsCompanies.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("UserID", strPort);
                //    rpt.SetParameterValue("StartDate", strStart);
                //    rpt.SetParameterValue("EndDate", strEnd);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ExportNewProjectReport_" + strDate);
                //}
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