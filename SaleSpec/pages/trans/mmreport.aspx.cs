using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;

namespace SaleSpec.pages.trans
{
    public partial class mmreport : System.Web.UI.Page
    {
        string ssql;
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        DataTable dt2 = new DataTable();
        DataTable dt3 = new DataTable();
        DataTable dt4 = new DataTable();
        DataTable dt5 = new DataTable();
        DataTable dt6 = new DataTable();
        ReportDocument rpt = new ReportDocument();
        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;
        public string strMsgAlert = "";
        public string strTblVCA = "";
        public string strTblVCB = "";
        public string strTblVCC = "";
        public string strTblVCD = "";
        public string strTblVCE = "";
        public string strTblActive = "";
        public string strVCA = "";
        public string strVCB = "";
        public string strVCC = "";
        public string strVCD = "";
        public string strVCE = "";
        public string yearstart="";
        public string yearend = "";
        public string strmonth01 = "";
        public string strmonth02 = "";
        public string strmonth03 = "";
        public string strmonth04 = "";
        public string strmonth05 = "";
        public string strmonth06 = "";
        public string strmonth07 = "";
        public string strmonth08 = "";
        public string strmonth09 = "";
        public string strmonth10 = "";
        public string strmonth11 = "";
        public string strmonth12 = "";


        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }
            
            btnGetspecPerson();
        }



        protected void btnGetspecPerson()
        {
            try
            {
                
                ssql = "spGetSpecPerson_m2mReport";
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;    
                da = new SqlDataAdapter(Comm);
                dt2 = new DataTable();
                da.Fill(dt2);
                                

                if (dt2.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt2.Rows.Count - 1; i++)
                    {

                        string SpecID = dt2.Rows[i]["SpecID"].ToString();
                        string Titlename = dt2.Rows[i]["Titlename"].ToString();

                        if (SpecID == "VCA")
                        {
                            strVCA = Titlename;
                        }

                        if (SpecID == "VCB")
                        {
                            strVCB = Titlename;
                        }

                        if (SpecID == "VCC")
                        {
                            strVCC = Titlename;
                        }

                        if (SpecID == "VCD")
                        {
                            strVCD = Titlename;
                        }
                        
                        if (SpecID == "VCE")
                        {
                            strVCE = Titlename;
                        }

                    }

                }




            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "')</script>");
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }



        protected void btnSearch_click(object sender, EventArgs e)
        {
            try
            {

            
                    string Inyear = Request.Form["selectTextInYear"].ToString();
                    Session["InYear"] = Inyear;
                    int iyear = int.Parse(Inyear)-1;
                    int iyearend = int.Parse(Inyear);
                    int strdatestart = iyear+543;
                    int strdateend = iyearend + 543;
                    yearstart = strdatestart.ToString().Substring(2, 2);
                    yearend = strdateend.ToString().Substring(2, 2);
                    strmonth01 = "ต.ค." + "-" + yearstart;
                    strmonth02 = "พ.ย." + "-" + yearstart;
                    strmonth03 = "ธ.ค." + "-" + yearstart;
                    strmonth04 = "ม.ค." + "-" + yearend;
                    strmonth05 = "ก.พ." + "-" + yearend;
                    strmonth06 = "มี.ค." + "-" + yearend;
                    strmonth07 = "เม.ย." + "-" + yearend;
                    strmonth08 = "พ.ค." + "-" + yearend;
                    strmonth09 = "มิ.ย." + "-" + yearend;
                    strmonth10 = "ก.ค." + "-" + yearend;
                    strmonth11 = "ส.ค." + "-" + yearend;
                    strmonth12 = "ก.ย." + "-" + yearend;

                

                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGetReportMetreToMile_VCA", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.CommandTimeout = 600;
                    SqlParameter param1 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };         
                    Comm.Parameters.Add(param1);                   
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);


                    if (dt.Rows.Count != 0)
                    {

                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {

                            string xno = dt.Rows[i]["xno"].ToString();
                            string CompanyName = dt.Rows[i]["CompanyName"].ToString();
                            string custName = dt.Rows[i]["custName"].ToString();
                            string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                            string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                            string No_AAList = dt.Rows[i]["No_AAList"].ToString();
                            string month01 = dt.Rows[i]["month01"].ToString();
                            string month02 = dt.Rows[i]["month02"].ToString();
                            string month03 = dt.Rows[i]["month03"].ToString();
                            string month04 = dt.Rows[i]["month04"].ToString();
                            string month05 = dt.Rows[i]["month05"].ToString();
                            string month06 = dt.Rows[i]["month06"].ToString();
                            string month07 = dt.Rows[i]["month07"].ToString();
                            string month08 = dt.Rows[i]["month08"].ToString();
                            string month09 = dt.Rows[i]["month09"].ToString();
                            string month10 = dt.Rows[i]["month10"].ToString();
                            string month11 = dt.Rows[i]["month11"].ToString();
                            string month12 = dt.Rows[i]["month12"].ToString();
                            string Total = dt.Rows[i]["Total"].ToString();
                

                            strTblVCA += "<tr> " +
                                   "<td style=\"text-align:center;\">"  + xno + "</td> " +                               
                                   "<td style=\"text-align:center;\">" + ArchitecID + "</td> " +
                                   "<td style=\"text-align:left;\">"  + custName + "</td> " +
                                    "<td style=\"text-align:center;\">" + CompanyID + "</td> " +
                                    "<td style=\"text-align:left;\">" + CompanyName + "</td> " +
                                     "<td style=\"text-align:center;\">" + No_AAList + "</td> " +
                                   "<td >" + month01 + "</td> " +
                                       "<td >" + month02 + "</td> " +
                                     "<td >" + month03 + "</td> " +
                                        "<td >" + month04 + "</td> " +
                                         "<td >" + month05 + "</td> " +
                                          "<td >" + month06 + "</td> " +
                                           "<td >" + month07 + "</td> " +
                                              "<td >" + month08 + "</td> " +
                                              "<td >" + month09 + "</td> " +
                                             "<td >" + month10 + "</td> " +
                                             "<td >" + month11 + "</td> " +
                                             "<td >" + month12 + "</td> " +
                                             "<td >" + Total + "</td> " +                                           
                                         "</tr>";
                        }

                    }







                Comm = new SqlCommand("spGetReportMetreToMile_VCB", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param2 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param2);
                SqlDataAdapter adapter3 = new SqlDataAdapter();
                adapter3.SelectCommand = Comm;
                dt3 = new DataTable();
                adapter3.Fill(dt3);

             
                if (dt3.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt3.Rows.Count - 1; i++)
                    {

                        string xno = dt3.Rows[i]["xno"].ToString();
                        string CompanyName = dt3.Rows[i]["CompanyName"].ToString();
                        string custName = dt3.Rows[i]["custName"].ToString();
                        string ArchitecID = dt3.Rows[i]["ArchitecID"].ToString();
                        string CompanyID = dt3.Rows[i]["CompanyID"].ToString();
                        string No_AAList = dt3.Rows[i]["No_AAList"].ToString();
                        string month01 = dt3.Rows[i]["month01"].ToString();
                        string month02 = dt3.Rows[i]["month02"].ToString();
                        string month03 = dt3.Rows[i]["month03"].ToString();
                        string month04 = dt3.Rows[i]["month04"].ToString();
                        string month05 = dt3.Rows[i]["month05"].ToString();
                        string month06 = dt3.Rows[i]["month06"].ToString();
                        string month07 = dt3.Rows[i]["month07"].ToString();
                        string month08 = dt3.Rows[i]["month08"].ToString();
                        string month09 = dt3.Rows[i]["month09"].ToString();
                        string month10 = dt3.Rows[i]["month10"].ToString();
                        string month11 = dt3.Rows[i]["month11"].ToString();
                        string month12 = dt3.Rows[i]["month12"].ToString();
                        string Total = dt3.Rows[i]["Total"].ToString();


                        strTblVCB += "<tr> " +
                           "<td style=\"text-align:center;\">" + xno + "</td> " +
                            "<td style=\"text-align:center;\">" + ArchitecID + "</td> " +
                            "<td style=\"text-align:left;\">" + custName + "</td> " +
                             "<td style=\"text-align:center;\">" + CompanyID + "</td> " +
                              "<td style=\"text-align:left;\">" + CompanyName + "</td> " +
                               "<td style=\"text-align:center;\">" + No_AAList + "</td> " +
                               "<td >" + month01 + "</td> " +
                                   "<td >" + month02 + "</td> " +
                                 "<td >" + month03 + "</td> " +
                                    "<td >" + month04 + "</td> " +
                                     "<td >" + month05 + "</td> " +
                                      "<td >" + month06 + "</td> " +
                                       "<td >" + month07 + "</td> " +
                                          "<td >" + month08 + "</td> " +
                                          "<td >" + month09 + "</td> " +
                                         "<td >" + month10 + "</td> " +
                                         "<td >" + month11 + "</td> " +
                                         "<td >" + month12 + "</td> " +
                                         "<td >" + Total + "</td> " +
                                     "</tr>";
                    }

                }




                Comm = new SqlCommand("spGetReportMetreToMile_VCC", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param3 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param3);
                SqlDataAdapter adapter4 = new SqlDataAdapter();
                adapter4.SelectCommand = Comm;
                dt4 = new DataTable();
                adapter4.Fill(dt4);


                if (dt4.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt4.Rows.Count - 1; i++)
                    {

                        string xno = dt4.Rows[i]["xno"].ToString();
                        string CompanyName = dt4.Rows[i]["CompanyName"].ToString();
                        string custName = dt4.Rows[i]["custName"].ToString();
                        string ArchitecID = dt4.Rows[i]["ArchitecID"].ToString();
                        string CompanyID = dt4.Rows[i]["CompanyID"].ToString();
                        string No_AAList = dt4.Rows[i]["No_AAList"].ToString();
                        string month01 = dt4.Rows[i]["month01"].ToString();
                        string month02 = dt4.Rows[i]["month02"].ToString();
                        string month03 = dt4.Rows[i]["month03"].ToString();
                        string month04 = dt4.Rows[i]["month04"].ToString();
                        string month05 = dt4.Rows[i]["month05"].ToString();
                        string month06 = dt4.Rows[i]["month06"].ToString();
                        string month07 = dt4.Rows[i]["month07"].ToString();
                        string month08 = dt4.Rows[i]["month08"].ToString();
                        string month09 = dt4.Rows[i]["month09"].ToString();
                        string month10 = dt4.Rows[i]["month10"].ToString();
                        string month11 = dt4.Rows[i]["month11"].ToString();
                        string month12 = dt4.Rows[i]["month12"].ToString();
                        string Total = dt4.Rows[i]["Total"].ToString();


                        strTblVCC += "<tr> " +
                           "<td style=\"text-align:center;\">" + xno + "</td> " +
                            "<td style=\"text-align:center;\">" + ArchitecID + "</td> " +
                             "<td style=\"text-align:left;\">" + custName + "</td> " +
                              "<td style=\"text-align:center;\">" + CompanyID + "</td> " +
                              "<td style=\"text-align:left;\">" + CompanyName + "</td> " +
                               "<td style=\"text-align:center;\">" + No_AAList + "</td> " +
                               "<td >" + month01 + "</td> " +
                                   "<td >" + month02 + "</td> " +
                                 "<td >" + month03 + "</td> " +
                                    "<td >" + month04 + "</td> " +
                                     "<td >" + month05 + "</td> " +
                                      "<td >" + month06 + "</td> " +
                                       "<td >" + month07 + "</td> " +
                                          "<td >" + month08 + "</td> " +
                                          "<td >" + month09 + "</td> " +
                                         "<td >" + month10 + "</td> " +
                                         "<td >" + month11 + "</td> " +
                                         "<td >" + month12 + "</td> " +
                                         "<td >" + Total + "</td> " +
                                     "</tr>";
                    }

                }




                Comm = new SqlCommand("spGetReportMetreToMile_VCD", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param4 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param4);
                SqlDataAdapter adapter5 = new SqlDataAdapter();
                adapter5.SelectCommand = Comm;
                dt5 = new DataTable();
                adapter5.Fill(dt5);


                if (dt5.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt5.Rows.Count - 1; i++)
                    {

                        string xno = dt5.Rows[i]["xno"].ToString();
                        string CompanyName = dt5.Rows[i]["CompanyName"].ToString();
                        string custName = dt5.Rows[i]["custName"].ToString();
                        string ArchitecID = dt5.Rows[i]["ArchitecID"].ToString();
                        string CompanyID = dt5.Rows[i]["CompanyID"].ToString();
                        string No_AAList = dt5.Rows[i]["No_AAList"].ToString();
                        string month01 = dt5.Rows[i]["month01"].ToString();
                        string month02 = dt5.Rows[i]["month02"].ToString();
                        string month03 = dt5.Rows[i]["month03"].ToString();
                        string month04 = dt5.Rows[i]["month04"].ToString();
                        string month05 = dt5.Rows[i]["month05"].ToString();
                        string month06 = dt5.Rows[i]["month06"].ToString();
                        string month07 = dt5.Rows[i]["month07"].ToString();
                        string month08 = dt5.Rows[i]["month08"].ToString();
                        string month09 = dt5.Rows[i]["month09"].ToString();
                        string month10 = dt5.Rows[i]["month10"].ToString();
                        string month11 = dt5.Rows[i]["month11"].ToString();
                        string month12 = dt5.Rows[i]["month12"].ToString();
                        string Total = dt5.Rows[i]["Total"].ToString();


                        strTblVCD += "<tr> " +
                            "<td style=\"text-align:center;\">" + xno + "</td> " +
                            "<td style=\"text-align:center;\">" + ArchitecID + "</td> " +
                            "<td style=\"text-align:left;\">" + custName + "</td> " +
                             "<td style=\"text-align:center;\">" + CompanyID + "</td> " +
                              "<td style=\"text-align:left;\">" + CompanyName + "</td> " +
                               "<td style=\"text-align:center;\">" + No_AAList + "</td> " +
                               "<td >" + month01 + "</td> " +
                                   "<td >" + month02 + "</td> " +
                                 "<td >" + month03 + "</td> " +
                                    "<td >" + month04 + "</td> " +
                                     "<td >" + month05 + "</td> " +
                                      "<td >" + month06 + "</td> " +
                                       "<td >" + month07 + "</td> " +
                                          "<td >" + month08 + "</td> " +
                                          "<td >" + month09 + "</td> " +
                                         "<td >" + month10 + "</td> " +
                                         "<td >" + month11 + "</td> " +
                                         "<td >" + month12 + "</td> " +
                                         "<td >" + Total + "</td> " +
                                     "</tr>";
                    }

                }





                Comm = new SqlCommand("spGetReportMetreToMile_VCE", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param5 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param5);
                SqlDataAdapter adapter6 = new SqlDataAdapter();
                adapter6.SelectCommand = Comm;
                dt6 = new DataTable();
                adapter6.Fill(dt6);


                if (dt6.Rows.Count != 0)
                {

                    for (int i = 0; i <= dt6.Rows.Count - 1; i++)
                    {

                        string xno = dt6.Rows[i]["xno"].ToString();
                        string CompanyName = dt6.Rows[i]["CompanyName"].ToString();
                        string custName = dt6.Rows[i]["custName"].ToString();
                        string ArchitecID = dt6.Rows[i]["ArchitecID"].ToString();
                        string CompanyID = dt6.Rows[i]["CompanyID"].ToString();
                        string No_AAList = dt6.Rows[i]["No_AAList"].ToString();
                        string month01 = dt6.Rows[i]["month01"].ToString();
                        string month02 = dt6.Rows[i]["month02"].ToString();
                        string month03 = dt6.Rows[i]["month03"].ToString();
                        string month04 = dt6.Rows[i]["month04"].ToString();
                        string month05 = dt6.Rows[i]["month05"].ToString();
                        string month06 = dt6.Rows[i]["month06"].ToString();
                        string month07 = dt6.Rows[i]["month07"].ToString();
                        string month08 = dt6.Rows[i]["month08"].ToString();
                        string month09 = dt6.Rows[i]["month09"].ToString();
                        string month10 = dt6.Rows[i]["month10"].ToString();
                        string month11 = dt6.Rows[i]["month11"].ToString();
                        string month12 = dt6.Rows[i]["month12"].ToString();
                        string Total = dt6.Rows[i]["Total"].ToString();
                    



                        strTblVCE += "<tr> " +
                           "<td style=\"text-align:center;\">" + xno + "</td> " +
                            "<td style=\"text-align:center;\">" + ArchitecID + "</td> " +
                            "<td style=\"text-align:left;\">" + custName + "</td> " +
                             "<td style=\"text-align:center;\">" + CompanyID + "</td> " +
                              "<td style=\"text-align:left;\">" + CompanyName + "</td> " +
                               "<td style=\"text-align:center;\">" + No_AAList + "</td> " +
                               "<td >" + month01 + "</td> " +
                                   "<td >" + month02 + "</td> " +
                                 "<td >" + month03 + "</td> " +
                                    "<td >" + month04 + "</td> " +
                                     "<td >" + month05 + "</td> " +
                                      "<td >" + month06 + "</td> " +
                                       "<td >" + month07 + "</td> " +
                                          "<td >" + month08 + "</td> " +
                                          "<td >" + month09 + "</td> " +
                                         "<td >" + month10 + "</td> " +
                                         "<td >" + month11 + "</td> " +
                                         "<td >" + month12 + "</td> " +
                                         "<td >" + Total + "</td> " +
                                     "</tr>";
                    }

                }






            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "')</script>");
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;
            }
        }


        protected void btnDownloadPDF_click(object sender, EventArgs e)
        {
            try
            {

                string Inyear = Request.Form["selectTextInYear"].ToString();
                Session["InYear"] = Inyear;
                int iyear = int.Parse(Inyear) - 1;
                int iyearend = int.Parse(Inyear);
                int strdatestart = iyear + 543;
                int strdateend = iyearend + 543;
                yearstart = strdatestart.ToString().Substring(2, 2);
                yearend = strdateend.ToString().Substring(2, 2);
                strmonth01 = "ต.ค." + "-" + yearstart;
                strmonth02 = "พ.ย." + "-" + yearstart;
                strmonth03 = "ธ.ค." + "-" + yearstart;
                strmonth04 = "ม.ค." + "-" + yearend;
                strmonth05 = "ก.พ." + "-" + yearend;
                strmonth06 = "มี.ค." + "-" + yearend;
                strmonth07 = "เม.ย." + "-" + yearend;
                strmonth08 = "พ.ค." + "-" + yearend;
                strmonth09 = "มิ.ย." + "-" + yearend;
                strmonth10 = "ก.ค." + "-" + yearend;
                strmonth11 = "ส.ค." + "-" + yearend;
                strmonth12 = "ก.ย." + "-" + yearend;

                

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGetReportMetreToMile_VCA", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param1);            
                SqlDataAdapter adapter3 = new SqlDataAdapter();
                adapter3.SelectCommand = Comm;
                dt1 = new DataTable();
                adapter3.Fill(dt1);
                dbConn.CloseConn();




                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGetReportMetreToMile_VCB", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param2 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param2);
                SqlDataAdapter adapter1 = new SqlDataAdapter();
                adapter1.SelectCommand = Comm;
                dt2 = new DataTable();
                adapter1.Fill(dt2);
                dbConn.CloseConn();



                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGetReportMetreToMile_VCC", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param3 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param3);
                SqlDataAdapter adapter2 = new SqlDataAdapter();
                adapter2.SelectCommand = Comm;
                dt3 = new DataTable();
                adapter2.Fill(dt3);
                dbConn.CloseConn();


                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGetReportMetreToMile_VCD", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param4 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param4);
                SqlDataAdapter adapter4 = new SqlDataAdapter();
                adapter4.SelectCommand = Comm;
                dt4 = new DataTable();
                adapter4.Fill(dt4);
                dbConn.CloseConn();



                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGetReportMetreToMile_VCE", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param5 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                Comm.Parameters.Add(param5);
                SqlDataAdapter adapter5 = new SqlDataAdapter();
                adapter5.SelectCommand = Comm;
                dt5 = new DataTable();
                adapter5.Fill(dt5);
                dbConn.CloseConn();


                //rpt.Load(Server.MapPath("../reports/rptMetreToMileVCB.rpt"));
                //reports.DtMetreToMile DtMetreToMile = new reports.DtMetreToMile();
                //DtMetreToMile.Merge(dt2);
                //rpt.SetDataSource(dt2);


                rpt.Load(Server.MapPath("../reports/rptMetreToMile.rpt"));

                rpt.Subreports["rptMetreToMileVCA.rpt"].Database.Tables[0].SetDataSource(dt1);
                rpt.Subreports["rptMetreToMileVCB.rpt"].Database.Tables[0].SetDataSource(dt2);
                rpt.Subreports["rptMetreToMileVCC.rpt"].Database.Tables[0].SetDataSource(dt3);
                rpt.Subreports["rptMetreToMileVCD.rpt"].Database.Tables[0].SetDataSource(dt4);
                rpt.Subreports["rptMetreToMileVCE.rpt"].Database.Tables[0].SetDataSource(dt5);

                rpt.SetParameterValue("@ProYear", Inyear);
                rpt.SetParameterValue("@strmonth01", strmonth01);
                rpt.SetParameterValue("@strmonth02", strmonth02);
                rpt.SetParameterValue("@strmonth03", strmonth03);
                rpt.SetParameterValue("@strmonth04", strmonth04);
                rpt.SetParameterValue("@strmonth05", strmonth05);
                rpt.SetParameterValue("@strmonth06", strmonth06);
                rpt.SetParameterValue("@strmonth07", strmonth07);
                rpt.SetParameterValue("@strmonth08", strmonth08);
                rpt.SetParameterValue("@strmonth09", strmonth09);
                rpt.SetParameterValue("@strmonth10", strmonth10);
                rpt.SetParameterValue("@strmonth11", strmonth11);
                rpt.SetParameterValue("@strmonth12", strmonth12);
                rpt.SetParameterValue("@strdatestart",strdatestart);
                rpt.SetParameterValue("@strdateend", strdateend);
                rpt.SetParameterValue("@strVCA", strVCA);
                rpt.SetParameterValue("@strVCB", strVCB);
                rpt.SetParameterValue("@strVCC", strVCC);
                rpt.SetParameterValue("@strVCD", strVCD);
                rpt.SetParameterValue("@strVCE", strVCE);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, " MetreToMile" + strdateend);

            }
            catch (Exception ex)
            {
              
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                           "      <strong>Warning..!</strong> " + ex.Message + " " +
                           "</div>";
                return;

            }
        }




        protected void btnExportExcel_click(object sender, EventArgs e)
        {
            try
            {



                string Inyear = Request.Form["selectTextInYear"].ToString();
                Session["InYear"] = Inyear;
                int iyear = int.Parse(Inyear) - 1;
                int iyearend = int.Parse(Inyear);
                int strdatestart = iyear + 543;
                int strdateend = iyearend + 543;
                yearstart = strdatestart.ToString().Substring(2, 2);
                yearend = strdateend.ToString().Substring(2, 2);
                strmonth01 = "ต.ค." + "-" + yearstart;
                strmonth02 = "พ.ย." + "-" + yearstart;
                strmonth03 = "ธ.ค." + "-" + yearstart;
                strmonth04 = "ม.ค." + "-" + yearend;
                strmonth05 = "ก.พ." + "-" + yearend;
                strmonth06 = "มี.ค." + "-" + yearend;
                strmonth07 = "เม.ย." + "-" + yearend;
                strmonth08 = "พ.ค." + "-" + yearend;
                strmonth09 = "มิ.ย." + "-" + yearend;
                strmonth10 = "ก.ค." + "-" + yearend;
                strmonth11 = "ส.ค." + "-" + yearend;
                strmonth12 = "ก.ย." + "-" + yearend;


               
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGetReportMetreToMile_VCA", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.CommandTimeout = 600;
                    SqlParameter param1 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };     
                    Comm.Parameters.Add(param1);                
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);
                    ExcelPackage excel = new ExcelPackage();
                    if (dt.Rows.Count != 0)
                    {
                        var workSheet = excel.Workbook.Worksheets.Add("Metre to mile" + " " + Inyear);
                        var totalCols = dt.Columns.Count;
                        var totalRows = dt.Rows.Count;
                        var totalFooter = dt.Columns.Count;
                        int header_title = 7;
                        var totalfoot = dt.Rows.Count + 1 + header_title;
                        var footheader = dt.Columns.Count;
                        int col = 0;
                        int row = 0;
                        int fot = 0;
                        for (col = 1; col <= totalCols; col++)
                        {
                            workSheet.Cells["A2:S2"].Merge = true;
                            workSheet.Cells["A2:S2"].Value = "สรุปโปรโมชั่น Metre to mile เดือน กันยายน" + " " + Inyear;
                            workSheet.Cells["A2:S2"].Style.Font.Name = "Angsana New";
                            workSheet.Cells["A2:S2"].Style.Font.Size = 12;
                            workSheet.Cells["A2:S2"].Style.Font.Bold = true;
                            workSheet.Cells["A2:S2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;


                            workSheet.Cells["A3:S3"].Merge = true;
                            workSheet.Cells["A3:S3"].Value = "ระยะเวลาส่งเสริมการขาย : วันที่ 1 ตุลาคม" + " " + yearstart + "-" + "30 กันยายน" + " " + yearend;
                            workSheet.Cells["A3:S3"].Style.Font.Name = "Angsana New";
                            workSheet.Cells["A3:S3"].Style.Font.Size = 9;
                            workSheet.Cells["A3:S3"].Style.Font.Bold = true;
                            workSheet.Cells["A3:S3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;


                            workSheet.Cells["A4:S4"].Merge = true;
                            workSheet.Cells["A4:S4"].Value = strVCA;
                            workSheet.Cells["A4:S4"].Style.Font.Name = "Angsana New";
                            workSheet.Cells["A4:S4"].Style.Font.Size = 9;
                            workSheet.Cells["A4:S4"].Style.Font.Bold = true;
                            workSheet.Cells["A4:S4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;




                            workSheet.Cells[5, 1, 7, 1].Merge = true;
                            workSheet.Cells[5, 1, 7, 1].Value = "ลำดับ";                 
                            workSheet.Cells[5, 1, 7, 1].Style.Font.Size = 8;
                            workSheet.Cells[5, 1, 7, 1].Style.Font.Bold = true;
                            workSheet.Cells[5, 1, 7, 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[5, 2, 7, 2].Merge = true;


                            workSheet.Cells[5, 2, 7, 2].Value = "AA ID";
                            workSheet.Cells[5, 2, 7, 2].Style.Font.Size = 8;
                            workSheet.Cells[5, 2, 7, 2].Style.Font.Bold = true;
                            workSheet.Cells[5, 2, 7, 2].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[5, 3, 7, 3].Merge = true;


                            workSheet.Cells[5, 3, 7, 3].Value = "ชื่อลูกค้า";
                            workSheet.Cells[5, 3, 7, 3].Style.Font.Size = 8;
                            workSheet.Cells[5, 3, 7, 3].Style.Font.Bold = true;
                            workSheet.Cells[5, 3, 7, 3].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[5, 4, 7, 4].Merge = true;


                            workSheet.Cells[5, 4, 7, 4].Value = "Company ID";
                            workSheet.Cells[5, 4, 7, 4].Style.Font.Size = 8;
                            workSheet.Cells[5, 4, 7, 4].Style.Font.Bold = true;
                            workSheet.Cells[5, 4, 7, 4].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[5, 5, 7, 5].Merge = true;



                            workSheet.Cells[5, 5, 7, 5].Value = "บริษัท";
                            workSheet.Cells[5, 5, 7, 5].Style.Font.Size = 8;
                            workSheet.Cells[5, 5, 7, 5].Style.Font.Bold = true;
                            workSheet.Cells[5, 5, 7, 5].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[5, 6, 7, 6].Merge = true;



                        workSheet.Cells[5, 6, 7, 6].Merge = true;
                        workSheet.Cells[5, 6, 7, 6].Value = "ลำดับที่ใน AA+CLUB 2021 Member List";
                        workSheet.Cells[5, 6, 7, 6].Style.Font.Size = 8;
                        workSheet.Cells[5, 6, 7, 6].Style.Font.Bold = true;
                        workSheet.Cells[5, 6, 7, 6].Style.WrapText = true;
                        workSheet.Cells[5, 6, 7, 6].Style.VerticalAlignment = ExcelVerticalAlignment.Center;                    
                     


                        workSheet.Cells["G5:R5"].Merge = true;
                        workSheet.Cells["G5:R5"].Value = "Mile สะสม";
                        workSheet.Cells["G5:R5"].Style.Font.Size = 9;                     
                        workSheet.Cells["G5:R5"].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                        workSheet.Cells["G5:R5"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;


                        workSheet.Cells[6, 7, 7, 7].Merge = true;
                        workSheet.Cells[6, 7, 7, 7].Value = strmonth01;
                        workSheet.Cells[6, 7, 7, 7].Style.Font.Size = 8;
                        workSheet.Cells[6, 7, 7, 7].Style.Font.Bold = true;                      
                        workSheet.Cells[6, 7, 7, 7].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                          
                        workSheet.Cells[6, 8, 7, 8].Merge = true;
                        workSheet.Cells[6, 8, 7, 8].Value = strmonth02;
                        workSheet.Cells[6, 8, 7, 8].Style.Font.Size = 8;
                        workSheet.Cells[6, 8, 7, 8].Style.Font.Bold = true;
                        workSheet.Cells[6, 8, 7, 8].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 9, 7, 9].Merge = true;
                        workSheet.Cells[6, 9, 7, 9].Value = strmonth03;
                        workSheet.Cells[6, 9, 7, 9].Style.Font.Size = 8;
                        workSheet.Cells[6, 9, 7, 9].Style.Font.Bold = true;
                        workSheet.Cells[6, 9, 7, 9].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                        workSheet.Cells[6, 10, 7, 10].Merge = true;
                        workSheet.Cells[6, 10, 7, 10].Value = strmonth04;
                        workSheet.Cells[6, 10, 7, 10].Style.Font.Size = 8;
                        workSheet.Cells[6, 10, 7, 10].Style.Font.Bold = true;
                        workSheet.Cells[6, 10, 7, 10].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 11, 7, 11].Merge = true;
                        workSheet.Cells[6, 11, 7, 11].Value = strmonth05;
                        workSheet.Cells[6, 11, 7, 11].Style.Font.Size = 8;
                        workSheet.Cells[6, 11, 7, 11].Style.Font.Bold = true;
                        workSheet.Cells[6, 11, 7, 11].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 12, 7, 12].Merge = true;
                        workSheet.Cells[6, 12, 7, 12].Value = strmonth06;
                        workSheet.Cells[6, 12, 7, 12].Style.Font.Size = 8;
                        workSheet.Cells[6, 12, 7, 12].Style.Font.Bold = true;
                        workSheet.Cells[6, 12, 7, 12].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 13, 7, 13].Merge = true;
                        workSheet.Cells[6, 13, 7, 13].Value = strmonth07;
                        workSheet.Cells[6, 13, 7, 13].Style.Font.Size = 8;
                        workSheet.Cells[6, 13, 7, 13].Style.Font.Bold = true;
                        workSheet.Cells[6, 13, 7, 13].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 14, 7, 14].Merge = true;
                        workSheet.Cells[6, 14, 7, 14].Value = strmonth08;
                        workSheet.Cells[6, 14, 7, 14].Style.Font.Size = 8;
                        workSheet.Cells[6, 14, 7, 14].Style.Font.Bold = true;
                        workSheet.Cells[6, 14, 7, 14].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 15, 7, 15].Merge = true;
                        workSheet.Cells[6, 15, 7, 15].Value = strmonth09;
                        workSheet.Cells[6, 15, 7, 15].Style.Font.Size = 8;
                        workSheet.Cells[6, 15, 7, 15].Style.Font.Bold = true;
                        workSheet.Cells[6, 15, 7, 15].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 16, 7, 16].Merge = true;
                        workSheet.Cells[6, 16, 7, 16].Value = strmonth10;
                        workSheet.Cells[6, 16, 7, 16].Style.Font.Size = 8;
                        workSheet.Cells[6, 16, 7, 16].Style.Font.Bold = true;
                        workSheet.Cells[6, 16, 7, 16].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 17, 7, 17].Merge = true;
                        workSheet.Cells[6, 17, 7, 17].Value = strmonth11;
                        workSheet.Cells[6, 17, 7, 17].Style.Font.Size = 8;
                        workSheet.Cells[6, 17, 7, 17].Style.Font.Bold = true;
                        workSheet.Cells[6, 17, 7, 17].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                        workSheet.Cells[6, 18, 7, 18].Merge = true;
                        workSheet.Cells[6, 18, 7, 18].Value = strmonth12;
                        workSheet.Cells[6, 18, 7, 18].Style.Font.Size = 8;
                        workSheet.Cells[6, 18, 7, 18].Style.Font.Bold = true;
                        workSheet.Cells[6, 18, 7, 18].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                        workSheet.Cells[5, 19, 7, 19].Merge = true;
                        workSheet.Cells[5, 19, 7, 19].Value = "Total";
                        workSheet.Cells["S5:S7"].Style.Font.Name = "Angsana New";
                        workSheet.Cells["S5:S7"].Style.Font.Size = 10;
                        workSheet.Cells[5, 19, 7, 19].Style.Font.Bold = true;
                        workSheet.Cells[5, 19, 7, 19].Style.VerticalAlignment = ExcelVerticalAlignment.Center; 
                   


                        workSheet.Cells[5, col].Style.Font.Bold = true;
                        workSheet.Cells[5, col].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                        workSheet.Cells[5, col].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                        workSheet.Cells[5, col].Style.Border.Right.Style = ExcelBorderStyle.Hair;

                


                            workSheet.Cells[5, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                          
                            workSheet.Cells[5, col].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[5, col].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[5, col].AutoFitColumns();
                      
                            workSheet.Cells[6, col].Style.Font.Bold = true;
                            workSheet.Cells[6, col].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[5, col].Style.Font.Name = "Angsana New";
                            workSheet.Cells[6, col].Style.Font.Name = "Angsana New";
                            workSheet.Cells[7, col].Style.Font.Name = "Angsana New";                  
                            workSheet.Cells[6, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[6, col].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[6, col].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[6, col].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[6, col].AutoFitColumns();                         
                            workSheet.Cells[7, col].Style.Font.Bold = true;
                            workSheet.Cells[7, col].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[7, col].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[7, col].Style.Border.Left.Style = ExcelBorderStyle.Hair;                        
                            workSheet.Cells[7, col].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[7, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[7, col].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[7, col].AutoFitColumns();





                        }

                    workSheet.Column(1).Width = 3;
                    workSheet.Column(2).Width = 4;
                    workSheet.Column(3).Width = 15;
                    workSheet.Column(4).Width = 6;
                    workSheet.Column(5).Width = 25;
                    workSheet.Column(6).Width = 10;
                    workSheet.Column(7).Width =  6;
                    workSheet.Column(8).Width =  6;
                    workSheet.Column(9).Width =  6;
                    workSheet.Column(10).Width = 6;
                    workSheet.Column(11).Width = 6;
                    workSheet.Column(12).Width = 6;
                    workSheet.Column(13).Width = 6;
                    workSheet.Column(14).Width = 6;
                    workSheet.Column(15).Width = 6;
                    workSheet.Column(16).Width = 6;
                    workSheet.Column(17).Width = 6;
                    workSheet.Column(18).Width = 6;
                    workSheet.Column(19).Width = 6;






                    for (row = 0; row < totalRows; row++)
                    {
                        for (col = 0; col <= totalCols - 1; col++)
                        {
                            workSheet.Cells[row + 8, col + 1].Value = dt.Rows[row][col];
                            workSheet.Cells[row + 8, col + 1].Style.Font.Name = "Angsana New";
                            workSheet.Cells[row + 8, col + 1].Style.Font.Size = 9;
                            workSheet.Cells[row + 8, col + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[row + 8, col + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;   
                            workSheet.Cells[row + 8, col + 1].Style.Font.Bold = false;
                            workSheet.Cells[row + 8, col + 1].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[row + 8, col + 1].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[row + 8, col + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[row + 8, col + 1].Style.Border.Left.Style = ExcelBorderStyle.Hair;                       
                            workSheet.Cells[row + 8, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[row + 8, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[row + 8, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                            workSheet.Cells[row + 8, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[row + 8, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                            workSheet.Cells[row + 8, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                       
                          

                        }
                    }





                    int iresign = dt.Rows.Count + 9;  //start
                    int headertitle_iresign = dt.Rows.Count + 10;  //start
                    int headertitle2_iresign = dt.Rows.Count + 11;  //start
                    int headerend_iresign = dt.Rows.Count + 12;  //start
                    int rowstart_iresign = dt.Rows.Count + 13;  //start
                    int rowstarttwo_iresign = dt.Rows.Count + 15;  //start
                    int rowstartthree_iresign = dt.Rows.Count + 17;  //start
                    int rowstart_remark = dt.Rows.Count + 14;  //start
                    int rowstarttwo_remark = dt.Rows.Count + 16;  //start
               

                
                    Comm = new SqlCommand("spGetReportMetreToMile_VCB", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.CommandTimeout = 600;
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                    Comm.Parameters.Add(param2);  
                    adapter.SelectCommand = Comm;
                    dt1 = new DataTable();
                    adapter.Fill(dt1);
                    if (dt1.Rows.Count != 0)
                    {
                        int col2 = 1;
                        var totalCols2 = dt1.Columns.Count;
                        var totalRows2 = dt1.Rows.Count;
                        var totalFooter2 = dt1.Columns.Count;

                        //remarkrow = totalRows2;

                        var totalfoot2 = dt1.Rows.Count + 1 + headerend_iresign;
                        var footheader2 = dt1.Columns.Count;

                        int row2 = 0;
                        int fot2 = 0;

                        for (col2 = 1; col2 <= totalCols2; col2++)
                        {


                            workSheet.Cells[headertitle_iresign, col2].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle_iresign, col2].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, col2].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, col2].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign, col2].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign, col2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle_iresign, col2].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign, col2].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle_iresign, col2].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle_iresign, col2].AutoFitColumns();
                            workSheet.Cells[headertitle2_iresign, col2].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle2_iresign, col2].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, col2].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, col2].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign, col2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle2_iresign, col2].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign, col2].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle2_iresign, col2].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle2_iresign, col2].AutoFitColumns();
                            workSheet.Cells[headerend_iresign, col2].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headerend_iresign, col2].Style.Font.Size = 8;
                            workSheet.Cells[headerend_iresign, col2].Style.Font.Bold = true;
                            workSheet.Cells[headerend_iresign, col2].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign, col2].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign, col2].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign, col2].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headerend_iresign, col2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headerend_iresign, col2].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headerend_iresign, col2].AutoFitColumns();




                            string strcom = "A" + iresign.ToString();
                            workSheet.Cells[strcom].Value =strVCB;
                            workSheet.Cells[strcom].Style.Font.Name = "Angsana New";
                            workSheet.Cells[strcom].Style.Font.Size = 9;
                            workSheet.Cells[strcom].Style.Font.Bold = true;




                            workSheet.Cells[headertitle_iresign, 1, headerend_iresign, 1].Merge = true;
                            workSheet.Cells[headertitle_iresign, 1, headerend_iresign, 1].Value = "ลำดับ";
                            //workSheet.Cells[headertitle_iresign, 1, headerend_iresign, 1].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign, 1, headerend_iresign, 1].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 1, headerend_iresign, 1].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 1, headerend_iresign, 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign, 2, headerend_iresign, 2].Merge = true;
                            workSheet.Cells[headertitle_iresign, 2, headerend_iresign, 2].Value = "AA ID";
                            workSheet.Cells[headertitle_iresign, 2, headerend_iresign, 2].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 2, headerend_iresign, 2].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 2, headerend_iresign, 2].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign, 3, headerend_iresign, 3].Merge = true;
                            workSheet.Cells[headertitle_iresign, 3, headerend_iresign, 3].Value = "ชื่อลูกค้า";
                            workSheet.Cells[headertitle_iresign, 3, headerend_iresign, 3].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 3, headerend_iresign, 3].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 3, headerend_iresign, 3].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


          



                            workSheet.Cells[headertitle_iresign, 4, headerend_iresign, 4].Merge = true;
                            workSheet.Cells[headertitle_iresign, 4, headerend_iresign, 4].Value = "Company ID";
                            workSheet.Cells[headertitle_iresign, 4, headerend_iresign, 4].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 4, headerend_iresign, 4].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 4, headerend_iresign, 4].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign, 5, headerend_iresign, 5].Merge = true;
                            workSheet.Cells[headertitle_iresign, 5, headerend_iresign, 5].Value = "บริษัท";
                            workSheet.Cells[headertitle_iresign, 5, headerend_iresign, 5].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 5, headerend_iresign, 5].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 5, headerend_iresign, 5].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Merge = true;



                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Merge = true;
                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Value = "ลำดับที่ใน AA+CLUB 2021 Member List";
                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Style.WrapText = true;
                            workSheet.Cells[headertitle_iresign, 6, headerend_iresign, 6].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                       



                            workSheet.Cells[headertitle_iresign,7, headertitle_iresign, 18].Merge = true;
                            workSheet.Cells[headertitle_iresign, 7].Value = "Mile สะสม";
                            workSheet.Cells[headertitle_iresign, 7, headertitle_iresign, 18].Style.Font.Size = 9;                           
                            workSheet.Cells[headertitle_iresign, 7, headertitle_iresign, 18].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign, 7, headertitle_iresign, 18].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign, 7, headerend_iresign, 7].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 7, headerend_iresign, 7].Value = strmonth01;
                            workSheet.Cells[headertitle2_iresign, 7, headerend_iresign, 7].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 7, headerend_iresign, 7].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 7, headerend_iresign, 7].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                     
                            

                            workSheet.Cells[headertitle2_iresign, 8, headerend_iresign, 8].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 8, headerend_iresign, 8].Value = strmonth02;
                            workSheet.Cells[headertitle2_iresign, 8, headerend_iresign, 8].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 8, headerend_iresign, 8].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 8, headerend_iresign, 8].Style.VerticalAlignment = ExcelVerticalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign, 9, headerend_iresign, 9].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 9, headerend_iresign, 9].Value = strmonth03;
                            workSheet.Cells[headertitle2_iresign, 9, headerend_iresign, 9].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 9, headerend_iresign, 9].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 9, headerend_iresign, 9].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign, 10, headerend_iresign, 10].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 10, headerend_iresign, 10].Value = strmonth04;
                            workSheet.Cells[headertitle2_iresign, 10, headerend_iresign, 10].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 10, headerend_iresign, 10].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 10, headerend_iresign, 10].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign, 11, headerend_iresign, 11].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 11, headerend_iresign, 11].Value = strmonth05;
                            workSheet.Cells[headertitle2_iresign, 11, headerend_iresign, 11].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 11, headerend_iresign, 11].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 11, headerend_iresign, 11].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign, 12, headerend_iresign, 12].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 12, headerend_iresign, 12].Value = strmonth06;
                            workSheet.Cells[headertitle2_iresign, 12, headerend_iresign, 12].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 12, headerend_iresign, 12].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 12, headerend_iresign, 12].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle2_iresign, 13, headerend_iresign, 13].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 13, headerend_iresign, 13].Value = strmonth07;
                            workSheet.Cells[headertitle2_iresign, 13, headerend_iresign, 13].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 13, headerend_iresign, 13].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 13, headerend_iresign, 13].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign, 14, headerend_iresign, 14].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 14, headerend_iresign, 14].Value = strmonth08;
                            workSheet.Cells[headertitle2_iresign, 14, headerend_iresign, 14].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 14, headerend_iresign, 14].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 14, headerend_iresign, 14].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign, 15, headerend_iresign, 15].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 15, headerend_iresign, 15].Value = strmonth09;
                            workSheet.Cells[headertitle2_iresign, 15, headerend_iresign, 15].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 15, headerend_iresign, 15].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 15, headerend_iresign, 15].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign, 16, headerend_iresign, 16].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 16, headerend_iresign, 16].Value = strmonth10;
                            workSheet.Cells[headertitle2_iresign, 16, headerend_iresign, 16].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 16, headerend_iresign, 16].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 16, headerend_iresign, 16].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign, 17, headerend_iresign, 17].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 17, headerend_iresign, 17].Value = strmonth11;
                            workSheet.Cells[headertitle2_iresign, 17, headerend_iresign, 17].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 17, headerend_iresign, 17].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 17, headerend_iresign, 17].Style.VerticalAlignment = ExcelVerticalAlignment.Center;

                            workSheet.Cells[headertitle2_iresign, 18, headerend_iresign, 18].Merge = true;
                            workSheet.Cells[headertitle2_iresign, 18, headerend_iresign, 18].Value = strmonth12;
                            workSheet.Cells[headertitle2_iresign, 18, headerend_iresign, 18].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign, 18, headerend_iresign, 18].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign, 18, headerend_iresign, 18].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign, 19, headerend_iresign, 19].Merge = true;
                            workSheet.Cells[headertitle_iresign, 19, headerend_iresign, 19].Value = "Total";
                            workSheet.Cells[headertitle_iresign, 19, headerend_iresign, 19].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign, 19, headerend_iresign, 19].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign, 19, headerend_iresign, 19].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign, 19, headerend_iresign, 19].Merge = true;


                    

                            workSheet.Cells[headerend_iresign, col2].AutoFitColumns();



                        }




                        workSheet.Column(1).Width = 3;
                        workSheet.Column(2).Width = 4;
                        workSheet.Column(3).Width = 15;
                        workSheet.Column(4).Width = 6;
                        workSheet.Column(5).Width = 25;
                        workSheet.Column(6).Width = 10;
                        workSheet.Column(7).Width = 6;
                        workSheet.Column(8).Width = 6;
                        workSheet.Column(9).Width = 6;
                        workSheet.Column(10).Width = 6;
                        workSheet.Column(11).Width = 6;
                        workSheet.Column(12).Width = 6;
                        workSheet.Column(13).Width = 6;
                        workSheet.Column(14).Width = 6;
                        workSheet.Column(15).Width = 6;
                        workSheet.Column(16).Width = 6;
                        workSheet.Column(17).Width = 6;
                        workSheet.Column(18).Width = 6;
                        workSheet.Column(19).Width = 6;



                        for (row2 = 0; row2 <= totalRows2 - 1; row2++)
                        {
                            for (col2 = 0; col2 <= totalCols2 - 1; col2++)
                            {
                

                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Value = dt1.Rows[row2][col2];
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Font.Name = "Angsana New";
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Font.Size = 9;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Font.Bold = false;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row2 + rowstart_iresign, col2 + 1].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row2 + rowstart_iresign, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row2 + rowstart_iresign, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row2 + rowstart_iresign, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row2 + rowstart_iresign, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row2 + rowstart_iresign, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row2 + rowstart_iresign, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;







































                            }
                        }





                    }







                    int iresign3 = dt1.Rows.Count + 1 + rowstart_iresign;  //start
                    int headertitle_iresign3 = dt1.Rows.Count + 1 + rowstart_iresign+1;  //start
                    int headertitle2_iresign3 = dt1.Rows.Count + 1 + rowstart_iresign+2;  //start
                    int headerend_iresign3 = dt1.Rows.Count + 1+ rowstart_iresign+3;  //start
                    int rowstart_iresign3 = dt1.Rows.Count + rowstart_iresign+5;  //start
                  

                    Comm = new SqlCommand("spGetReportMetreToMile_VCC", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.CommandTimeout = 600;
                    SqlParameter param3 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                    Comm.Parameters.Add(param3);
                    adapter.SelectCommand = Comm;
                    dt2 = new DataTable();
                    adapter.Fill(dt2);
                    if (dt2.Rows.Count != 0)
                    {
                        int col3 = 1;
                        var totalCols3 = dt2.Columns.Count;
                        var totalRows3 = dt2.Rows.Count;
                        var totalFooter3 = dt2.Columns.Count;

                        //remarkrow = totalRows2;

                        var totalfoot2 = dt2.Rows.Count + 1 + headerend_iresign3;
                        var footheader2 = dt2.Columns.Count;

                        int row3 = 0;
                        int fot3 = 0;

                        for (col3 = 1; col3 <= totalCols3; col3++)
                        {


                            workSheet.Cells[headertitle_iresign3, col3].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle_iresign3, col3].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, col3].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, col3].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign3, col3].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign3, col3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle_iresign3, col3].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign3, col3].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle_iresign3, col3].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle_iresign3, col3].AutoFitColumns();
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign3, col3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle2_iresign3, col3].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle2_iresign3, col3].AutoFitColumns();
                            workSheet.Cells[headerend_iresign3, col3].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headerend_iresign3, col3].Style.Font.Size = 8;
                            workSheet.Cells[headerend_iresign3, col3].Style.Font.Bold = true;
                            workSheet.Cells[headerend_iresign3, col3].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign3, col3].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign3, col3].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign3, col3].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headerend_iresign3, col3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headerend_iresign3, col3].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headerend_iresign3, col3].AutoFitColumns();




                            string strcom3 = "A" + iresign3.ToString();
                            workSheet.Cells[strcom3].Value = strVCC;
                            workSheet.Cells[strcom3].Style.Font.Name = "Angsana New";
                            workSheet.Cells[strcom3].Style.Font.Size = 9;
                            workSheet.Cells[strcom3].Style.Font.Bold = true;




                            workSheet.Cells[headertitle_iresign3, 1, headerend_iresign3, 1].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 1, headerend_iresign3, 1].Value = "ลำดับ";
                            workSheet.Cells[headertitle_iresign3, 1, headerend_iresign3, 1].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 1, headerend_iresign3, 1].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 1, headerend_iresign3, 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign3, 2, headerend_iresign3, 2].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 2, headerend_iresign3, 2].Value = "AA ID";
                            workSheet.Cells[headertitle_iresign3, 2, headerend_iresign3, 2].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 2, headerend_iresign3, 2].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 2, headerend_iresign3, 2].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign3, 3, headerend_iresign3, 3].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 3, headerend_iresign3, 3].Value = "ชื่อลูกค้า";
                            workSheet.Cells[headertitle_iresign3, 3, headerend_iresign3, 3].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 3, headerend_iresign3, 3].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 3, headerend_iresign3, 3].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign3, 4, headerend_iresign3, 4].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 4, headerend_iresign3, 4].Value = "Company ID";
                            workSheet.Cells[headertitle_iresign3, 4, headerend_iresign3, 4].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 4, headerend_iresign3, 4].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 4, headerend_iresign3, 4].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign3, 5, headerend_iresign3, 5].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 5, headerend_iresign3, 5].Value = "บริษัท";
                            workSheet.Cells[headertitle_iresign3, 5, headerend_iresign3, 5].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 5, headerend_iresign3, 5].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 5, headerend_iresign3, 5].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Merge = true;



                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Value = "ลำดับที่ใน AA+CLUB 2021 Member List";
                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Style.WrapText = true;
                            workSheet.Cells[headertitle_iresign3, 6, headerend_iresign3, 6].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign3, 7, headertitle_iresign3, 18].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 7].Value = "Mile สะสม";
                            workSheet.Cells[headertitle_iresign3, 7, headertitle_iresign3, 18].Style.Font.Size = 9;
                            workSheet.Cells[headertitle_iresign3, 7, headertitle_iresign3, 18].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign3, 7, headertitle_iresign3, 18].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign3, 7, headerend_iresign3, 7].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 7, headerend_iresign3, 7].Value = strmonth01;
                            workSheet.Cells[headertitle2_iresign3, 7, headerend_iresign3, 7].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 7, headerend_iresign3, 7].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 7, headerend_iresign3, 7].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign3, 8, headerend_iresign3, 8].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 8, headerend_iresign3, 8].Value = strmonth02;
                            workSheet.Cells[headertitle2_iresign3, 8, headerend_iresign3, 8].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 8, headerend_iresign3, 8].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 8, headerend_iresign3, 8].Style.VerticalAlignment = ExcelVerticalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign3, 9, headerend_iresign3, 9].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 9, headerend_iresign3, 9].Value = strmonth03;
                            workSheet.Cells[headertitle2_iresign3, 9, headerend_iresign3, 9].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 9, headerend_iresign3, 9].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 9, headerend_iresign3, 9].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign3, 10, headerend_iresign3, 10].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 10, headerend_iresign3, 10].Value = strmonth04;
                            workSheet.Cells[headertitle2_iresign3, 10, headerend_iresign3, 10].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 10, headerend_iresign3, 10].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 10, headerend_iresign3, 10].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign3, 11, headerend_iresign3, 11].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 11, headerend_iresign3, 11].Value = strmonth05;
                            workSheet.Cells[headertitle2_iresign3, 11, headerend_iresign3, 11].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 11, headerend_iresign3, 11].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 11, headerend_iresign3, 11].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign3, 12, headerend_iresign3, 12].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 12, headerend_iresign3, 12].Value = strmonth06;
                            workSheet.Cells[headertitle2_iresign3, 12, headerend_iresign3, 12].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 12, headerend_iresign3, 12].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 12, headerend_iresign3, 12].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle2_iresign3, 13, headerend_iresign3, 13].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 13, headerend_iresign3, 13].Value = strmonth07;
                            workSheet.Cells[headertitle2_iresign3, 13, headerend_iresign3, 13].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 13, headerend_iresign3, 13].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 13, headerend_iresign3, 13].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign3, 14, headerend_iresign3, 14].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 14, headerend_iresign3, 14].Value = strmonth08;
                            workSheet.Cells[headertitle2_iresign3, 14, headerend_iresign3, 14].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 14, headerend_iresign3, 14].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 14, headerend_iresign3, 14].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign3, 15, headerend_iresign3, 15].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 15, headerend_iresign3, 15].Value = strmonth09;
                            workSheet.Cells[headertitle2_iresign3, 15, headerend_iresign3, 15].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 15, headerend_iresign3, 15].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 15, headerend_iresign3, 15].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign3, 16, headerend_iresign3, 16].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 16, headerend_iresign3, 16].Value = strmonth10;
                            workSheet.Cells[headertitle2_iresign3, 16, headerend_iresign3, 16].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 16, headerend_iresign3, 16].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 16, headerend_iresign3, 16].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign3, 17, headerend_iresign3, 17].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 17, headerend_iresign3, 17].Value = strmonth11;
                            workSheet.Cells[headertitle2_iresign3, 17, headerend_iresign3, 17].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 17, headerend_iresign3, 17].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 17, headerend_iresign3, 17].Style.VerticalAlignment = ExcelVerticalAlignment.Center;

                            workSheet.Cells[headertitle2_iresign3, 18, headerend_iresign3, 18].Merge = true;
                            workSheet.Cells[headertitle2_iresign3, 18, headerend_iresign3, 18].Value = strmonth12;
                            workSheet.Cells[headertitle2_iresign3, 18, headerend_iresign3, 18].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign3, 18, headerend_iresign3, 18].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign3, 18, headerend_iresign3, 18].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign3, 19, headerend_iresign3, 19].Merge = true;
                            workSheet.Cells[headertitle_iresign3, 19, headerend_iresign3, 19].Value = "Total";
                            workSheet.Cells[headertitle_iresign3, 19, headerend_iresign3, 19].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign3, 19, headerend_iresign3, 19].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign3, 19, headerend_iresign3, 19].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign3, 19, headerend_iresign3, 19].Merge = true;




                            workSheet.Cells[headerend_iresign3, col3].AutoFitColumns();



                        }




                        workSheet.Column(1).Width = 3;
                        workSheet.Column(2).Width = 4;
                        workSheet.Column(3).Width = 15;
                        workSheet.Column(4).Width = 6;
                        workSheet.Column(5).Width = 25;
                        workSheet.Column(6).Width = 10;
                        workSheet.Column(7).Width = 6;
                        workSheet.Column(8).Width = 6;
                        workSheet.Column(9).Width = 6;
                        workSheet.Column(10).Width = 6;
                        workSheet.Column(11).Width = 6;
                        workSheet.Column(12).Width = 6;
                        workSheet.Column(13).Width = 6;
                        workSheet.Column(14).Width = 6;
                        workSheet.Column(15).Width = 6;
                        workSheet.Column(16).Width = 6;
                        workSheet.Column(17).Width = 6;
                        workSheet.Column(18).Width = 6;
                        workSheet.Column(19).Width = 6;





                        for (row3 = 0; row3 <= totalRows3 - 1; row3++)
                        {
                            for (col3 = 0; col3 <= totalCols3 - 1; col3++)
                            {


                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Value = dt2.Rows[row3][col3];
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Font.Name = "Angsana New";
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Font.Size = 9;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Font.Bold = false;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row3 + rowstart_iresign3, col3 + 1].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row3 + rowstart_iresign3, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row3 + rowstart_iresign3, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row3 + rowstart_iresign3, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row3 + rowstart_iresign3, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row3 + rowstart_iresign3, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row3 + rowstart_iresign3, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;








                            }
                        }



                    }













                    int iresign4 = dt2.Rows.Count + 1 + rowstart_iresign3;  //start
                    int headertitle_iresign4 = dt2.Rows.Count + 1 + rowstart_iresign3 + 1;  //start
                    int headertitle2_iresign4 = dt2.Rows.Count + 1 + rowstart_iresign3 + 2;  //start
                    int headerend_iresign4 = dt2.Rows.Count + 1 + rowstart_iresign3 + 3;  //start
                    int rowstart_iresign4 = dt2.Rows.Count + rowstart_iresign3 + 5;  //start


                    Comm = new SqlCommand("spGetReportMetreToMile_VCD", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.CommandTimeout = 600;
                    SqlParameter param4 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                    Comm.Parameters.Add(param4);
                    adapter.SelectCommand = Comm;
                    dt3 = new DataTable();
                    adapter.Fill(dt3);
                    if (dt3.Rows.Count != 0)
                    {
                        int col4 = 1;
                        var totalCols4 = dt3.Columns.Count;
                        var totalRows4 = dt3.Rows.Count;
                        var totalFooter4 = dt3.Columns.Count;

                        //remarkrow = totalRows2;

                        var totalfoot3 = dt3.Rows.Count + 1 + headerend_iresign3;
                        var footheader3 = dt3.Columns.Count;

                        int row4 = 0;
                        int fot4 = 0;

                        for (col4 = 1; col4 <= totalCols4; col4++)
                        {


                            workSheet.Cells[headertitle_iresign4, col4].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle_iresign4, col4].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, col4].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, col4].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign4, col4].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign4, col4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle_iresign4, col4].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign4, col4].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle_iresign4, col4].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle_iresign4, col4].AutoFitColumns();
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign4, col4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle2_iresign4, col4].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle2_iresign4, col4].AutoFitColumns();
                            workSheet.Cells[headerend_iresign4, col4].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headerend_iresign4, col4].Style.Font.Size = 8;
                            workSheet.Cells[headerend_iresign4, col4].Style.Font.Bold = true;
                            workSheet.Cells[headerend_iresign4, col4].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign4, col4].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign4, col4].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign4, col4].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headerend_iresign4, col4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headerend_iresign4, col4].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headerend_iresign4, col4].AutoFitColumns();




                            string strcom4 = "A" + iresign4.ToString();
                            workSheet.Cells[strcom4].Value = strVCD;
                            workSheet.Cells[strcom4].Style.Font.Name = "Angsana New";
                            workSheet.Cells[strcom4].Style.Font.Size = 9;
                            workSheet.Cells[strcom4].Style.Font.Bold = true;




                            workSheet.Cells[headertitle_iresign4, 1, headerend_iresign4, 1].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 1, headerend_iresign4, 1].Value = "ลำดับ";
                            workSheet.Cells[headertitle_iresign4, 1, headerend_iresign4, 1].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 1, headerend_iresign4, 1].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 1, headerend_iresign4, 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign4, 2, headerend_iresign4, 2].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 2, headerend_iresign4, 2].Value = "AA ID";
                            workSheet.Cells[headertitle_iresign4, 2, headerend_iresign4, 2].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 2, headerend_iresign4, 2].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 2, headerend_iresign4, 2].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign4, 3, headerend_iresign4, 3].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 3, headerend_iresign4, 3].Value = "ชื่อลูกค้า";
                            workSheet.Cells[headertitle_iresign4, 3, headerend_iresign4, 3].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 3, headerend_iresign4, 3].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 3, headerend_iresign4, 3].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign4, 4, headerend_iresign4, 4].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 4, headerend_iresign4, 4].Value = "Company ID";
                            workSheet.Cells[headertitle_iresign4, 4, headerend_iresign4, 4].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 4, headerend_iresign4, 4].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 4, headerend_iresign4, 4].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign4, 5, headerend_iresign4, 5].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 5, headerend_iresign4, 5].Value = "บริษัท";
                            workSheet.Cells[headertitle_iresign4, 5, headerend_iresign4, 5].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 5, headerend_iresign4, 5].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 5, headerend_iresign4, 5].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Merge = true;



                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Value = "ลำดับที่ใน AA+CLUB 2021 Member List";
                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Style.WrapText = true;
                            workSheet.Cells[headertitle_iresign4, 6, headerend_iresign4, 6].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign4, 7, headertitle_iresign4, 18].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 7].Value = "Mile สะสม";
                            workSheet.Cells[headertitle_iresign4, 7, headertitle_iresign4, 18].Style.Font.Size = 9;
                            workSheet.Cells[headertitle_iresign4, 7, headertitle_iresign4, 18].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign4, 7, headertitle_iresign4, 18].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign4, 7, headerend_iresign4, 7].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 7, headerend_iresign4, 7].Value = strmonth01;
                            workSheet.Cells[headertitle2_iresign4, 7, headerend_iresign4, 7].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 7, headerend_iresign4, 7].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 7, headerend_iresign4, 7].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign4, 8, headerend_iresign4, 8].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 8, headerend_iresign4, 8].Value = strmonth02;
                            workSheet.Cells[headertitle2_iresign4, 8, headerend_iresign4, 8].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 8, headerend_iresign4, 8].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 8, headerend_iresign4, 8].Style.VerticalAlignment = ExcelVerticalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign4, 9, headerend_iresign4, 9].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 9, headerend_iresign4, 9].Value = strmonth03;
                            workSheet.Cells[headertitle2_iresign4, 9, headerend_iresign4, 9].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 9, headerend_iresign4, 9].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 9, headerend_iresign4, 9].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign4, 10, headerend_iresign4, 10].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 10, headerend_iresign4, 10].Value = strmonth04;
                            workSheet.Cells[headertitle2_iresign4, 10, headerend_iresign4, 10].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 10, headerend_iresign4, 10].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 10, headerend_iresign4, 10].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign4, 11, headerend_iresign4, 11].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 11, headerend_iresign4, 11].Value = strmonth05;
                            workSheet.Cells[headertitle2_iresign4, 11, headerend_iresign4, 11].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 11, headerend_iresign4, 11].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 11, headerend_iresign4, 11].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign4, 12, headerend_iresign4, 12].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 12, headerend_iresign4, 12].Value = strmonth06;
                            workSheet.Cells[headertitle2_iresign4, 12, headerend_iresign4, 12].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 12, headerend_iresign4, 12].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 12, headerend_iresign4, 12].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle2_iresign4, 13, headerend_iresign4, 13].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 13, headerend_iresign4, 13].Value = strmonth07;
                            workSheet.Cells[headertitle2_iresign4, 13, headerend_iresign4, 13].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 13, headerend_iresign4, 13].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 13, headerend_iresign4, 13].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign4, 14, headerend_iresign4, 14].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 14, headerend_iresign4, 14].Value = strmonth08;
                            workSheet.Cells[headertitle2_iresign4, 14, headerend_iresign4, 14].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 14, headerend_iresign4, 14].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 14, headerend_iresign4, 14].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign4, 15, headerend_iresign4, 15].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 15, headerend_iresign4, 15].Value = strmonth09;
                            workSheet.Cells[headertitle2_iresign4, 15, headerend_iresign4, 15].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 15, headerend_iresign4, 15].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 15, headerend_iresign4, 15].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign4, 16, headerend_iresign4, 16].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 16, headerend_iresign4, 16].Value = strmonth10;
                            workSheet.Cells[headertitle2_iresign4, 16, headerend_iresign4, 16].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 16, headerend_iresign4, 16].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 16, headerend_iresign4, 16].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign4, 17, headerend_iresign4, 17].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 17, headerend_iresign4, 17].Value = strmonth11;
                            workSheet.Cells[headertitle2_iresign4, 17, headerend_iresign4, 17].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 17, headerend_iresign4, 17].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 17, headerend_iresign4, 17].Style.VerticalAlignment = ExcelVerticalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign4, 18, headerend_iresign4, 18].Merge = true;
                            workSheet.Cells[headertitle2_iresign4, 18, headerend_iresign4, 18].Value = strmonth12;
                            workSheet.Cells[headertitle2_iresign4, 18, headerend_iresign4, 18].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign4, 18, headerend_iresign4, 18].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign4, 18, headerend_iresign4, 18].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign4, 19, headerend_iresign4, 19].Merge = true;
                            workSheet.Cells[headertitle_iresign4, 19, headerend_iresign4, 19].Value = "Total";
                            workSheet.Cells[headertitle_iresign4, 19, headerend_iresign4, 19].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign4, 19, headerend_iresign4, 19].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign4, 19, headerend_iresign4, 19].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign4, 19, headerend_iresign4, 19].Merge = true;




                            workSheet.Cells[headerend_iresign4, col4].AutoFitColumns();



                        }




                        workSheet.Column(1).Width = 3;
                        workSheet.Column(2).Width = 4;
                        workSheet.Column(3).Width = 15;
                        workSheet.Column(4).Width = 6;
                        workSheet.Column(5).Width = 25;
                        workSheet.Column(6).Width = 10;
                        workSheet.Column(7).Width = 6;
                        workSheet.Column(8).Width = 6;
                        workSheet.Column(9).Width = 6;
                        workSheet.Column(10).Width = 6;
                        workSheet.Column(11).Width = 6;
                        workSheet.Column(12).Width = 6;
                        workSheet.Column(13).Width = 6;
                        workSheet.Column(14).Width = 6;
                        workSheet.Column(15).Width = 6;
                        workSheet.Column(16).Width = 6;
                        workSheet.Column(17).Width = 6;
                        workSheet.Column(18).Width = 6;
                        workSheet.Column(19).Width = 6;





                        for (row4 = 0; row4 <= totalRows4 - 1; row4++)
                        {
                            for (col4 = 0; col4 <= totalCols4 - 1; col4++)
                            {


                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Value = dt3.Rows[row4][col4];
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Font.Name = "Angsana New";
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Font.Size = 9;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Font.Bold = false;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row4 + rowstart_iresign4, col4 + 1].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row4 + rowstart_iresign4, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row4 + rowstart_iresign4, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row4 + rowstart_iresign4, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row4 + rowstart_iresign4, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row4 + rowstart_iresign4, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row4 + rowstart_iresign4, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;







































                            }
                        }



                    }






                    int iresign5 = dt3.Rows.Count + 1 + rowstart_iresign4;  //start
                    int headertitle_iresign5 = dt3.Rows.Count + 1 + rowstart_iresign4 + 1;  //start
                    int headertitle2_iresign5 = dt3.Rows.Count + 1 + rowstart_iresign4 + 2;  //start
                    int headerend_iresign5 = dt3.Rows.Count + 1 + rowstart_iresign4 + 3;  //start
                    int rowstart_iresign5 = dt3.Rows.Count + rowstart_iresign4 + 5;  //start


                    Comm = new SqlCommand("spGetReportMetreToMile_VCE", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.CommandTimeout = 600;
                    SqlParameter param5 = new SqlParameter() { ParameterName = "@ProYear", Value = Inyear };
                    Comm.Parameters.Add(param5);
                    adapter.SelectCommand = Comm;
                    dt4 = new DataTable();
                    adapter.Fill(dt4);
                    if (dt4.Rows.Count != 0)
                    {
                        int col5 = 1;
                        var totalCols5 = dt4.Columns.Count;
                        var totalRows5 = dt4.Rows.Count;
                        var totalFooter5 = dt4.Columns.Count;

                        //remarkrow = totalRows2;

                        var totalfoot4 = dt4.Rows.Count + 1 + headerend_iresign4;
                        var footheader4 = dt4.Columns.Count;

                        int row5 = 0;
                        int fot5 = 0;

                        for (col5 = 1; col5 <= totalCols5; col5++)
                        {


                            workSheet.Cells[headertitle_iresign5, col5].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle_iresign5, col5].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, col5].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, col5].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign5, col5].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign5, col5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle_iresign5, col5].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign5, col5].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle_iresign5, col5].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle_iresign5, col5].AutoFitColumns();
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign5, col5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headertitle2_iresign5, col5].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headertitle2_iresign5, col5].AutoFitColumns();
                            workSheet.Cells[headerend_iresign5, col5].Style.Font.Name = "Angsana New";
                            workSheet.Cells[headerend_iresign5, col5].Style.Font.Size = 8;
                            workSheet.Cells[headerend_iresign5, col5].Style.Font.Bold = true;
                            workSheet.Cells[headerend_iresign5, col5].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign5, col5].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign5, col5].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headerend_iresign5, col5].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[headerend_iresign5, col5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            workSheet.Cells[headerend_iresign5, col5].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                            workSheet.Cells[headerend_iresign5, col5].AutoFitColumns();




                            string strcom5 = "A" + iresign5.ToString();
                            workSheet.Cells[strcom5].Value = strVCE;
                            workSheet.Cells[strcom5].Style.Font.Name = "Angsana New";
                            workSheet.Cells[strcom5].Style.Font.Size = 9;
                            workSheet.Cells[strcom5].Style.Font.Bold = true;




                            workSheet.Cells[headertitle_iresign5, 1, headerend_iresign5, 1].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 1, headerend_iresign5, 1].Value = "ลำดับ";
                            workSheet.Cells[headertitle_iresign5, 1, headerend_iresign5, 1].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 1, headerend_iresign5, 1].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 1, headerend_iresign5, 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign5, 2, headerend_iresign5, 2].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 2, headerend_iresign5, 2].Value = "AA ID";
                            workSheet.Cells[headertitle_iresign5, 2, headerend_iresign5, 2].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 2, headerend_iresign5, 2].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 2, headerend_iresign5, 2].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign5, 3, headerend_iresign5, 3].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 3, headerend_iresign5, 3].Value = "ชื่อลูกค้า";
                            workSheet.Cells[headertitle_iresign5, 3, headerend_iresign5, 3].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 3, headerend_iresign5, 3].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 3, headerend_iresign5, 3].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign5, 4, headerend_iresign5, 4].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 4, headerend_iresign5, 4].Value = "Company ID";
                            workSheet.Cells[headertitle_iresign5, 4, headerend_iresign5, 4].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 4, headerend_iresign5, 4].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 4, headerend_iresign5, 4].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle_iresign5, 5, headerend_iresign5, 5].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 5, headerend_iresign5, 5].Value = "บริษัท";
                            workSheet.Cells[headertitle_iresign5, 5, headerend_iresign5, 5].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 5, headerend_iresign5, 5].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 5, headerend_iresign5, 5].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Merge = true;



                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Value = "ลำดับที่ใน AA+CLUB 2021 Member List";
                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Style.WrapText = true;
                            workSheet.Cells[headertitle_iresign5, 6, headerend_iresign5, 6].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle_iresign5, 7, headertitle_iresign5, 18].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 7].Value = "Mile สะสม";
                            workSheet.Cells[headertitle_iresign5, 7, headertitle_iresign5, 18].Style.Font.Size = 9;
                            workSheet.Cells[headertitle_iresign5, 7, headertitle_iresign5, 18].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                            workSheet.Cells[headertitle_iresign5, 7, headertitle_iresign5, 18].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign5, 7, headerend_iresign5, 7].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 7, headerend_iresign5, 7].Value = strmonth01;
                            workSheet.Cells[headertitle2_iresign5, 7, headerend_iresign5, 7].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 7, headerend_iresign5, 7].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 7, headerend_iresign5, 7].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign5, 8, headerend_iresign5, 8].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 8, headerend_iresign5, 8].Value = strmonth02;
                            workSheet.Cells[headertitle2_iresign5, 8, headerend_iresign5, 8].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 8, headerend_iresign5, 8].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 8, headerend_iresign5, 8].Style.VerticalAlignment = ExcelVerticalAlignment.Center;





                            workSheet.Cells[headertitle2_iresign5, 9, headerend_iresign5, 9].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 9, headerend_iresign5, 9].Value = strmonth03;
                            workSheet.Cells[headertitle2_iresign5, 9, headerend_iresign5, 9].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 9, headerend_iresign5, 9].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 9, headerend_iresign5, 9].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign5, 10, headerend_iresign5, 10].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 10, headerend_iresign5, 10].Value = strmonth04;
                            workSheet.Cells[headertitle2_iresign5, 10, headerend_iresign5, 10].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 10, headerend_iresign5, 10].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 10, headerend_iresign5, 10].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign5, 11, headerend_iresign5, 11].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 11, headerend_iresign5, 11].Value = strmonth05;
                            workSheet.Cells[headertitle2_iresign5, 11, headerend_iresign5, 11].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 11, headerend_iresign5, 11].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 11, headerend_iresign5, 11].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign5, 12, headerend_iresign5, 12].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 12, headerend_iresign5, 12].Value = strmonth06;
                            workSheet.Cells[headertitle2_iresign5, 12, headerend_iresign5, 12].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 12, headerend_iresign5, 12].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 12, headerend_iresign5, 12].Style.VerticalAlignment = ExcelVerticalAlignment.Center;




                            workSheet.Cells[headertitle2_iresign5, 13, headerend_iresign5, 13].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 13, headerend_iresign5, 13].Value = strmonth07;
                            workSheet.Cells[headertitle2_iresign5, 13, headerend_iresign5, 13].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 13, headerend_iresign5, 13].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 13, headerend_iresign5, 13].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign5, 14, headerend_iresign5, 14].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 14, headerend_iresign5, 14].Value = strmonth08;
                            workSheet.Cells[headertitle2_iresign5, 14, headerend_iresign5, 14].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 14, headerend_iresign5, 14].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 14, headerend_iresign5, 14].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign5, 15, headerend_iresign5, 15].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 15, headerend_iresign5, 15].Value = strmonth09;
                            workSheet.Cells[headertitle2_iresign5, 15, headerend_iresign5, 15].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 15, headerend_iresign5, 15].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 15, headerend_iresign5, 15].Style.VerticalAlignment = ExcelVerticalAlignment.Center;



                            workSheet.Cells[headertitle2_iresign5, 16, headerend_iresign5, 16].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 16, headerend_iresign5, 16].Value = strmonth10;
                            workSheet.Cells[headertitle2_iresign5, 16, headerend_iresign5, 16].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 16, headerend_iresign5, 16].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 16, headerend_iresign5, 16].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign5, 17, headerend_iresign5, 17].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 17, headerend_iresign5, 17].Value = strmonth11;
                            workSheet.Cells[headertitle2_iresign5, 17, headerend_iresign5, 17].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 17, headerend_iresign5, 17].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 17, headerend_iresign5, 17].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle2_iresign5, 18, headerend_iresign5, 18].Merge = true;
                            workSheet.Cells[headertitle2_iresign5, 18, headerend_iresign5, 18].Value = strmonth12;
                            workSheet.Cells[headertitle2_iresign5, 18, headerend_iresign5, 18].Style.Font.Size = 8;
                            workSheet.Cells[headertitle2_iresign5, 18, headerend_iresign5, 18].Style.Font.Bold = true;
                            workSheet.Cells[headertitle2_iresign5, 18, headerend_iresign5, 18].Style.VerticalAlignment = ExcelVerticalAlignment.Center;


                            workSheet.Cells[headertitle_iresign5, 19, headerend_iresign5, 19].Merge = true;
                            workSheet.Cells[headertitle_iresign5, 19, headerend_iresign5, 19].Value = "Total";
                            workSheet.Cells[headertitle_iresign5, 19, headerend_iresign5, 19].Style.Font.Size = 8;
                            workSheet.Cells[headertitle_iresign5, 19, headerend_iresign5, 19].Style.Font.Bold = true;
                            workSheet.Cells[headertitle_iresign5, 19, headerend_iresign5, 19].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[headertitle_iresign5, 19, headerend_iresign5, 19].Merge = true;


                            workSheet.Cells[headerend_iresign5, col5].AutoFitColumns();



                        }




                        workSheet.Column(1).Width = 3;
                        workSheet.Column(2).Width = 4;
                        workSheet.Column(3).Width = 15;
                        workSheet.Column(4).Width = 6;
                        workSheet.Column(5).Width = 25;
                        workSheet.Column(6).Width = 10;
                        workSheet.Column(7).Width = 6;
                        workSheet.Column(8).Width = 6;
                        workSheet.Column(9).Width = 6;
                        workSheet.Column(10).Width = 6;
                        workSheet.Column(11).Width = 6;
                        workSheet.Column(12).Width = 6;
                        workSheet.Column(13).Width = 6;
                        workSheet.Column(14).Width = 6;
                        workSheet.Column(15).Width = 6;
                        workSheet.Column(16).Width = 6;
                        workSheet.Column(17).Width = 6;
                        workSheet.Column(18).Width = 6;
                        workSheet.Column(19).Width = 6;





                        for (row5 = 0; row5 <= totalRows5 - 1; row5++)
                        {
                            for (col5 = 0; col5 <= totalCols5 - 1; col5++)
                            {


                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Value = dt4.Rows[row5][col5];
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Font.Name = "Angsana New";
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Font.Size = 9;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Font.Bold = false;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Border.Top.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Border.Right.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row5 + rowstart_iresign5, col5 + 1].Style.Border.Left.Style = ExcelBorderStyle.Hair;
                                workSheet.Cells[row5 + rowstart_iresign5, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row5 + rowstart_iresign5, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row5 + rowstart_iresign5, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row5 + rowstart_iresign5, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                workSheet.Cells[row5 + rowstart_iresign5, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                                workSheet.Cells[row5 + rowstart_iresign5, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;







































                            }
                        }



                    }



            }




                using (var memoryStream = new MemoryStream())
                    {
                        Response.AddHeader("content-disposition", "attachment;  filename=MetreToMile_" + Inyear + ".xls");
                        excel.SaveAs(memoryStream);
                        memoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                }




                
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