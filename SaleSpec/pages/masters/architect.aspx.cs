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
    public partial class architect : System.Web.UI.Page
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

        public string sPage = "masters/architect";

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
            GetArchitectDataBind();
        }

        protected void GetArchitectDataBind()
        {
            try
            {
                //ssql = "SELECT ArchitecID, FirstName, LastName, NickName, Position, Address, Phone, Mobile, Email, Status='Confirmed' FROM adArchitecture ";

                ssql = "SELECT a.CompanyID, a.ArchitecID, a.FirstName, a.LastName, a.NickName, a.Position, a.Address, a.Phone, " +
                       "        a.Mobile, a.Email, a.StatusConID, b.ConDesc2, a.GradeID, c.GradeDesc, convert(nvarchar(10), a.Birthday, 126) Birthday, SpecID " +
                       "FROM adArchitecture AS a LEFT OUTER JOIN " + 
                       "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID LEFT JOIN " + 
                       "        adGrade c on a.GradeID=c.GradeID ";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strCompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string strArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string strFirstName = dt.Rows[i]["FirstName"].ToString();
                        string strLastName = dt.Rows[i]["LastName"].ToString();
                        string strNickName = dt.Rows[i]["NickName"].ToString();
                        string strPosition = dt.Rows[i]["Position"].ToString();
                        string strAddress = dt.Rows[i]["Address"].ToString();
                        string strPhone = dt.Rows[i]["Phone"].ToString();
                        string strMobile = dt.Rows[i]["Mobile"].ToString();
                        string strEmail = dt.Rows[i]["Email"].ToString();
                        string strStatusConID = dt.Rows[i]["StatusConID"].ToString();
                        string strStatus = dt.Rows[i]["ConDesc2"].ToString();
                        string strGradeID = dt.Rows[i]["GradeID"].ToString();
                        string strBirthday = dt.Rows[i]["Birthday"].ToString();
                        string strSpecID = dt.Rows[i]["SpecID"].ToString();

                        if (strStatusConID == "0")
                        {
                            strStatus = "<span class=\"text-orange\">" + strStatus + "</span>";
                        }
                        else if (strStatusConID == "1")
                        {
                            strStatus = "<span class=\"text-green\">" + strStatus + "</span>";
                        }
                        else if (strStatusConID == "3")
                        {
                            strStatus = "<span class=\"text-blue\">" + strStatus + "</span>";
                        }
                        else
                        {
                            strStatus = "<span class=\"text-red\">" + strStatus + "</span>";
                        }
                        strTblDetail += "<tr> " +
                                        "     <td class=\"hidden\">" + strCompanyID + "</td> " +
                                        "     <td>" + strArchitecID + "</td> " +
                                        //"     <td>" + strArchitecName + "</td> " +
                                        "     <td>" + strFirstName + "</td> " +
                                        "     <td>" + strLastName + "</td> " +
                                        "     <td>" + strNickName + "</td> " +
                                        "     <td>" + strPosition + "</td> " +
                                        "     <td>" + strAddress + "</td> " +
                                        "     <td>" + strPhone + "</td> " +
                                        "     <td>" + strMobile + "</td> " +
                                        "     <td>" + strEmail + "</td> " +
                                        "     <td class=\"hidden\">" + strStatusConID + "</td> " +
                                        "     <td>" + strStatus + "</td> " +
                                        "     <td class=\"hidden\">" + strGradeID + "</td> " +
                                        
                                        "<td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-pencil-square-o text-green\"></i></a></td> " +
                                        "<td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"#\" title=\"Delete\"><i class=\"fa fa-trash text-red\"></i></a></td> " +
                                        "     <td class=\"hidden\">" + strBirthday + "</td> " +
                                        "     <td>" + strSpecID + "</td> " +
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
                string strArcID = "";
                ssql = "spGetCountArchitect";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                DataTable dtCount = new DataTable();
                da.Fill(dtCount);
                if (dtCount.Rows.Count != 0)
                {
                    strArcID = dtCount.Rows[0]["ArchitecID"].ToString();
                }
                Conn.Close();

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strArchitectID = strArcID; //Request.Form["txtArchitectID"];
                string strFirstName = Request.Form["txtFirstName"];
                string strLastName = Request.Form["txtLastName"];
                string strCompany = Request.Form["selectCompany"];  
                string strNickName = Request.Form["txtNickName"];
                string strPosition = Request.Form["txtPosition"];
                string strAddress = Request.Form["txtAddress"];
                string strPhone = Request.Form["txtPhone"];
                string strMobile = Request.Form["txtMobile"];
                string strEmail = Request.Form["txtEmail"];
                string strStatusConID = Request.Form["selectStatusConID"];
                string strGradeID = Request.Form["selectGradeID"];
                string strDatebirthday = Request.Form["datebirthday"];
                string strSpecID = Request.Form["txtPort"];

                if (strFirstName != "" && strLastName != "")
                {
                    ssql = "insert into adArchitecture (ArchitecID, CompanyID, Name, FirstName, LastName, NickName, Position, " +
                           "       Address, Phone, Mobile, Email, StatusConID, CreatedDate, UpdatedDate, GradeID, Birthday, SpecID) " +
                           "values  (@ArchitecID, @CompanyID, @Name, @FirstName, @LastName, @NickName, @Position, " +
                           "       @Address, @Phone, @Mobile, @Email, @StatusConID, @CreatedDate, @UpdatedDate, @GradeID, @Birthday, @SpecID)  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ArchitecID", SqlDbType.NVarChar).Value = strArchitectID;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = strCompany;
                    Comm.Parameters.Add("@Name", SqlDbType.NVarChar).Value = strFirstName;
                    Comm.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = strFirstName;
                    Comm.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = strLastName;
                    Comm.Parameters.Add("@NickName", SqlDbType.NVarChar).Value = strNickName;
                    Comm.Parameters.Add("@Position", SqlDbType.NVarChar).Value = strPosition;
                    Comm.Parameters.Add("@Address", SqlDbType.NVarChar).Value = strAddress;
                    Comm.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = strPhone;
                    Comm.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = strMobile;
                    Comm.Parameters.Add("@Email", SqlDbType.NVarChar).Value = strEmail;
                    Comm.Parameters.Add("@StatusConID", SqlDbType.NVarChar).Value = strStatusConID;
                    Comm.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.Parameters.Add("@UpdatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.Parameters.Add("@GradeID", SqlDbType.NVarChar).Value = strGradeID;
                    Comm.Parameters.Add("@Birthday", SqlDbType.NVarChar).Value = strDatebirthday;
                    Comm.Parameters.Add("@SpecID", SqlDbType.NVarChar).Value = strSpecID;
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

                string strArchitectID = Request.Form["txtArchitectIDEdit"];
                string strFirstName = Request.Form["txtFirstNameEdit"];
                string strLastName = Request.Form["txtLastNameEdit"];
                string strCompany = Request.Form["selectCompanyEdit"];
                string strNickName = Request.Form["txtNickNameEdit"];
                string strPosition = Request.Form["txtPositionEdit"];
                string strAddress = Request.Form["txtAddressEdit"];
                string strPhone = Request.Form["txtPhoneEdit"];
                string strMobile = Request.Form["txtMobileEdit"];
                string strEmail = Request.Form["txtEmailEdit"];
                string strStatusConID = Request.Form["selectStatusConIDEdit"];
                string strGradeID = Request.Form["selectGradeIDEdit"];
                string strDatebirthday = Request.Form["datebirthdayedit"];
                string strSpecID = Request.Form["txtPortEdit"];

                if (strFirstName != "" && strLastName != "")
                {
                    ssql = "update  adArchitecture set CompanyID=@CompanyID, Name=@Name, FirstName=@FirstName, LastName=@LastName, NickName=@NickName, Position=@Position, " +
                           "       Address=@Address, Phone=@Phone, Mobile=@Mobile, Email=@Email, StatusConID=@StatusConID, UpdatedDate=@UpdatedDate, GradeID=@GradeID, Birthday=@Birthday, SpecID=@SpecID " +
                           "where  ArchitecID=@ArchitecID ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ArchitecID", SqlDbType.NVarChar).Value = strArchitectID;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = strCompany;
                    Comm.Parameters.Add("@Name", SqlDbType.NVarChar).Value = strFirstName;
                    Comm.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = strFirstName;
                    Comm.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = strLastName;
                    Comm.Parameters.Add("@NickName", SqlDbType.NVarChar).Value = strNickName;
                    Comm.Parameters.Add("@Position", SqlDbType.NVarChar).Value = strPosition;
                    Comm.Parameters.Add("@Address", SqlDbType.NVarChar).Value = strAddress;
                    Comm.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = strPhone;
                    Comm.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = strMobile;
                    Comm.Parameters.Add("@Email", SqlDbType.NVarChar).Value = strEmail;
                    Comm.Parameters.Add("@StatusConID", SqlDbType.NVarChar).Value = strStatusConID;
                    Comm.Parameters.Add("@UpdatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.Parameters.Add("@GradeID", SqlDbType.NVarChar).Value = strGradeID;
                    Comm.Parameters.Add("@Birthday", SqlDbType.NVarChar).Value = strDatebirthday;
                    Comm.Parameters.Add("@SpecID", SqlDbType.NVarChar).Value = strSpecID;
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

                string strArchitecID = Request.Form["txtArchitectIDDel"];

                if (strArchitecID != "" )
                {
                    ssql = "delete from  adArchitecture where  ArchitecID=@ArchitecID ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ArchitecID", SqlDbType.NVarChar).Value = strArchitecID; 
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
                //ssql = "SELECT a.CompanyID, a.ArchitecID, a.FirstName, a.LastName, a.NickName, a.Position, a.Address, a.Phone, " +
                //       "        a.Mobile, a.Email, a.StatusConID, b.ConDesc2, a.Birthday  " +
                //       "FROM adArchitecture AS a LEFT OUTER JOIN " +
                //       "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID";

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

        protected void btnSendMail_Click(object sender, EventArgs e)
        {
            try
            {
                string strEmail = Request.Form["txtConfirmEmail"];
                string strRepType = Request.Form["txtRepOpt"];
                string strUserID = Session["UserID"].ToString();
                string strEmpCode = Session["EmpCode"].ToString();
                string strOpt = Request.Form["txtRepOpt"];
                string strOptName = "Architecture Setup List";

                string strVerifyCode = GenerateVerfifyCode();

                string strFinalVerifyCode = GenerateVerfifyCode();

                string strMailBody = GetMailBodyTempleate(strEmail, strRepType, strUserID, strEmpCode, strOpt, strOptName, strVerifyCode);

                //Response.Write("<script>alert('" + strRepType +":"+  strUserID + ":" + strEmpCode + ":" + strOpt + ":" + strOptName + ":" + strFrom + ":" + strEnd + ":" + strPort + ":" + strQty + ":" + strQtyTo + ":" + strSearch + ":" + strVerifyCode + "')</script>");

                if (strEmail != "")
                {
                    MailMessage mail = new MailMessage();

                    mail.From = new MailAddress("no-reply@ampelite.co.th");
                    mail.To.Add(strEmail);
                    mail.Bcc.Add("santi@ampelite.co.th");
                    //mail.Bcc.Add("santi@ampelite.co.th,chanunnett@ampelite.co.th");

                    mail.Subject = "Request Verify Password for Architecture Setup Report";
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

                Response.Write("<script>alert('Password timeout within 10 minute please check your email : " + strEmail + " ')</script>");


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

            using (StreamReader reader = new StreamReader(Server.MapPath("sendmail_architectsetup.html")))
            {
                strBodyMail = reader.ReadToEnd();
            }

            strFullName = Session["sEmpEngFirstName"].ToString() + "  " + Session["sEmpEngLastName"].ToString();
            strRequestDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss tt");
            strExpireDate = DateTime.Now.AddMinutes(10).ToString("yyyy-MM-dd HH:mm:ss tt");

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

                Comm = new SqlCommand("spVerifyReportArchitectSetup", Conn);
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