using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace SaleSpec.Class
{
    /// <summary>
    /// Summary description for DataServices
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class DataServices : System.Web.Services.WebService
    {
        dbConnection dbConn = new dbConnection();
        
        [WebMethod]
        public void GetDataCompany()
        {
            dbConn.OpenConn();
            string cs = "server=ITMANAGER-IT;database=DB_SaleSpec;uid=sa;pwd=sa1234;";
            List<GetCompany> companies = new List<GetCompany>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetCompany", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetCompany company = new GetCompany();
                    company.CompanyID = rdr["CompanyID"].ToString();
                    company.CompanyNameTH = rdr["CompanyNameTH"].ToString();
                    company.CompanyNameEN = rdr["CompanyNameEN"].ToString();
                    companies.Add(company);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(companies));
        }
    }
}
