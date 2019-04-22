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
using System.Net.NetworkInformation;

namespace SaleSpec
{
    public partial class _default : System.Web.UI.Page
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

        public string strCountProjects = "";
        public string strCountProjectsYear = "";
        public string strCountCompany = "";
        public string strCountSaleSpec = "";
        public string strCountArchitect = "";

        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            //string strUserID = Session["UserID"].ToString();
            if (Session["UserID"] == null)
            {
                Response.Redirect("../pages/users/login");
            }

            //Session["EmpCode"] ;
            //Session["Password"] ;
            //Session["id"];
            //Session["sEmpID"] ;
            //Session["sEmpOrgLevel2"];
            //Session["sEmpNamePrefix"];
            //Session["sEmpFirstName"];
            //Session["sEmpLastName"];
            //Session["sEmpEngNamePrefix"] ;
            //Session["sEmpEngFirstName"];
            //Session["sEmpEngLastName"];
            //Session["sEmpNickName"] ;

            if (!IsPostBack)
            {
                GetInitialData();
                GetMACAddress();
            }
        }


        public void GetMACAddress()
        {
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            String sMacAddress = string.Empty;
            foreach (NetworkInterface adapter in nics)
            {
                if (sMacAddress == String.Empty)// only return MAC Address from first card  
                {
                    IPInterfaceProperties properties = adapter.GetIPProperties();
                    sMacAddress = adapter.GetPhysicalAddress().ToString();
                }
            }
            txtMacAddress.Text = sMacAddress;
        }

        protected void GetCountProjects()
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("GetDashboardCountProjects", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    strCountProjects = dt.Rows[0]["CountProject"].ToString();
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }

        protected void GetCountProjectsYear(int iyear)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("GetDashboardCountProjectsYear", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@CurrentYear", iyear);
                
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    strCountProjectsYear = dt.Rows[0]["CountProject"].ToString();
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }

        protected void GetCountCopany()
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("GetDashboardCountCompany", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    strCountCompany = dt.Rows[0]["CountCompany"].ToString();
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }

        protected void GetCountSaleSpec()
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("GetDashboardCountSaleSpec", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    strCountSaleSpec = dt.Rows[0]["CountSaleSpec"].ToString();
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }

        protected void GetCountArchitect()
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("GetDashboardCountArchitect", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = Comm;

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    strCountArchitect = dt.Rows[0]["CountArchitect"].ToString();
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }
        protected void GetInitialData()
        {
            //GetTransArchitectDataBind();
            GetCountProjects();
            GetCountProjectsYear(int.Parse(DateTime.Now.ToString("yyyy")));
            GetCountCopany();
            GetCountSaleSpec();
            GetCountArchitect();
        }

        protected void GetTransArchitectDataBind()
        {
            try
            {
                ssql = "SELECT TransID, CustTypeID, GradeID, CustomerID, CustomerName, CustomerName2, Address, " +
                       "        ProvinceID, ContactPerson, Phone, Mobile, Email, ArchitecID, ArchitecName, NickName, Position, Status, Spec " +
                       "FROM    tsTransSaleSpec ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strTransID = dt.Rows[i]["TransID"].ToString();
                        string strCustTypeID = dt.Rows[i]["CustTypeID"].ToString();
                        string strGradeID = dt.Rows[i]["GradeID"].ToString();
                        string strCustomerID = dt.Rows[i]["CustomerID"].ToString();
                        string strCustomerName = dt.Rows[i]["CustomerName"].ToString();
                        string strCustomerName2 = dt.Rows[i]["CustomerName2"].ToString();
                        string strAddress = dt.Rows[i]["Address"].ToString();
                        string strProvinceID = dt.Rows[i]["ProvinceID"].ToString();
                        string strContactPerson = dt.Rows[i]["ContactPerson"].ToString();
                        string strPhone = dt.Rows[i]["Phone"].ToString();
                        string strMobile = dt.Rows[i]["Mobile"].ToString();
                        string strEmail = dt.Rows[i]["Email"].ToString();
                        string strArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string strArchitecName = dt.Rows[i]["ArchitecName"].ToString();
                        string strNickName = dt.Rows[i]["NickName"].ToString();
                        string strPosition = dt.Rows[i]["Position"].ToString();
                        string strStatus = dt.Rows[i]["Status"].ToString();
                        string strSpec = dt.Rows[i]["Spec"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td>" + strTransID + "</td> " +
                                        "     <td>" + strCustTypeID + "</td> " +
                                        "     <td>" + strGradeID + "</td> " +
                                        "     <td>" + strCustomerID + "</td> " +
                                        "     <td>" + strCustomerName + "</td> " +
                                        "     <td class=\"hidden\">" + strCustomerName2 + "</td> " +
                                        "     <td class=\"hidden\">" + strAddress + "</td> " +
                                        "     <td class=\"hidden\">" + strProvinceID + "</td> " +
                                        "     <td>" + strContactPerson + "</td> " +
                                        "     <td>" + strPhone + "</td> " +
                                        "     <td>" + strMobile + "</td> " +
                                        "     <td class=\"hidden\">" + strEmail + "</td> " +
                                        "     <td>" + strArchitecID + "</td> " +
                                        "     <td>" + strArchitecName + "</td> " +
                                        "     <td class=\"hidden\">" + strPosition + "</td> " +
                                        "     <td class=\"hidden\">" + strStatus + "</td> " +
                                        "     <td>" + strSpec + "</td> " +
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
                ssql = "SELECT TransID, CustTypeID, GradeID, CustomerID, CustomerName, CustomerName2, Address, " +
                      "        ProvinceID, ContactPerson, Phone, Mobile, Email, ArchitecID, ArchitecName, NickName, Position, Status, Spec " +
                      "FROM    tsTransSaleSpec ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=AllTransArchitectExport.xls");
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