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
        //string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=AmpelCloud@2020;";
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void GetSaleOnSpecFinal(string sdate, string edate)
        {
            List<cGetSaleOnSpecFinal> datas = new List<cGetSaleOnSpecFinal>();
            SqlCommand comm = new SqlCommand("spSaleOnSpecFinal", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            //SqlParameter param1 = new SqlParameter() { ParameterName = "@sdate", Value = sdate };
            //SqlParameter param2 = new SqlParameter() { ParameterName = "@edate", Value = edate };
            //comm.Parameters.Add(param1);
            //comm.Parameters.Add(param2);

            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetSaleOnSpecFinal data = new cGetSaleOnSpecFinal();
                data.CompanyID = rdr["CompanyID"].ToString();
                data.CompanyName = rdr["CompanyName"].ToString();
                data.ArchitecID = rdr["ArchitecID"].ToString();
                data.Name = rdr["Name"].ToString();
                data.sosMonth = rdr["sosMonth"].ToString();
                data.ProjectYear = rdr["ProjectYear"].ToString();
                data.ProjectMonth = rdr["ProjectMonth"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.ProjectId = rdr["ProjectId"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.GoodID = rdr["GoodID"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.ActQty = rdr["ActQty"].ToString();
                data.SpecQty = rdr["SpecQty"].ToString();
                data.Amount = rdr["Amount"].ToString();
                data.PerUnit = rdr["PerUnit"].ToString();
                data.NetRF_B = rdr["NetRF_B"].ToString();
                data.NetCom = rdr["NetCom"].ToString();
                data.TotalSale = rdr["TotalSale"].ToString();
                data.SaleCode = rdr["SaleCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();           
                data.chkTrash = rdr["chkTrash"].ToString();
                data.RentCom = rdr["RentCom"].ToString();
                data.id = rdr["id"].ToString();
                datas.Add(data);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(datas));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSaleOnSpecFinalWithOutProject(string sdate, string edate)
        {
            List<cGetSaleOnSpecFinal> datas = new List<cGetSaleOnSpecFinal>();
            SqlCommand comm = new SqlCommand("spSaleOnSpecFinalWithoutPort", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            //SqlParameter param1 = new SqlParameter() { ParameterName = "@sdate", Value = sdate };
            //SqlParameter param2 = new SqlParameter() { ParameterName = "@edate", Value = edate };
            //comm.Parameters.Add(param1);
            //comm.Parameters.Add(param2);

            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetSaleOnSpecFinal data = new cGetSaleOnSpecFinal();
                data.CompanyID = rdr["CompanyID"].ToString();
                data.CompanyName = rdr["CompanyName"].ToString();
                data.ArchitecID = rdr["ArchitecID"].ToString();
                data.Name = rdr["Name"].ToString();
                data.sosMonth = rdr["sosMonth"].ToString();
                data.ProjectYear = rdr["ProjectYear"].ToString();
                data.ProjectMonth = rdr["ProjectMonth"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.ProjectId = rdr["ProjectId"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.GoodID = rdr["GoodID"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.ActQty = rdr["ActQty"].ToString();
                data.SpecQty = rdr["SpecQty"].ToString();
                data.Amount = rdr["Amount"].ToString();
                data.PerUnit = rdr["PerUnit"].ToString();
                data.NetRF_B = rdr["NetRF_B"].ToString();
                data.NetCom = rdr["NetCom"].ToString();
                data.TotalSale = rdr["TotalSale"].ToString();
                data.SaleCode = rdr["SaleCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.chkTrash = rdr["chkTrash"].ToString();
                datas.Add(data);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(datas));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetUpdateProjectReferenceExport(string trn, string id, string companyid, string companyname, string architecid, string  name, string sosmonth, 
                                                    string projectyear, string projectmonth, string    docuno, string custcode, string custname, string projectid, 
                                                    string projectname, string goodid, string goodname, string actqty, string specqty, string amount,
                                                    string perunit, string netrf_b, string netcom, string totalsale, string salecode, string salename, 
                                                    string docudate, string chktrash, string rentcom)
        {
            SqlCommand comm = new SqlCommand("spGetUpdateProjectReferenceExport", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;
            comm.Parameters.AddWithValue("@trn", trn);
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@companyid", companyid);
            comm.Parameters.AddWithValue("@companyname", companyname);
            comm.Parameters.AddWithValue("@architecid", architecid);
            comm.Parameters.AddWithValue("@name", name);
            comm.Parameters.AddWithValue("@sosmonth", sosmonth);
            comm.Parameters.AddWithValue("@projectyear", projectyear);
            comm.Parameters.AddWithValue("@projectmonth", projectmonth);
            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.Parameters.AddWithValue("@custcode", custcode);
            comm.Parameters.AddWithValue("@custname", custname);
            comm.Parameters.AddWithValue("@projectid", projectid);
            comm.Parameters.AddWithValue("@projectname", projectname);
            comm.Parameters.AddWithValue("@goodid", goodid);
            comm.Parameters.AddWithValue("@goodname", goodname);
            comm.Parameters.AddWithValue("@actqty", actqty);
            comm.Parameters.AddWithValue("@specqty", specqty);
            comm.Parameters.AddWithValue("@amount", amount);
            comm.Parameters.AddWithValue("@perunit", perunit);
            comm.Parameters.AddWithValue("@netrf_b", netrf_b);
            comm.Parameters.AddWithValue("@netcom", netcom);
            comm.Parameters.AddWithValue("@totalsale", totalsale);
            comm.Parameters.AddWithValue("@salecode", salecode);
            comm.Parameters.AddWithValue("@salename", salename);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@chktrash", chktrash);
            comm.Parameters.AddWithValue("@rentcom", rentcom);
            comm.ExecuteNonQuery();
            conn.CloseConn();

        }

        [WebMethod]
        public void GetssProjectMappingUpdate(string projectid, string refdocno)
        {
            SqlCommand comm = new SqlCommand("spGetssProjectMappingUpdate", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;
            comm.Parameters.AddWithValue("@ProjectID", projectid);
            comm.Parameters.AddWithValue("@RefDocuNo", refdocno);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetssProjectMappingDelete(string id, string projectid, string refdocno)
        {
            SqlCommand comm = new SqlCommand("spGetssProjectMappingDelete", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@ProjectID", projectid);
            comm.Parameters.AddWithValue("@RefDocuNo", refdocno);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetssProjectMappingExcept(string docuno, string empid, string empname)
        {
            SqlCommand comm = new SqlCommand("spGetssProjectMappingExcept", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;
            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.Parameters.AddWithValue("@empid", empid);
            comm.Parameters.AddWithValue("@empname", empname);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetssProjectMappingFilter()
        {
            List<cGetssProjectMappingFilter> datas = new List<cGetssProjectMappingFilter>();

            SqlCommand comm = new SqlCommand("spGetssProjectMappingFilter", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetssProjectMappingFilter data = new cGetssProjectMappingFilter();

                data.id = rdr["id"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.SendDate = rdr["SendDate"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.StockQty = rdr["StockQty"].ToString();
                data.GoodPrice2 = rdr["GoodPrice2"].ToString();
                data.GoodAmnt = rdr["GoodAmnt"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.ContactName = rdr["ContactName"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.chkTrash = rdr["chkTrash"].ToString();
                datas.Add(data);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(datas));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetssProjectFilterDelete(string docuno)
        {
            SqlCommand comm = new SqlCommand("spGetssProjectFilterDelete", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;
            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSaleOnSpecFinalShare(string id, string ownerqty, string owneramount, string ownernetcom, string ownertotal, string isshare, string shareport, string shareqty,
            string shareamount, string sharenetcom, string sharetotal)
        {
            SqlCommand comm = new SqlCommand("spSaleOnSpecFinalShare", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@OwnerQty", ownerqty);
            comm.Parameters.AddWithValue("@OwnerAmount", owneramount);
            comm.Parameters.AddWithValue("@OwnerNetCom", ownernetcom);
            comm.Parameters.AddWithValue("@OwnerTotal", ownertotal);
            comm.Parameters.AddWithValue("@isShare", isshare);
            comm.Parameters.AddWithValue("@SharePort", shareport);
            comm.Parameters.AddWithValue("@ShareQty", shareqty);
            comm.Parameters.AddWithValue("@ShareAmount", shareamount);
            comm.Parameters.AddWithValue("@ShareNetCom", sharenetcom);
            comm.Parameters.AddWithValue("@ShareTotal", sharetotal);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
    }
}
