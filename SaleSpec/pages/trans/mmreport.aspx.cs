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



    }
}