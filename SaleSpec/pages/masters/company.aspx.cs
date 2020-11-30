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

namespace SaleSpec.pages.masters
{
    public partial class company : System.Web.UI.Page
    {
        string ssql;
        DataTable dt = new DataTable();

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        public string strMsgAlert = "";
        public string strTblDetail = "";
        public string strTblActive = "";

        dbConnection dbConn = new dbConnection();

        ReportDocument rpt = new ReportDocument();

        public string sPage = "masters/company";

        public string strFullName = "";
        public string strRequestDate = "";
        public string strExpireDate = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }

            if (!IsPostBack)
            {
                GetInitialData();
            }
        }

        protected void GetInitialData()
        {
            GetCustomerDataBind();
            GetStatusDataBind();
        }

        protected void GetStatusDataBind()
        {
            try
            {
                //ssql = "sp_adCustomerTypeStatus";

                //Conn = dbConn.OpenConn();
                //Comm = new SqlCommand(ssql);
                //Comm.Connection = Conn;
                //Comm.CommandType = CommandType.StoredProcedure;

                //da = new SqlDataAdapter(Comm);

                //dt = new DataTable();
                //da.Fill(dt);

                ssql = "SELECT StatusID, StatusDesc, StatusDetails FROM adSystemStatus";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strStatusID = dt.Rows[i]["StatusID"].ToString();
                        string strStatusDesc = dt.Rows[i]["StatusDesc"].ToString();
                        string strStatusDetails = dt.Rows[i]["StatusDetails"].ToString();

                        strTblActive += "<tr> " +
                                        "     <td>" + strStatusID + "</td> " +
                                        "     <td>" + strStatusDesc + "</td> " +
                                        "     <td>" + strStatusDetails + "</td> " +
                                        "     <td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-pencil-square-o text-green\"></i>aaa</a></td> " +
                                        "</tr>";
                    }
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                             "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                             "</div>";
                return;
            }

        }

        protected void GetCustomerDataBind()
        {
            try
            {
                //CompanyID, CompanyName, CompanyName2, Address, ProvinceID, ArchitecName, Phone, Mobile, Email

                ssql = "SELECT a.CompanyID, a.CompanyName, a.CompanyName2, a.Address, a.ProvinceID, a.ContactName, " +
                       "    a.Phone, a.Mobile, a.Email, a.StatusConID, b.ConDesc2, CustTypeID " +
                       "FROM    adCompany a LEFT OUTER JOIN " +
                       "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID " + 
                       "WHERE a.CompanyID not in ('0') ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strCompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string strCompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string strCompanyName2 = dt.Rows[i]["CompanyName2"].ToString();
                        string strCustTypeID = dt.Rows[i]["CustTypeID"].ToString();
                        string strAddress = dt.Rows[i]["Address"].ToString();
                        string strProvinceID = dt.Rows[i]["ProvinceID"].ToString();
                        string strContactPerson = dt.Rows[i]["ContactName"].ToString();
                        string strPhone = dt.Rows[i]["Phone"].ToString();
                        string strMobile = dt.Rows[i]["Mobile"].ToString();
                        string strEmail = dt.Rows[i]["Email"].ToString();
                        string strStatusConID = dt.Rows[i]["StatusConID"].ToString();
                        string strStatus = dt.Rows[i]["ConDesc2"].ToString();

                        if (strStatusConID == "0")
                        {
                            strStatus = "<span class=\"text-orange\">" + strStatus + "</span>";
                        }
                        else if (strStatusConID == "1")
                        {
                            strStatus = "<span class=\"text-green\">" + strStatus + "</span>";
                        }
                        else
                        {
                            strStatus = "<span class=\"text-red\">" + strStatus + "</span>";
                        }

                        strTblDetail += "<tr> " +
                                        "     <td>" + strCompanyID + "</td> " +
                                        "     <td>" + strCompanyName + "</td> " +
                                        "     <td>" + strCompanyName2 + "</td> " +
                                        "     <td class=\"hidden\">" + strCustTypeID + "</td> " +
                                        "     <td>" + strAddress + "</td> " +
                                        "     <td class=\"hidden\">" + strProvinceID + "</td> " +
                                        "     <td>" + strContactPerson + "</td> " +
                                        "     <td>" + strPhone + "</td> " +
                                        "     <td class=\"hidden\">" + strMobile + "</td> " +
                                        "     <td class=\"hidden\">" + strEmail + "</td> " +
                                        "     <td class=\"hidden\">" + strStatusConID + "</td> " +
                                        "     <td>" + strStatus + "</td> " +
                                        "<td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-pencil-square-o text-green\"></i></a></td> " +
                                        "<td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"#\" title=\"Delete\"><i class=\"fa fa-trash text-red\"></i></a></td> " +
                                        "</tr>";
                    }

                    Session["datalist"] = strTblDetail;
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                             "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                             "</div>";
                return;
            }
        }

        protected void btnSaveNewData_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strCompanyID = Request.Form["txtCompanyID"];
                string strCompanyName = Request.Form["txtCompanyName"];
                string strCompanyName2 = Request.Form["txtCompanyName2"];
                string strCustTypeID = Request.Form["selectCustTypeID"];
                string strAddress = Request.Form["txtAddress"];
                string strProvinceID = Request.Form["txtProvinceID"];
                string strContactName = Request.Form["txtContactName"];
                string strPhone = Request.Form["txtPhone"];
                string strMobile = Request.Form["txtMobile"];
                string strEmail = Request.Form["txtEmail"];
                string strStatusConID = Request.Form["selectStatusConID"];

                if (strCompanyName != "" && strCompanyName2 != "")
                {
                    ssql = "insert into adCompany (CompanyName, CompanyName2, CustTypeID, Address, ProvinceID, ContactName, Phone, Mobile, Email, StatusConID, CreatedDate, UpdatedDate) " +
                           "values    (@CompanyName, @CompanyName2, @CustTypeID, @Address, @ProvinceID, @ContactName, @Phone, @Mobile, @Email, @StatusConID, @CreatedDate, @UpdatedDate)  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = strCompanyName;
                    Comm.Parameters.Add("@CompanyName2", SqlDbType.NVarChar).Value = strCompanyName2;
                    Comm.Parameters.Add("@CustTypeID", SqlDbType.NVarChar).Value = strCustTypeID;
                    Comm.Parameters.Add("@Address", SqlDbType.NVarChar).Value = strAddress;
                    Comm.Parameters.Add("@ProvinceID", SqlDbType.NVarChar).Value = strProvinceID;
                    Comm.Parameters.Add("@ContactName", SqlDbType.NVarChar).Value = strContactName;
                    Comm.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = strPhone;
                    Comm.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = strMobile;
                    Comm.Parameters.Add("@Email", SqlDbType.NVarChar).Value = strEmail;
                    Comm.Parameters.Add("@StatusConID", SqlDbType.NVarChar).Value = strStatusConID;
                    Comm.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.Parameters.Add("@UpdatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.ExecuteNonQuery();

                }
                else
                {
                    strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                               "      <strong>Warning..!</strong> Details is not complete please check.. " +
                               "</div>";
                    return;
                }

                transac.Commit();
                Conn.Close();

                GetInitialData();

            }
            catch (Exception ex)
            {
                transac.Rollback();
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                             "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                             "</div>";
                return;
            }
        }

        protected void btnUpdateData_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strCompanyID = Request.Form["txtCompanyIDEdit"];
                string strCompanyName = Request.Form["txtCompanyNameEdit"];
                string strCompanyName2 = Request.Form["txtCompanyName2Edit"];
                string strCustTypeID = Request.Form["selectCustTypeIDEdit"];
                string strAddress = Request.Form["txtAddressEdit"];
                string strProvinceID = Request.Form["txtProvinceIDEdit"];
                string strContactName = Request.Form["txtContactNameEdit"];
                string strPhone = Request.Form["txtPhoneEdit"];
                string strMobile = Request.Form["txtMobileEdit"];
                string strEmail = Request.Form["txtEmailEdit"];
                string strStatusConID = Request.Form["selectStatusConIDEdit"];

                if (strCompanyID != "" && strCompanyName != "")
                {
                    ssql = "update  adCompany set CompanyName=@CompanyName, CompanyName2=@CompanyName2, CustTypeID=@CustTypeID, Address=@Address, ProvinceID=@ProvinceID, " +
                           "        ContactName=@ContactName, Phone=@Phone, Mobile=@Mobile, Email=@Email, StatusConID=@StatusConID, UpdatedDate=@UpdatedDate " +
                           "where   CompanyID=@CompanyID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = strCompanyID;
                    Comm.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = strCompanyName;
                    Comm.Parameters.Add("@CompanyName2", SqlDbType.NVarChar).Value = strCompanyName2;
                    Comm.Parameters.Add("@CustTypeID", SqlDbType.NVarChar).Value = strCustTypeID;
                    Comm.Parameters.Add("@Address", SqlDbType.NVarChar).Value = strAddress;
                    Comm.Parameters.Add("@ProvinceID", SqlDbType.NVarChar).Value = strProvinceID;
                    Comm.Parameters.Add("@ContactName", SqlDbType.NVarChar).Value = strContactName;
                    Comm.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = strPhone;
                    Comm.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = strMobile;
                    Comm.Parameters.Add("@Email", SqlDbType.NVarChar).Value = strEmail;
                    Comm.Parameters.Add("@StatusConID", SqlDbType.NVarChar).Value = strStatusConID;
                    Comm.Parameters.Add("@UpdatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.ExecuteNonQuery();

                }
                else
                {
                    strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                               "      <strong>Warning..!</strong> Details is not complete please check.. " +
                               "</div>";
                    return;
                }

                transac.Commit();
                Conn.Close();

                GetInitialData();

            }
            catch (Exception ex)
            {
                transac.Rollback();
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                             "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                             "</div>";
                return;
            }
        }

        protected void btnDeleteData_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strCompanyID = Request.Form["txtCompanyIDDel"];

                if (strCompanyID != "")
                {
                    ssql = "delete from  adCompany where   CompanyID=@CompanyID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = strCompanyID;
                    Comm.ExecuteNonQuery();

                }
                else
                {
                    strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                               "      <strong>Warning..!</strong> Details is not complete please check.. " +
                               "</div>";
                    return;
                }

                transac.Commit();
                Conn.Close();

                GetInitialData();

            }
            catch (Exception ex)
            {
                transac.Rollback();
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                             "      <strong>พบข้อผิดพลาด..!</strong> " + ex.Message + " " +
                             "</div>";
                return;
            }
        }

        protected void btnExportExcel_click(object sender, EventArgs e)
        {
            try
            {
                //ssql = "SELECT a.CompanyID, a.CompanyName, a.CompanyName2, a.CustTypeID, c.CustTypeDesc, a.Address, a.ProvinceID, a.ContactName, " +
                //        "    a.Phone, a.Mobile, a.Email, a.StatusConID, b.ConDesc2 " +
                //        "FROM    adCompany a LEFT OUTER JOIN " +
                //        "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID  left join " +
                //        "        adCustomerType c on a.CustTypeID=c.CustTypeID " +
                //        "WHERE a.CompanyID not in ('0') ";

                //ssql = "select CompanyID, CompanyName, CompanyName2, " +
                //        "        Port = stuff((select distinct ', ' + TypeID " +
                //        "         from adProjects " +
                //        "         where CompanyID = a.CompanyID " +
                //        "         for xml path(''), TYPE " +
                //        "        ).value('.[1]', 'nvarchar(max)'), 1, 1,''), " +
                //        "        CustTypeID, CustTypeDesc, Address, ProvinceID, ContactName, " +
                //        "        Phone, Mobile, Email,  ConDesc2 " +
                //        "from( " +
                //        "    SELECT a.CompanyID, a.CompanyName, a.CompanyName2, a.CustTypeID, c.CustTypeDesc, a.Address, a.ProvinceID, a.ContactName, " +
                //        "            a.Phone, a.Mobile, a.Email, b.ConDesc2 " +
                //        "    FROM    adCompany a LEFT OUTER JOIN " +
                //        "            adStatusConfirm AS b ON a.StatusConID = b.StatusConID  left join " +
                //        "            adCustomerType c on a.CustTypeID = c.CustTypeID " +
                //        "    WHERE a.CompanyID not in ('0')) a";

                ssql = "SELECT a.CompanyID, a.CompanyName, a.CompanyName2, b.ArchitecID, b.name " +
                       "        , b.SpecID as Port,	 a.CustTypeID, a.CustTypeDesc, a.Address " +
                       "        , a.ProvinceID, a.ContactName, a.Phone, a.Mobile, a.Email " +
                       "        , c.ConDesc, a.CreatedDate, a.UpdatedDate " +
                       "FROM    adCompany a left join " +
                       "        (select* from adArchitecture where ArchitecID is not null and SpecID is not null) b on a.CompanyID = b.CompanyID left join " +
                       "        adStatusConfirm c on a.StatusConID = c.StatusConID " +
                       "ORDER BY a.CompanyName";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=CompanyExport.xls");
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
                ssql = "spPrintCompany";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    rpt.Load(Server.MapPath("../reports/rptPrintCompany.rpt"));
                    
                    reports.dsCompanies dsCompanies = new reports.dsCompanies();
                    dsCompanies.Merge(dt);

                    rpt.SetDataSource(dt);
                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ExportCompany"+ strDate);
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                            "      <strong>Error GetOrderCharge..!</strong> " + ex.Message + " " +
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
                string strOptName = "Company Setup List";

                string strVerifyCode = GenerateVerfifyCode();

                string strFinalVerifyCode = GenerateVerfifyCode();

                string strMailBody = GetMailBodyTempleate(strEmail, strRepType, strUserID, strEmpCode, strOpt, strOptName, strVerifyCode);

                //Response.Write("<script>alert('" + strRepType +":"+  strUserID + ":" + strEmpCode + ":" + strOpt + ":" + strOptName + ":" + strFrom + ":" + strEnd + ":" + strPort + ":" + strQty + ":" + strQtyTo + ":" + strSearch + ":" + strVerifyCode + "')</script>");

                if (strEmail != "")
                {
                    MailMessage mail = new MailMessage();

                    mail.From = new MailAddress("no-reply@ampelite.co.th");
                    mail.To.Add(strEmail);
                    //mail.Bcc.Add("santi@ampelite.co.th");
                    mail.Bcc.Add("santi@ampelite.co.th,chanunnett@ampelite.co.th");

                    mail.Subject = "Request Verify Password for Company Setup Report";
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

                saveVerifyPassword(strEmail, strUserID, strEmpCode, strOpt, strOptName, strVerifyCode, strFullName, strRequestDate, strExpireDate);

                Response.Write("<script>alert('Password timeout within 90 minute please check your email : " + strEmail + " ')</script>");


                GetInitialData();
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

        protected string GetMailBodyTempleate(string strEmail, string strRepType, string strUserID, string strEmpCode, string strOpt, string strOptName, string strVerifyCode)
        {

            //StringBuilder strBodyBuilder = new StringBuilder;
            string strBodyMail = string.Empty;

            using (StreamReader reader = new StreamReader(Server.MapPath("sendmail_companysetup.html")))
            {
                strBodyMail = reader.ReadToEnd();
            }

            strFullName = Session["sEmpEngFirstName"].ToString() + "  " + Session["sEmpEngLastName"].ToString();
            strRequestDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss tt");
            strExpireDate = DateTime.Now.AddMinutes(90).ToString("yyyy-MM-dd HH:mm:ss tt");

            strBodyMail = strBodyMail.Replace("{strEmail}", strEmail);
            strBodyMail = strBodyMail.Replace("{strRepType}", strRepType);
            strBodyMail = strBodyMail.Replace("{strOptName}", strOptName);
            strBodyMail = strBodyMail.Replace("{strVerifyCode}", strVerifyCode);
            strBodyMail = strBodyMail.Replace("{strFullName}", strFullName);
            strBodyMail = strBodyMail.Replace("{strRequestDate}", strRequestDate);
            strBodyMail = strBodyMail.Replace("{strExpireDate}", strExpireDate);



            return strBodyMail;
        }

        protected void saveVerifyPassword(string sEmail, string sUserID, string sEmpCode, string sRepOpt, string sRepOptName, string sVerifyCode, string sRequestedBy, string sRequestedDate, string sExpirationDate)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spVerifyReportCompanySetup", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@Email", sEmail);
                Comm.Parameters.AddWithValue("@UserID", sUserID);
                Comm.Parameters.AddWithValue("@EmpCode", sEmpCode);
                Comm.Parameters.AddWithValue("@RepOpt", sRepOpt);
                Comm.Parameters.AddWithValue("@RepOptName", sRepOptName);
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