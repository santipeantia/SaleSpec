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
    public partial class architectprofile : System.Web.UI.Page
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
        public string strCompany = "";
        public string strGrade = "";
        public string strStatus = "";
        public string strTblWeeklyReport = "";

        public string sPage = "report/architectprofile";

        public string ID;
        public string ArchitecID;
        public string CompanyID;
        public string Name;
        public string FirstName;
        public string LastName;
        public string NickName;
        public string Position;
        public string Address;
        public string Phone;
        public string Mobile;
        public string Email;
        public string StatusConID;
        public string ConDesc;
        public string UpdatedDate;
        public string GradeID;
        public string GradeDesc;
        public string GradeDetail;

        protected void Page_Load(object sender, EventArgs e)
        {
            //string strUserID = Session["UserID"].ToString();
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }
            else {

                try
                {
                    string id = Request.QueryString["id"].ToString();
                    if (id != null || id != "")
                    {
                        GetArchitectProfile(id);
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

        protected void GetArchitectProfile(string id)
        {
            Conn = new SqlConnection();
            Conn = dbConn.OpenConn();

            Comm = new SqlCommand("spGetArchitectInfoByid", Conn);
            Comm.CommandType = CommandType.StoredProcedure;
            Comm.Parameters.AddWithValue("@ArchitecID", id);

            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = Comm;

            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                 ID = dt.Rows[0]["ID"].ToString();
                 ArchitecID = dt.Rows[0]["ArchitecID"].ToString();
                 CompanyID = dt.Rows[0]["CompanyID"].ToString();
                 Name = dt.Rows[0]["Name"].ToString();
                 FirstName = dt.Rows[0]["FirstName"].ToString();
                 LastName = dt.Rows[0]["LastName"].ToString();
                 NickName = dt.Rows[0]["NickName"].ToString();
                 Position = dt.Rows[0]["Position"].ToString();
                 Address = dt.Rows[0]["Address"].ToString();
                 Phone = dt.Rows[0]["Phone"].ToString();
                 Mobile = dt.Rows[0]["Mobile"].ToString();
                 Email = dt.Rows[0]["Email"].ToString();
                 StatusConID = dt.Rows[0]["StatusConID"].ToString();
                 ConDesc = dt.Rows[0]["ConDesc"].ToString();
                 UpdatedDate = dt.Rows[0]["UpdatedDate"].ToString();
                 GradeID = dt.Rows[0]["GradeID"].ToString();
                 GradeDesc = dt.Rows[0]["GradeDesc"].ToString();
                 GradeDetail = dt.Rows[0]["GradeDetail"].ToString();


                //txtFirstNameEdit.val(FirstName);
                GetDataCompanyByid(CompanyID);
                GetDataGradeByid(GradeID);
                GetDataStatusConfirmByid(StatusConID);
                GetDataProjectByid(ArchitecID);
                GetDataWeeklyReportByid(ArchitecID);


            }
        }

                          

        protected void GetDataCompanyByid(string companyid)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetCompanyInfoByid", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@CompanyID", companyid);

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string strValue = dt.Rows[i]["CompanyID"].ToString();
                        string strText = dt.Rows[i]["CompanyNameTH"].ToString();

                        strCompany += "<option value=\"" + strValue + "\">" + strText + "</option>";

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

        protected void GetDataGradeByid(string gradeid)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetGradeInfoByid", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@GradeID", gradeid);

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string strValue = dt.Rows[i]["GradeID"].ToString();
                        string strText = dt.Rows[i]["GradeDesc"].ToString();

                        strGrade += "<option value=\"" + strValue + "\">" + strText + "</option>";

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

        protected void GetDataStatusConfirmByid(string statusconid)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetStatusConInfoByid", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@StatusConID", statusconid);

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string strValue = dt.Rows[i]["StatusConID"].ToString();
                        string strText = dt.Rows[i]["ConDesc2"].ToString();

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

        protected void GetDataProjectByid(string architectid)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetProjectInfoByid", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@ArchitecID", Value = architectid };

                Comm.Parameters.Add(param1);

                //conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string No = dt.Rows[i]["No"].ToString();
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
                        string ProjStep = dt.Rows[i]["ProjStep"].ToString();
                        string ProductType = dt.Rows[i]["ProductType"].ToString();
                        string RefProfile = dt.Rows[i]["RefProfile"].ToString();
                        string ProdTypeID = dt.Rows[i]["ProdTypeID"].ToString();
                        string ProdTypeNameEN = dt.Rows[i]["ProdTypeNameEN"].ToString();
                        string ProdID = dt.Rows[i]["ProdID"].ToString();
                        string ProdNameEN = dt.Rows[i]["ProdNameEN"].ToString();
                        string ProfID = dt.Rows[i]["ProfID"].ToString();
                        string ProfNameEN = dt.Rows[i]["ProfNameEN"].ToString();
                        string StatusID = dt.Rows[i]["StatusID"].ToString();
                        string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                        string Quantity = dt.Rows[i]["Quantity"].ToString();
                        string RefType = dt.Rows[i]["RefType"].ToString();
                        string DeliveryDate = dt.Rows[i]["DeliveryDate"].ToString();
                        string Drawing = dt.Rows[i]["Drawing"].ToString();
                        string TypeID = dt.Rows[i]["TypeID"].ToString();
                        string SaleSpec = dt.Rows[i]["SaleSpec"].ToString();
                        string StatusConID = dt.Rows[i]["StatusConID"].ToString();
                        string CreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                        string LastUpdate = dt.Rows[i]["LastUpdate"].ToString();

                        strTblDetail += "<tr> " +
                                            "<td>" + No + "</td>" +
                                            "<td>" + ProjectYear + "</td>" +
                                            "<td>" + ProjectMonth + "</td>" +
                                            "<td class=\"hidden\">" + ProjectID + "</td>" +
                                            "<td> " + ProjectName + "</td>" +
                                            "<td class=\"hidden\">" + CompanyID + "</td>" +
                                            "<td>" + CompanyName + "</td>" +
                                            "<td class=\"hidden\">" + ArchitecID + "</td>" +
                                            "<td class=\"hidden\">" + Name + "</td>" +
                                            "<td>" + Location + "</td>" +
                                            "<td>" + ProdTypeNameEN + "</td>" +
                                            "<td>" + StatusNameEn + "</td>" +
                                            "<td>" + DeliveryDate + "</td>" +
                                            "<td>" + Quantity + "</td>" +
                                            "<td>" + LastUpdate + "</td>" +
                                       "</tr> ";
                    }

                    //Response.Write("<script>alert('Data inserted successfully')</script>");
                }
                //GetDataSalePort();
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

        protected void GetDataWeeklyReportByid(string architectid)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetWeeklyReportInfoByid", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@ArchitecID", Value = architectid };

                Comm.Parameters.Add(param1);

                //conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string No = dt.Rows[i]["No"].ToString();
                        string WeekDate = dt.Rows[i]["WeekDate"].ToString();
                        string WeekTime = dt.Rows[i]["WeekTime"].ToString();
                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string Name = dt.Rows[i]["Name"].ToString();
                        string TransID = dt.Rows[i]["TransID"].ToString();
                        string TransNameEN = dt.Rows[i]["TransNameEN"].ToString();
                        string ProjectID = dt.Rows[i]["ProjectID"].ToString();
                        string ProjectName = dt.Rows[i]["ProjectName"].ToString();
                        string Location = dt.Rows[i]["Location"].ToString();
                        string StatusID = dt.Rows[i]["StatusID"].ToString();
                        string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                        string StepID = dt.Rows[i]["StepID"].ToString();
                        string StepNameEn = dt.Rows[i]["StepNameEn"].ToString();
                        string Remark = dt.Rows[i]["Remark"].ToString();
                        string UserID = dt.Rows[i]["UserID"].ToString();
                        string EmpCode = dt.Rows[i]["EmpCode"].ToString();
                        string CreatedBy = dt.Rows[i]["CreatedBy"].ToString();
                        string CreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                        string ID = dt.Rows[i]["ID"].ToString();
                        string STB = dt.Rows[i]["STB"].ToString();


                        strTblWeeklyReport += "<tr> " +
                                            "<td>" + No + "</td>" +
                                            "<td> " + WeekDate + "</td>" +
                                            "<td> " + WeekTime + "</td>" +
                                            "<td> " + ProjectName + "</td>" +
                                            "<td>" + CompanyName + "</td>" +
                                            "<td>" + Location + "</td>" +
                                            "<td>" + Name + "</td>" +
                                            "<td>" + StepNameEn + "</td>" +
                                            "<td>" + Remark + "</td>" +
                                            "<td>" + UserID + "</td>" +
                                            "<td>" + CreatedDate + "</td>" +
                                       "</tr> ";
                    }

                    //Response.Write("<script>alert('Data inserted successfully')</script>");
                }
                //GetDataSalePort();
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




        protected void btnQuery_Click(object sender, EventArgs e)
        {
            try
            {
                string strPort = Request.Form["selectSalePort"];
                string strStatus = "S01"; //Request.Form["selectSalePort"];
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

                if (dt.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string No = dt.Rows[i]["No"].ToString();
                        string ProjectID = dt.Rows[i]["ProjectID"].ToString();
                        string ProjectName = dt.Rows[i]["ProjectName"].ToString();
                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string Name = dt.Rows[i]["Name"].ToString();
                        string Location = dt.Rows[i]["Location"].ToString();
                        string ProdTypeNameEN = dt.Rows[i]["ProdTypeNameEN"].ToString();
                        string StepNameTh = dt.Rows[i]["StepNameTh"].ToString();
                        string StatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                        string DeliveryDate = dt.Rows[i]["DeliveryDate"].ToString();
                        string Quantity = dt.Rows[i]["Quantity"].ToString();
                        string LastUpdate = dt.Rows[i]["LastUpdate"].ToString();

                        strTblDetail += "<tr> " +
                                            "<td>" + No + "</td>" +
                                            "<td>" + ProjectID + "</td>" +
                                            "<td> " + ProjectName + "</td>" +
                                            "<td>" + CompanyID + "</td>" +
                                            "<td>" + CompanyName + "</td>" +
                                            "<td>" + ArchitecID + "</td>" +
                                            "<td>" + Name + "</td>" +
                                            "<td>" + Location + "</td>" +
                                            "<td>" + ProdTypeNameEN + "</td>" +
                                            "<td>" + StepNameTh + "</td>" +
                                            "<td>" + StatusNameEn + "</td>" +
                                            "<td>" + DeliveryDate + "</td>" +
                                            "<td>" + Quantity + "</td>" +
                                            "<td>" + LastUpdate + "</td>" +
                                       "</tr> ";
                    }

                    //Response.Write("<script>alert('Data inserted successfully')</script>");
                }
                //GetDataSalePort();
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
                //GetDataSalePort();
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

        protected void btnExportExcelOption_click(object sender, EventArgs e)
        {
            try
            {
                string strPort = Request.Form["selectSalePort"];
                string strStatus = "S01";
                string strStart = Request.Form["datepickertrans"];
                string strEnd = Request.Form["datepickerend"];
                string strQtyStart = Request.Form["QtyStart"];
                string strQtyEnd = Request.Form["QtyEnd"];
                string strSearch = Request.Form["Search"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                if (strPort != "SELECTED ALL")
                {
                    Comm = new SqlCommand("sp_GetDataProjectByPortStatusOptionReport", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                }
                else
                {

                    Comm = new SqlCommand("sp_GetDataProjectByPortStatusAllOptionReport", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                }


                SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strPort };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStart };
                SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEnd };
                SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyStart", Value = strQtyStart };
                SqlParameter param6 = new SqlParameter() { ParameterName = "@QtyEnd", Value = strQtyEnd };
                SqlParameter param7 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };

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
                //GetDataSalePort();
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