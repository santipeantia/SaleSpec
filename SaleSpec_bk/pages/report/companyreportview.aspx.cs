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
    public partial class companyreportview : System.Web.UI.Page
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

        public string sPage = "report/companyreportview";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetDataProjectWithComPort();
            }
            catch (Exception ex)
            {
            }
        }

        protected void GetDataProjectWithComPort()
        {
            try
            {
                string strComid = Request.QueryString["comid"];
                string strPortid = Request.QueryString["portid"];
                SqlParameter param1 = new SqlParameter() { ParameterName = "@ComID", Value = strComid };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@PortID", Value = strPortid };

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetProjectWithComPort", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.Add(param1);
                Comm.Parameters.Add(param2);

                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string ProjectID = dt.Rows[i]["ProjectID"].ToString();
                        string ProjectYear = dt.Rows[i]["ProjectYear"].ToString();
                        string ProjectMonth = dt.Rows[i]["ProjectMonth"].ToString();
                        string ProjectName = dt.Rows[i]["ProjectName"].ToString();
                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string Name = dt.Rows[i]["Name"].ToString();
                        string Location = dt.Rows[i]["Location"].ToString();
                        string TurnKey = dt.Rows[i]["TurnKey"].ToString();
                        string MainCons = dt.Rows[i]["MainCons"].ToString();
                        string RefRfDf = dt.Rows[i]["RefRfDf"].ToString();
                        string ProductType = dt.Rows[i]["ProductType"].ToString();
                        string RefProfile = dt.Rows[i]["RefProfile"].ToString();
                        string ProdNameEN = dt.Rows[i]["ProdNameEN"].ToString();
                        string Quantity = dt.Rows[i]["Quantity"].ToString();
                        string DeliveryDate = dt.Rows[i]["DeliveryDate"].ToString();
                        string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();



                        strTblDetail += "<tr> " +
                                        "     <td class=\"hidden\">" + ProjectID + "</td> " +
                                        "     <td>" + ProjectYear + "</td> " +
                                        "     <td>" + ProjectMonth + "</td> " +
                                        "     <td class=\"text-blue\">" + ProjectName + "</td> " +
                                        "     <td class=\"hidden\">" + CompanyID + "</td> " +
                                        "     <td>" + CompanyName + "</td> " +
                                        "     <td class=\"hidden\">" + ArchitecID + "</td> " +
                                        "     <td class=\"text-blue\">" + Name + "</td> " +
                                        "     <td>" + Location + "</td> " +
                                        "     <td>" + TurnKey + "</td> " +
                                        "     <td>" + MainCons + "</td> " +
                                        "     <td>" + RefRfDf + "</td> " +
                                        "     <td>" + ProductType + "</td> " +
                                        "     <td>" + RefProfile + "</td> " +
                                        "     <td>" + ProdNameEN + "</td> " +
                                        "     <td>" + Quantity + "</td> " +
                                        "     <td>" + DeliveryDate + "</td> " +
                                        "     <td>" + StatusNameEn + "</td> " +
                                        "</tr>";
                    }

                }

            }
            catch (Exception ex)
            {
            }
        }

        protected void btnExportExcel_click(object sender, EventArgs e)
        {
            try
            {
                string strPort = Request.Form["selectSalePort"];
                string strStatus = "S01";
                string strStart = Request.Form["datepickertrans"];
                string strEnd = Request.Form["datepickerend"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("sp_GetDataProjectByPortStatus", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };

                Comm.Parameters.Add(param1);
                Comm.Parameters.Add(param2);
                Comm.Parameters.Add(param3);
                Comm.Parameters.Add(param4);
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
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                              "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                              "</div>";
            }
        }

        protected void btnDownload_click(object sender, EventArgs e)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");

                //string strReportType = Request.Form["selectReportType"];
                string strPort = Request.Form["selectSalePort"];
                string strStatus = "S01";
                string strStart = Request.Form["datepickertrans"];
                string strEnd = Request.Form["datepickerend"];
                string strstrPort = "";

                if (strPort != "SELECTED ALL")
                {
                    ssql = "sp_GetDataProjectByPortStatus";

                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand(ssql);
                    Comm.Connection = Conn;
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };

                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    Comm.Parameters.Add(param3);
                    Comm.Parameters.Add(param4);

                    strstrPort = Request.Form["selectSalePort"].ToString();

                }
                else
                {
                    ssql = "sp_GetDataProjectByPortStatusAll";

                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand(ssql);
                    Comm.Connection = Conn;
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };

                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    Comm.Parameters.Add(param3);

                    strstrPort = Request.Form["selectSalePort"].ToString();
                }

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    rpt.Load(Server.MapPath("../reports/rptPrintIntakeProjectReport.rpt"));

                    reports.dsCompanies dsCompanies = new reports.dsCompanies();
                    dsCompanies.Merge(dt);

                    rpt.SetDataSource(dt);
                    rpt.SetParameterValue("UserID", strstrPort);
                    rpt.SetParameterValue("StartDate", strStart);
                    rpt.SetParameterValue("EndDate", strEnd);
                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ExportIntakeProject" + strDate);
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                            "      <strong>Error rptPrintIntakeProjectReport..!</strong> " + ex.Message + " " +
                            "</div>";
                return;
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            Response.Redirect("../report/companyreport?opt=rcom");
        }
    }
}