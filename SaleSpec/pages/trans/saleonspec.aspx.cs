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


namespace SaleSpec.pages.trans
{
    public partial class saleonspec : System.Web.UI.Page
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

        public string sPage = "trans/saleonspec";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetInitialData();
            }
        }

        protected void GetInitialData()
        {
            GetProjectDataBind();
        }

        protected void GetProjectDataBind()
        {
            try
            {
                //CompanyID, CompanyName, CompanyName2, Address, ProvinceID, ArchitecName, Phone, Mobile, Email

                ssql = "SELECT	a.ProjectID, a.ProjectYear, a.ProjectMonth, a.ProjectName, a.ArchitecID, a.CompanyID, a.CompanyName, " +
                        "        a.Location, a.ProvinceID, a.ProvinceName, a.MainCons, a.RefRfDf, a.ProductType, a.RefProfile, a.Quantity, a.RefType,  " +
                        "        a.DeliveryDate, a.Drawing, a.ProcID, a.StepID, a.SaleID, a.EmpCode, a.sEmFirstName, a.sEmLastName, a.CreatedDate,  " +
                        "        a.CreatedBy, a.LastedUpdate, a.UpdatedBy, a.StatusConID, b.ConDesc2 " +
                        "FROM    adProjects2 AS a LEFT JOIN " +
                        "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID " +
                        "WHERE  a.StepID in ('sold', 'sos') ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strProjectID = dt.Rows[i]["ProjectID"].ToString();
                        string strProjectYear = dt.Rows[i]["ProjectYear"].ToString();
                        string strProjectMonth = dt.Rows[i]["ProjectMonth"].ToString();
                        string strProjectName = dt.Rows[i]["ProjectName"].ToString();
                        string strArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string strCompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string strCompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string strLocation = dt.Rows[i]["Location"].ToString();
                        string strProvinceID = dt.Rows[i]["ProvinceID"].ToString();
                        string strProvinceName = dt.Rows[i]["ProvinceName"].ToString();
                        string strMainCons = dt.Rows[i]["MainCons"].ToString();
                        string strRefRfDf = dt.Rows[i]["RefRfDf"].ToString();
                        string strProductType = dt.Rows[i]["ProductType"].ToString();
                        string strRefProfile = dt.Rows[i]["RefProfile"].ToString();
                        string strQuantity = dt.Rows[i]["Quantity"].ToString();
                        string strRefType = dt.Rows[i]["RefType"].ToString();
                        string strDeliveryDate = dt.Rows[i]["DeliveryDate"].ToString();
                        string strDrawing = dt.Rows[i]["Drawing"].ToString();
                        string strProcID = dt.Rows[i]["ProcID"].ToString();
                        string strStepID = dt.Rows[i]["StepID"].ToString();
                        string strSaleID = dt.Rows[i]["SaleID"].ToString();
                        string strEmpCode = dt.Rows[i]["EmpCode"].ToString();
                        string strsEmFirstName = dt.Rows[i]["sEmFirstName"].ToString();
                        string strsEmLastName = dt.Rows[i]["sEmLastName"].ToString();
                        string strCreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                        string strCreatedBy = dt.Rows[i]["CreatedBy"].ToString();
                        string strLastedUpdate = dt.Rows[i]["LastedUpdate"].ToString();
                        string strUpdatedBy = dt.Rows[i]["UpdatedBy"].ToString();
                        string strStatusConID = dt.Rows[i]["StatusConID"].ToString();
                        string strConDesc2 = dt.Rows[i]["ConDesc2"].ToString();

                        if (strStatusConID == "0")
                        {
                            strConDesc2 = "<span class=\"text-orange\">" + strConDesc2 + "</span>";
                        }
                        else if (strStatusConID == "1")
                        {
                            strConDesc2 = "<span class=\"text-green\">" + strConDesc2 + "</span>";
                        }
                        else
                        {
                            strConDesc2 = "<span class=\"text-red\">" + strConDesc2 + "</span>";
                        }

                        strTblDetail += "<tr> " +
                                    "     <td>" + strProjectID + "</td> " +
                                    "     <td class=\"hidden\">" + strProjectYear + "</td> " +
                                    "     <td class=\"hidden\">" + strProjectMonth + "</td> " +
                                    "     <td>" + strProjectName + "</td> " +
                                    "     <td class=\"hidden\">" + strArchitecID + "</td> " +
                                    "     <td class=\"hidden\">" + strCompanyID + "</td> " +
                                    "     <td>" + strCompanyName + "</td> " +
                                    "     <td>" + strLocation + "</td> " +
                                    "     <td class=\"hidden\">" + strProvinceID + "</td> " +
                                    "     <td class=\"hidden\">" + strProvinceName + "</td> " +
                                    "     <td class=\"hidden\">" + strMainCons + "</td> " +
                                    "     <td class=\"hidden\">" + strRefRfDf + "</td> " +
                                    "     <td>" + strRefProfile + "</td> " +
                                    "     <td>" + strQuantity + "</td> " +
                                    "     <td class=\"hidden\">" + strRefType + "</td> " +
                                    "     <td>" + strDeliveryDate + "</td> " +
                                    "     <td>" + strProcID + "</td> " +
                                    "     <td>" + strStepID + "</td> " +
                                    "     <td class=\"hidden\">" + strEmpCode + "</td> " +
                                    "     <td class=\"hidden\">" + strsEmFirstName + "</td> " +
                                    "     <td class=\"hidden\">" + strsEmLastName + "</td> " +
                                    "     <td class=\"hidden\">" + strCreatedDate + "</td> " +
                                    "     <td class=\"hidden\">" + strCreatedBy + "</td> " +
                                    "     <td class=\"hidden\">" + strLastedUpdate + "</td> " +
                                    "     <td class=\"hidden\">" + strUpdatedBy + "</td> " +
                                    "     <td class=\"hidden\">" + strStatusConID + "</td> " +
                                    "     <td>" + strConDesc2 + "</td> " +
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

                string strGradeID = Request.Form["txtGradeID"];
                string strGradeDesc = Request.Form["txtGradeDesc"];
                string strGradeDetail = Request.Form["txtGradeDetail"];

                if (strGradeID != "" && strGradeDesc != "")
                {
                    ssql = "insert into adGrade (GradeID, GradeDesc, GradeDetail) " +
                           "values    (@GradeID, @GradeDesc, @GradeDetail)  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@GradeID", SqlDbType.NVarChar).Value = strGradeID;
                    Comm.Parameters.Add("@GradeDesc", SqlDbType.NVarChar).Value = strGradeDesc;
                    Comm.Parameters.Add("@GradeDetail", SqlDbType.NVarChar).Value = strGradeDetail;

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

                string strArchitecID = Request.Form["txtArchitectIDEdit"];
                string strFirstName = Request.Form["txtFirstNameEdit"];
                string strLastName = Request.Form["txtLastNameEdit"];
                string strNickName = Request.Form["txtNickNameEdit"];
                string strPosition = Request.Form["txtPositionEdit"];
                string strAddress = Request.Form["txtAddressEdit"];
                string strPhone = Request.Form["txtPhoneEdit"];
                string strMobile = Request.Form["txtMobileEdit"];
                string strEmail = Request.Form["txtEmailEdit"];

                if (strArchitecID != "")
                {
                    ssql = "update adArchitecture set  ArchitecID=@ArchitecID, FirstName=@FirstName, LastName=@LastName, NickName=@NickName, " +
                           "       Position=@Position, Address=@Address, Phone=@Phone, Mobile=@Mobile, Email=@Email " +
                           "where    ArchitecID=@ArchitecID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ArchitecID", SqlDbType.NVarChar).Value = strArchitecID;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = "";
                    Comm.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = strFirstName;
                    Comm.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = strLastName;
                    Comm.Parameters.Add("@NickName", SqlDbType.NVarChar).Value = strNickName;
                    Comm.Parameters.Add("@Position", SqlDbType.NVarChar).Value = strPosition;
                    Comm.Parameters.Add("@Address", SqlDbType.NVarChar).Value = strAddress;
                    Comm.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = strPhone;
                    Comm.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = strMobile;
                    Comm.Parameters.Add("@Email", SqlDbType.NVarChar).Value = strEmail;
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

                if (strArchitecID != "")
                {
                    ssql = "delete from adArchitecture " +
                           "where    ArchitecID=@ArchitecID  ";

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
                ssql = "SELECT ID, ArchitecID, CompanyID, FirstName, LastName, NickName, Position, Address, Phone, Mobile, Email FROM adArchitecture ";
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
    }
}