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
    public partial class projects_update : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                GetInitialData();
            }
        }

        protected void GetInitialData()
        {
            string strEmpCode = Session["sEmpID"].ToString();
            int ifromYear = int.Parse(DateTime.Now.ToString("yyyy")) -1 ;
            int ifromMonth = 1;
            int itoYear = int.Parse(DateTime.Now.ToString("yyyy"));
            int itoMonth = int.Parse(DateTime.Now.ToString("MM")); ;

            frommonth.Value = ifromMonth.ToString();
            fromyear.Value = ifromYear.ToString();

            tomonth.Value = itoMonth.ToString();
            toyear.Value = itoYear.ToString();

            GetDataBind(strEmpCode, ifromYear, ifromMonth, itoYear, itoMonth);
        }

        protected void GetDataBind(string EmpCode, int iFromYear, int iFromMonth, int iToYear, int iToMonth)
        {
            try
            {
                ssql = "SELECT	a.ProjectID, a.ProjectYear, a.ProjectMonth, a.ProjectName,  " +
                        "        a.ArchitecID, b.FirstName, b.LastName, a.CompanyID, c.CompanyName,  " +
                        "        a.Location, a.ProvinceID, d.ProvinceName, a.MainCons, a.RefRfDf, a.ProductType,    " +
                        "        a.RefProfile, a.Quantity, a.RefType, a.DeliveryDate, a.Drawing, a.ProcID, f.ProcName2,  " +
                        "        a.StepID, g.StepName2, a.SaleID, a.EmpCode, a.sEmFirstName, a.sEmLastName, a.CreatedDate,   " +
                        "        a.CreatedBy, a.LastedUpdate, a.UpdatedBy  " +
                        "FROM    adProjects2 a left join  " +
                        "        adArchitecture b on a.ArchitecID = b.ArchitecID left join  " +
                        "        adCompany c on a.CompanyID = c.CompanyID left join  " +
                        "        adProvince d on a.ProvinceID = d.ProvinceID left join  " +
                        "        adEmployee e on a.EmpCode = e.sEmpID left join  " +
                        "        adProcess f on a.ProcID = f.ProcID left join  " +
                        "        adStep g on a.StepID = g.StepID  " +
                        "WHERE(EmpCode = '"+ EmpCode + "') and(ProjectYear >= "+ iFromYear + " and ProjectMonth >= "+ iFromMonth + ")  " +
                        "            and(ProjectYear <= "+ iToYear + " and ProjectMonth <= "+ iToMonth + ")  " +
                        "ORDER BY Projectyear, ProjectMonth";

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
                        string strArchitecID = dt.Rows[i]["ArchitecID"].ToString();
                        string strFirstName = dt.Rows[i]["FirstName"].ToString();
                        string strLastName = dt.Rows[i]["LastName"].ToString();
                        string strLocation = dt.Rows[i]["Location"].ToString();
                        string strProjStep = dt.Rows[i]["ProcName2"].ToString();
                        string strStatus = dt.Rows[i]["StepName2"].ToString();

                        strTblDetail += "<tr> " +
                                        "     <td>" + strProjectID + "</td> " +
                                        "     <td>" + strProjectYear + "</td> " +
                                        "     <td>" + strProjectMonth + "</td> " +
                                        "     <td>" + strProjectName + "</td> " +
                                        "     <td>" + strArchitecID + "</td> " +
                                        "     <td>" + strFirstName + "</td> " +
                                        "     <td>" + strLastName + "</td> " +
                                        "     <td>" + strLocation + "</td> " +
                                        "     <td>" + strProjStep + "</td> " +
                                        "     <td>" + strStatus + "</td> " +
                                        "<td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"../../pages/trans/projects-update-status?opt=wkr&proj="+ strProjectID + "&evt=edit\" title=\"Edit\"><i class=\"fa fa-pencil-square-o text-green\"></i></a></td> " +
                                        "<td style=\"width: 20px; text-align: center;\"> " +
                                        "       <a href=\"#\" title=\"Delete\"><i class=\"fa fa-trash text-red\"></i></a></td> " +
                                        "</tr>";


                    }

                }
                }


            catch (Exception ex)
            {
            }
        }

        protected void GetDataSearch(object sender, EventArgs e)
        {
            string strEmpCode = Session["sEmpID"].ToString();
            int ifromYear = int.Parse(fromyear.Value);
            int ifromMonth = int.Parse(frommonth.Value);
            int itoYear = int.Parse(toyear.Value);
            int itoMonth = int.Parse(tomonth.Value); ;

            GetDataBind(strEmpCode, ifromYear, ifromMonth, itoYear, itoMonth);
        }

    }
}