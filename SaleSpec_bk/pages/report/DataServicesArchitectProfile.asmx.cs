﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using SaleSpec.Class;

namespace SaleSpec.pages.report
{
    /// <summary>
    /// Summary description for DataServicesArchitectProfile
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class DataServicesArchitectProfile : System.Web.Services.WebService
    {
        //dbConnection conn = new dbConnection();

        //string cs = "server=192.168.1.4;database=DB_SaleSpec;uid=ampel;pwd=Amp7896321;";       
        //string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=AmpelCloud@2020;";
        string cs = HttpContext.Current.Server.MapPath("~/ClassConnection/dbConnectionSQL.txt");


        [WebMethod]
        public void GetEventActivity()
        {
            List<GetEventActivity> objs = new List<GetEventActivity>();

            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetDataEventActivity", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetEventActivity obj = new GetEventActivity();
                    obj.act_id = rdr["act_id"].ToString();
                    obj.act_desc = rdr["act_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }


        //get attached
        [WebMethod]
        public void GetEventType()
        {
            List<GetDataEventType> objs = new List<GetDataEventType>();


            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetDataEventType", conn);
                comm.CommandType = CommandType.StoredProcedure;

                //SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strUserID };
                //SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
                //SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };

                //comm.Parameters.Add(param1);
                //comm.Parameters.Add(param2);
                //comm.Parameters.Add(param3);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataEventType obj = new GetDataEventType();
                    obj.id = rdr["id"].ToString();
                    obj.event_desc = rdr["event_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }


        [WebMethod]
        public void GetEventTypeID(string strid) {
            List<GetDataEventType> objs = new List<GetDataEventType>();


            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetDataEventTypeID", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@strid", strid);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataEventType obj = new GetDataEventType();
                    obj.id = rdr["id"].ToString();
                    obj.event_desc = rdr["event_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }

        [WebMethod]
        public void GetInvitation()
        {
            List<GetDataInvitation> objs = new List<GetDataInvitation>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetDataInvitation", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataInvitation obj = new GetDataInvitation();
                    obj.id = rdr["id"].ToString();
                    obj.inv_desc = rdr["inv_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }

        [WebMethod]
        public void GetAttendance()
        {
            List<GetDataAttendance> objs = new List<GetDataAttendance>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetadAttendance", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataAttendance obj = new GetDataAttendance();
                    obj.id = rdr["id"].ToString();
                    obj.attn_desc = rdr["attn_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }


        [WebMethod]
        public void GetDataYearly()
        {
            List<GetDataYearly> objs = new List<GetDataYearly>();


            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("spGetDataYearly", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataYearly obj = new GetDataYearly();
                    obj.id = rdr["id"].ToString();
                    obj.year_desc = rdr["year_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }


        [WebMethod]
        public void GetInsertRewardEvent(string tran_id, string event_id, string event_desc, string title_id, string title_desc, string trans_date, string architect_id, string details,
                                string inv_id, string inv_desc, string attn_id, string attn_desc, string remark, string userid, string created_date, string lasted_date, string isdelete)
        {

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertRewardEvent", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@tran_id", tran_id);
                comm.Parameters.AddWithValue("@event_id", event_id);
                comm.Parameters.AddWithValue("@event_desc", event_desc);
                comm.Parameters.AddWithValue("@title_id", title_id);
                comm.Parameters.AddWithValue("@title_desc", title_desc);
                comm.Parameters.AddWithValue("@trans_date", trans_date);
                comm.Parameters.AddWithValue("@architect_id", architect_id);
                comm.Parameters.AddWithValue("@details", details);
                comm.Parameters.AddWithValue("@inv_id", inv_id);
                comm.Parameters.AddWithValue("@inv_desc", inv_desc);
                comm.Parameters.AddWithValue("@attn_id", attn_id);
                comm.Parameters.AddWithValue("@attn_desc", attn_desc);
                comm.Parameters.AddWithValue("@remark", remark);
                comm.Parameters.AddWithValue("@userid", userid);
                comm.Parameters.AddWithValue("@created_date", created_date);
                comm.Parameters.AddWithValue("@lasted_date", lasted_date);
                comm.Parameters.AddWithValue("@isdelete", isdelete);
                comm.ExecuteNonQuery();
                conn.Close();
            }

        }

        [WebMethod]
        public void GetRewardEventUpdate(string id)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spRewardEventUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;

                comm.Parameters.AddWithValue("@id", id);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

       

        [WebMethod]
        public void GetDataPreviousYear()
        {
            List<GetPreviousYear> objs = new List<GetPreviousYear>();


            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("sp_GetPreviousYear", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetPreviousYear obj = new GetPreviousYear();
                    obj.iYear = int.Parse(rdr["iYear"].ToString());
                    obj.nYear = rdr["nYear"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }

        [WebMethod]
        public void GetDataLevel()
        {
            List<GetDataLevel> objs = new List<GetDataLevel>();


            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("sp_GetDataLevel", conn);
                comm.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetDataLevel obj = new GetDataLevel();
                    obj.level_id = rdr["level_id"].ToString();
                    obj.level_desc = rdr["level_desc"].ToString();
                    objs.Add(obj);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(objs));
        }



        
        [WebMethod]
        public void GetLevelHistory(string id)
        {
            List<GetLevelHistory> levels = new List<GetLevelHistory>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("sp_GetLevelHistory", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@ArchitecID", Value = id };
                comm.Parameters.Add(param1);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetLevelHistory level = new GetLevelHistory();

                    level.id = int.Parse(rdr["id"].ToString());
                    level.inYear = int.Parse(rdr["inYear"].ToString());
                    level.ArchitecID = rdr["ArchitecID"].ToString();
                    level.FirstName = rdr["FirstName"].ToString();
                    level.LastName = rdr["LastName"].ToString();
                    level.level_id = rdr["level_id"].ToString();
                    level.level_desc = rdr["level_desc"].ToString();
                    level.last_update = rdr["last_update"].ToString();
                    level.Port = rdr["Port"].ToString();
                    levels.Add(level);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(levels));

        }

        [WebMethod]
        public void GetArchitectPortOwner(string id)
        {
            List<GetArchitectPortOwner> xPorts = new List<GetArchitectPortOwner>();
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand comm = new SqlCommand("sp_GetArchitectPortOwner", conn);
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@ArchitecID", Value = id };
                comm.Parameters.Add(param1);
                conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetArchitectPortOwner xPort = new GetArchitectPortOwner();

                    xPort.xNo = rdr["xNo"].ToString();
                    xPort.ArchitecID = rdr["ArchitecID"].ToString();
                    xPort.Port = rdr["Port"].ToString();
                    xPorts.Add(xPort);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(xPorts));

        }

        [WebMethod]
        public void GetInsertHistoryLevel(string inYear, string ArchitecID, string FirstName, string LastName, string level_id, string level_desc, string isactive, string last_update)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spInsertHistoryLevel", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@inYear", inYear);
                comm.Parameters.AddWithValue("@ArchitecID", ArchitecID);
                comm.Parameters.AddWithValue("@FirstName", FirstName);
                comm.Parameters.AddWithValue("@LastName", LastName);
                comm.Parameters.AddWithValue("@level_id", level_id);
                comm.Parameters.AddWithValue("@level_desc", level_desc);
                comm.Parameters.AddWithValue("@isactive", isactive);
                comm.Parameters.AddWithValue("@last_update", last_update);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

        [WebMethod]
        public void GetUpdateHistoryLevel(int id)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand comm = new SqlCommand("spHistoryLevelUpdate", conn);
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@id", id);
                comm.ExecuteNonQuery();
                conn.Close();
            }
        }

    }
}
