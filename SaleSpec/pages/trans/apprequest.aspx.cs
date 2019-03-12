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
    public partial class appsequest : System.Web.UI.Page
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
                //GetInitialData();
            }
        }

        protected void GetInitialData()
        {
            GetCustomerDataBind();
        }

        protected void btnSearch_click(object sender, EventArgs e)
        {
            GetCustomerDataBind();
        }

        protected void GetCustomerDataBind()
        {
            try
            {
                //ssql = "SELECT top 10  CompanyID, CompanyName, CompanyName2, Address, ProvinceID, ContactPerson, Phone, Mobile, Email " +
                //       "FROM    adCompany ";

                int sYear = int.Parse(Convert.ToDateTime(datepickerstart.Value).ToString("yyyy"));
                int sMonth = int.Parse(Convert.ToDateTime(datepickerstart.Value).ToString("MM"));

                int eYear = int.Parse(Convert.ToDateTime(datepickerend.Value).ToString("yyyy"));
                int eMonth = int.Parse(Convert.ToDateTime(datepickerend.Value).ToString("MM"));

                ssql = "SELECT  ProjectID, ProjectYear, ProjectMonth, ProjectName, CompanyName, Location, MainCons, RefRfDf, " +
                       "        ProjStep, ProductType, RefProfile, Quantity, RefType, DeliveryDate, Drawing, Status, TypeID, SaleSpec " +
                       "FROM    adProjects " +
                       "WHERE (ProjectYear >='" + sYear + "' and ProjectMonth >= '" + sMonth + "') and  (ProjectYear <='" + eYear + "' and ProjectMonth <= '" + eMonth + "') ";

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
                        string strCompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string strLocation = dt.Rows[i]["Location"].ToString();
                        string strTypeID = dt.Rows[i]["TypeID"].ToString();
                        string strSaleSpec = dt.Rows[i]["SaleSpec"].ToString();
                        string strStatus = dt.Rows[i]["Status"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td> </td> " +
                                        "     <td> </td> " +
                                        "     <td> </td> " +
                                        "     <td>" + strProjectID + "</td> " +
                                        "     <td>" + strProjectYear + "</td> " +
                                        "     <td>" + strProjectMonth + "</td> " +
                                        "     <td>" + strProjectName + "</td> " +
                                        "     <td>" + strCompanyName + "</td> " +
                                        "     <td>" + strLocation + "</td> " +
                                        "     <td>" + strTypeID + "</td> " +
                                        "     <td>" + strSaleSpec + "</td> " +
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