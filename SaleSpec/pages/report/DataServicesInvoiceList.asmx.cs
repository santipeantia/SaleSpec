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
    }
}

