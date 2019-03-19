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

namespace SaleSpec.pages.masters
{
    public partial class projectsetup : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetInitialData();
            }
        }

        protected void GetInitialData()
        {
            GetCompanyDataBind();
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

        protected void GetCompanyDataBind()
        {
            try
            {
                //CompanyID, CompanyName, CompanyName2, Address, ProvinceID, ArchitecName, Phone, Mobile, Email

                ssql = "SELECT	a.ProjectID, a.ProjectYear, a.ProjectMonth, a.ProjectName, a.ArchitecID, a.CompanyID, a.CompanyName, " +
                        "        a.Location, a.ProvinceID, a.ProvinceName, a.MainCons, a.RefRfDf, a.ProductType, a.RefProfile, a.Quantity, a.RefType,  " +
                        "        a.DeliveryDate, a.Drawing, a.ProcID, a.StepID, a.SaleID, a.EmpCode, a.sEmFirstName, a.sEmLastName, a.CreatedDate,  " +
                        "        a.CreatedBy, a.LastedUpdate, a.UpdatedBy, a.StatusConID, b.ConDesc2 " +
                        "FROM    adProjects2 AS a LEFT JOIN " +
                        "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID";
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
                        else {
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

                string strGradeIDEdit = Request.Form["txtGradeIDEdit"];
                string strGradeDescEdit = Request.Form["txtGradeDescEdit"];
                string strGradeDetailEdit = Request.Form["txtGradeDetailEdit"];

                if (strGradeIDEdit != "" && strGradeDescEdit != "")
                {
                    ssql = "update adGrade set  GradeID=@GradeID, GradeDesc=@GradeDesc, GradeDetail=@GradeDetail " +
                           "where    GradeID=@GradeID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@GradeID", SqlDbType.NVarChar).Value = strGradeIDEdit;
                    Comm.Parameters.Add("@GradeDesc", SqlDbType.NVarChar).Value = strGradeDescEdit;
                    Comm.Parameters.Add("@GradeDetail", SqlDbType.NVarChar).Value = strGradeDetailEdit;

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

                string strGradeIDDelete = Request.Form["txtGradeIDDelete"];
                //string strGradeDescEdit = Request.Form["txtGradeDescDelete"];
                //string strGradeDetailEdit = Request.Form["txtGradeDetailDelete"];

                if (strGradeIDDelete != "")
                {
                    ssql = "delete from adGrade " +
                           "where    GradeID=@GradeID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@GradeID", SqlDbType.NVarChar).Value = strGradeIDDelete;
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
                ssql = "SELECT CustomerID, CustomerName, CustomerName2, Address, ProvinceID, ContactPerson, Phone, Mobile, Email " +
                      "FROM    adCustomers ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=CustomerExport.xls");
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