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


namespace SaleSpec.pages.trans
{
    public partial class companyreport : System.Web.UI.Page
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

        public string sPage = "report/companyreport";

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
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetDataSaleSpec", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@SpecID", Session["EmpCode"].ToString());

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string strValue = dt.Rows[i]["SpecID"].ToString();
                        string strText = dt.Rows[i]["FullName"].ToString();

                        strPortOption += "<option value=\"" + strValue + "\">" + strText + "</option>";

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

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            try
            {
                string strPort = Request.Form["selectSalePort"];

                Session["ssPort"] = strPort;

                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlParameter param1 = new SqlParameter();

                if (strPort != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetReportCompany", Conn);
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

                    Comm = new SqlCommand("spGetReportCompanyAll", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                }

                //Conn = new SqlConnection();
                //Conn = dbConn.OpenConn();

                //Comm = new SqlCommand("spGetReportCompany", Conn);
                //Comm.CommandType = CommandType.StoredProcedure;

                //SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                //Comm.Parameters.Add(param1);

                //SqlDataAdapter adapter = new SqlDataAdapter();
                //adapter.SelectCommand = Comm;
                //dt = new DataTable();
                //adapter.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string CompanyName2 = dt.Rows[i]["CompanyName2"].ToString();
                        string CustTypeID = dt.Rows[i]["CustTypeID"].ToString();
                        string CustTypeDesc = dt.Rows[i]["CustTypeDesc"].ToString();
                        string Address = dt.Rows[i]["Address"].ToString();
                        string ProvinceID = dt.Rows[i]["ProvinceID"].ToString();
                        string ContactName = dt.Rows[i]["ContactName"].ToString();
                        string Phone = dt.Rows[i]["Phone"].ToString();
                        string Mobile = dt.Rows[i]["Mobile"].ToString();
                        string Email = dt.Rows[i]["Email"].ToString();
                        strPort = dt.Rows[i]["Port"].ToString();

                        strTblDetail += "<tr> " +
                                            "<td>" + strPort + "</td>" +
                                            "<td><a href=\"../report/companyreportview?opt=rcom&comid=" + CompanyID + "&portid=" + strPort + "\" target=\"_blank\" title=\"View\"> " + CompanyName +" </a></td>" +
                                            "<td class=\"hidden\"> " + CompanyName2 + "</td>" +
                                           
                                            "<td>" + Address + "</td>" +
                                            "<td>" + CustTypeID + "</td>" +
                                            "<td class=\"hidden\">" + CustTypeDesc + "</td>" +
                                            "<td class=\"hidden\">" + ProvinceID + "</td>" +
                                            "<td><a href=\"../report/companyreportview?opt=rcom&comid=" + CompanyID + "&portid=" + strPort + "\" target=\"_blank\" title=\"View\"> " + ContactName + " </a></td>" +
                                            "<td class=\"hidden\">" + Phone + "</td>" +
                                            "<td>" + Mobile + "</td>" +
                                            "<td>" + Email + "</td>" +
                                            "<td><a href=\"../report/companyreportview?opt=rcom&comid=" + CompanyID +"&portid="+ strPort + "\" target=\"_blank\" title=\"View\"><i class=\"fa fa-search text-green\"></i></a></td>" +
                                       "</tr> ";
                    }

                    //Response.Write("<script>alert('Data inserted successfully')</script>");
                }

                 GetDataSalePort();
            }
            catch (Exception ex)
            {
                //Response.Write("<script>alert('"+ ex.Message +"')</script>");
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }

        protected void btnExportExcel_click(object sender, EventArgs e)
        {
            try
            {
                if (Session["ssPort"] == null)
                {
                    strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> Please get show data before export the report..!  " +
                           "</div>";
                    GetDataSalePort();
                    return;
                }

                string strPort = Session["ssPort"].ToString(); // Request.Form["selectSalePort"];

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
                GetDataSalePort();
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
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");

                ////string strReportType = Request.Form["selectReportType"];
                //string strPort = Request.Form["selectSalePort"];
                //string strStatus = "S01";
                //string strStart = Request.Form["datepickertrans"];
                //string strEnd = Request.Form["datepickerend"];
                //string strstrPort = "";

                //if (strPort != "SELECTED ALL")
                //{
                //    ssql = "sp_GetDataProjectByPortStatus";

                //    Conn = dbConn.OpenConn();
                //    Comm = new SqlCommand(ssql);
                //    Comm.Connection = Conn;
                //    Comm.CommandType = CommandType.StoredProcedure;

                //    SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                //    SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                //    SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                //    SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };

                //    Comm.Parameters.Add(param1);
                //    Comm.Parameters.Add(param2);
                //    Comm.Parameters.Add(param3);
                //    Comm.Parameters.Add(param4);

                //    strstrPort = Request.Form["selectSalePort"].ToString();

                //}
                //else
                //{
                //    ssql = "sp_GetDataProjectByPortStatusAll";

                //    Conn = dbConn.OpenConn();
                //    Comm = new SqlCommand(ssql);
                //    Comm.Connection = Conn;
                //    Comm.CommandType = CommandType.StoredProcedure;

                //    SqlParameter param1 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                //    SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                //    SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };

                //    Comm.Parameters.Add(param1);
                //    Comm.Parameters.Add(param2);
                //    Comm.Parameters.Add(param3);

                //    strstrPort = Request.Form["selectSalePort"].ToString();
                //}

                //da = new SqlDataAdapter(Comm);

                //dt = new DataTable();
                //da.Fill(dt);

                //if (dt.Rows.Count != 0)
                //{
                //    rpt.Load(Server.MapPath("../reports/rptPrintIntakeProjectReport.rpt"));

                //    reports.dsCompanies dsCompanies = new reports.dsCompanies();
                //    dsCompanies.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("UserID", strstrPort);
                //    rpt.SetParameterValue("StartDate", strStart);
                //    rpt.SetParameterValue("EndDate", strEnd);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ExportIntakeProject" + strDate);
                //}
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                            "      <strong>Error rptPrintIntakeProjectReport..!</strong> " + ex.Message + " " +
                            "</div>";
                return;
            }
        }


    }
}