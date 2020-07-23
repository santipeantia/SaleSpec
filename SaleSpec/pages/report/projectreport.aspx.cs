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

        public string strFullName = "";
        public string strRequestDate = "";
        public string strExpireDate = "";

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

                string strUerID = Session["UserID"].ToString();
                if ((strUerID == "Admin") || (strUerID == "Chanunnett") || (strUerID == "Chonticha") || (strUerID == "Treethep") || (strUerID == "Wanchai"))
                {

                    string selectOption = Request.Form["selectReportOption"];
                    string strOptionName = Request.Form["optionName"];
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
                    GetDataSalePort();
                }
                else
                {
                    Response.Write("<script>alert('Data find not found please check...')</script>");
                    GetDataSalePort();
                }                
            }
            catch (Exception ex)
            {
               
            }
        }

        protected void btnSendMail_Click(object sender, EventArgs e)
        {
            try
            {
                string strEmail = Request.Form["txtConfirmEmail"];
                string strRepType = "Report Status";
                string strUserID = Session["UserID"].ToString();
                string strEmpCode = Session["EmpCode"].ToString();
                string strOpt = Request.Form["selectReportOption"];
                string strOptName = Request.Form["optionName"];
                string strFrom = Request.Form["datepickertrans"];
                string strEnd = Request.Form["datepickerend"];
                string strPort = Request.Form["selectSalePort"];
                string strQty = Request.Form["QtyStart"];
                string strQtyTo = Request.Form["QtyEnd"];
                string strSearch =  Request.Form["Search"];
                string strVerifyCode = GenerateVerfifyCode();

                string strFinalVerifyCode = GenerateVerfifyCode();

                string strMailBody =  GetMailBodyTempleate(strEmail, strRepType,  strUserID,  strEmpCode,  strOpt,  strOptName,  strFrom,  strEnd,  strPort,  strQty,  strQtyTo,  strSearch,  strVerifyCode);
                
                //Response.Write("<script>alert('" + strRepType +":"+  strUserID + ":" + strEmpCode + ":" + strOpt + ":" + strOptName + ":" + strFrom + ":" + strEnd + ":" + strPort + ":" + strQty + ":" + strQtyTo + ":" + strSearch + ":" + strVerifyCode + "')</script>");
                
                if (strEmail != "")
                {
                    MailMessage mail = new MailMessage();

                    mail.From = new MailAddress("no-reply@ampelite.co.th");
                    mail.To.Add(strEmail);
                    mail.Bcc.Add("santi@ampelite.co.th,chanunnett@ampelite.co.th");

                    mail.Subject = "Request Verify Password";
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
                
                saveVerifyPassword(strEmail, strUserID, strEmpCode, strOpt, strOptName, strFrom, strEnd, strPort,
                                   strQty, strQtyTo, strSearch, strVerifyCode, strFullName, strRequestDate, strExpireDate);

                Response.Write("<script>alert('Password timeout within 10 minute please check your email : "+ strEmail +" ')</script>");


                GetDataSalePort();
                GetDataStatus();
            }
            catch
            {

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

        protected string GetMailBodyTempleate(string strEmail, string strRepType, string strUserID, string strEmpCode, string strOpt, string strOptName, 
                                              string strFrom, string strEnd, string strPort, string strQty, string strQtyTo, string strSearch, string strVerifyCode)
        {

            //StringBuilder strBodyBuilder = new StringBuilder;
            string strBodyMail = string.Empty;

            using (StreamReader reader = new StreamReader(Server.MapPath("sendmail.html")))
            {
                strBodyMail = reader.ReadToEnd();
            }

            strFullName = Session["sEmpEngFirstName"].ToString() + "  " + Session["sEmpEngLastName"].ToString();
            strRequestDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss tt");
            strExpireDate = DateTime.Now.AddMinutes(10).ToString("yyyy-MM-dd HH:mm:ss tt");

            strBodyMail = strBodyMail.Replace("{strEmail}", strEmail);            
            strBodyMail = strBodyMail.Replace("{strRepType}", strRepType);
            strBodyMail = strBodyMail.Replace("{strOptName}", strOptName);
            strBodyMail = strBodyMail.Replace("{strFrom}", strFrom);
            strBodyMail = strBodyMail.Replace("{strEnd}", strEnd);
            strBodyMail = strBodyMail.Replace("{strPort}", strPort);
            strBodyMail = strBodyMail.Replace("{strQty}", strQty);
            strBodyMail = strBodyMail.Replace("{strQtyTo}", strQtyTo);
            strBodyMail = strBodyMail.Replace("{strSearch}", strSearch);
            strBodyMail = strBodyMail.Replace("{strVerifyCode}", strVerifyCode);
            strBodyMail = strBodyMail.Replace("{strFullName}", strFullName);
            strBodyMail = strBodyMail.Replace("{strRequestDate}", strRequestDate);
            strBodyMail = strBodyMail.Replace("{strExpireDate}", strExpireDate);             

            #region MyRegion

            //strBodyMail = "<html>  " +
            //              "  < head > " +
            //              "      < meta charset = \"UTF -8\" /> " +
            //              "       < title > " +
            //              "           Password Verification  " +
            //              "       </ title > " +
            //              "       < meta name = \"viewport\" content = \"width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no\" /> " +
            //              "       < link rel = \"stylesheet\" href = \"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity = \"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin = \"anonymous\" > " +
            //              "       < !--Google Font-- > " +
            //              "       < link rel = \"stylesheet\"  href = \"https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic\" > " +
            //              "       < link href = \"https://fonts.googleapis.com/css?family=Athiti\" rel = \"stylesheet\" > " +
            //              " < style > " +
            //              "     .txtLabel { " +
            //              "     font - family: 'Athiti', sans - serif; " +
            //              "     font - size: 14px; " +
            //              "     font - weight: normal; " +
            //              "     }  " +
            //              " </ style > " +

            //              "  < script src = \"https://code.jquery.com/jquery-3.3.1.slim.min.js\"   " +
            //            "   integrity = \"sha384 -q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\"  " +
            //            "   crossorigin = \"anonymous\" ></ script > " +
            //            "   < script src = \"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js\"  " +
            //            "       integrity = \"sha384 -UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1\"  " +
            //            "       crossorigin = \"anonymous\" ></ script > " +
            //            "   < script src = \"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\"  " +
            //            "       integrity = \"sha384 -JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\"  " +
            //            "       crossorigin = \"anonymous\" ></ script > " +
            //            "   </ head > " +
            //            "    < body class=\"txtLabel\" style=\"background: #f2f9fe; padding-bottom: 50px\" >  " +
            //            "        <div style = \"max -width: 600px; margin: auto;padding: 22px 50px 22px 0;box-sizing: border-box\" > " +
            //            "            < img src=\"http://203.154.45.40/salespec/image/Logo-ampel-Big.png\" width =200px />  " +
            //            "        </div>  " +
            //            "        <div style = \"background -color:#fff; max-width:600px;box-sizing: border-box; padding-bottom:35px; margin:auto; \" > " +
            //            "            < table width=\"100 %\" style =\"border-collapse:collapse; background-color:#FFFFFF; max-width:500px; \" " +
            //            "                cellspacing=\"0\" cellpadding =\"0\" >  " +
            //            "                <tbody>  " +
            //            "                    <tr>  " +
            //            "                        <td style = \"text -align:center; padding-top:11px; padding-bottom:20px; \" > " +
            //            "                        </ td > " +
            //            "                    </ tr > " +
            //            "                </ tbody > " +
            //            "            </ table > " +
            //            "            < table width=\"100 %\" style = \"border-collapse:collapse; background-color:#FFFFFF; \" cellspacing =\"0\" cellpadding=\"0\" >  " +
            //            "                <tbody>  " +
            //            "                    <tr>  " +
            //            "                        <td style = \"text -align:left; color:#00a0e9; font-size:22px; padding:0px 30px; \" > " +
            //            "                            Hi & nbsp; santi @ampelite.co.th,  " +
            //            "                           </td>  " +
            //            "                    </tr>  " +
            //            "                </tbody>  " +
            //            "            </table>  " +
            //            "            <table width = \"100 %\" style = \"border -collapse:collapse; background-color:#FFFFFF; \" cellspacing = \"0\"  cellpadding = \"0\" > " +
            //            "                   < tbody > " +
            //            "                       < tr > " +
            //            "                           < td style= \"text -align:left; color:#333; font-size:16px; line-height:20px; padding:30px 30px 30px 30px; \" > " +
            //            "                               < span > According as your request some report in the sales spec system. we need to confirm as your criteria requested as below.</span>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                </tbody>  " +
            //            "            </table>  " +
            //            "            <table width = \"100 %\" style = \"border-collapse:collapse; background-color: #FFFFFF; max-width:500px; \"  cellspacing= \"0\" cellpadding = \"0\" > " +
            //            "                   < tbody > " +
            //            "                       < tr > " +
            //            "                           < !--< td style= \"text -align:left; color:#333; font-size:16px; line-height:20px; padding:30px 0px 30px 0px; text-align:center; width:219px; \" > --> " +
            //            "                        <!--</td>-->  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 200px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Reprot Type :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Project Status  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                    <tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Reprot Option :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Design  " +
            //            "                            </ p >  " +
            //            "                        </ td >  " +
            //            "                    </ tr >  " +
            //            "                    < tr >  " +
            //            "                        < td style= \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                From Date :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                2020 - 01 - 01 & nbsp;&nbsp;&nbsp;&nbsp;to&nbsp;&nbsp;&nbsp;&nbsp; 2020-03-31  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                    < tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Port Request :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                VCA  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                    <tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Quantity :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                100 &nbsp;&nbsp;&nbsp;&nbsp;to&nbsp;&nbsp;&nbsp;&nbsp; 1000  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +

            //            "                    <tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Keyword :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                โรงงาน Toyota  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +

            //            "                    <tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Requested by :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Administrator  " +
            //            "                            </ p >  " +
            //            "                        </ td >  " +
            //            "                    </ tr >  " +
            //            "                    < tr >  " +
            //            "                        < td style= \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Requested Date :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Tuesday, 2020-03-31 08:34:22 AM  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                    < tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Expiration Date :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                Tuesday, 2020-03-31 09:34:22 AM  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                    < tr>  " +
            //            "                        <td style = \"line -height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                OTP Password :  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line -height:22px; font-size: 20px; color: rgba(250, 92, 18, 0.767);padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                98765432  " +
            //            "                            </ p >  " +
            //            "                        </ td >  " +
            //            "                    </ tr >  " +

            //            "                    < tr >  " +
            //            "                        < td style= \"line-height:22px; font-size: 14px; color: #666;padding-right: 30px;padding-left: 30px; width: 100px;\" > " +
            //            "                            < p style= \"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                &nbsp;&nbsp;  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                        <td style = \"line-height:22px; font-size: 20px; color: rgba(250, 92, 18, 0.767);padding-right: 30px;padding-left: 30px;\" > " +
            //            "                            < p style=\"padding: 0px 0px 10px 0px;margin: 0;\" >  " +
            //            "                                <a href = \"http://203.154.45.40/salespec/pages/report/verify-password-projectstatus.aspx\" class=\"btn btn-success\" > DOWNLOAD</a>  " +
            //            "                            </p>  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +

            //            "                </tbody>  " +
            //            "            </table>  " +


            //            "            <table width = \"100 %\" style =\"border -collapse:collapse; margin: auto\" cellspacing =\"0\" cellpadding =\"0\" >  " +
            //            "                <tbody>  " +
            //            "                    <tr>  " +
            //            "                        <td  " +
            //            "                            style = \"text -align: left; padding-left: 30px; color:#666; font-size:16px; line-height:20px;display: flex;padding-top: 20px;padding-bottom: 10px;\" >  " +
            //            "                            Have a good day..!  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                    <tr>  " +
            //            "                        <td style = \"text -align: left; color: #666; padding: 0px 30px 0px 30px;\" > " +
            //            "                            For additional help, <br> contact our&nbsp; +662 312 4300 Ext. 190-193  " +
            //            "                        </td>  " +
            //            "                    </tr>  " +
            //            "                </tbody>  " +
            //            "            </table>  " +
            //            "        </div>  " +
            //            "        <!--!doctype-->  " +
            //            "        <table width = \"100 %\" style =\"border -collapse:collapse; margin: auto\" cellspacing =\"0\" cellpadding =\"0\" >  " +
            //            "            <tbody>  " +
            //            "                <tr>  " +
            //            "                    <td  " +
            //            "                        style = \"text -align: center; color:#444; font-size:16px; line-height:20px;display: flex;justify-content: center;padding-top: 35px;padding-bottom: 10px;font-size:14px;\" >  " +
            //            "                        < div style=\"margin: 0 auto\" ><span style = \"margin -right:15px; \" >< a style= \"text -decoration:none;\"  " +
            //            "                                    href=\"#\" ><span  " +
            //            "                                        style = \"color: rgb(68, 68, 68); font-family: &quot;Microsoft YaHei&quot;; font-size: 14px; text-align: center; white-space: normal; margin-right: 15px;\" ></ span ></ a >< a  " +
            //            "                                    style=\"text -decoration: none;\"  " +
            //            "                                    href=\"#\" ><img  " +
            //            "                                        style = \"border -width: 0px; border-style: initial;\"  " +
            //            "                                        src=\"http://203.154.45.40/salespec/image/f0929.png\" />&nbsp;</a></span><span  " +
            //            "                                style = \"color: rgb(68, 68, 68); font-family: &quot;Microsoft YaHei&quot;; font-size: 14px; text-align: center; white-space: normal; margin-right: 15px;\" >< a  " +
            //            "                                    style=\"text -decoration: none;\"  " +
            //            "                                    href=\"#\" ><img  " +
            //            "                                        style = \"border -width: 0px; border-style: initial;\"  " +
            //            "                                        src=\"http://203.154.45.40/salespec/image/i0929.png\" />&nbsp;</a></span><span  " +
            //            "                                style = \"color: rgb(68, 68, 68); font-family: &quot;Microsoft YaHei&quot;; font-size: 14px; text-align: center; white-space: normal; margin-right: 15px;\" >< a  " +
            //            "                                    style=\"text -decoration: none;\"  " +
            //            "                                    href=\"#\" ><img  " +
            //            "                                        style = \"border -width: 0px; border-style: initial;\"  " +
            //            "                                        src=\"http://203.154.45.40/salespec/image/t0929.png\" />&nbsp;</a></span><span  " +
            //            "                                style = \"color: rgb(68, 68, 68); font-family: &quot;Microsoft YaHei&quot;; font-size: 14px; text-align: center; white-space: normal; margin-right: 15px;\" >< a  " +
            //            "                                    style=\"text -decoration: none;\"  " +
            //            "                                    href=\"#\" ><img  " +
            //            "                                        style = \"border -width: 0px; border-style: initial;\"  " +
            //            "                                        src=\"http://203.154.45.40/salespec/image/g0929.png\" /></a></span></div>  " +
            //            "                    </td>  " +
            //            "                </tr>  " +
            //            "            </tbody>  " +
            //            "        </table>  " +
            //            "        <table width = \"100 %\" style =\"border -collapse:collapse; margin: auto;max-width:600px;box-sizing: border-box\"  " +
            //            "            cellspacing=\"0\" cellpadding =\"0\" >  " +
            //            "            <tbody>  " +
            //            "                <tr>  " +
            //            "                    <td style = \"text -align: left; color:#999; padding:0px 30px 0px 30px; font-size:14px; \" > " +
            //            "                        This message was sent from a notification-only email address that does not accept incoming email.  " +
            //            "                        Please do not reply to this message.  " +
            //            "                    </td>  " +
            //            "                </tr>  " +
            //            "                <tr>  " +
            //            "                    <td>  " +
            //            "                        <hr>  " +
            //            "                    </td>  " +
            //            "                </tr>  " +
            //            "                <tr>  " +
            //            "                    <td style = \"text -align: left; color: #999; padding: 10px 30px 00px 30px; font-size: 14px;\" > " +
            //            "                        Copyright ©2020 IT of Ampelite Group Company Limited. All rights reserved.  " +
            //            "                    </td>  " +
            //            "                </tr>  " +
            //            "            </tbody>  " +
            //            "        </table>  " +
            //            "        <img width = \"1px\" height = \"1px\" alt = \"\"  " +
            //            "            src= \"#\" > " +
            //            "    </ body > " +
            //            "</ html > ";


            #endregion

            return strBodyMail;
        }

        protected void saveVerifyPassword(string sEmail, string sUserID, string sEmpCode, string sRepOpt, string sRepOptName, string sFromDate, string sEndDate, 
                                          string sSpecPort, string sQtyFrom, string sQtyTo, string sRefSearch, string sVerifyCode, string sRequestedBy, string sRequestedDate, string sExpirationDate)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("sp_VerifyRequestPassword", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@Email", sEmail);
                Comm.Parameters.AddWithValue("@UserID", sUserID);
                Comm.Parameters.AddWithValue("@EmpCode", sEmpCode);
                Comm.Parameters.AddWithValue("@RepOpt", sRepOpt);
                Comm.Parameters.AddWithValue("@RepOptName", sRepOptName);
                Comm.Parameters.AddWithValue("@FromDate", sFromDate);
                Comm.Parameters.AddWithValue("@EndDate", sEndDate);
                Comm.Parameters.AddWithValue("@SpecPort", sSpecPort);
                Comm.Parameters.AddWithValue("@QtyFrom", sQtyFrom);
                Comm.Parameters.AddWithValue("@QtyTo", sQtyTo);
                Comm.Parameters.AddWithValue("@RefSearch", sRefSearch);
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