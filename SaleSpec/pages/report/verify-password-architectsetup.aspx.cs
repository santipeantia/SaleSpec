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
    public partial class verify_password_architectsetup : System.Web.UI.Page
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
        public string strServer = "147.50.150.243";
        public string strSource = "DB_SaleSpec";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //swid = Request.QueryString["wid"].ToString();
            }
            catch
            {
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

                Comm = new SqlCommand("sp_varidateRequesetArchitectSetupData", Conn);
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

                    if (strOpt == "EXCEL")
                    {
                        exportExcelReport(strUserID, strEmpCode, strOpt, strOptName);
                    }
                    else {
                        // export pdf report
                        exportPDFReport(strUserID, strEmpCode, strOpt, strOptName);
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

        protected void exportExcelReport(string strUserID, string strEmpCode, string strOpt, string strOptName)
        {
            try
            {
                ssql = "select *, " +
                         "        ProjectName = stuff((select ', ' + ProjectName " +
                         "         from adProjects " +
                         "         where CompanyID = a.CompanyID and ArchitecID = a.ArchitecID " +
                         "         for xml path(''), TYPE " +
                         "        ).value('.[1]', 'nvarchar(max)'), 1, 1, '') " +
                         "from(select distinct a.ArchitecID, a.FirstName, a.LastName, a.CompanyID, cm.CompanyName, a.NickName, " +
                         "        a.Position, a.Address, a.Phone, a.Mobile, a.Email, b.ConDesc2, a.Birthday, " +
                         "        pj.TypeID as Port " +
                         "from adArchitecture as a left join " +
                         "        adStatusConfirm as b on a.StatusConID = b.StatusConID left join " +
                         "        adProjects as pj on a.ArchitecID = pj.ArchitecID left join " +
                         "        adCompany as cm on a.CompanyID = cm.CompanyID  " +
                          "       ) a ";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                GridView GridviewExport = new GridView();

                string strExportDate = DateTime.Now.ToString("yyyyMMddHHmmss");

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=ArchitectExport" + strExportDate + ".xls");
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
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert(' " + ex.Message + " ')</script>");
            }
        }

        protected void exportPDFReport(string strUserID, string strEmpCode, string strOpt, string strOptName)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                ssql = "spPrintArchitect";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    rpt.Load(Server.MapPath("../reports/rptPrintArchitect.rpt"));

                    reports.dsArchitects dsArchitects = new reports.dsArchitects();
                    dsArchitects.Merge(dt);

                    rpt.SetDataSource(dt);
                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ExportArchitect" + strDate);
                }
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