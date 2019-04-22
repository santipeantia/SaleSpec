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
    public partial class customertype : System.Web.UI.Page
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
            GetCustTypeDataBind();
            GetCustStatusDataBind();
        }

        protected void GetCustTypeDataBind()
        {
            try
            {
                ssql = "sp_adCustomerType";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Warning Alert...." + dt.Rows.Count + "');", true);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strCustID = dt.Rows[i]["CustTypeID"].ToString();
                        string strCusDesc = dt.Rows[i]["CustTypeDesc"].ToString();
                        string strCustStatusID = dt.Rows[i]["CustStatusID"].ToString();
                        string strStatusDesc = dt.Rows[i]["StatusDesc"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td>" + strCustID + "</td> " +
                                        "     <td>" + strCusDesc + "</td> " +
                                        "     <td class=\"hide\">" + strCustStatusID + "</td> " +
                                        "     <td>" + strStatusDesc + "</td> " +
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

        protected void GetCustStatusDataBind()
        {
            try
            {
                ssql = "sp_adCustomerTypeStatus";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;
                
                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strCustStatusID = dt.Rows[i]["CustStatusID"].ToString();
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

        protected void btnSaveNewCustomer_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strtxtCustomerID = Request.Form["txtCustomerID"];
                string strtxtCustTypeDescNew = Request.Form["txtCustTypeDescNew"];
                string strtxtStatusIDNew = Request.Form["txtStatusIDNew"];
                string strtxtStatusNew = Request.Form["txtStatusNew"];

                if (strtxtCustomerID != "" && strtxtCustTypeDescNew != "" && strtxtStatusIDNew != "" && strtxtStatusNew != "")
                {
                    ssql = "insert into adCustomerType (CustTypeID, CustTypeDesc, CustStatusID, IsActive) " +
                           "values (@CustTypeID, @CustTypeDesc, @CustStatusID, @IsActive) ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@CustTypeID", SqlDbType.NVarChar).Value = strtxtCustomerID;
                    Comm.Parameters.Add("@CustTypeDesc", SqlDbType.NVarChar).Value = strtxtCustTypeDescNew;
                    Comm.Parameters.Add("@CustStatusID", SqlDbType.NVarChar).Value = strtxtStatusIDNew;
                    Comm.Parameters.Add("@IsActive", SqlDbType.Bit).Value = true;
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
                             "      <strong>ข้อผิดพลาด..!</strong> ตรวจพบข้อมูลรายการมีอยู่ในระบบเรียบร้อยแล้ว...! <br/>" + ex.Message + " " +
                             "</div>";
                GetInitialData();
                return;
            }
        }

        protected void btnUpdateCustomer_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strtxtCustomerIDEdit = Request.Form["txtCustomerIDEdit"];
                string strtxtCustTypeDesc = Request.Form["txtCustTypeDesc"];
                string strtxtStatusID = Request.Form["txtStatusID"];
                string strtxtStatusEdit = Request.Form["txtStatusEdit"];

                if (strtxtCustomerIDEdit != "" && strtxtCustTypeDesc != "" && strtxtStatusID != "" && strtxtStatusEdit != "")
                {
                    ssql = "update adCustomerType set  CustTypeID=@CustTypeID, CustTypeDesc=@CustTypeDesc, CustStatusID=@CustStatusID, IsActive=@IsActive " +
                           "where    CustTypeID=@CustTypeID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@CustTypeID", SqlDbType.NVarChar).Value = strtxtCustomerIDEdit;
                    Comm.Parameters.Add("@CustTypeDesc", SqlDbType.NVarChar).Value = strtxtCustTypeDesc;
                    Comm.Parameters.Add("@CustStatusID", SqlDbType.NVarChar).Value = strtxtStatusID;
                    Comm.Parameters.Add("@IsActive", SqlDbType.Bit).Value = true;
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

        protected void btnDeleteCustomer_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strtxtCustomerIDDelete = Request.Form["txtCustomerIDDelete"];


                if (strtxtCustomerIDDelete != "")
                {
                    ssql = "delete adCustomerType " +
                           "where    CustTypeID=@CustTypeID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@CustTypeID", SqlDbType.NVarChar).Value = strtxtCustomerIDDelete;
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
                ssql = "sp_adCustomerType";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

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