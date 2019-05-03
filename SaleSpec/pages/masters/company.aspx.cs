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
                                        "       <a href=\"#\" title=\"Edit\"><i class=\"fa fa-pencil-square-o text-green\"></i></a></td> " +
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
                ssql = "SELECT a.CompanyID, a.CompanyName, a.CompanyName2, a.CustTypeID, c.CustTypeDesc, a.Address, a.ProvinceID, a.ContactName, " +
                        "    a.Phone, a.Mobile, a.Email, a.StatusConID, b.ConDesc2 " +
                        "FROM    adCompany a LEFT OUTER JOIN " +
                        "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID  left join " +
                        "        adCustomerType c on a.CustTypeID=c.CustTypeID " +
                        "WHERE a.CompanyID not in ('0') ";

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
    }
}