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
        //string cs = "server=ITMANAGER-IT;database=DB_SaleSpec;uid=sa;pwd=sa1234;";
        //string cs = "server=192.168.1.4;database=DB_SaleSpec;uid=ampel;pwd=Amp7896321;";
        string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=Amp88Cloud@2018;";

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
        public void GetProducts(string ProdTypeID)
        {
            List<GetDataProducts> products = new List<GetDataProducts>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProducts", conn);
                comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param = new SqlParameter()
                {
                    ParameterName = "@ProdTypeID",
                    Value = ProdTypeID
                };
                comm.Parameters.Add(param);
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
        public void GetProfile()
        {
            List<GetDataProfile> profiles = new List<GetDataProfile>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProfile", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProfile profile = new GetDataProfile();
                    profile.ProfID = rdr["ProfID"].ToString();
                    profile.ProfNameTH = rdr["ProfNameTH"].ToString();
                    profile.ProfNameEN = rdr["ProfNameEN"].ToString();
                    profiles.Add(profile);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(profiles));
        }

        [WebMethod]
        public void GetStatus()
        {
            List<GetDataStatus> statuses = new List<GetDataStatus>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetStatus", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataStatus status = new GetDataStatus();
                    status.StatusID = rdr["StatusID"].ToString();
                    status.StatusNameTh = rdr["StatusNameTh"].ToString();
                    status.StatusNameEn = rdr["StatusNameEn"].ToString();
                    statuses.Add(status);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(statuses));
        }

        //GetDataStatusConfirm
        [WebMethod]
        public void GetStatusConfirm()
        {
            List<GetDataStatusConfirm> confirmed = new List<GetDataStatusConfirm>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetStatusConfirm", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataStatusConfirm confirm = new GetDataStatusConfirm();
                    confirm.StatusConID = rdr["StatusConID"].ToString();
                    confirm.ConDesc = rdr["ConDesc"].ToString();
                    confirm.ConDesc2 = rdr["ConDesc2"].ToString();
                    confirmed.Add(confirm);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(confirmed));
        }

        [WebMethod]
        public void GetTransEntry()
        {
            List<GetDataTransEntry> transactions = new List<GetDataTransEntry>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetTransEntry", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataTransEntry transaction = new GetDataTransEntry();
                    transaction.TransID = rdr["TransID"].ToString();
                    transaction.TransNameTH = rdr["TransNameTH"].ToString();
                    transaction.TransNameEN = rdr["TransNameEN"].ToString();
                    transactions.Add(transaction);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(transactions));
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
        public void GetCountProject()
        {
            List<GetDataCountProject> countprojects = new List<GetDataCountProject>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetCountProject", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataCountProject countproject = new GetDataCountProject();
                    countproject.ProjectID = rdr["ProjectID"].ToString();
                    countprojects.Add(countproject);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();

            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(countprojects));
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

        [WebMethod]
        public void GetInsertWeeklyReport(string WeekDate, string WeekTime, string CompanyID, string CompanyName, string ArchitecID, string Name, string TransID, string TransNameEN,
                                          string ProjectID, string ProjectName, string Location, string TurnKey, string StepID, string StepNameEn, string BiddingName1, string OwnerName1, string BiddingName2, string OwnerName2,
                                          string BiddingName3, string OwnerName3, string AwardMC, string ContactMC, string AwardRF, string ContactRF, string ProdTypeID, string ProdTypeNameEN, string ProdID, string ProdNameEN,
                                          string ProfID, string ProfNameEN, string Quantity, string DeliveryDate, string NextVisitDate, string StatusID, string StatusNameEn, string Remark,
                                          string UserID, string EmpCode, string CreatedBy, string CreatedDate)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReport", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@WeekDate", WeekDate);
                comm.Parameters.AddWithValue("@WeekTime", WeekTime);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@TransID", TransID);
                comm.Parameters.AddWithValue("@TransNameEN", TransNameEN);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Location", Location);
                comm.Parameters.AddWithValue("@TurnKey", TurnKey);                
                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StepNameEn", StepNameEn);
                comm.Parameters.AddWithValue("@BiddingName1", BiddingName1);
                comm.Parameters.AddWithValue("@OwnerName1", OwnerName1);
                comm.Parameters.AddWithValue("@BiddingName2", BiddingName2);
                comm.Parameters.AddWithValue("@OwnerName2", OwnerName2);
                comm.Parameters.AddWithValue("@BiddingName3", BiddingName3);
                comm.Parameters.AddWithValue("@OwnerName3", OwnerName3);
                comm.Parameters.AddWithValue("@AwardMC", AwardMC);
                comm.Parameters.AddWithValue("@ContactMC", ContactMC);
                comm.Parameters.AddWithValue("@AwardRF", AwardRF);
                comm.Parameters.AddWithValue("@ContactRF", ContactRF);
                comm.Parameters.AddWithValue("@ProdTypeID", ProdTypeID);
                comm.Parameters.AddWithValue("@ProdTypeNameEN", ProdTypeNameEN);
                comm.Parameters.AddWithValue("@ProdID", ProdID);
                comm.Parameters.AddWithValue("@ProdNameEN", ProdNameEN);
                comm.Parameters.AddWithValue("@ProfID", ProfID);
                comm.Parameters.AddWithValue("@ProfNameEN", ProfNameEN);
                comm.Parameters.AddWithValue("@Quantity", Quantity);
                comm.Parameters.AddWithValue("@DeliveryDate", DeliveryDate);
                comm.Parameters.AddWithValue("@NextVisitDate", NextVisitDate);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetInsertWeeklyReportWithExtended(string WeekDate, string WeekTime, string CompanyID, string CompanyName, string ArchitecID, string Name, string TransID, string TransNameEN,
                                          string ProjectID, string ProjectName, string Location, string StepID, string StepNameEn, string BiddingName1, string OwnerName1, string BiddingName2, string OwnerName2,
                                          string BiddingName3, string OwnerName3, string AwardMC, string ContactMC, string AwardRF, string ContactRF, string ProdTypeID, string ProdTypeNameEN, string ProdID, string ProdNameEN,
                                          string ProfID, string ProfNameEN, string Quantity, string DeliveryDate, string NextVisitDate, string StatusID, string StatusNameEn, string Remark,
                                          string UserID, string EmpCode, string CreatedBy, string CreatedDate)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReportWithExtended", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@WeekDate", WeekDate);
                comm.Parameters.AddWithValue("@WeekTime", WeekTime);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@TransID", TransID);
                comm.Parameters.AddWithValue("@TransNameEN", TransNameEN);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Location", Location);
                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StepNameEn", StepNameEn);
                comm.Parameters.AddWithValue("@BiddingName1", BiddingName1);
                comm.Parameters.AddWithValue("@OwnerName1", OwnerName1);
                comm.Parameters.AddWithValue("@BiddingName2", BiddingName2);
                comm.Parameters.AddWithValue("@OwnerName2", OwnerName2);
                comm.Parameters.AddWithValue("@BiddingName3", BiddingName3);
                comm.Parameters.AddWithValue("@OwnerName3", OwnerName3);
                comm.Parameters.AddWithValue("@AwardMC", AwardMC);
                comm.Parameters.AddWithValue("@ContactMC", ContactMC);
                comm.Parameters.AddWithValue("@AwardRF", AwardRF);
                comm.Parameters.AddWithValue("@ContactRF", ContactRF);
                comm.Parameters.AddWithValue("@ProdTypeID", ProdTypeID);
                comm.Parameters.AddWithValue("@ProdTypeNameEN", ProdTypeNameEN);
                comm.Parameters.AddWithValue("@ProdID", ProdID);
                comm.Parameters.AddWithValue("@ProdNameEN", ProdNameEN);
                comm.Parameters.AddWithValue("@ProfID", ProfID);
                comm.Parameters.AddWithValue("@ProfNameEN", ProfNameEN);
                comm.Parameters.AddWithValue("@Quantity", Quantity);
                comm.Parameters.AddWithValue("@DeliveryDate", DeliveryDate);
                comm.Parameters.AddWithValue("@NextVisitDate", NextVisitDate);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        // ***************************************//
        // ***************************************//
        // GetData Services for update project
        [WebMethod]
        public void GetDataProjectWithPort(string CompanyID , string ArchitecID, string TypeID)
        {
            List<GetProjectWithPort> projects = new List<GetProjectWithPort>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProjectWithPort", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@CompanyID", Value = CompanyID };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@ArchitecID", Value = ArchitecID };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@TypeID", Value = TypeID };

                comm.Parameters.Add(param1);
                comm.Parameters.Add(param2);
                comm.Parameters.Add(param3);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetProjectWithPort project = new GetProjectWithPort();
                    project.ProjectID = rdr["ProjectID"].ToString();
                    project.ProjectName = rdr["ProjectName"].ToString();
                    projects.Add(project);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(projects));
        }

        [WebMethod]
        public void GetStepUpdate()
        {
            List<GetDataStepUpdate> stepupdated = new List<GetDataStepUpdate>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetStepUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataStepUpdate stepupdate = new GetDataStepUpdate();
                    stepupdate.StepID = rdr["StepID"].ToString();
                    stepupdate.StepNameEn = rdr["StepNameEn"].ToString();
                    stepupdated.Add(stepupdate);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(stepupdated));
        }

        [WebMethod]
        public void GetProductTypeUpdate()
        {
            List<GetDataProductTypeUpdate> productupdated = new List<GetDataProductTypeUpdate>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProductTypeUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProductTypeUpdate productupdate = new GetDataProductTypeUpdate();
                    productupdate.ProdTypeID = rdr["ProdTypeID"].ToString();
                    productupdate.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                    productupdated.Add(productupdate);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(productupdated));
        }

        [WebMethod]
        public void GetProductsUpdate(string ProdTypeID)
        {
            List<GetDataProductsUpdate> products = new List<GetDataProductsUpdate>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProductsUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param = new SqlParameter()
                {
                    ParameterName = "@ProdTypeID",
                    Value = ProdTypeID
                };
                comm.Parameters.Add(param);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProductsUpdate product = new GetDataProductsUpdate();
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
        public void GetProfileUpdate()
        {
            List<GetDataProfileUpdate> profiles = new List<GetDataProfileUpdate>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProfileUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProfileUpdate profile = new GetDataProfileUpdate();
                    profile.ProfID = rdr["ProfID"].ToString();
                    profile.ProfNameTH = rdr["ProfNameTH"].ToString();
                    profile.ProfNameEN = rdr["ProfNameEN"].ToString();
                    profiles.Add(profile);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(profiles));
        }

        [WebMethod]
        public void GetStatusUpdate()
        {
            List<GetDataStatusUpdate> statuses = new List<GetDataStatusUpdate>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetStatusUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataStatusUpdate status = new GetDataStatusUpdate();
                    status.StatusID = rdr["StatusID"].ToString();
                    status.StatusNameTh = rdr["StatusNameTh"].ToString();
                    status.StatusNameEn = rdr["StatusNameEn"].ToString();
                    statuses.Add(status);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(statuses));
        }

        [WebMethod]
        public void GetProjectLastUdate(string ProjectID)
        {
            List<GetDataProjectLastUdate> projects = new List<GetDataProjectLastUdate>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetProjectLastUdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param = new SqlParameter()
                {
                    ParameterName = "@ProjectID",
                    Value = ProjectID
                };
                comm.Parameters.Add(param);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataProjectLastUdate project = new GetDataProjectLastUdate();
                    project.ProjectID = rdr["ProjectID"].ToString();
                    project.ProjectYear = rdr["ProjectYear"].ToString();
                    project.ProjectMonth = rdr["ProjectMonth"].ToString();
                    project.ProjectName = rdr["ProjectName"].ToString();
                    project.CompanyID = rdr["CompanyID"].ToString();
                    project.CompanyName = rdr["CompanyName"].ToString();
                    project.ArchitecID = rdr["ArchitecID"].ToString();
                    project.Name = rdr["Name"].ToString();
                    project.Location = rdr["Location"].ToString();
                    project.TurnKey = rdr["TurnKey"].ToString();

                    project.MainCons = rdr["MainCons"].ToString();
                    project.RefRfDf = rdr["RefRfDf"].ToString();
                    project.ProjStep = rdr["ProjStep"].ToString();
                    project.ProductType = rdr["ProductType"].ToString();
                    project.RefProfile = rdr["RefProfile"].ToString();
                    project.ProdTypeID = rdr["ProdTypeID"].ToString();
                    project.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                    project.ProdID = rdr["ProdID"].ToString();
                    project.ProdNameEN = rdr["ProdNameEN"].ToString();
                    project.ProfID = rdr["ProfID"].ToString();
                    project.ProfNameEN = rdr["ProfNameEN"].ToString();
                    project.StatusID = rdr["StatusID"].ToString();
                    project.StatusNameEn = rdr["StatusNameEn"].ToString();
                    project.Quantity = rdr["Quantity"].ToString();
                    project.RefType = rdr["RefType"].ToString();
                    project.DeliveryDate = rdr["DeliveryDate"].ToString();
                    project.Drawing = rdr["Drawing"].ToString();
                    project.TypeID = rdr["TypeID"].ToString();
                    project.SaleSpec = rdr["SaleSpec"].ToString();
                    project.StatusConID = rdr["StatusConID"].ToString();
                    project.LastUpdate = rdr["LastUpdate"].ToString();
                    projects.Add(project);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(projects));
        }

        //get attached
        [WebMethod]
        public void GetDocAttached(string ProjectID)
        {
            List<GetDataDocAttached> projects = new List<GetDataDocAttached>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetDocAttached", conn);
                comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param = new SqlParameter()
                {
                    ParameterName = "@ProjectID",
                    Value = ProjectID
                };
                comm.Parameters.Add(param);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataDocAttached project = new GetDataDocAttached();
                    project.id = rdr["id"].ToString();
                    project.ProjectID = rdr["ProjectID"].ToString();
                    project.ProjectName = rdr["ProjectName"].ToString();
                    project.Description = rdr["Description"].ToString();
                    project.FileName = rdr["FileName"].ToString();
                    project.Remark = rdr["Remark"].ToString();
                    project.UserID = rdr["UserID"].ToString();
                    project.EmpCode = rdr["EmpCode"].ToString();
                    project.CreatedBy = rdr["CreatedBy"].ToString();
                    project.CreatedDate = rdr["CreatedDate"].ToString();
                    projects.Add(project);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(projects));
        }

        [WebMethod]
        public void GetInsertWeeklyReportUpdate(string WeekDate, string WeekTime, string CompanyID, string CompanyName, string ArchitecID, string Name,
                                          string TransID, string TransNameEN, string ProjectID, string ProjectName, string Location, string TurnKey,  string StepID,
                                          string StepNameEn, string BiddingName1, string OwnerName1, string BiddingName2, string OwnerName2,
                                          string BiddingName3, string OwnerName3, string AwardMC, string ContactMC, string AwardRF, string ContactRF,
                                          string ProdTypeID, string ProdTypeNameEN, string ProdID, string ProdNameEN, string ProfID, string ProfNameEN,
                                          string Quantity, string DeliveryDate, string NextVisitDate, string StatusID, string StatusNameEn, 
                                          string Remark, string UserID, string EmpCode, string CreatedBy, string CreatedDate)
          
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReportUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@WeekDate", WeekDate);
                comm.Parameters.AddWithValue("@WeekTime", WeekTime);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@TransID", TransID);
                comm.Parameters.AddWithValue("@TransNameEN", TransNameEN);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Location", Location);
                comm.Parameters.AddWithValue("@TurnKey", TurnKey);
                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StepNameEn", StepNameEn);
                comm.Parameters.AddWithValue("@BiddingName1", BiddingName1);
                comm.Parameters.AddWithValue("@OwnerName1", OwnerName1);
                comm.Parameters.AddWithValue("@BiddingName2", BiddingName2);
                comm.Parameters.AddWithValue("@OwnerName2", OwnerName2);
                comm.Parameters.AddWithValue("@BiddingName3", BiddingName3);
                comm.Parameters.AddWithValue("@OwnerName3", OwnerName3);
                comm.Parameters.AddWithValue("@AwardMC", AwardMC);
                comm.Parameters.AddWithValue("@ContactMC", ContactMC);
                comm.Parameters.AddWithValue("@AwardRF", AwardRF);
                comm.Parameters.AddWithValue("@ContactRF", ContactRF);
                comm.Parameters.AddWithValue("@ProdTypeID", ProdTypeID);
                comm.Parameters.AddWithValue("@ProdTypeNameEN", ProdTypeNameEN);
                comm.Parameters.AddWithValue("@ProdID", ProdID);
                comm.Parameters.AddWithValue("@ProdNameEN", ProdNameEN);
                comm.Parameters.AddWithValue("@ProfID", ProfID);
                comm.Parameters.AddWithValue("@ProfNameEN", ProfNameEN);
                comm.Parameters.AddWithValue("@Quantity", Quantity);
                comm.Parameters.AddWithValue("@DeliveryDate", DeliveryDate);
                comm.Parameters.AddWithValue("@NextVisitDate", NextVisitDate);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);

                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }


        [WebMethod]
        public void GetInsertWeeklyReportUpdateOther(string WeekDate, string WeekTime, string CompanyID, string CompanyName, string ArchitecID, string Name, string TransID,
                        string TransNameEN, string ProjectID, string ProjectName, string Location, string TurnKey, string StepID, string StepNameEn, string StatusID, string StatusNameEn,
                        string NewArchitect, string HaveFiles, string FileName, string Remark, string UserID, string EmpCode, string CreatedBy, string CreatedDate)

        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReportUpdateOther", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@WeekDate", WeekDate);
                comm.Parameters.AddWithValue("@WeekTime", WeekTime);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@TransID", TransID);
                comm.Parameters.AddWithValue("@TransNameEN", TransNameEN);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Location", Location);
                comm.Parameters.AddWithValue("@TurnKey", TurnKey);

                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StepNameEn", StepNameEn);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);
                comm.Parameters.AddWithValue("@NewArchitect", NewArchitect);
                comm.Parameters.AddWithValue("@HaveFiles", HaveFiles);
                comm.Parameters.AddWithValue("@FileName", FileName);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetInsertWeeklyReportIntakeUpdate(string CompanyID, string CompanyName, string ArchitecID, string Name, 
                                                        string ProjectID, string ProjectName, string StepID, string StatusID, string StatusNameEn, 
                                                        string UserID, string EmpCode, string CreatedBy, string CreatedDate)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReportIntakeUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetInsertWeeklyReportWithExtendedUpdate(string WeekDate, string WeekTime, string CompanyID, string CompanyName, string ArchitecID, string Name, string TransID, string TransNameEN,
                                          string ProjectID, string ProjectName, string Location, string StepID, string StepNameEn, string BiddingName1, string OwnerName1, string BiddingName2, string OwnerName2,
                                          string BiddingName3, string OwnerName3, string AwardMC, string ContactMC, string AwardRF, string ContactRF, string ProdTypeID, string ProdTypeNameEN, string ProdID, string ProdNameEN,
                                          string ProfID, string ProfNameEN, string Quantity, string DeliveryDate, string NextVisitDate, string StatusID, string StatusNameEn, string Remark,
                                          string UserID, string EmpCode, string CreatedBy, string CreatedDate)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReportWithExtendedUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@WeekDate", WeekDate);
                comm.Parameters.AddWithValue("@WeekTime", WeekTime);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@TransID", TransID);
                comm.Parameters.AddWithValue("@TransNameEN", TransNameEN);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Location", Location);
                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StepNameEn", StepNameEn);
                comm.Parameters.AddWithValue("@BiddingName1", BiddingName1);
                comm.Parameters.AddWithValue("@OwnerName1", OwnerName1);
                comm.Parameters.AddWithValue("@BiddingName2", BiddingName2);
                comm.Parameters.AddWithValue("@OwnerName2", OwnerName2);
                comm.Parameters.AddWithValue("@BiddingName3", BiddingName3);
                comm.Parameters.AddWithValue("@OwnerName3", OwnerName3);
                comm.Parameters.AddWithValue("@AwardMC", AwardMC);
                comm.Parameters.AddWithValue("@ContactMC", ContactMC);
                comm.Parameters.AddWithValue("@AwardRF", AwardRF);
                comm.Parameters.AddWithValue("@ContactRF", ContactRF);
                comm.Parameters.AddWithValue("@ProdTypeID", ProdTypeID);
                comm.Parameters.AddWithValue("@ProdTypeNameEN", ProdTypeNameEN);
                comm.Parameters.AddWithValue("@ProdID", ProdID);
                comm.Parameters.AddWithValue("@ProdNameEN", ProdNameEN);
                comm.Parameters.AddWithValue("@ProfID", ProfID);
                comm.Parameters.AddWithValue("@ProfNameEN", ProfNameEN);
                comm.Parameters.AddWithValue("@Quantity", Quantity);
                comm.Parameters.AddWithValue("@DeliveryDate", DeliveryDate);
                comm.Parameters.AddWithValue("@NextVisitDate", NextVisitDate);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetInsertWeeklyReportNewArchitect(string WeekDate, string WeekTime, string CompanyID, string CompanyName, string ArchitecID, string Name,
                                         string TransID, string TransNameEN, string ProjectID, string ProjectName, string Location, string StepID,
                                         string StepNameEn, string BiddingName1, string OwnerName1, string BiddingName2, string OwnerName2,
                                         string BiddingName3, string OwnerName3, string AwardMC, string ContactMC, string AwardRF, string ContactRF,
                                         string ProdTypeID, string ProdTypeNameEN, string ProdID, string ProdNameEN, string ProfID, string ProfNameEN,
                                         string Quantity, string DeliveryDate, string NextVisitDate, string StatusID, string StatusNameEn, string NewArchitect,
                                         string HaveFiles, string FileName, string Remark, string UserID, string EmpCode, string CreatedBy, string CreatedDate)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertWeeklyReportNewArchitect", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@WeekDate", WeekDate);
                comm.Parameters.AddWithValue("@WeekTime", WeekTime);
                comm.Parameters.AddWithValue("@CompanyID", CompanyID);
                comm.Parameters.AddWithValue("@CompanyName", CompanyName);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@Name", Name);
                comm.Parameters.AddWithValue("@TransID", TransID);
                comm.Parameters.AddWithValue("@TransNameEN", TransNameEN);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Location", Location);
                comm.Parameters.AddWithValue("@StepID", StepID);
                comm.Parameters.AddWithValue("@StepNameEn", StepNameEn);
                comm.Parameters.AddWithValue("@BiddingName1", BiddingName1);
                comm.Parameters.AddWithValue("@OwnerName1", OwnerName1);
                comm.Parameters.AddWithValue("@BiddingName2", BiddingName2);
                comm.Parameters.AddWithValue("@OwnerName2", OwnerName2);
                comm.Parameters.AddWithValue("@BiddingName3", BiddingName3);
                comm.Parameters.AddWithValue("@OwnerName3", OwnerName3);
                comm.Parameters.AddWithValue("@AwardMC", AwardMC);
                comm.Parameters.AddWithValue("@ContactMC", ContactMC);
                comm.Parameters.AddWithValue("@AwardRF", AwardRF);
                comm.Parameters.AddWithValue("@ContactRF", ContactRF);
                comm.Parameters.AddWithValue("@ProdTypeID", ProdTypeID);
                comm.Parameters.AddWithValue("@ProdTypeNameEN", ProdTypeNameEN);
                comm.Parameters.AddWithValue("@ProdID", ProdID);
                comm.Parameters.AddWithValue("@ProdNameEN", ProdNameEN);
                comm.Parameters.AddWithValue("@ProfID", ProfID);
                comm.Parameters.AddWithValue("@ProfNameEN", ProfNameEN);
                comm.Parameters.AddWithValue("@Quantity", Quantity);
                comm.Parameters.AddWithValue("@DeliveryDate", DeliveryDate);
                comm.Parameters.AddWithValue("@NextVisitDate", NextVisitDate);
                comm.Parameters.AddWithValue("@StatusID", StatusID);
                comm.Parameters.AddWithValue("@StatusNameEn", StatusNameEn);
                comm.Parameters.AddWithValue("@NewArchitect", NewArchitect);
                comm.Parameters.AddWithValue("@HaveFiles", HaveFiles);
                comm.Parameters.AddWithValue("@FileName", FileName);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetUploadDocAttached(string ProjectID, string ProjectName, string Description, string FileName, string Remark, string UserID, string EmpCode, string CreatedBy, string CreatedDate)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertDocAttached", conn);
                comm.CommandType = CommandType.StoredProcedure;
                //comm.Parameters.AddWithValue("@id", id);
                comm.Parameters.AddWithValue("@ProjectID", ProjectID);
                comm.Parameters.AddWithValue("@ProjectName", ProjectName);
                comm.Parameters.AddWithValue("@Description", Description);
                comm.Parameters.AddWithValue("@FileName", FileName);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@UserID", UserID);
                comm.Parameters.AddWithValue("@EmpCode", EmpCode);
                comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetSpecPerson()
        {
            List<GetDataSpecPerson> specpersonal = new List<GetDataSpecPerson>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetSpecPerson", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataSpecPerson specperson = new GetDataSpecPerson();
                    specperson.SpecID = rdr["SpecID"].ToString();
                    specperson.FullName = rdr["FullName"].ToString();
                    specpersonal.Add(specperson);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(specpersonal));
        }


        [WebMethod]
        public void GetSpecPort(string TypeID)
        {
            List<GetDataSpecPort> specports = new List<GetDataSpecPort>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetSpecPort", conn);
                comm.CommandType = CommandType.StoredProcedure;
                SqlParameter param = new SqlParameter() { ParameterName = "@TypeID", Value = TypeID };
                comm.Parameters.Add(param);

                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataSpecPort specport = new GetDataSpecPort();
                    specport.SpecID = rdr["SpecID"].ToString();
                    specport.FullName = rdr["FullName"].ToString();
                    specports.Add(specport);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(specports));
        }


        [WebMethod]
        public void GetCustomerType()
        {
            List<GetDataCustomerType> customers = new List<GetDataCustomerType>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetCustomerType", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataCustomerType customer = new GetDataCustomerType();
                    customer.CustTypeID = rdr["CustTypeID"].ToString();
                    customer.CustTypeDesc = rdr["CustTypeDesc"].ToString();
                    customers.Add(customer);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(customers));
        }


        [WebMethod]
        public void GetDataGrade()
        {
            List<GetDataGrade> grades = new List<GetDataGrade>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetGrade", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataGrade grade = new GetDataGrade();
                    grade.GradeID = rdr["GradeID"].ToString();
                    grade.GradeDesc = rdr["GradeDesc"].ToString();
                    grades.Add(grade);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(grades));
        }
    }
}
