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
    public partial class projectreport : System.Web.UI.Page
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

        public string sPage = "report/projectreport";

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
                GetDataStatus();
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

        protected void GetDataStatus()
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetStatus", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string strValue = dt.Rows[i]["StatusID"].ToString();
                        string strText = dt.Rows[i]["StatusNameTh"].ToString();

                        strStatus += "<option value=\"" + strValue + "\">" + strText + "</option>";

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
                string strStatus = Request.Form["selectStatus"];

                Session["ssPort"] = strPort;
                Session["ssStatus"] = strStatus;

                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlParameter param1 = new SqlParameter();
                SqlParameter param2 = new SqlParameter();

                if (strPort != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetProjectWithPortStatus", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);

                    adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);
                }
                else
                {

                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetProjectWithPortStatusAll", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);

                    adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                }

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string Port = dt.Rows[i]["Port"].ToString();
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
                        string StatusID = dt.Rows[i]["StatusID"].ToString();
                        string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();

                        strTblDetail += "<tr> " +
                                            "<td >" + Port + "</td>" +
                                            "<td class=\"hidden\">" + ProjectID + "</td>" +
                                            "<td> " + ProjectYear + "</td>" +
                                            "<td>" + ProjectMonth + "</td>" +
                                            "<td>" + ProjectName + "</td>" +
                                            "<td class=\"hidden\">" + CompanyID + "</td>" +
                                            "<td>" + CompanyName + "</td>" +
                                            "<td class=\"hidden\">" + ArchitecID + "</td>" +
                                            "<td>" + Name + "</td>" +
                                            "<td>" + Location + "</td>" +
                                            "<td>" + TurnKey + "</td>" +
                                            "<td>" + MainCons + "</td>" +
                                            "<td>" + RefRfDf + "</td>" +
                                            "<td>" + ProductType + "</td>" +
                                            "<td>" + RefProfile + "</td>" +
                                            "<td>" + ProdNameEN + "</td>" +
                                            "<td>" + Quantity + "</td>" +
                                            "<td>" + DeliveryDate + "</td>" +
                                            "<td class=\"hidden\">" + StatusID + "</td>" +
                                            "<td>" + StatusNameEn + "</td>" +
                                       //"<td><a href=\"../report/companyreportview?opt=rcom&comid=" + CompanyID + "&portid=" + strPort + "\" title=\"View\"><i class=\"fa fa-search text-green\"></i></a></td>" +
                                       "</tr> ";
                    }

                    //Response.Write("<script>alert('Data inserted successfully')</script>");
                }

                GetDataSalePort();
                GetDataStatus();
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
                string strStatus = Session["ssStatus"].ToString();

                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlParameter param1 = new SqlParameter();
                SqlParameter param2 = new SqlParameter();

                if (strPort != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetRepProjectWithPortStatus", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);

                    adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);
                }
                else
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spGetRepProjectWithPortStatusAll", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                    param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);

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
                    Response.AddHeader("content-disposition", "attachment;filename=ExportProjectWithPortStatus_" + strPort + ".xls");
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
                //strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                //            "      <strong>Error rptPrintIntakeProjectReport..!</strong> " + ex.Message + " " +
                //            "</div>";
                //return;
            }
        }


        protected void btnExportExcelOption_click(object sender, EventArgs e)
        {
            try
            {
                //string strPort = Request.Form["selectSalePort"];
                //string strStatus = "S01";
                //string strStart = Request.Form["datepickertrans"];
                //string strEnd = Request.Form["datepickerend"];
                //string strQtyStart = Request.Form["QtyStart"];
                //string strQtyEnd = Request.Form["QtyEnd"];
                //string strSearch = Request.Form["Search"];


                string selectOption = Request.Form["selectReportOption"];
                string strOptionName =  Request.Form["optionName"];
                string datepickertrans = Request.Form["datepickertrans"];
                string datepickerend = Request.Form["datepickerend"];
                string selectSaleport = Request.Form["selectSalePort"];
                string strqtystrat = Request.Form["QtyStart"];
                string strqtyend = Request.Form["QtyEnd"];
                string strsearch = Request.Form["Search"];

                string empcode = Session["EmpCode"].ToString();

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
                        //string strWarning = "";
                        //strWarning += "Swal.fire({ ";
                        //strWarning += "     type: 'error', ";
                        //strWarning += "     title: 'You do not have permission print all.', ";
                        //strWarning += "     text: 'Permission access denied.', ";
                        //strWarning += "     footer: 'Please contact system administrator..'})";

                        //Response.Write("<script>successalert();</script>");

                        //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "myJsFn", "successalert();", true);

                        //ScriptManager.RegisterStartupScript(this, GetType(), null, strWarning, true);

                        //ClientScript.RegisterStartupScript(this.GetType(), "warning", "successalert()", true);

                        //Response.Write(""+ strWarning  +"");

                        GetDataSalePort();
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
                    Response.AddHeader("content-disposition", "attachment;filename=ExportReport_" + strOptionName + "_"+ selectSaleport + ".xls");
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
    }
}