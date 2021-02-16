using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Text;
using System.Data.SqlClient;
using System.Web.Script.Serialization;


namespace SaleSpec.pages.report
{
    /// <summary>
    /// Summary description for DataServicesInvoiceList
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class DataServicesInvoiceList : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        //string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=AmpelCloud@2020;";

        //[WebMethod]
        //public string HelloWorld()
        //{
        //    return "Hello World";
        //}

        [WebMethod]
        public void GetInvoiceList()
        {
            List<cGetInvoiceList> objs = new List<cGetInvoiceList>();

                SqlCommand comm = new SqlCommand("spGetInvoiceList", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    cGetInvoiceList obj = new cGetInvoiceList();
                    obj.InvNo = rdr["InvNo"].ToString();
                    obj.DocuDate = rdr["DocuDate"].ToString();
                    obj.CustCode = rdr["CustCode"].ToString();
                    obj.CustName = rdr["CustName"].ToString();
                    obj.EmpCode = rdr["EmpCode"].ToString();
                    obj.SaleName = rdr["SaleName"].ToString();
                    obj.TotalPrice = rdr["TotalPrice"].ToString();
                    obj.chk = rdr["chk"].ToString();
                    objs.Add(obj);
                }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }

        [WebMethod]
        public void GetInvoiceListSOS(string sdate, string edate)
        {
            List<cGetInvoiceList> objs = new List<cGetInvoiceList>();

            SqlCommand comm = new SqlCommand("spGetInvoiceListSOS", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetInvoiceList obj = new cGetInvoiceList();
                obj.InvNo = rdr["InvNo"].ToString();
                obj.DocuDate = rdr["DocuDate"].ToString();
                obj.CustCode = rdr["CustCode"].ToString();
                obj.CustName = rdr["CustName"].ToString();
                obj.EmpCode = rdr["EmpCode"].ToString();
                obj.SaleName = rdr["SaleName"].ToString();
                obj.TotalPrice = rdr["TotalPrice"].ToString();
                obj.chk = rdr["chk"].ToString();
                objs.Add(obj);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }

        [WebMethod]
        public void GetInvoiceListSOSMapping(string sdate)
        {
            List<cGetInvoiceListSOSMapping> objs = new List<cGetInvoiceListSOSMapping>();

            SqlCommand comm = new SqlCommand("spGetInvoiceListSOS_R2", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetInvoiceListSOSMapping obj = new cGetInvoiceListSOSMapping();
                obj.ID = rdr["ID"].ToString();
                obj.DocuNo = rdr["DocuNo"].ToString();
                obj.DocuDate = rdr["DocuDate"].ToString();
                obj.CustPONo = rdr["CustPONo"].ToString();
                obj.CustCode = rdr["CustCode"].ToString();
                obj.CustName = rdr["CustName"].ToString();
                obj.JobName = rdr["JobName"].ToString();
                obj.GoodCode = rdr["GoodCode"].ToString();
                obj.Model = rdr["Model"].ToString();
                obj.EmpCode = rdr["EmpCode"].ToString();
                obj.SaleName = rdr["SaleName"].ToString();
                obj.Amount = rdr["Amount"].ToString();
                obj.RentAmount = rdr["RentAmount"].ToString();
                obj.TotalPrice = rdr["TotalPrice"].ToString();
                obj.chk = rdr["chk"].ToString();
                objs.Add(obj);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));

        }

        [WebMethod]
        public void GetDataProjectReferenceExport(string sdate, string edate) {
            List<cGetDataProjectReferenceExport> datas = new List<cGetDataProjectReferenceExport>();

            SqlCommand comm = new SqlCommand("spGetReportProjectStatusExport", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetDataProjectReferenceExport data = new cGetDataProjectReferenceExport();
                data.ID = rdr["ID"].ToString();
                data.WeekDate = rdr["WeekDate"].ToString();
                data.CompanyID = rdr["CompanyID"].ToString();
                data.CompanyName = rdr["CompanyName"].ToString();
                data.ArchitecID = rdr["ArchitecID"].ToString();
                data.Name = rdr["Name"].ToString();
                data.ProjectID = rdr["ProjectID"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.ProdNameEN = rdr["ProdNameEN"].ToString();
                data.DeliveryDate = rdr["DeliveryDate"].ToString();
                data.Quantity = rdr["Quantity"].ToString();
                data.ProjYear = rdr["ProjYear"].ToString();
                data.UserID = rdr["UserID"].ToString();
                data.SosType = rdr["SosType"].ToString();
                data.chkTrash = rdr["chkTrash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(datas));
            conn.CloseConn();
        }
    }
}

