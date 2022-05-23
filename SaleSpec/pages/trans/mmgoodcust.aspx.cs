using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;

namespace SaleSpec.pages.trans
{
    public partial class mmgoodcust : System.Web.UI.Page
    {
        string ssql;
        DataTable dt = new DataTable();

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;
        ReportDocument rpt = new ReportDocument();
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
            
            }


        }


        protected void btnSearch_click(object sender, EventArgs e)
        {
            try
            {

                string Inyear = Request.Form["TextInYear"].ToString();
                string strYearDesc = Request.Form["txtYearDesc"].ToString(); 
                Session["InYear"] = Inyear;
                Session["YearDesc"] = strYearDesc;   

                if (Session["InYear"].ToString() != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGet_adGoodCustomer", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    SqlParameter param1 = new SqlParameter() { ParameterName = "@Inyear", Value = Inyear };                  
                    Comm.Parameters.Add(param1);                  
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count != 0)
                    {

                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {

                            string id = dt.Rows[i]["id"].ToString();
                            string xno = dt.Rows[i]["xno"].ToString();
                            string inYear = dt.Rows[i]["inYear"].ToString();
                            string No_AAList = dt.Rows[i]["No_AAList"].ToString();
                            string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                            string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                            string FirstName = dt.Rows[i]["FirstName"].ToString();
                            string LastName = dt.Rows[i]["LastName"].ToString();
                            string CustName = dt.Rows[i]["CustName"].ToString();
                            string Name = dt.Rows[i]["Name"].ToString();
                            string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                            string SpecID = dt.Rows[i]["SpecID"].ToString();
                            string level_desc = dt.Rows[i]["level_desc"].ToString();
                            string Salename = dt.Rows[i]["Salename"].ToString();
                            string urlview = dt.Rows[i]["urlview"].ToString();
                            string urldelete = dt.Rows[i]["urldelete"].ToString();

                            strTblDetail += "<tr> " +
                                 "<td class=\"text-right\">" + id + "</td> " +
                                 "<td class=\"text-center\">" + xno + "</td> " +
                                    "<td class=\"text-center\">" + inYear + "</td> " +
                                     "<td class=\"text-center\">" + No_AAList + "</td> " +
                                     "<td class=\"text-center\">" + ArchitecID + "</td> " +
                                        "<td class=\"text-center\">" + CompanyID + "</td> " +
                                         "<td class=\"text-center\">" + FirstName + "</td> " +
                                       "<td class=\"text-left\">" + LastName + "</td> " +
                                      "   <td class=\"text-left\">" + CustName + "</td> " +
                                       "   <td class=\"text-right\">" + Name + "</td> " +
                                       "   <td class=\"text-left\">" + CompanyName + "</td> " +
                                            "<td>" + SpecID + "</td> " +
                                       "   <td class=\"text-left\">" + level_desc + "</td> " +
                                        "   <td class=\"text-left\">" + Salename + "</td> " +                                        
                                             "   <td>" + urlview + "</td> " +
                                             "   <td>" + urldelete + "</td> " +
                                        "</tr>";

                        }

                    }
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

        protected void button3_click(object sender, EventArgs e)
        {
            try
            {
       

           
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGet_adGoodCustomer_detail", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;             
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                 if (dt.Rows.Count != 0)
                 {

                    for (int i = 0; i <= dt.Rows.Count - 1; i++)

                    {

                        string id = dt.Rows[i]["id"].ToString();
                        string xno = dt.Rows[i]["xno"].ToString();
                        string inYear = dt.Rows[i]["inYear"].ToString();
                        string No_AAList = dt.Rows[i]["No_AAList"].ToString();
                        string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string FirstName = dt.Rows[i]["FirstName"].ToString();
                        string LastName = dt.Rows[i]["LastName"].ToString();
                        string CustName = dt.Rows[i]["CustName"].ToString();
                        string Name = dt.Rows[i]["Name"].ToString();
                        string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                        string SpecID = dt.Rows[i]["SpecID"].ToString();
                        string level_desc = dt.Rows[i]["level_desc"].ToString();
                        string Salename = dt.Rows[i]["Salename"].ToString();
                        string urlview = dt.Rows[i]["urlview"].ToString();
                        string urldelete = dt.Rows[i]["urldelete"].ToString();

                        strTblDetail += "<tr> " +
                             "<td class=\"text-right\">" + id + "</td> " +
                             "<td class=\"text-center\">" + xno + "</td> " +
                                "<td class=\"text-center\">" + inYear + "</td> " +
                                 "<td class=\"text-center\">" + No_AAList + "</td> " +
                                 "<td class=\"text-center\">" + ArchitecID + "</td> " +
                                    "<td class=\"text-center\">" + CompanyID + "</td> " +
                                     "<td class=\"text-center\">" + FirstName + "</td> " +
                                   "<td class=\"text-left\">" + LastName + "</td> " +
                                  "   <td class=\"text-left\">" + CustName + "</td> " +
                                   "   <td class=\"text-right\">" + Name + "</td> " +
                                   "   <td class=\"text-left\">" + CompanyName + "</td> " +
                                        "<td>" + SpecID + "</td> " +
                                   "   <td class=\"text-left\">" + level_desc + "</td> " +
                                    "   <td class=\"text-left\">" + Salename + "</td> " +
                                         "   <td>" + urlview + "</td> " +
                                         "   <td>" + urldelete + "</td> " +
                                    "</tr>";

                    }

                 }
            


                // SelectTypeot.Value = strTypeOt;
            }
            catch (Exception ex)
            {
                //Response.Write("<script>alert('"+ ex.Message +"')</script>");
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }


        protected void btnExportPDF_click(object sender, EventArgs e)
        {
            try
            {

                string Inyear = Request.Form["TextInYear"].ToString();
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGet_adGoodCustomer", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter() { ParameterName = "@Inyear", Value = Inyear };
                Comm.Parameters.Add(param1);
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);
                rpt.Load(Server.MapPath("../reports/rptGoodCustomer.rpt"));
                reports.DtGoodcustomers DtMetreToMile = new reports.DtGoodcustomers();
                DtMetreToMile.Merge(dt);
                rpt.SetDataSource(dt);
                rpt.SetParameterValue("@Inyear", Inyear);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AAFirst" + Inyear);

            }
            catch (Exception ex)
            {
                //Response.Write("<script>alert('"+ ex.Message +"')</script>");
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }






    }
}