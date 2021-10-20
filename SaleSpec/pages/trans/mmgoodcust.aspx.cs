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
    public partial class mmgoodcust : System.Web.UI.Page
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
                GetInitialData();
            }


        }


        protected void GetInitialData()
        {

            GetCustStatusDataBind();
        }



        protected void GetCustStatusDataBind()
        {
            try
            {
                ssql = "spGet_adArchitecture";

                Conn = dbConn.OpenConn();
                Comm = new SqlCommand(ssql);
                Comm.Connection = Conn;
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(Comm);

                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string ArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string CompanyID = dt.Rows[i]["CompanyID"].ToString();
                        string Name = dt.Rows[i]["Name"].ToString();
                        string FirstName = dt.Rows[i]["FirstName"].ToString();
                        string LastName = dt.Rows[i]["LastName"].ToString();
                        string SpecID = dt.Rows[i]["SpecID"].ToString();

                        strTblActive += "<tr> " +
                                        "<td class=\"text-center\">" + ArchitecID + "</td> " +
                                        "<td >" + CompanyID + "</td> " +
                                        "<td >" + Name + "</td> " +
                                        "<td >" + FirstName + "</td> " +
                                        "<td >" + LastName + "</td> " +
                                        "<td >" + SpecID + "</td> " +
                                        "<td style=\"width:50px;\"> " +
                                        "  <a href=\"#\" title=\"Edit\"><i class=\"btnSelect fa fa-pencil-square-o text-green\"></i></a></td> " +
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


    }
}