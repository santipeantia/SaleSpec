using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;


namespace SaleSpec.pages.trans
{
    public partial class mmproducts : System.Web.UI.Page
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
        public string strTblmmoption = "";
        public string strTblActive = "";

        public string strClassActiveOption = "active";
        public string strClassActivePoint = "";

        public string strimg ="" ;
        public byte[] strimgDEL;

       

   dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }

          

        }




        protected void btnSearch_click(object sender, EventArgs e)
        {
            try
            {
                

                string Inyear = Request.Form["TextInYear"].ToString();
                string strYearDesc = Request.Form["txtYearDesc"].ToString();
                Session["PointYear"] = Inyear;
                Session["PointYearDesc"] = strYearDesc;
                
                if (Session["PointYear"].ToString() != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGet_mmpointmaster", Conn);
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
                            string InYear = dt.Rows[i]["InYear"].ToString();
                            string step_type = dt.Rows[i]["step_type"].ToString();
                            string pointmin = dt.Rows[i]["pointmin"].ToString();
                            string pointmax = dt.Rows[i]["pointmax"].ToString();
                            string descvoucher = dt.Rows[i]["descvoucher"].ToString();
                            string remark = dt.Rows[i]["remark"].ToString();               
                            string urlview = dt.Rows[i]["urlview"].ToString();
                            string urldelete = dt.Rows[i]["urldelete"].ToString();

                            strTblDetail += "<tr> " +
                                 "<td class=\"hidden\">" + id + "</td> " +
                                 "<td class=\"text-center\">" + xno + "</td> " +
                                    "<td class=\"text-center\">" + InYear + "</td> " +
                                     "<td class=\"text-center\">" + step_type + "</td> " +
                                     "<td class=\"text-right\">" + pointmin + "</td> " +
                                        "<td class=\"text-right\">" + pointmax + "</td> " +
                                         "<td class=\"text-left\">" + descvoucher + "</td> " +
                                       "<td class=\"text-left\">" + remark + "</td> " +                                 
                                             "   <td>" + urlview + "</td> " +
                                             "   <td>" + urldelete + "</td> " +
                                        "</tr>";

                        }
                        strClassActiveOption = "";
                        strClassActivePoint = "active";

                        //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "lnkClick()", true);

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


        protected void btnpointdetail_click(object sender, EventArgs e)
        {
            try
            {


             
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGet_mmpointmasterdetail", Conn);
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
                            string InYear = dt.Rows[i]["InYear"].ToString();
                            string step_type = dt.Rows[i]["step_type"].ToString();
                            string pointmin = dt.Rows[i]["pointmin"].ToString();
                            string pointmax = dt.Rows[i]["pointmax"].ToString();
                            string descvoucher = dt.Rows[i]["descvoucher"].ToString();
                            string remark = dt.Rows[i]["remark"].ToString();
                            string urlview = dt.Rows[i]["urlview"].ToString();
                            string urldelete = dt.Rows[i]["urldelete"].ToString();

                            strTblDetail += "<tr> " +
                                 "<td class=\"hidden\">" + id + "</td> " +
                                 "<td class=\"text-center\">" + xno + "</td> " +
                                    "<td class=\"text-center\">" + InYear + "</td> " +
                                     "<td class=\"text-center\">" + step_type + "</td> " +
                                     "<td class=\"text-right\">" + pointmin + "</td> " +
                                        "<td class=\"text-right\">" + pointmax + "</td> " +
                                         "<td class=\"text-left\">" + descvoucher + "</td> " +
                                       "<td class=\"text-left\">" + remark + "</td> " +
                                             "   <td>" + urlview + "</td> " +
                                             "   <td>" + urldelete + "</td> " +
                                        "</tr>";

                        }
                        strClassActiveOption = "";
                        strClassActivePoint = "active";

                   
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


        protected void btnSearchmmoption_click(object sender, EventArgs e)
        {
            try
            {


                string Inyear = Request.Form["TextInYearoption"].ToString();
                string strYearDesc = Request.Form["txtYearDescoption"].ToString();

                Session["Yearoption"] = Inyear;
                Session["YearDescoption"] = strYearDesc;

                if (Session["Yearoption"].ToString() != "SELECTED ALL")
                {
                    Conn = new SqlConnection();
                    Conn = dbConn.OpenConn();
                    Comm = new SqlCommand("spGet_mmoption", Conn);
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
                            string InYear = dt.Rows[i]["InYear"].ToString();
                            string steptype_id = dt.Rows[i]["steptype_id"].ToString();
                            string step_type = dt.Rows[i]["step_type"].ToString();
                            string step = dt.Rows[i]["step"].ToString();
                            string option_id = dt.Rows[i]["option_id"].ToString();
                            string optiondetail = dt.Rows[i]["optiondetail"].ToString();
                            string detailcost = dt.Rows[i]["detailcost"].ToString();
                            string productname = dt.Rows[i]["productname"].ToString();
                            byte[] images = (byte[])dt.Rows[i]["images"];
                            string urlview = dt.Rows[i]["urlview"].ToString();
                            string urldelete = dt.Rows[i]["urldelete"].ToString();



                            if (images != null && images.Length > 0)
                            {


                                strTblmmoption += "<tr> " +
                                 //"<td class=\"hidden\">" + id + "</td> " +
                                 "<td class=\"hidden\">" + id + "</td> " +
                                 "<td class=\"text-center\">" + xno + "</td> " +
                                    "<td class=\"text-center\">" + InYear + "</td> " +
                                     "<td class=\"hidden\">" + steptype_id + "</td> " +
                                     "<td class=\"hidden\">" + step_type + "</td> " +
                                     "<td class=\"text-center\">" + step + "</td> " +
                                     "<td class=\"hidden\">" + option_id + "</td> " +
                                     "<td class=\"text-left\">" + optiondetail + "</td> " +
                                    "<td style=\"width:50px;\"> <img height='75px' width='75px' class='btnSelectoption' src=\'data:image/jpg;base64," + (Convert.ToBase64String(images)) + "' /></td> " +
                                    "<td class=\"text-left\">" + detailcost + "</td> " +
                                         "<td class=\"text-left\">" + productname + "</td> " +

                                             "   <td>" + urlview + "</td> " +
                                             "   <td>" + urldelete + "</td> " +
                                        "</tr>";

                            }

                            else
                            {
                                strTblmmoption += "<tr> " +
                                //"<td class=\"hidden\">" + id + "</td> " +
                                "<td class=\"hidden\">" + id + "</td> " +
                                "<td class=\"text-center\">" + xno + "</td> " +
                                   "<td class=\"text-center\">" + InYear + "</td> " +
                                    "<td class=\"hidden\">" + steptype_id + "</td> " +
                                    "<td class=\"hidden\">" + step_type + "</td> " +
                                    "<td class=\"text-center\">" + step + "</td> " +
                                    "<td class=\"hidden\">" + option_id + "</td> " +
                                    "<td class=\"text-left\">" + optiondetail + "</td> " +
                                    "<td style=\"width:50px;\"> <img height='75px' width='75px' class='btnSelectoption' src='../../image/download.png' /></td> " +
                                    "<td class=\"text-left\">" + detailcost + "</td> " +
                                    "<td class=\"text-left\">" + productname + "</td> " +
                                    "<td>" + urlview + "</td> " +
                                    "<td>" + urldelete + "</td> " +
                                       "</tr>";

                            }


                        }
                        strClassActiveOption = "active";
                        strClassActivePoint = "";

                        //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "lnkClick()", true);

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



        protected void btnExportPDF_click(object sender, EventArgs e)
        {
            try
            {

                string Inyear = Request.Form["TextInYearoption"].ToString();
                string strYearDesc = Request.Form["txtYearDescoption"].ToString();
                Session["Yearoption"] = Inyear;
                Session["YearDescoption"] = strYearDesc;
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGet_mmProduct_rpt", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter() { ParameterName = "@Inyear", Value = Inyear };
                Comm.Parameters.Add(param1);
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);
                rpt.Load(Server.MapPath("../reports/rptmmpromotion.rpt"));
                reports.Dtmmpromotion Dtmmpromotion = new reports.Dtmmpromotion();
                Dtmmpromotion.Merge(dt);
                rpt.SetDataSource(dt); 
                rpt.SetParameterValue("@Inyear", Inyear);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "MetretoMile"+Inyear);

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



        protected void LoadData()
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();
                Comm = new SqlCommand("spGet_mmoptiondetail", Conn);
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
                        string InYear = dt.Rows[i]["InYear"].ToString();
                        string steptype_id = dt.Rows[i]["steptype_id"].ToString();
                        string step_type = dt.Rows[i]["step_type"].ToString();
                        string step = dt.Rows[i]["step"].ToString();
                        string option_id = dt.Rows[i]["option_id"].ToString();
                        string optiondetail = dt.Rows[i]["optiondetail"].ToString();
                        string detailcost = dt.Rows[i]["detailcost"].ToString();
                        string productname = dt.Rows[i]["productname"].ToString();
                        byte[] images = (byte[])dt.Rows[i]["images"];                    
                        string urlview = dt.Rows[i]["urlview"].ToString();
                        string urldelete = dt.Rows[i]["urldelete"].ToString();



                        if (images != null && images.Length > 0)
                        {

                            strTblmmoption += "<tr> " +
                             //"<td class=\"hidden\">" + id + "</td> " +
                             "<td class=\"hidden\">" + id + "</td> " +
                             "<td class=\"text-center\">" + xno + "</td> " +
                                "<td class=\"text-center\">" + InYear + "</td> " +
                                 "<td class=\"hidden\">" + steptype_id + "</td> " +
                                 "<td class=\"hidden\">" + step_type + "</td> " +
                                 "<td class=\"text-center\">" + step + "</td> " +
                                 "<td class=\"hidden\">" + option_id + "</td> " +
                                   "<td class=\"text-left\">" + optiondetail + "</td> " +
                                     "<td style=\"width:50px;\"> <img height='75px' width='75px' class='btnSelectoption' src=\'data:image/jpg;base64," + Convert.ToBase64String(images) + "' /></td> " +
                                    "<td class=\"text-left\">" + detailcost + "</td> " +
                                     "<td class=\"text-left\">" + productname + "</td> " +
                                         "   <td>" + urlview + "</td> " +
                                         "   <td>" + urldelete + "</td> " +
                                    "</tr>";


                        }



                        else
                        {
                            strTblmmoption += "<tr> " +
                            //"<td class=\"hidden\">" + id + "</td> " +
                            "<td class=\"hidden\">" + id + "</td> " +
                            "<td class=\"text-center\">" + xno + "</td> " +
                               "<td class=\"text-center\">" + InYear + "</td> " +
                                "<td class=\"hidden\">" + steptype_id + "</td> " +
                                "<td class=\"hidden\">" + step_type + "</td> " +
                                "<td class=\"text-center\">" + step + "</td> " +
                                "<td class=\"hidden\">" + option_id + "</td> " +
                                "<td class=\"text-left\">" + optiondetail + "</td> " +
                                "<td style=\"width:50px;\"> <img height='75px' width='75px' class='btnSelectoption' src='../../image/download.png' /></td> " +
                                "<td class=\"text-left\">" + detailcost + "</td> " +
                                "<td class=\"text-left\">" + productname + "</td> " +
                                "<td>" + urlview + "</td> " +
                                "<td>" + urldelete + "</td> " +
                                   "</tr>";

                        }



                    }
                    strClassActiveOption = "active";
                    strClassActivePoint = "";

                    //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "lnkClick()", true);

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



        protected void btnSavemmoption_Click(object sender, EventArgs e)
        {
           
          
            string stryear = Request.Form["InYearNewoption"].ToString();
            string steptypeid = Request.Form["TextsteptypeID"].ToString();
            string steptype = Request.Form["Txtsteptype"].ToString();
            string selectOption = Request.Form["selectTextoption"].ToString();
            string cost = Request.Form["TextCost"].ToString();
            string productname = Request.Form["TextProductName"].ToString();
            byte[] imgData = FileUpload.FileBytes; 

            SqlCommand comm = new SqlCommand("spsave_mmoption", dbConn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@typeupdate", 1);
            comm.Parameters.AddWithValue("@ID", "");
            comm.Parameters.AddWithValue("@InYear", stryear);
            comm.Parameters.AddWithValue("@steptypeid", steptypeid);
            comm.Parameters.AddWithValue("@steptype", steptype);
            comm.Parameters.AddWithValue("@selectOption", selectOption);
            comm.Parameters.AddWithValue("@cost", cost);
            comm.Parameters.AddWithValue("@productname", productname);
            comm.Parameters.AddWithValue("@images", imgData);          
            comm.Parameters.AddWithValue("@createby", Session["EmpCode"]);
            comm.Parameters.AddWithValue("@updateby", Session["EmpCode"]);
            comm.ExecuteNonQuery();
            dbConn.CloseConn();

            LoadData();

        }


        protected void btnUpdatemmoption_Click(object sender, EventArgs e)
        {
           
            string stryear = Request.Form["InYearNewoptionEdit"].ToString();
            string steptypeid = Request.Form["TextsteptypeIDEdit"].ToString();
            string steptype = Request.Form["TxtsteptypeEdit"].ToString();
            string selectOption = Request.Form["selectTextoptionEdit"].ToString();
            string cost = Request.Form["TextCostEdit"].ToString();
            string productname = Request.Form["TextProductNameEdit"].ToString();
            string id = Request.Form["TxtIDEditOption"].ToString();          
            byte[] imgDataEdit = FileUploadEdit.FileBytes; 

            SqlCommand comm = new SqlCommand("spsave_mmoption", dbConn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@typeupdate", 2);
            comm.Parameters.AddWithValue("@ID", id);
            comm.Parameters.AddWithValue("@InYear", stryear);
            comm.Parameters.AddWithValue("@steptypeid", steptypeid);
            comm.Parameters.AddWithValue("@steptype", steptype);
            comm.Parameters.AddWithValue("@selectOption", selectOption);
            comm.Parameters.AddWithValue("@cost", cost);
            comm.Parameters.AddWithValue("@productname", productname);
            comm.Parameters.AddWithValue("@images", imgDataEdit);
            comm.Parameters.AddWithValue("@createby","");
            comm.Parameters.AddWithValue("@updateby", Session["EmpCode"]);
            comm.ExecuteNonQuery();
            dbConn.CloseConn();

            LoadData();

        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
           
      
            string id = Request.Form["TxtIDOptionDEL"].ToString();        
   
            SqlCommand comm = new SqlCommand("spdelete_mmoption", dbConn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;       
            comm.Parameters.AddWithValue("@ID", id);           
            comm.ExecuteNonQuery();
            dbConn.CloseConn();

            LoadData();
        }



    





    }
}