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
    public partial class productgroup : System.Web.UI.Page
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

        public string sPage = "masters/productgroup";

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
            GetDataBindProduct();
            //GetCustStatusDataBind();
        }

        protected void GetDataBindProduct()
        {
            try
            {
                ssql = "sp_GetProductData";

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
                        string strProdID = dt.Rows[i]["ProdID"].ToString();
                        string strProdTypeID = dt.Rows[i]["ProdTypeID"].ToString();
                        string strProdTypeNameEN = dt.Rows[i]["ProdTypeNameEN"].ToString();
                        string strProdNameTH = dt.Rows[i]["ProdNameTH"].ToString();
                        string strProdNameEN = dt.Rows[i]["ProdNameEN"].ToString();
                        string strProdDesc = dt.Rows[i]["ProdDesc"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td class=\"hide\">" + strProdID + "</td> " +
                                        "     <td class=\"hide\">" + strProdTypeID + "</td> " +
                                        "     <td>" + strProdTypeNameEN + "</td> " +
                                        "     <td>" + strProdNameTH + "</td> " +
                                        "     <td>" + strProdNameEN + "</td> " +
                                        "     <td>" + strProdDesc + "</td> " +
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

        protected void btnSaveNewCustomer_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strtxtProdID = Request.Form["txtProdID"];
                string strselectProductType = Request.Form["selectProductType"];
                string strtxtProdNameTH = Request.Form["txtProdNameTH"];
                string strtxtProdNameEN = Request.Form["txtProdNameEN"];
                string strtxtProdDesc = Request.Form["txtProdDesc"];

                if (strselectProductType != "" && strtxtProdNameTH != "" && strtxtProdNameEN != "")
                {
                    ssql = "insert into adProducts  (ProdTypeID, ProdNameTH, ProdNameEN, ProdDesc) " +
                           "values (@ProdTypeID, @ProdNameTH, @ProdNameEN, @ProdDesc)  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ProdTypeID", SqlDbType.NVarChar).Value = strselectProductType;
                    Comm.Parameters.Add("@ProdNameTH", SqlDbType.NVarChar).Value = strtxtProdNameTH;
                    Comm.Parameters.Add("@ProdNameEN", SqlDbType.NVarChar).Value = strtxtProdNameEN;
                    Comm.Parameters.Add("@ProdDesc", SqlDbType.NVarChar).Value = strtxtProdDesc;
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

                string strtxtProdID = Request.Form["txtProdIDEdit"];
                string strselectProductType = Request.Form["selectProductTypeEdit"];
                string strtxtProdNameTH = Request.Form["txtProdNameTHEdit"];
                string strtxtProdNameEN = Request.Form["txtProdNameENEdit"];
                string strtxtProdDesc = Request.Form["txtProdDescEdit"];

                if (strselectProductType != "" && strtxtProdNameTH != "" && strtxtProdNameEN != "")
                {
                    ssql = "update adProducts  set ProdTypeID=@ProdTypeID, ProdNameTH=@ProdNameTH, ProdNameEN=@ProdNameEN, ProdDesc=@ProdDesc " +
                           "where ProdID=@ProdID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ProdID", SqlDbType.NVarChar).Value = strtxtProdID;
                    Comm.Parameters.Add("@ProdTypeID", SqlDbType.NVarChar).Value = strselectProductType;
                    Comm.Parameters.Add("@ProdNameTH", SqlDbType.NVarChar).Value = strtxtProdNameTH;
                    Comm.Parameters.Add("@ProdNameEN", SqlDbType.NVarChar).Value = strtxtProdNameEN;
                    Comm.Parameters.Add("@ProdDesc", SqlDbType.NVarChar).Value = strtxtProdDesc;
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

                string strtxtProdID = Request.Form["txtProdIDDel"];

                if (strtxtProdID != "" )
                {
                    ssql = "delete from adProducts  where ProdID=@ProdID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ProdID", SqlDbType.NVarChar).Value = strtxtProdID;
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
                ssql = "sp_GetProductData";

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
                    Response.AddHeader("content-disposition", "attachment;filename=ProductsExport.xls");
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