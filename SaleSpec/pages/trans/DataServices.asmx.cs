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
        string cs = "server=ITMANAGER-IT;database=DB_SaleSpec;uid=sa;pwd=sa1234;";

        [WebMethod]
        public void GetDataCompany()
        {
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

        [WebMethod]
        public void GetDataArchitect(string CompanyID)
        {
            List<GetArchitects> architects = new List<GetArchitects>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetArchitect", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param = new SqlParameter()
                {
                    ParameterName = "@CompanyID", Value = CompanyID
                };
                //comm.Parameters.Add(new SqlParameter("@username", "username"));
                //comm.Parameters.Add(new SqlParameter("@password", "password"));
                comm.Parameters.Add(param);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetArchitects architect = new GetArchitects();
                    architect.ArchitecID = rdr["ArchitecID"].ToString();
                    architect.FullName = rdr["FullName"].ToString();
                    architects.Add(architect);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(architects));
        }

        [WebMethod]
        public void GetInsertCompanies(string CompanyName, string CompanyName2, string Address, string ProvinceID, string ContactName, string Phone, string Mobile, string Email, string StatusConID)
        {
            List<GetInsertCompany> companies = new List<GetInsertCompany>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertCompany", conn);
                comm.CommandType = CommandType.StoredProcedure;

                //SqlParameter param1 = new SqlParameter()
                //{
                //    ParameterName = "@CompanyName",
                //    Value = CompanyName
                //};

                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@CompanyName2", CompanyName2);
                comm.Parameters.AddWithValue("@Address", Address);
                comm.Parameters.AddWithValue("@ProvinceID", ProvinceID);
                comm.Parameters.AddWithValue("@ContactName", ContactName);
                comm.Parameters.AddWithValue("@Phone", Phone);
                comm.Parameters.AddWithValue("@Mobile", Mobile);
                comm.Parameters.AddWithValue("@Email", Email);
                comm.Parameters.AddWithValue("@StatusConID", StatusConID);
                comm.ExecuteNonQuery();
                conn.Close();

                //SqlDataReader rdr = comm.ExecuteReader();
                //while (rdr.Read())
                //{
                //    GetArchitects architect = new GetArchitects();
                //    architect.ArchitecID = rdr["ArchitecID"].ToString();
                //    architect.FullName = rdr["FullName"].ToString();
                //    architects.Add(architect);
                //}
            }
            //JavaScriptSerializer js = new JavaScriptSerializer();
            //Context.Response.ContentType = "application/json";
            //Context.Response.Write(js.Serialize(architects));
        }
    }
}
