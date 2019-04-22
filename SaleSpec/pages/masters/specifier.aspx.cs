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
    public partial class specifier : System.Web.UI.Page
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
                
                ssql = "SELECT StatusID, StatusDesc, StatusDetails FROM adSystemStatus ";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strCustStatusID = dt.Rows[i]["StatusID"].ToString();
                        string strStatusDesc = dt.Rows[i]["StatusDesc"].ToString();
                        string strStatusDetails = dt.Rows[i]["StatusDetails"].ToString();

                        strTblActive += "<tr> " +
                                        "     <td>" + strCustStatusID + "</td> " +
                                        "     <td>" + strStatusDesc + "</td> " +
                                        "     <td>" + strStatusDetails + "</td> " +
                                        "<td style=\"width: 20px; text-align: center;\"> " +
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
                ssql = "SELECT SpecID, SpecTitle, SpecName, SpecLastname, EmpCode, SpecDesc, isActive, CreatedBy, CreateDate " +
                       "FROM    adSpecPerson ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strSpecID = dt.Rows[i]["SpecID"].ToString();
                        string strSpecTitle = dt.Rows[i]["SpecTitle"].ToString();
                        string strSpecName = dt.Rows[i]["SpecName"].ToString();
                        string strSpecLastname = dt.Rows[i]["SpecLastname"].ToString();
                        string strEmpCode = dt.Rows[i]["EmpCode"].ToString();
                        string strSpecDesc = dt.Rows[i]["SpecDesc"].ToString();
                        string strisActive = dt.Rows[i]["isActive"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td>" + strSpecID + "</td> " +
                                        "     <td>" + strSpecTitle + "</td> " +
                                        "     <td>" + strSpecName + "</td> " +
                                        "     <td>" + strSpecLastname + "</td> " +
                                        "     <td>" + strSpecDesc + "</td> " +
                                        "     <td class=\"hidden\">" + strEmpCode + "</td> " +
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

                string strSpecID = Request.Form["txtSpecID"];
                string strSpecTitle = Request.Form["txtTitle"];
                string strSpecName = Request.Form["txtFirstName"];
                string strSpecLastname = Request.Form["txtLastName"];
                string strEmpCode = Request.Form["txtEmpCode"];
                string strSpecDesc = Request.Form["txtSpecDesc"];
                string strisActive = Request.Form["txtStatusID"];
                string strCreatedBy = "SANTI";   //Request.Form["CreatedBy"];
                string strCreateDate = DateTime.Now.ToString("yyyy-MM-dd"); //Request.Form["CreateDate"];

                if (strisActive == "")
                {
                    strisActive = "1";
                }

                if (strSpecID != "" && strSpecName != "")
                {
                    ssql = "Insert into  adSpecPerson (SpecID, SpecTitle, SpecName, SpecLastname, EmpCode, SpecDesc, isActive, CreatedBy, CreateDate) " +
                           "Values (@SpecID, @SpecTitle, @SpecName, @SpecLastname, @EmpCode, @SpecDesc, @isActive, @CreatedBy, @CreateDate) ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@SpecID", SqlDbType.NVarChar).Value = strSpecID;
                    Comm.Parameters.Add("@SpecTitle", SqlDbType.NVarChar).Value = strSpecTitle;
                    Comm.Parameters.Add("@SpecName", SqlDbType.NVarChar).Value = strSpecName;
                    Comm.Parameters.Add("@SpecLastname", SqlDbType.NVarChar).Value = strSpecLastname;
                    Comm.Parameters.Add("@EmpCode", SqlDbType.NVarChar).Value = strEmpCode;
                    Comm.Parameters.Add("@SpecDesc", SqlDbType.NVarChar).Value = strSpecDesc;
                    Comm.Parameters.Add("@isActive", SqlDbType.NVarChar).Value = strisActive;
                    Comm.Parameters.Add("@CreatedBy", SqlDbType.NVarChar).Value = strCreatedBy;
                    Comm.Parameters.Add("@CreateDate", SqlDbType.NVarChar).Value = strCreateDate;
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

                string strSpecID = Request.Form["txtSpecIDEdit"];
                string strSpecTitle = Request.Form["txtTitleEdit"];
                string strSpecName = Request.Form["txtFirstNameEdit"];
                string strSpecLastname = Request.Form["txtLastNameEdit"];
                string strEmpCode = Request.Form["txtEmpCodeEdit"];
                string strSpecDesc = Request.Form["txtSpecDescEdit"];
                string strisActive = Request.Form["txtStatusIDEdit"];
                string strCreatedBy = "SANTI";   //Request.Form["CreatedBy"];
                string strCreateDate = DateTime.Now.ToString("yyyy-MM-dd"); //Request.Form["CreateDate"];

                if (strisActive == "")
                {
                    strisActive = "1";
                }

                if (strSpecID != "" && strSpecName != "")
                {
                    ssql = "Update adSpecPerson set SpecID=@SpecID, SpecTitle=@SpecTitle, SpecName=@SpecName, SpecLastname=@SpecLastname, EmpCode=@EmpCode, SpecDesc=@SpecDesc, isActive=@isActive, CreatedBy=@CreatedBy, CreateDate=@CreateDate  " +
                           "where SpecID=@SpecID ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@SpecID", SqlDbType.NVarChar).Value = strSpecID;
                    Comm.Parameters.Add("@SpecTitle", SqlDbType.NVarChar).Value = strSpecTitle;
                    Comm.Parameters.Add("@SpecName", SqlDbType.NVarChar).Value = strSpecName;
                    Comm.Parameters.Add("@SpecLastname", SqlDbType.NVarChar).Value = strSpecLastname;
                    Comm.Parameters.Add("@EmpCode", SqlDbType.NVarChar).Value = strEmpCode;
                    Comm.Parameters.Add("@SpecDesc", SqlDbType.NVarChar).Value = strSpecDesc;
                    Comm.Parameters.Add("@isActive", SqlDbType.NVarChar).Value = strisActive;
                    Comm.Parameters.Add("@CreatedBy", SqlDbType.NVarChar).Value = strCreatedBy;
                    Comm.Parameters.Add("@CreateDate", SqlDbType.NVarChar).Value = strCreateDate;
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

                string strSpecID = Request.Form["txtSpecIDDel"];

                if (strSpecID != "")
                {
                    ssql = "Delete from adSpecPerson where SpecID=@SpecID ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
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