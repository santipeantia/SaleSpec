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

namespace SaleSpec.pages.report
{
    public partial class saleweeklyreport : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        string ssql;
        DataTable dt = new DataTable();

        public static string strErorConn = "";

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        public string strMsgAlert = "";
        public string strTblDetail = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //string strUserID = Session["UserID"].ToString();
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection conn = new SqlConnection();
                conn = dbConn.OpenConn();

                SqlCommand comm = new SqlCommand("spWeeklyReporting", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = "VCA" };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = "2019-04-01" };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = "2019-05-30" };

                comm.Parameters.Add(param1);
                comm.Parameters.Add(param2);
                comm.Parameters.Add(param3);
                //conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = comm;
                dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count != 0) {

                    strTblDetail += "";

                    //Response.Write("<script>alert('Data inserted successfully')</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('"+ ex.Message +"')</script>");
            }
        }
    }
}