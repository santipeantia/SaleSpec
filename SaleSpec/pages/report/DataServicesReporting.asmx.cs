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
        string cs = "server=192.168.1.4;database=DB_SaleSpec;uid=ampel;pwd=Amp7896321;";
        //string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=Amp88Cloud@2018;";

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


        [WebMethod]
        public void GetNewProjectReporting(string strUserID, string strStartDate, string strEndDate)
        {
            List<GetDataNewProjectReporting> newprojects = new List<GetDataNewProjectReporting>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spNewProjectReporting", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strUserID };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };

                comm.Parameters.Add(param1);
                comm.Parameters.Add(param2);
                comm.Parameters.Add(param3);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read()) {
                    GetDataNewProjectReporting newproject = new GetDataNewProjectReporting();
                    newproject.WeekDate = rdr["WeekDate"].ToString();
                    newproject.WeekTime = rdr["WeekTime"].ToString();
                    newproject.CompanyID = rdr["CompanyID"].ToString();
                    newproject.CompanyName = rdr["CompanyName"].ToString();
                    newproject.ArchitecID = rdr["ArchitecID"].ToString();
                    newproject.Name = rdr["Name"].ToString();
                    newproject.ProjectID = rdr["ProjectID"].ToString();
                    newproject.ProjectName = rdr["ProjectName"].ToString();
                    newproject.Location = rdr["Location"].ToString();
                    newproject.StatusID = rdr["StatusID"].ToString();
                    newproject.StatusNameEn = rdr["StatusNameEn"].ToString();
                    newproject.StepID = rdr["StepID"].ToString();
                    newproject.StepNameEn = rdr["StepNameEn"].ToString();
                    newproject.Remark = rdr["Remark"].ToString();
                    newproject.UserID = rdr["UserID"].ToString();
                    newproject.EmpCode = rdr["EmpCode"].ToString();
                    newproject.CreatedBy = rdr["CreatedBy"].ToString();
                    newproject.CreatedDate = rdr["CreatedDate"].ToString();
                    newprojects.Add(newproject);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(newprojects));

        }



    }
}
