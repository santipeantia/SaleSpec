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
    public partial class projects : System.Web.UI.Page
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

        public string sPage = "trans/projects";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetInitialData();
            }
        }

        protected void GetInitialData()
        {
            GetDataBind();
        }

        protected void GetDataBind()
        {
            try
            {
                int sYear = 2014; // int.Parse(Convert.ToDateTime(datepickerstart.Value).ToString("yyyy"));
                int sMonth = 01; // int.Parse(Convert.ToDateTime(datepickerstart.Value).ToString("MM"));

                int eYear = 2019; // int.Parse(Convert.ToDateTime(datepickerend.Value).ToString("yyyy"));
                int eMonth = 12; // int.Parse(Convert.ToDateTime(datepickerend.Value).ToString("MM"));

                ssql = "SELECT top(20) ProjectID, ProjectYear, ProjectMonth, ProjectName, CompanyName, Location, MainCons, RefRfDf, " +
                       "        ProjStep, ProductType, RefProfile, Quantity, RefType, DeliveryDate, Drawing, StatusID, TypeID, SaleSpec " +
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
                        string strStatus = dt.Rows[i]["StatusID"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td> "+ strProjectID + "-"+ i + " </td> " +
                                        "     <td> FirstName - "+ i +"</td> " +
                                        "     <td> LastName - " + i + " </td> " +
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
    }
}