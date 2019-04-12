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
    /// Summary description for DataServicesReporting
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class DataServicesReporting : System.Web.Services.WebService
    {
        string cs = "server=ITMANAGER-IT;database=DB_SaleSpec;uid=sa;pwd=sa1234;";

        //get attached
        [WebMethod]
        public void GetWeeklyReporting(string strUserID, string strStartDate, string strEndDate)
        {
            List<GetDataWeeklyReporting> weeks = new List<GetDataWeeklyReporting>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spWeeklyReporting", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strUserID };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };

                comm.Parameters.Add(param1);
                comm.Parameters.Add(param2);
                comm.Parameters.Add(param3);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataWeeklyReporting week = new GetDataWeeklyReporting();
                    week.WeekDate = rdr["WeekDate"].ToString();
                    week.WeekTime = rdr["WeekTime"].ToString();
                    week.CompanyID = rdr["CompanyID"].ToString();
                    week.CompanyName = rdr["CompanyName"].ToString();
                    week.ArchitecID = rdr["ArchitecID"].ToString();
                    week.Name = rdr["Name"].ToString();
                    week.ProjectID = rdr["ProjectID"].ToString();
                    week.ProjectName = rdr["ProjectName"].ToString();
                    week.Location = rdr["Location"].ToString();
                    week.StatusID = rdr["StatusID"].ToString();
                    week.StatusNameEn = rdr["StatusNameEn"].ToString();
                    week.StepID = rdr["StepID"].ToString();
                    week.StepNameEn = rdr["StepNameEn"].ToString();
                    week.Remark = rdr["Remark"].ToString();
                    week.UserID = rdr["UserID"].ToString();
                    week.EmpCode = rdr["EmpCode"].ToString();
                    week.CreatedBy = rdr["CreatedBy"].ToString();
                    week.CreatedDate = rdr["CreatedDate"].ToString();
                    weeks.Add(week);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(weeks));
        }
    }
}
