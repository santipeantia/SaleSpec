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
                       "        a.Mobile, a.Email, a.StatusConID, b.ConDesc2, a.GradeID, c.GradeDesc, convert(nvarchar(10), a.Birthday, 126) Birthday " +
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

                if (strFirstName != "" && strLastName != "")
                {
                    ssql = "insert into adArchitecture (ArchitecID, CompanyID, Name, FirstName, LastName, NickName, Position, " +
                           "       Address, Phone, Mobile, Email, StatusConID, CreatedDate, UpdatedDate, GradeID, Birthday) " +
                           "values  (@ArchitecID, @CompanyID, @Name, @FirstName, @LastName, @NickName, @Position, " +
                           "       @Address, @Phone, @Mobile, @Email, @StatusConID, @CreatedDate, @UpdatedDate @GradeID, @Birthday)  ";

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

                if (strFirstName != "" && strLastName != "")
                {
                    ssql = "update  adArchitecture set CompanyID=@CompanyID, Name=@Name, FirstName=@FirstName, LastName=@LastName, NickName=@NickName, Position=@Position, " +
                           "       Address=@Address, Phone=@Phone, Mobile=@Mobile, Email=@Email, StatusConID=@StatusConID, UpdatedDate=@UpdatedDate, GradeID=@GradeID, Birthday=@Birthday " +
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
                ssql = "SELECT a.CompanyID, a.ArchitecID, a.FirstName, a.LastName, a.NickName, a.Position, a.Address, a.Phone, " +
                       "        a.Mobile, a.Email, a.StatusConID, b.ConDesc2, a.Birthday  " +
                       "FROM adArchitecture AS a LEFT OUTER JOIN " +
                       "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID";

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
    }
}