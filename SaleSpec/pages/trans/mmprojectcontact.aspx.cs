using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace SaleSpec.pages.trans
{
    public partial class mmprojectcontact : System.Web.UI.Page
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
               // GetInitialData();
            }
        }

        protected void button2_click(object sender, EventArgs e)
        {
            try
            {
                string strStartdate = Request.Form["datepickertrans"].ToString();
                string strdateend = Request.Form["datepickerend"].ToString();

                string StartDate = (Convert.ToDateTime(strStartdate).ToString("yyyy-MM-dd"));
                string StartEnd = (Convert.ToDateTime(strdateend).ToString("yyyy-MM-dd"));

                Session["Datestart"] = StartDate;
                Session["DateEnd"] = StartEnd;

                if (Session["Datestart"].ToString() != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGetProjectContract", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    SqlParameter param1 = new SqlParameter() { ParameterName = "@datestart", Value = StartDate };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@dateend", Value = StartEnd };
                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count != 0)
                    {

                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {

                            string xno = dt.Rows[i]["xno"].ToString();
                            string DocuDate = dt.Rows[i]["DocuDate"].ToString();
                            string CustCode = dt.Rows[i]["CustCode"].ToString();
                            string DocuNo = dt.Rows[i]["DocuNo"].ToString();
                            string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                            string Name = dt.Rows[i]["Name"].ToString();
                            string CustName = dt.Rows[i]["CustName"].ToString();
                            string GoodName = dt.Rows[i]["GoodName"].ToString();
                            string QAmount = dt.Rows[i]["QAmount"].ToString();
                            string NetRF_B = dt.Rows[i]["NetRF_B"].ToString();
                            string SaleCode = dt.Rows[i]["SaleCode"].ToString();
                            string SaleName = dt.Rows[i]["SaleName"].ToString();
                            string net = dt.Rows[i]["net"].ToString();
                            string netcheck = dt.Rows[i]["netcheck"].ToString();                            
                            string urlview = dt.Rows[i]["urlview"].ToString();
                            string urldelete = dt.Rows[i]["urldelete"].ToString();
                            strTblDetail += "<tr> " +
                                 "<td class=\"text-right\">" + xno + "</td> " +
                                    "<td class=\"text-right\">" + DocuDate + "</td> " +
                                     "<td>" + DocuNo + "</td> " +
                                     "<td>" + CustCode + "</td> " +
                                        "<td class=\"text-left\">" + CustName + "</td> " +
                                         "<td class=\"text-center\">" + ArchitecID + "</td> " +
                                       "<td class=\"text-left\">" + Name + "</td> " +
                                      "   <td class=\"text-left\">" + GoodName + "</td> " +
                                       "   <td class=\"text-right\">" + QAmount + "</td> " +
                                       "   <td class=\"text-right\">" + NetRF_B + "</td> " +
                                            "   <td>" + net + "</td> " +
                                       "   <td class=\"text-right\">" + SaleCode + "</td> " +
                                        "   <td class=\"text-right\">" + SaleName + "</td> " +
                                            "  <td class=\"hidden\">" + netcheck + "</td> " +
                                             "  <td>" + urlview + "</td> " +
                                             "   <td>" + urldelete + "</td> " +
                                        "</tr>";

                        }

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


        protected void btnSearch_click(object sender, EventArgs e)
        {
            try
            {
                string strStartdate = Request.Form["datepickertrans"].ToString();
                string strdateend = Request.Form["datepickerend"].ToString();

                string StartDate = (Convert.ToDateTime(strStartdate).ToString("yyyy-MM-dd"));
                string StartEnd = (Convert.ToDateTime(strdateend).ToString("yyyy-MM-dd"));

                Session["Datestart"] = StartDate;
                Session["DateEnd"] = StartEnd;

                if (Session["Datestart"].ToString() != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGetProjectContract", Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    SqlParameter param1 = new SqlParameter() { ParameterName = "@datestart", Value = StartDate };
                    SqlParameter param2 = new SqlParameter() { ParameterName = "@dateend", Value = StartEnd };      
                    Comm.Parameters.Add(param1);
                    Comm.Parameters.Add(param2);            
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = Comm;
                    dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count != 0)
                    {

                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {
                            
                            string xno = dt.Rows[i]["xno"].ToString();
                            string DocuDate = dt.Rows[i]["DocuDate"].ToString();
                            string CustCode = dt.Rows[i]["CustCode"].ToString();
                            string DocuNo = dt.Rows[i]["DocuNo"].ToString();
                            string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                            string Name = dt.Rows[i]["Name"].ToString();
                            string CustName = dt.Rows[i]["CustName"].ToString();                        
                            string GoodName = dt.Rows[i]["GoodName"].ToString();                        
                            string QAmount = dt.Rows[i]["QAmount"].ToString();
                            string NetRF_B = dt.Rows[i]["NetRF_B"].ToString();
                            string SaleCode = dt.Rows[i]["SaleCode"].ToString();
                            string SaleName = dt.Rows[i]["SaleName"].ToString();
                            string net = dt.Rows[i]["net"].ToString();
                            string netcheck = dt.Rows[i]["netcheck"].ToString();
                            string urlview = dt.Rows[i]["urlview"].ToString();
                            string urldelete = dt.Rows[i]["urldelete"].ToString();

                            strTblDetail += "<tr> " +
                                 "<td class=\"text-right\">" + xno + "</td> " +
                                    "<td class=\"text-right\">" + DocuDate + "</td> " +
                                     "<td>" + DocuNo + "</td> " +
                                     "<td>" + CustCode + "</td> " +
                                        "<td class=\"text-left\">" + CustName + "</td> " +
                                         "<td class=\"text-center\">" + ArchitecID + "</td> " +
                                       "<td class=\"text-left\">" + Name + "</td> " +
                                      "   <td class=\"text-left\">" + GoodName + "</td> " +
                                       "   <td class=\"text-right\">" + QAmount + "</td> " +
                                       "   <td class=\"text-right\">" + NetRF_B + "</td> " +
                                            "   <td>" + net + "</td> " +
                                       "   <td class=\"text-right\">" + SaleCode + "</td> " +
                                        "   <td class=\"text-right\">" + SaleName + "</td> " +
                                           "   <td class=\"hidden\">" + netcheck + "</td> " +
                                             "   <td>" + urlview + "</td> " +
                                             "   <td>" + urldelete + "</td> " +

                                        "</tr>";

                        }

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


    }
}