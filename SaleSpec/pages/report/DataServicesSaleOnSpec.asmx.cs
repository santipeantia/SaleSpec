using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;


namespace SaleSpec.pages.report
{
    /// <summary>
    /// Summary description for DataServicesSaleOnSpec
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class DataServicesSaleOnSpec : System.Web.Services.WebService
    {
        string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=AmpelCloud@2020;";


        [WebMethod]
        public void GetDataProjectWithInvoice(string strInvNo) {
            List<GetDataProjectWithInvoice> projects = new List<GetDataProjectWithInvoice>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spWeeklyReporting", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@strInvNo", Value = strInvNo };
                comm.Parameters.Add(param1);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProjectWithInvoice project = new GetDataProjectWithInvoice();
                    project.docuno = rdr["WeekDate"].ToString();
                    //weeks.WeekTime = rdr["WeekTime"].ToString();
                    //week.CompanyID = rdr["CompanyID"].ToString();
                    //week.CompanyName = rdr["CompanyName"].ToString();
                    //week.ArchitecID = rdr["ArchitecID"].ToString();
                    //week.Name = rdr["Name"].ToString();
                    //week.ProjectID = rdr["ProjectID"].ToString();
                    //week.ProjectName = rdr["ProjectName"].ToString();
                    //week.Location = rdr["Location"].ToString();
                    //week.StatusID = rdr["StatusID"].ToString();
                    //week.StatusNameEn = rdr["StatusNameEn"].ToString();
                    //week.StepID = rdr["StepID"].ToString();
                    //week.StepNameEn = rdr["StepNameEn"].ToString();
                    //week.Remark = rdr["Remark"].ToString();
                    //week.UserID = rdr["UserID"].ToString();
                    //week.EmpCode = rdr["EmpCode"].ToString();
                    //week.CreatedBy = rdr["CreatedBy"].ToString();
                    //week.CreatedDate = rdr["CreatedDate"].ToString();
                    projects.Add(project);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(projects));
        }
    }
}
