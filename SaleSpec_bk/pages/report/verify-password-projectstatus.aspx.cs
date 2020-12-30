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
    public partial class verify_password_projectstatus : System.Web.UI.Page
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

                Comm = new SqlCommand("sp_varidateRequesetData", Conn);
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
                    string strFrom = dt.Rows[0]["FromDate"].ToString();
                    string strEnd = dt.Rows[0]["EndDate"].ToString();
                    string strPort = dt.Rows[0]["SpecPort"].ToString();
                    string strQty = dt.Rows[0]["QtyFrom"].ToString();
                    string strQtyTo = dt.Rows[0]["QtyTo"].ToString();
                    string strSearch = dt.Rows[0]["RefSearch"].ToString();

                    exportExcelReport(strUserID, strEmpCode, strOpt, strOptName, strFrom, strEnd, strPort, strQty, strQtyTo, strSearch);
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

        protected void exportExcelReport(string strUserID, string strEmpCode, string strOpt, string strOptName, string strFrom, string strEnd, string strPort, string strQty, string strQtyTo, string strSearch)
        {
            try
            {
                string userid = strUserID;
                if ((userid == "Admin") || (userid == "Chanunnett") || (userid == "Chonticha") || (userid == "Treethep") || (userid == "Wanchai"))
                {

                    string selectOption = strOpt;       // Request.Form["selectReportOption"];
                    string strOptionName = strOptName;  // Request.Form["optionName"];
                    string datepickertrans = strFrom;   // Request.Form["datepickertrans"];
                    string datepickerend = strEnd;      // Request.Form["datepickerend"];
                    string selectSaleport = strPort;    // Request.Form["selectSalePort"];
                    string strqtystrat = strQty;        // Request.Form["QtyStart"];
                    string strqtyend = strQtyTo;        // Request.Form["QtyEnd"];
                    string strsearch = strSearch;       // Request.Form["Search"];

                    string empcode = strEmpCode;

                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();


                    if (selectSaleport == "SELECTED ALL")
                    {
                        if (empcode == "118052" || empcode == "316010" || empcode == "506009")
                        {
                            Comm = new SqlCommand("spGetReportProjectStatusByOption2", Conn);
                            Comm.CommandType = CommandType.StoredProcedure;

                            SqlParameter param1 = new SqlParameter() { ParameterName = "@strOption", Value = selectOption };
                            SqlParameter param2 = new SqlParameter() { ParameterName = "@strDateStart", Value = datepickertrans };
                            SqlParameter param3 = new SqlParameter() { ParameterName = "@strDateEnd", Value = datepickerend };
                            SqlParameter param4 = new SqlParameter() { ParameterName = "@strUserID", Value = selectSaleport };
                            SqlParameter param5 = new SqlParameter() { ParameterName = "@strQtyStart", Value = strqtystrat };
                            SqlParameter param6 = new SqlParameter() { ParameterName = "@strQtyEnd", Value = strqtyend };
                            SqlParameter param7 = new SqlParameter() { ParameterName = "@strSearch", Value = strsearch };

                            Comm.Parameters.Add(param1);
                            Comm.Parameters.Add(param2);
                            Comm.Parameters.Add(param3);
                            Comm.Parameters.Add(param4);
                            Comm.Parameters.Add(param5);
                            Comm.Parameters.Add(param6);
                            Comm.Parameters.Add(param7);

                            //conn.Open();
                            SqlDataAdapter adapter = new SqlDataAdapter();
                            adapter.SelectCommand = Comm;
                            dt = new DataTable();
                            adapter.Fill(dt);
                        }
                        else
                        {
                            return;
                        }
                    }
                    else
                    {
                        Comm = new SqlCommand("spGetReportProjectStatusByOption2", Conn);
                        Comm.CommandType = CommandType.StoredProcedure;

                        SqlParameter param1 = new SqlParameter() { ParameterName = "@strOption", Value = selectOption };
                        SqlParameter param2 = new SqlParameter() { ParameterName = "@strDateStart", Value = datepickertrans };
                        SqlParameter param3 = new SqlParameter() { ParameterName = "@strDateEnd", Value = datepickerend };
                        SqlParameter param4 = new SqlParameter() { ParameterName = "@strUserID", Value = selectSaleport };
                        SqlParameter param5 = new SqlParameter() { ParameterName = "@strQtyStart", Value = strqtystrat };
                        SqlParameter param6 = new SqlParameter() { ParameterName = "@strQtyEnd", Value = strqtyend };
                        SqlParameter param7 = new SqlParameter() { ParameterName = "@strSearch", Value = strsearch };

                        Comm.Parameters.Add(param1);
                        Comm.Parameters.Add(param2);
                        Comm.Parameters.Add(param3);
                        Comm.Parameters.Add(param4);
                        Comm.Parameters.Add(param5);
                        Comm.Parameters.Add(param6);
                        Comm.Parameters.Add(param7);

                        //conn.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter();
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
                        Response.AddHeader("content-disposition", "attachment;filename=ExportReport_" + strOptionName + "_" + selectSaleport + ".xls");
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
                else
                {
                    Response.Write("<script>alert('Data find not found please check...')</script>");
                }

                Response.Write("<script>alert('Congratulation, Report ready to download...')</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert(' " + ex.Message + " ')</script>");
            }
        }


    }
}