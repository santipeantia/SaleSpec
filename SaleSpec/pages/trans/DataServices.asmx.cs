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
        public void GetPositions()
        {
            List<GetDataPosition> positions = new List<GetDataPosition>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetPositions", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataPosition position = new GetDataPosition();
                    position.PositionID = rdr["PositionID"].ToString();
                    position.PositionNameTH = rdr["PositionNameTH"].ToString();
                    position.PositionNameEN = rdr["PositionNameEN"].ToString();
                    positions.Add(position);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(positions));
        }

        
        [WebMethod]
        public void GetStepSpec()
        {
            List<GetDataStepSpec> stepspecs = new List<GetDataStepSpec>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetStep", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataStepSpec stepspec = new GetDataStepSpec();
                    stepspec.StepID = rdr["StepID"].ToString();
                    stepspec.StepNameTh = rdr["StepNameTh"].ToString();
                    stepspec.StepNameEn = rdr["StepNameEn"].ToString();
                    stepspecs.Add(stepspec);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(stepspecs));
        }

        [WebMethod]
        public void GetProductType()
        {
            List<GetDataProductType> producttypes = new List<GetDataProductType>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProductType", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProductType producttype = new GetDataProductType();
                    producttype.ProdTypeID = rdr["ProdTypeID"].ToString();
                    producttype.ProdTypeNameTH = rdr["ProdTypeNameTH"].ToString();
                    producttype.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                    producttypes.Add(producttype);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(producttypes));
        }

        [WebMethod]
        public void GetProducts()
        {
            List<GetDataProducts> products = new List<GetDataProducts>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProducts", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProducts product = new GetDataProducts();
                    product.ProdID = rdr["ProdID"].ToString();
                    product.ProdTypeID = rdr["ProdTypeID"].ToString();
                    product.ProdNameTH = rdr["ProdNameTH"].ToString();
                    product.ProdNameEN = rdr["ProdNameEN"].ToString();
                    products.Add(product);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(products));
        }

        [WebMethod]
        public void GetInsertCompanies(string CompanyName, string CompanyName2, string Address, string ProvinceID, string ContactName, 
                                        string Phone, string Mobile, string Email, string StatusConID)
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
                
        [WebMethod]
        public void GetDataCountArchitect()
        {
            List<GetCountArchitect> countarchitects = new List<GetCountArchitect>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetCountArchitect", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetCountArchitect countarchitect = new GetCountArchitect();
                    countarchitect.ArchitecID = rdr["ArchitecID"].ToString();
                    countarchitects.Add(countarchitect);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();

            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(countarchitects));
        }

        [WebMethod]
        public void GetDataInsertArchitect(string ArchitecID, string CompanyID, string Name, string FirstName, string LastName, 
                                            string NickName, string Position, string Address, string Phone, string Mobile, string Email, string StatusConID)
        {
            List<GetInsertArchitect> companies = new List<GetInsertArchitect>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertArchitect", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@FirstName", FirstName);
                comm.Parameters.AddWithValue("@LastName", LastName);
                comm.Parameters.AddWithValue("@NickName", NickName);
                comm.Parameters.AddWithValue("@Position", Position);
                comm.Parameters.AddWithValue("@Address", Address);
                comm.Parameters.AddWithValue("@Phone", Phone);
                comm.Parameters.AddWithValue("@Mobile", Mobile);
                comm.Parameters.AddWithValue("@Email", Email);
                comm.Parameters.AddWithValue("@StatusConID", StatusConID);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }  
    }
}
