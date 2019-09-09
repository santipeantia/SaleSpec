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
        ReportDocument rpt = new ReportDocument();

        public string sPage = "masters/projectsetup";

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
            GetProjectDataBind();
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

        protected void GetProjectDataBind()
        {
            try
            {
                //ssql = "SELECT		a.ProjectID, a.ProjectYear, a.ProjectMonth, a.ProjectName, a.CompanyID, a.CompanyName, " +
                //        "            a.ArchitecID, a.Name, a.Location, a.MainCons, a.RefRfDf, a.ProjStep, b.StepNameEn,  " +
                //        "            a.ProductType, a.RefProfile, a.ProdTypeID,  a.ProdTypeNameEN, a.ProdID, a.ProdNameEN,  " +
                //        "            a.ProfID, a.ProfNameEN, a.StatusID, a.StatusNameEn, a.Quantity, a.RefType, a.DeliveryDate,  " +
                //        "            a.Drawing, a.TypeID, a.SaleSpec, a.StatusConID, c.ConDesc2, a.CreatedDate, a.LastUpdate " +
                //        "FROM        adProjects AS a LEFT JOIN " +
                //        "            adStep AS b ON a.ProjStep = b.StepID left join " +
                //        "            adStatusConfirm AS c ON a.StatusConID = c.StatusConID";

                ssql = "spGetProjectsList";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                //dt = new DataTable();
                //dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strProjectID = dt.Rows[i]["ProjectID"].ToString();
                        string strProjectYear = dt.Rows[i]["ProjectYear"].ToString();
                        string strProjectMonth = dt.Rows[i]["ProjectMonth"].ToString();
                        string strProjectName = dt.Rows[i]["ProjectName"].ToString();
                        string strCompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string strCompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string strArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string strName = dt.Rows[i]["Name"].ToString();
                        string strLocation = dt.Rows[i]["Location"].ToString();
                        string strMainCons = dt.Rows[i]["MainCons"].ToString();
                        string strRefRfDf = dt.Rows[i]["RefRfDf"].ToString();
                        string strProjStep = dt.Rows[i]["ProjStep"].ToString();
                        string strStepNameEn = dt.Rows[i]["StepNameEn"].ToString();
                        string strProductType = dt.Rows[i]["ProductType"].ToString();
                        string strRefProfile = dt.Rows[i]["RefProfile"].ToString();
                        string strProdTypeID = dt.Rows[i]["ProdTypeID"].ToString();
                        string strProdTypeNameEN = dt.Rows[i]["ProdTypeNameEN"].ToString();
                        string strProdID = dt.Rows[i]["ProdID"].ToString();
                        string strProdNameEN = dt.Rows[i]["ProdNameEN"].ToString();
                        string strProfID = dt.Rows[i]["ProfID"].ToString();
                        string strProfNameEN = dt.Rows[i]["ProfNameEN"].ToString();
                        string strStatusID = dt.Rows[i]["StatusID"].ToString();
                        string strStatusNameEn = dt.Rows[i]["StatusNameEn"].ToString();
                        string strQuantity = dt.Rows[i]["Quantity"].ToString();
                        string strRefType = dt.Rows[i]["RefType"].ToString();
                        string strDeliveryDate = dt.Rows[i]["DeliveryDate"].ToString();
                        string strDrawing = dt.Rows[i]["Drawing"].ToString();
                        string strTypeID = dt.Rows[i]["TypeID"].ToString();
                        string strSaleSpec = dt.Rows[i]["SaleSpec"].ToString();
                        string strStatusConID = dt.Rows[i]["StatusConID"].ToString();
                        string strCreatedDate = dt.Rows[i]["CreatedDate"].ToString();
                        string strLastUpdate = dt.Rows[i]["LastUpdate"].ToString();
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
                                        "     <td class=\"hidden\">" + strMainCons + "</td> " +
                                        "     <td class=\"hidden\">" + strRefRfDf + "</td> " +

                                        "     <td class=\"hidden\">" + strProjStep + "</td> " +
                                        "     <td>" + strStepNameEn + "</td> " +

                                        "     <td class=\"hidden\">" + strProdTypeID + "</td> " +
                                        "     <td>" + strProdTypeNameEN + "</td> " +
                                        "     <td class=\"hidden\">" + strProdID + "</td> " +
                                        "     <td>" + strProdNameEN + "</td> " +

                                        "     <td>" + strRefProfile + "</td> " +
                                        "     <td>" + strQuantity + "</td> " +
                                        "     <td>" + strDeliveryDate + "</td> " +
                                        "     <td class=\"hidden\">" + strStatusID + "</td> " +
                                        "     <td>" + strStatusNameEn + "</td> " +
                                        "     <td>" + strTypeID + "</td> " +
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
                string strProjecID = "";
                ssql = "spGetCountProject";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                DataTable dtCount = new DataTable();
                da.Fill(dtCount);
                if (dtCount.Rows.Count != 0)
                {
                    strProjecID = dtCount.Rows[0]["ProjectID"].ToString();
                }
                Conn.Close();

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                transac = Conn.BeginTransaction();

                string strProjectID = strProjecID; // Request.Form["ProjectID"];
                string strProjectYear = DateTime.Now.ToString("yyyy"); //Request.Form["ProjectYear"];
                string strProjectMonth = DateTime.Now.ToString("MM");  //Request.Form["ProjectMonth"];

                string strProjectName = Request.Form["ProjectName"];
                string strselectCompanyID = Request.Form["selectCompanyID"];
                string strselectCompanyName = Request.Form["CompanyName"];
                string strselectArchitecID = Request.Form["selectArchitecID"];
                string strselectArchitecName = Request.Form["ArchitecName"];

                string strLocation = Request.Form["Location"];
                string strMainCons = Request.Form["MainCons"];
                string strRefRfDf = Request.Form["RefRfDf"];
                string strselectProjStep = Request.Form["selectProjStep"];
                string strselectProjStepName = Request.Form["ProjStepName"];

                string strselectTypeID = Request.Form["selectTypeID"];
                string strselectTypeName = Request.Form["TypeName"];

                string strselectProdTypeID = Request.Form["selectProdTypeID"];
                string strselectProdTypeName = Request.Form["ProductTypeName"];

                string strselectProdID = Request.Form["selectProdID"];
                string strselectProdName = Request.Form["ProductName"];
                string strProfID = Request.Form["ProfID"];

                string strQuantity = Request.Form["Quantity"];
                string strdatepickerdelivery = Request.Form["datepickerdelivery"];
                string strselectStatusConID =  Request.Form["selectStatusConID"];
                string selectStatusID = Request.Form["selectStatusID"];
                string txtStatusNameEn = Request.Form["txtStatusID"];

                if (strProjectID != "" && strProjectName != "")
                {
                    ssql = "insert into adProjects (ProjectID, ProjectYear, ProjectMonth, ProjectName, CompanyID, CompanyName, " +
                            "   ArchitecID, Name, Location, MainCons, RefRfDf, ProjStep, ProductType, RefProfile, ProdTypeID, " +
                            "   ProdTypeNameEN, ProdID, ProdNameEN, ProfID, ProfNameEN, StatusID, StatusNameEn, Quantity, RefType, " +
                            "   DeliveryDate, Drawing, TypeID, SaleSpec, StatusConID, CreatedDate, LastUpdate) " +
                           "values    (@ProjectID, @ProjectYear, @ProjectMonth, @ProjectName, @CompanyID, @CompanyName, " +
                            "   @ArchitecID, @Name, @Location, @MainCons, @RefRfDf, @ProjStep, @ProductType, @RefProfile, @ProdTypeID, " +
                            "   @ProdTypeNameEN, @ProdID, @ProdNameEN, @ProfID, @ProfNameEN, @StatusID, @StatusNameEn, @Quantity, @RefType, " +
                            "   @DeliveryDate, @Drawing, @TypeID, @SaleSpec, @StatusConID, @CreatedDate, @LastUpdate)  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ProjectID", SqlDbType.NVarChar).Value = strProjectID;
                    Comm.Parameters.Add("@ProjectYear", SqlDbType.NVarChar).Value = strProjectYear;
                    Comm.Parameters.Add("@ProjectMonth", SqlDbType.NVarChar).Value = strProjectMonth;
                    Comm.Parameters.Add("@ProjectName", SqlDbType.NVarChar).Value = strProjectName;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = strselectCompanyID;
                    Comm.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = strselectCompanyName;
                    Comm.Parameters.Add("@ArchitecID", SqlDbType.NVarChar).Value = strselectArchitecID;
                    Comm.Parameters.Add("@Name", SqlDbType.NVarChar).Value = strselectArchitecName;
                    Comm.Parameters.Add("@Location", SqlDbType.NVarChar).Value = strLocation;
                    Comm.Parameters.Add("@MainCons", SqlDbType.NVarChar).Value = strMainCons;
                    Comm.Parameters.Add("@RefRfDf", SqlDbType.NVarChar).Value = strRefRfDf;
                    Comm.Parameters.Add("@ProjStep", SqlDbType.NVarChar).Value = strselectProjStep;
                    Comm.Parameters.Add("@ProductType", SqlDbType.NVarChar).Value = strselectProdTypeID;
                    Comm.Parameters.Add("@RefProfile", SqlDbType.NVarChar).Value = strProfID;
                    Comm.Parameters.Add("@ProdTypeID", SqlDbType.NVarChar).Value = strselectProdTypeID;
                    Comm.Parameters.Add("@ProdTypeNameEN", SqlDbType.NVarChar).Value = strselectProdTypeName;
                    Comm.Parameters.Add("@ProdID", SqlDbType.NVarChar).Value = strselectProdID;
                    Comm.Parameters.Add("@ProdNameEN", SqlDbType.NVarChar).Value = strselectProdName;
                    Comm.Parameters.Add("@ProfID", SqlDbType.NVarChar).Value = strProfID;
                    Comm.Parameters.Add("@ProfNameEN", SqlDbType.NVarChar).Value = strProfID;
                    Comm.Parameters.Add("@StatusID", SqlDbType.NVarChar).Value = selectStatusID;
                    Comm.Parameters.Add("@StatusNameEn", SqlDbType.NVarChar).Value = txtStatusNameEn; //project step name
                    Comm.Parameters.Add("@Quantity", SqlDbType.NVarChar).Value = strQuantity;
                    Comm.Parameters.Add("@RefType", SqlDbType.NVarChar).Value = DBNull.Value;
                    Comm.Parameters.Add("@DeliveryDate", SqlDbType.NVarChar).Value = strdatepickerdelivery;
                    Comm.Parameters.Add("@Drawing", SqlDbType.NVarChar).Value = DBNull.Value;
                    Comm.Parameters.Add("@TypeID", SqlDbType.NVarChar).Value = strselectTypeID;
                    Comm.Parameters.Add("@SaleSpec", SqlDbType.NVarChar).Value = strselectTypeName.Replace("[" + strselectTypeID + "] ", "");
                    Comm.Parameters.Add("@StatusConID", SqlDbType.NVarChar).Value = strselectStatusConID;
                    Comm.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
                    Comm.Parameters.Add("@LastUpdate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
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

                string strProjectID =  Request.Form["ProjectIDEdit"];
                string strProjectName = Request.Form["ProjectNameEdit"];
                string strselectCompanyID = Request.Form["selectCompanyIDEdit"];
                string strselectCompanyName = Request.Form["CompanyNameEdit"];
                string strselectArchitecID = Request.Form["selectArchitecIDEdit"];
                string strselectArchitecName = Request.Form["ArchitecNameEdit"];
                string strLocation = Request.Form["LocationEdit"];
                string strMainCons = Request.Form["MainConsEdit"];
                string strRefRfDf = Request.Form["RefRfDfEdit"];
                string strselectProjStep = Request.Form["selectProjStepEdit"];
                string strselectProjStepName = Request.Form["ProjStepNameEdit"];
                string strselectTypeID = Request.Form["selectTypeIDEdit"];
                string strselectTypeName = Request.Form["TypeNameEdit"];
                string strselectProdTypeID = Request.Form["selectProdTypeIDEdit"];
                string strselectProdTypeName = Request.Form["ProductTypeNameEdit"];
                string strselectProdID = Request.Form["selectProdIDEdit"];
                string strselectProdName = Request.Form["ProductNameEdit"];
                string strProfID = Request.Form["ProfIDEdit"];
                string strQuantity = Request.Form["QuantityEdit"];
                string strdatepickerdelivery = Request.Form["datepickerdeliveryEdit"];
                string strselectStatusConID = Request.Form["selectStatusConIDEdit"];
                string selectStatusID = Request.Form["selectStatusIDEdit"];
                string txtStatusNameEn = Request.Form["txtStatusIDEdit"];

                if (strProjectID != "" && strProjectName != "")
                {
                    ssql = "update adProjects set ProjectID=@ProjectID, ProjectName=@ProjectName, CompanyID=@CompanyID, CompanyName=@CompanyName, " +
                            "   ArchitecID=@ArchitecID, Name=@Name, Location=@Location, MainCons=@MainCons, RefRfDf=@RefRfDf, ProjStep=@ProjStep, ProductType=@ProductType, RefProfile=@RefProfile, ProdTypeID=@ProdTypeID, " +
                            "   ProdTypeNameEN=@ProdTypeNameEN, ProdID=@ProdID, ProdNameEN=@ProdNameEN, ProfID=@ProfID, ProfNameEN=@ProfNameEN, StatusID=@StatusID, StatusNameEn=@StatusNameEn, Quantity=@Quantity, RefType=@RefType, " +
                            "   DeliveryDate=@DeliveryDate, Drawing=@Drawing, TypeID=@TypeID, SaleSpec=@SaleSpec, StatusConID=@StatusConID, LastUpdate=@LastUpdate  " +
                           "where    ProjectID=@ProjectID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ProjectID", SqlDbType.NVarChar).Value = strProjectID;
                    Comm.Parameters.Add("@ProjectName", SqlDbType.NVarChar).Value = strProjectName;
                    Comm.Parameters.Add("@CompanyID", SqlDbType.NVarChar).Value = strselectCompanyID;
                    Comm.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = strselectCompanyName;
                    Comm.Parameters.Add("@ArchitecID", SqlDbType.NVarChar).Value = strselectArchitecID;
                    Comm.Parameters.Add("@Name", SqlDbType.NVarChar).Value = strselectArchitecName;
                    Comm.Parameters.Add("@Location", SqlDbType.NVarChar).Value = strLocation;
                    Comm.Parameters.Add("@MainCons", SqlDbType.NVarChar).Value = strMainCons;
                    Comm.Parameters.Add("@RefRfDf", SqlDbType.NVarChar).Value = strRefRfDf;
                    Comm.Parameters.Add("@ProjStep", SqlDbType.NVarChar).Value = strselectProjStep;
                    Comm.Parameters.Add("@ProductType", SqlDbType.NVarChar).Value = strselectProdTypeID;
                    Comm.Parameters.Add("@RefProfile", SqlDbType.NVarChar).Value = strProfID;
                    Comm.Parameters.Add("@ProdTypeID", SqlDbType.NVarChar).Value = strselectProdTypeID;
                    Comm.Parameters.Add("@ProdTypeNameEN", SqlDbType.NVarChar).Value = strselectProdTypeName;
                    Comm.Parameters.Add("@ProdID", SqlDbType.NVarChar).Value = strselectProdID;
                    Comm.Parameters.Add("@ProdNameEN", SqlDbType.NVarChar).Value = strselectProdName;
                    Comm.Parameters.Add("@ProfID", SqlDbType.NVarChar).Value = strProfID;
                    Comm.Parameters.Add("@ProfNameEN", SqlDbType.NVarChar).Value = strProfID;
                    Comm.Parameters.Add("@StatusID", SqlDbType.NVarChar).Value = selectStatusID;
                    Comm.Parameters.Add("@StatusNameEn", SqlDbType.NVarChar).Value = txtStatusNameEn; //project step name

                    Comm.Parameters.Add("@Quantity", SqlDbType.NVarChar).Value = strQuantity;
                    Comm.Parameters.Add("@RefType", SqlDbType.NVarChar).Value = DBNull.Value;
                    Comm.Parameters.Add("@DeliveryDate", SqlDbType.NVarChar).Value = strdatepickerdelivery;
                    Comm.Parameters.Add("@Drawing", SqlDbType.NVarChar).Value = DBNull.Value;
                    Comm.Parameters.Add("@TypeID", SqlDbType.NVarChar).Value = strselectTypeID;
                    Comm.Parameters.Add("@SaleSpec", SqlDbType.NVarChar).Value = strselectTypeName.Replace("[" + strselectTypeID + "] ", "");
                    Comm.Parameters.Add("@StatusConID", SqlDbType.NVarChar).Value = strselectStatusConID;
                    Comm.Parameters.Add("@LastUpdate", SqlDbType.DateTime).Value = DateTime.Now.ToString();
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

                string strProjectID = Request.Form["ProjectIDDel"];

                if (strProjectID != "" )
                {
                    ssql = "delete from adProjects where ProjectID=@ProjectID  ";

                    Comm = new SqlCommand();
                    Comm.CommandText = ssql;
                    Comm.CommandType = CommandType.Text;
                    Comm.Connection = Conn;
                    Comm.Transaction = transac;
                    Comm.Parameters.Add("@ProjectID", SqlDbType.NVarChar).Value = strProjectID;
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
                //ssql = "SELECT	a.ProjectID, a.ProjectYear, a.ProjectMonth, a.ProjectName, a.CompanyID, a.CompanyName, a.ArchitecID, a.Name, a.Location, " +
                //       "        a.MainCons, a.RefRfDf, a.ProjStep, a.ProductType, a.RefProfile, a.ProdTypeID, a.ProdTypeNameEN, a.ProdID, a.ProdNameEN, a.ProfID,  " +
                //       "        a.ProfNameEN, a.StatusID, a.StatusNameEn, a.Quantity, a.RefType, a.DeliveryDate, a.Drawing, a.TypeID, a.SaleSpec, a.StatusConID,  " +
                //       "        a.CreatedDate, a.LastUpdate, b.ConDesc2 " +
                //       "FROM    adProjects AS a LEFT JOIN " +
                //       "        adStatusConfirm AS b ON a.StatusConID = b.StatusConID ";

                ssql = "spGetProjectsList";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                //dt = new DataTable();
                //dt = dbConn.GetDataTable(ssql);

                GridView GridviewExport = new GridView();
                string strExportDate = DateTime.Now.ToString("yyyyMMddHHmmss");

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=ExportProjects" + strExportDate + ".xls");
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