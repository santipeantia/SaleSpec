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

        public string strFullName = "";
        public string strRequestDate = "";
        public string strExpireDate = "";

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

                if (Session["EmpCode"].ToString() == "118052" || Session["UserID"].ToString() == "316010" || Session["UserID"].ToString() == "506009" || Session["UserID"].ToString() == "519012")
                {
                    Comm = new SqlCommand("spGetDataSaleSpec", Conn);
                }
                else
                {
                    Comm = new SqlCommand("spGetDataSaleSpecOwner", Conn);
                }

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

        protected void btnSendMail_Click(object sender, EventArgs e)
        {
            try
            {
                string strEmail = Request.Form["txtConfirmEmail"];
                string strRepType = Request.Form["txtRepOpt"];
                string strUserID = Session["UserID"].ToString();
                string strEmpCode = Session["EmpCode"].ToString();
                string strOpt = Request.Form["txtRepOpt"];
                string strOptName = "Company Report";

                string strPort = Session["ssPort"].ToString(); // Request.Form["selectSalePort"];                

                string strVerifyCode = GenerateVerfifyCode();

                string strFinalVerifyCode = GenerateVerfifyCode();

                string strMailBody = GetMailBodyTempleate(strEmail, strRepType, strUserID, strEmpCode, strOpt, strOptName, strPort, strVerifyCode);

                //Response.Write("<script>alert('" + strRepType +":"+  strUserID + ":" + strEmpCode + ":" + strOpt + ":" + strOptName + ":" + strFrom + ":" + strEnd + ":" + strPort + ":" + strQty + ":" + strQtyTo + ":" + strSearch + ":" + strVerifyCode + "')</script>");

                if (strEmail != "")
                {
                    MailMessage mail = new MailMessage();

                    mail.From = new MailAddress("no-reply@ampelite.co.th");
                    mail.To.Add(strEmail);
                   //mail.Bcc.Add("santi@ampelite.co.th");
                    mail.Bcc.Add("santi@ampelite.co.th,chanunnett@ampelite.co.th");

                    mail.Subject = "Request Verify Password for Company Report";
                    mail.Body = strMailBody;
                    mail.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient("mail.ampelite.co.th");

                    NetworkCredential credential = new NetworkCredential("no-reply@ampelite.co.th", "Ampel@1234");
                    smtp.Credentials = credential;
                    smtp.Send(mail);
                    Response.Write("Message was sent to " + mail.To + " at " + DateTime.Now);
                }
                else
                {
                }

                saveVerifyPassword(strEmail, strUserID, strEmpCode, strOpt, strOptName, strPort, strVerifyCode, strFullName, strRequestDate, strExpireDate);

                Response.Write("<script>alert('Password timeout within 90 minute please check your email : " + strEmail + " ')</script>");

                GetDataSalePort();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "')</script>");
            }

        }

        protected string GenerateVerfifyCode()
        {
            string strFinalVerifyCode = "";

            Random random = new Random();
            int randomNumber = random.Next(100000, 999999);

            strFinalVerifyCode = randomNumber.ToString();
            //Response.Write("<script>alert('"+ strFinalVerifyCode +"')</script>");
            return strFinalVerifyCode;
        }

        protected string GetMailBodyTempleate(string strEmail, string strRepType, string strUserID, string strEmpCode, string strOpt, string strOptName, string strPort, string strVerifyCode)
        {
            //StringBuilder strBodyBuilder = new StringBuilder;
            string strBodyMail = string.Empty;

            using (StreamReader reader = new StreamReader(Server.MapPath("sendmail_companyreport.html")))
            {
                strBodyMail = reader.ReadToEnd();
            }

            strFullName = Session["sEmpEngFirstName"].ToString() + "  " + Session["sEmpEngLastName"].ToString();
            strRequestDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss tt");
            strExpireDate = DateTime.Now.AddMinutes(90).ToString("yyyy-MM-dd HH:mm:ss tt");

            strBodyMail = strBodyMail.Replace("{strEmail}", strEmail);
            strBodyMail = strBodyMail.Replace("{strRepType}", strRepType);
            strBodyMail = strBodyMail.Replace("{strOptName}", strOptName);

            strBodyMail = strBodyMail.Replace("{strPort}", strPort);

            strBodyMail = strBodyMail.Replace("{strVerifyCode}", strVerifyCode);
            strBodyMail = strBodyMail.Replace("{strFullName}", strFullName);
            strBodyMail = strBodyMail.Replace("{strRequestDate}", strRequestDate);
            strBodyMail = strBodyMail.Replace("{strExpireDate}", strExpireDate);

            return strBodyMail;
        }

        protected void saveVerifyPassword(string sEmail, string sUserID, string sEmpCode, string sRepOpt, string sRepOptName,
                                          string strPort, string sVerifyCode, string sRequestedBy, string sRequestedDate, string sExpirationDate)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spVerifyReportCompanyReport", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@Email", sEmail);
                Comm.Parameters.AddWithValue("@UserID", sUserID);
                Comm.Parameters.AddWithValue("@EmpCode", sEmpCode);
                Comm.Parameters.AddWithValue("@RepOpt", sRepOpt);
                Comm.Parameters.AddWithValue("@RepOptName", sRepOptName);

                Comm.Parameters.AddWithValue("@sPort", strPort);

                Comm.Parameters.AddWithValue("@VerifyCode", sVerifyCode);
                Comm.Parameters.AddWithValue("@RequestedBy", sRequestedBy);
                Comm.Parameters.AddWithValue("@RequestedDate", sRequestedDate);
                Comm.Parameters.AddWithValue("@ExpirationDate", sExpirationDate);
                Comm.ExecuteNonQuery();
                Conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "')</script>");
            }
        }

    }
}