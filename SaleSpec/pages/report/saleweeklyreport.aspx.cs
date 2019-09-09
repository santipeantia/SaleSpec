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
    public partial class saleweeklyreport : System.Web.UI.Page
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

        public string sPage = "report/saleweeklyreport";

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
                string strStart = Request.Form["datepickertrans"];
                string strEnd = Request.Form["datepickerend"];
                string strSearch = Request.Form["Search"];

                Session["ssPort"] = strPort;
                Session["ssStart"] = strStart;
                Session["ssEnd"] = strEnd;
                Session["ssSearch"] = strSearch;

                if (Session["UserID"].ToString() == Session["ssPort"].ToString())
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spWeeklyReporting", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    Comm.Parameters.Add(param3);
                    Comm.Parameters.Add(param4);
                    //conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count != 0)
                    {

                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {
                            string WeekDate = dt.Rows[i]["WeekDate"].ToString();
                            string WeekTime = dt.Rows[i]["WeekTime"].ToString();

                            string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                            string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                            string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                            string Name = dt.Rows[i]["Name"].ToString();
                            string ProjectID = dt.Rows[i]["ProjectID"].ToString();
                            string ProjectName = dt.Rows[i]["ProjectName"].ToString();

                            string Location = dt.Rows[i]["Location"].ToString();
                            string StatusID = dt.Rows[i]["StatusID"].ToString();
                            string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                            //string NewArchitect = dt.Rows[i]["NewArchitect"].ToString();
                            string Remark = dt.Rows[i]["Remark"].ToString();

                            string UserID = dt.Rows[i]["UserID"].ToString();
                            string EmpCode = dt.Rows[i]["EmpCode"].ToString();
                            string CreatedBy = dt.Rows[i]["CreatedBy"].ToString();
                            string CreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                            string ID = dt.Rows[i]["ID"].ToString();
                            string STB = dt.Rows[i]["STB"].ToString();


                            strTblDetail += "<tr> " +
                                        "    <td>" + WeekDate + "</td> " +
                                       "    <td>" + WeekTime + "</td> " +
                                       "    <td  class=\"hidden\">" + CompanyID + "</td> " +
                                       "    <td>" + CompanyName + "</td> " +
                                       "    <td  class=\"hidden\">" + ArchitecID + "</td> " +
                                       "    <td>" + Name + "</td> " +
                                       "    <td  class=\"hidden\">" + ProjectID + "</td> " +
                                       "    <td>" + ProjectName + "</td> " +
                                       "    <td>" + Location + "</td> " +
                                       "    <td class=\"hidden\">" + StatusID + "</td> " +
                                       "    <td>" + StatusNameEn + "</td> " +
                                       "    <td>" + Remark + "</td> " +
                                       "    <td>" + CreatedBy + "</td> " +
                                       "    <td>" + CreatedDate + "</td> " +
                                       "    <td style=\"width: 20px; text-align: center;\"> " +
                                       "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-search text-green\"></i></a></td> " +
                                       "    <td class=\"hidden\">" + ID + "</td> " +
                                       "    <td class=\"hidden\">" + STB + "</td> " +
                                       //"    <td style=\"width: 20px; text-align: center;\"> " +
                                       //"        <a href=\"#\" data-toggle=\"modal\" class=\"\" title=\"ลบข้อมูล\"><span class='glyphicon glyphicon-trash text-red'></span></a></td> " +
                                       "</tr> ";
                        }

                        //Response.Write("<script>alert('Data inserted successfully')</script>");
                    }
                }
                else if (Session["EmpCode"].ToString() == "118052" || Session["UserID"].ToString() == "316010" || Session["UserID"].ToString() == "506009" || Session["UserID"].ToString() == "519012")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spWeeklyReporting", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    Comm.Parameters.Add(param3);
                    Comm.Parameters.Add(param4);
                    //conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count != 0)
                    {

                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {
                            string WeekDate = dt.Rows[i]["WeekDate"].ToString();
                            string WeekTime = dt.Rows[i]["WeekTime"].ToString();

                            string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                            string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                            string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                            string Name = dt.Rows[i]["Name"].ToString();
                            string ProjectID = dt.Rows[i]["ProjectID"].ToString();
                            string ProjectName = dt.Rows[i]["ProjectName"].ToString();

                            string Location = dt.Rows[i]["Location"].ToString();
                            string StatusID = dt.Rows[i]["StatusID"].ToString();
                            string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                            //string NewArchitect = dt.Rows[i]["NewArchitect"].ToString();
                            string Remark = dt.Rows[i]["Remark"].ToString();

                            string UserID = dt.Rows[i]["UserID"].ToString();
                            string EmpCode = dt.Rows[i]["EmpCode"].ToString();
                            string CreatedBy = dt.Rows[i]["CreatedBy"].ToString();
                            string CreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                            string ID = dt.Rows[i]["ID"].ToString();
                            string STB = dt.Rows[i]["STB"].ToString();


                            strTblDetail += "<tr> " +
                                        "    <td>" + WeekDate + "</td> " +
                                       "    <td>" + WeekTime + "</td> " +
                                       "    <td  class=\"hidden\">" + CompanyID + "</td> " +
                                       "    <td>" + CompanyName + "</td> " +
                                       "    <td  class=\"hidden\">" + ArchitecID + "</td> " +
                                       "    <td>" + Name + "</td> " +
                                       "    <td  class=\"hidden\">" + ProjectID + "</td> " +
                                       "    <td>" + ProjectName + "</td> " +
                                       "    <td>" + Location + "</td> " +
                                       "    <td class=\"hidden\">" + StatusID + "</td> " +
                                       "    <td>" + StatusNameEn + "</td> " +
                                       "    <td>" + Remark + "</td> " +
                                       "    <td>" + CreatedBy + "</td> " +
                                       "    <td>" + CreatedDate + "</td> " +
                                       "    <td style=\"width: 20px; text-align: center;\"> " +
                                       "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-search text-green\"></i></a></td> " +
                                       "    <td class=\"hidden\">" + ID + "</td> " +
                                       "    <td class=\"hidden\">" + STB + "</td> " +
                                       //"    <td style=\"width: 20px; text-align: center;\"> " +
                                       //"        <a href=\"#\" data-toggle=\"modal\" class=\"\" title=\"ลบข้อมูล\"><span class='glyphicon glyphicon-trash text-red'></span></a></td> " +
                                       "</tr> ";
                        }

                        //Response.Write("<script>alert('Data inserted successfully')</script>");
                    }
                }
                else
                {
                    //Response.Write("<script>alert(AlertErorr())</script>");
                    //return;

                    ClientScript.RegisterStartupScript(this.GetType(), "alertmee", "alert('Do not allowed selected all..!')", true);
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

        protected void btnQueryRefresh()
        {
            try
            {
                string strPort = Session["ssPort"].ToString();
                string strStart = Session["ssStart"].ToString();
                string strEnd = Session["ssEnd"].ToString();
                string strSearch = Request.Form["Search"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spWeeklyReporting", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

                Comm.Parameters.Add(param1);
                Comm.Parameters.Add(param2);
                Comm.Parameters.Add(param3);
                Comm.Parameters.Add(param4);

                //conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string WeekDate = dt.Rows[i]["WeekDate"].ToString();
                        string WeekTime = dt.Rows[i]["WeekTime"].ToString();

                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string Name = dt.Rows[i]["Name"].ToString();
                        string ProjectID = dt.Rows[i]["ProjectID"].ToString();
                        string ProjectName = dt.Rows[i]["ProjectName"].ToString();

                        string Location = dt.Rows[i]["Location"].ToString();
                        string StatusID = dt.Rows[i]["StatusID"].ToString();
                        string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                        //string NewArchitect = dt.Rows[i]["NewArchitect"].ToString();
                        string Remark = dt.Rows[i]["Remark"].ToString();

                        string UserID = dt.Rows[i]["UserID"].ToString();
                        string EmpCode = dt.Rows[i]["EmpCode"].ToString();
                        string CreatedBy = dt.Rows[i]["CreatedBy"].ToString();
                        string CreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                        string ID = dt.Rows[i]["ID"].ToString();
                        string STB = dt.Rows[i]["STB"].ToString();


                        strTblDetail += "<tr> " +
                                    "    <td>" + WeekDate + "</td> " +
                                   "    <td>" + WeekTime + "</td> " +
                                   "    <td  class=\"hidden\">" + CompanyID + "</td> " +
                                   "    <td>" + CompanyName + "</td> " +
                                   "    <td  class=\"hidden\">" + ArchitecID + "</td> " +
                                   "    <td>" + Name + "</td> " +
                                   "    <td  class=\"hidden\">" + ProjectID + "</td> " +
                                   "    <td>" + ProjectName + "</td> " +
                                   "    <td>" + Location + "</td> " +
                                   "    <td class=\"hidden\">" + StatusID + "</td> " +
                                   "    <td>" + StatusNameEn + "</td> " +
                                   "    <td>" + Remark + "</td> " +
                                   "    <td>" + CreatedBy + "</td> " +
                                   "    <td>" + CreatedDate + "</td> " +
                                   "    <td style=\"width: 20px; text-align: center;\"> " +
                                   "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-search text-green\"></i></a></td> " +
                                   "    <td class=\"hidden\">" + ID + "</td> " +
                                   "    <td class=\"hidden\">" + STB + "</td> " +
                                   //"    <td style=\"width: 20px; text-align: center;\"> " +
                                   //"        <a href=\"#\" data-toggle=\"modal\" class=\"\" title=\"ลบข้อมูล\"><span class='glyphicon glyphicon-trash text-red'></span></a></td> " +
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

            //Session["ssPort"] = strPort;
            //Session["ssStart"] = strStart;
            //Session["ssEnd"] = strEnd;
            {
                string strReportType = Request.Form["selectReportType"];
                string strPort = Session["ssPort"].ToString(); // Request.Form["selectSalePort"];
                string strStart = Session["ssStart"].ToString(); // Request.Form["datepickertrans"];
                string strEnd = Session["ssEnd"].ToString(); // Request.Form["datepickerend"];
                string strSearch = Session["ssSearch"].ToString();

                if (Session["UserID"].ToString() == Session["ssPort"].ToString())
                {
                    

                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spWeeklyReportingClear", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

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
                        Response.AddHeader("content-disposition", "attachment;filename=ExportWeeklyReport_" + strPort + ".xls");
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

                else if (Session["EmpCode"].ToString() == "118052" || Session["UserID"].ToString() == "316010" || Session["UserID"].ToString() == "506009" || Session["UserID"].ToString() == "519012")
                {

                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();

                    Comm = new SqlCommand("spWeeklyReportingClear", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

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
                        Response.AddHeader("content-disposition", "attachment;filename=ExportWeeklyReport_" + strPort + ".xls");
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
                else
                {
                    Response.Write("<script>alert('Data find not found please check...')</script>");
                }
                GetDataSalePort();
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                              "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                              "</div>";
            }
        }

        protected void btnUpdateData_click(Object sender, EventArgs e)
        {
            try
            {

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                string strID = Request.Form["txtID"];
                string strSTB = Request.Form["txtSTB"];
                string strSelectTime = Request.Form["txtVisitTime"];
                string strDate = Request.Form["txtVisitDate"];
                string strCompany = Request.Form["txtCompany"];
                string strArchitect = Request.Form["txtArchitect"];
                string strProject = Request.Form["txtProject"];
                string strLocation = Request.Form["txtLocation"];
                string strDesc = Request.Form["txtDesc"];
                string UserID = Session["ssPort"].ToString(); // Session["UserID"].ToString();
                string EmpCode = Session["EmpCode"].ToString();
                string CreatedBy = Session["sEmpFirstName"].ToString() + "  " + Session["sEmpLastName"].ToString();
                DateTime CreateDate = DateTime.Now;


                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                               "      <strong>Warning..!</strong> " + strID + strSTB + strSelectTime + strDate + strCompany + strArchitect + strProject + strLocation + strDesc + UserID + EmpCode + CreatedBy + CreateDate + "" +
                               "</div>";



                if (strSTB == "A")
                {
                    ssql = "update adWeeklyReport set WeekTime=@WeekTime, Location=@Location, Remark=@Remark, " +
                           "    CreatedBy=@CreatedBy, CreatedDate=@CreatedDate " +
                           "where ID=@ID ";

                    Comm = new SqlCommand();
                    Comm.CommandType = CommandType.Text;
                    Comm.CommandText = ssql;
                    Comm.Connection = Conn;
                    Comm.Parameters.Clear();
                    Comm.Parameters.Add("@ID", SqlDbType.NVarChar).Value = strID;
                    Comm.Parameters.Add("@WeekTime", SqlDbType.NVarChar).Value = strSelectTime;
                    Comm.Parameters.Add("@Location", SqlDbType.NVarChar).Value = strLocation;
                    Comm.Parameters.Add("@Remark", SqlDbType.NVarChar).Value = strDesc;
                    Comm.Parameters.Add("@CreatedBy", SqlDbType.NVarChar).Value = CreatedBy;
                    Comm.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = CreateDate;
                    Comm.ExecuteNonQuery();


                    strMsgAlert = "<div class=\"alert alert-success box-title txtLabel\"> " +
                               "      <strong>Warning..!</strong> " + strID + strSTB + "<br />" + strSelectTime + "<br />" + strDate + "<br />" + strCompany + "<br />" + strArchitect + "<br />" + strProject + strLocation + "<br />" + strDesc + UserID + EmpCode + CreatedBy + CreateDate + "" +
                               "</div>";


                }
                else
                {

                    ssql = "update adWeeklyReportOther set WeekTime=@WeekTime, Location=@Location, Remark=@Remark, " +
                           "    CreatedBy=@CreatedBy, CreatedDate=@CreatedDate " +
                           "where ID=@ID ";

                    Comm = new SqlCommand();
                    Comm.CommandType = CommandType.Text;
                    Comm.CommandText = ssql;
                    Comm.Connection = Conn;
                    Comm.Parameters.Clear();
                    Comm.Parameters.Add("@ID", SqlDbType.NVarChar).Value = strID;
                    Comm.Parameters.Add("@WeekTime", SqlDbType.NVarChar).Value = strSelectTime;
                    Comm.Parameters.Add("@Location", SqlDbType.NVarChar).Value = strLocation;
                    Comm.Parameters.Add("@Remark", SqlDbType.NVarChar).Value = strDesc;
                    Comm.Parameters.Add("@CreatedBy", SqlDbType.NVarChar).Value = CreatedBy;
                    Comm.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = CreateDate;
                    Comm.ExecuteNonQuery();


                    strMsgAlert = "<div class=\"alert alert-success box-title txtLabel\"> " +
                               "      <strong>Warning..!</strong> " + strID + strSTB + "<br />" + strSelectTime + "<br />" + strDate + "<br />" + strCompany + "<br />" + strArchitect + "<br />" + strProject + strLocation + "<br />" + strDesc + UserID + EmpCode + CreatedBy + CreateDate + "" +
                               "</div>";

                }


                GetDataSalePort();
                btnQueryRefresh();

            }
            catch (Exception ex)
            {

                //Response.Write("<script>alert('" + ex.Message + "')</script>");

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
                string strStart = Request.Form["datepickertrans"];
                string strEnd = Request.Form["datepickerend"];

                ssql = "spWeeklyReporting";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strPort };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };

                Comm.Parameters.Add(param1);
                Comm.Parameters.Add(param2);
                Comm.Parameters.Add(param3);

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    rpt.Load(Server.MapPath("../reports/rptPrintWeeklyReport.rpt"));

                    reports.dsCompanies dsCompanies = new reports.dsCompanies();
                    dsCompanies.Merge(dt);

                    rpt.SetDataSource(dt);
                    rpt.SetParameterValue("UserID", strPort);
                    rpt.SetParameterValue("StartDate", strStart);
                    rpt.SetParameterValue("EndDate", strEnd);
                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ExportWeekly" + strDate);
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                            "      <strong>Error spWeeklyReporting..!</strong> " + ex.Message + " " +
                            "</div>";
                return;
            }
        }

    }
}