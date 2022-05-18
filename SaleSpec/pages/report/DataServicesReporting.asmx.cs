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
        //string cs = "server=192.168.1.4;database=DB_SaleSpec;uid=ampel;pwd=Amp7896321;";
        //string cs = "server=203.154.45.40;database=DB_SaleSpec;uid=sa;pwd=AmpelCloud@2020;";
        //string cs = HttpContext.Current.Server.MapPath("~/ClassConnection/dbConnectionSQL.txt");
        dbConnection conn = new dbConnection();

        //get attached
        [WebMethod]
        public void GetWeeklyReporting(string strUserID, string strStartDate, string strEndDate, string strsearch)
        {
            List<GetDataWeeklyReporting> weeks = new List<GetDataWeeklyReporting>();
            SqlCommand comm = new SqlCommand("spWeeklyReporting", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strUserID };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = strsearch };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);

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
                week.TransID = rdr["TransID"].ToString();
                week.TransNameEN = rdr["TransNameEN"].ToString();
                weeks.Add(week);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(weeks));
            conn.CloseConn();
        }


        [WebMethod]
        public void GetNewProjectReporting(string strUserID, string strStartDate, string strEndDate, string strQtyStart, string strQtyEnd, string strSearch)
        {
            List<GetDataNewProjectReporting> newprojects = new List<GetDataNewProjectReporting>();
            SqlCommand comm = new SqlCommand("spNewProjectReporting", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@UserID", Value = strUserID };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@QtyStart", Value = strQtyStart };
            SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyEnd", Value = strQtyEnd };
            SqlParameter param6 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);
            comm.Parameters.Add(param5);
            comm.Parameters.Add(param6);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataNewProjectReporting newproject = new GetDataNewProjectReporting();
                newproject.WeekDate = rdr["WeekDate"].ToString();
                newproject.WeekTime = rdr["WeekTime"].ToString();
                //newproject.CompanyID = rdr["CompanyID"].ToString();
                newproject.CompanyName = rdr["CompanyName"].ToString();
                newproject.ArchitecID = rdr["ArchitecID"].ToString();
                newproject.Name = rdr["Name"].ToString();
                //newproject.ProjectID = rdr["ProjectID"].ToString();
                newproject.ProjectName = rdr["ProjectName"].ToString();
                newproject.Location = rdr["Location"].ToString();
                //newproject.StatusID = rdr["StatusID"].ToString();
                newproject.StatusNameEn = rdr["StatusNameEn"].ToString();
                //newproject.StepID = rdr["StepID"].ToString();
                newproject.StepNameEn = rdr["StepNameEn"].ToString();

                newproject.Quantity = rdr["Quantity"].ToString();
                newproject.Remark = rdr["Remark"].ToString();
                newproject.UserID = rdr["UserID"].ToString();
                //newproject.EmpCode = rdr["EmpCode"].ToString();
                newproject.CreatedBy = rdr["CreatedBy"].ToString();
                newproject.CreatedDate = rdr["CreatedDate"].ToString();
                newprojects.Add(newproject);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(newprojects));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataProjectByPortStatus(string strUserID, string strStatus, string strStartDate, string strEndDate, string strQtyStart, string strQtyEnd, string strSearch)
        {
            List<GetDataProjectByPortStatus> intakeprojects = new List<GetDataProjectByPortStatus>();
            SqlCommand comm = new SqlCommand("sp_GetDataProjectByPortStatusOption", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strUserID };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };
            SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyStart", Value = strQtyStart };
            SqlParameter param6 = new SqlParameter() { ParameterName = "@QtyEnd", Value = strQtyEnd };
            SqlParameter param7 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);
            comm.Parameters.Add(param5);
            comm.Parameters.Add(param6);
            comm.Parameters.Add(param7);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataProjectByPortStatus intakeproject = new GetDataProjectByPortStatus();
                intakeproject.No = rdr["No"].ToString();
                intakeproject.WeekDate = rdr["WeekDate"].ToString();
                intakeproject.WeekTime = rdr["WeekTime"].ToString();
                intakeproject.CompanyID = rdr["CompanyID"].ToString();
                intakeproject.CompanyName = rdr["CompanyName"].ToString();
                intakeproject.ArchitecID = rdr["ArchitecID"].ToString();
                intakeproject.Name = rdr["Name"].ToString();
                intakeproject.TransID = rdr["TransID"].ToString();
                intakeproject.TransNameEN = rdr["TransNameEN"].ToString();
                intakeproject.ProjectID = rdr["ProjectID"].ToString();
                intakeproject.ProjectName = rdr["ProjectName"].ToString();
                intakeproject.Location = rdr["Location"].ToString();
                intakeproject.TurnKey = rdr["TurnKey"].ToString();
                intakeproject.StepID = rdr["StepID"].ToString();
                intakeproject.StepNameEn = rdr["StepNameEn"].ToString();
                intakeproject.BiddingName1 = rdr["BiddingName1"].ToString();
                intakeproject.OwnerName1 = rdr["OwnerName1"].ToString();
                intakeproject.BiddingName2 = rdr["BiddingName2"].ToString();
                intakeproject.OwnerName2 = rdr["OwnerName2"].ToString();
                intakeproject.BiddingName3 = rdr["BiddingName3"].ToString();
                intakeproject.OwnerName3 = rdr["OwnerName3"].ToString();
                intakeproject.AwardMC = rdr["AwardMC"].ToString();
                intakeproject.ContactMC = rdr["ContactMC"].ToString();
                intakeproject.AwardRF = rdr["AwardRF"].ToString();
                intakeproject.ContactRF = rdr["ContactRF"].ToString();
                intakeproject.ProdTypeID = rdr["ProdTypeID"].ToString();
                intakeproject.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                intakeproject.ProdID = rdr["ProdID"].ToString();
                intakeproject.ProdNameEN = rdr["ProdNameEN"].ToString();
                intakeproject.ProfID = rdr["ProfID"].ToString();
                intakeproject.ProfNameEN = rdr["ProfNameEN"].ToString();
                intakeproject.Quantity = rdr["Quantity"].ToString();
                intakeproject.DeliveryDate = rdr["DeliveryDate"].ToString();
                intakeproject.NextVisitDate = rdr["NextVisitDate"].ToString();
                intakeproject.StatusID = rdr["StatusID"].ToString();
                intakeproject.StatusNameEn = rdr["StatusNameEn"].ToString();
                intakeproject.Remark = rdr["Remark"].ToString();
                intakeproject.UserID = rdr["UserID"].ToString();
                intakeproject.EmpCode = rdr["EmpCode"].ToString();
                intakeproject.CreatedBy = rdr["CreatedBy"].ToString();
                intakeproject.CreatedDate = rdr["CreatedDate"].ToString();
                intakeprojects.Add(intakeproject);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(intakeprojects));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataProjectByPortStatusAll(string strUserID, string strStatus, string strStartDate, string strEndDate, string strQtyStart, string strQtyEnd, string strSearch)
        {
            List<GetDataProjectByPortStatus> intakeprojects = new List<GetDataProjectByPortStatus>();
            SqlCommand comm = new SqlCommand("sp_GetDataProjectByPortStatusAllOption", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@TypeID", Value = strUserID };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@StatusID", Value = strStatus };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@StartDate", Value = strStartDate };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@EndDate", Value = strEndDate };
            SqlParameter param5 = new SqlParameter() { ParameterName = "@QtyStart", Value = strQtyStart };
            SqlParameter param6 = new SqlParameter() { ParameterName = "@QtyEnd", Value = strQtyEnd };
            SqlParameter param7 = new SqlParameter() { ParameterName = "@Search", Value = strSearch };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);
            comm.Parameters.Add(param5);
            comm.Parameters.Add(param6);
            comm.Parameters.Add(param7);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataProjectByPortStatus intakeproject = new GetDataProjectByPortStatus();
                intakeproject.No = rdr["No"].ToString();
                intakeproject.WeekDate = rdr["WeekDate"].ToString();
                intakeproject.WeekTime = rdr["WeekTime"].ToString();
                intakeproject.CompanyID = rdr["CompanyID"].ToString();
                intakeproject.CompanyName = rdr["CompanyName"].ToString();
                intakeproject.ArchitecID = rdr["ArchitecID"].ToString();
                intakeproject.Name = rdr["Name"].ToString();
                intakeproject.TransID = rdr["TransID"].ToString();
                intakeproject.TransNameEN = rdr["TransNameEN"].ToString();
                intakeproject.ProjectID = rdr["ProjectID"].ToString();
                intakeproject.ProjectName = rdr["ProjectName"].ToString();
                intakeproject.Location = rdr["Location"].ToString();
                intakeproject.TurnKey = rdr["TurnKey"].ToString();
                intakeproject.StepID = rdr["StepID"].ToString();
                intakeproject.StepNameEn = rdr["StepNameEn"].ToString();
                intakeproject.BiddingName1 = rdr["BiddingName1"].ToString();
                intakeproject.OwnerName1 = rdr["OwnerName1"].ToString();
                intakeproject.BiddingName2 = rdr["BiddingName2"].ToString();
                intakeproject.OwnerName2 = rdr["OwnerName2"].ToString();
                intakeproject.BiddingName3 = rdr["BiddingName3"].ToString();
                intakeproject.OwnerName3 = rdr["OwnerName3"].ToString();
                intakeproject.AwardMC = rdr["AwardMC"].ToString();
                intakeproject.ContactMC = rdr["ContactMC"].ToString();
                intakeproject.AwardRF = rdr["AwardRF"].ToString();
                intakeproject.ContactRF = rdr["ContactRF"].ToString();
                intakeproject.ProdTypeID = rdr["ProdTypeID"].ToString();
                intakeproject.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                intakeproject.ProdID = rdr["ProdID"].ToString();
                intakeproject.ProdNameEN = rdr["ProdNameEN"].ToString();
                intakeproject.ProfID = rdr["ProfID"].ToString();
                intakeproject.ProfNameEN = rdr["ProfNameEN"].ToString();
                intakeproject.Quantity = rdr["Quantity"].ToString();
                intakeproject.DeliveryDate = rdr["DeliveryDate"].ToString();
                intakeproject.NextVisitDate = rdr["NextVisitDate"].ToString();
                intakeproject.StatusID = rdr["StatusID"].ToString();
                intakeproject.StatusNameEn = rdr["StatusNameEn"].ToString();
                intakeproject.Remark = rdr["Remark"].ToString();
                intakeproject.UserID = rdr["UserID"].ToString();
                intakeproject.EmpCode = rdr["EmpCode"].ToString();
                intakeproject.CreatedBy = rdr["CreatedBy"].ToString();
                intakeproject.CreatedDate = rdr["CreatedDate"].ToString();
                intakeprojects.Add(intakeproject);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(intakeprojects));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataProjectByPortByOption(string strOption, string strDateStart, string strDateEnd, string strUserID, string strQtyStart, string strQtyEnd, string strSearch, string strSearch2)
        {

            List<GetReportProjectStatusByOptions> projects = new List<GetReportProjectStatusByOptions>();
            SqlCommand comm = new SqlCommand("spGetReportProjectStatusByOption3", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@strOption", Value = strOption };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@strDateStart", Value = strDateStart };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@strDateEnd", Value = strDateEnd };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@strUserID", Value = strUserID };
            SqlParameter param5 = new SqlParameter() { ParameterName = "@strQtyStart", Value = strQtyStart };
            SqlParameter param6 = new SqlParameter() { ParameterName = "@strQtyEnd", Value = strQtyEnd };
            SqlParameter param7 = new SqlParameter() { ParameterName = "@strSearch", Value = strSearch };
            SqlParameter param8 = new SqlParameter() { ParameterName = "@strSearch2", Value = strSearch2 };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);
            comm.Parameters.Add(param5);
            comm.Parameters.Add(param6);
            comm.Parameters.Add(param7);
            comm.Parameters.Add(param8);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetReportProjectStatusByOptions project = new GetReportProjectStatusByOptions();
                project.ID = rdr["ID"].ToString();
                project.UserID = rdr["UserID"].ToString();
                project.WeekDate = rdr["WeekDate"].ToString();
                project.WeekTime = rdr["WeekTime"].ToString();
                project.CompanyName = rdr["CompanyName"].ToString();
                project.ArchitectID = rdr["ArchitecID"].ToString();
                project.Name = rdr["Name"].ToString();
                project.ProjectID = rdr["ProjectID"].ToString();
                project.ProjectName = rdr["ProjectName"].ToString();
                project.Location = rdr["Location"].ToString();
                project.ProdTypeID = rdr["ProdTypeID"].ToString();
                project.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                project.ProdID = rdr["ProdID"].ToString();
                project.ProdNameEN = rdr["ProdNameEN"].ToString();
                project.ProfNameEN = rdr["ProfNameEN"].ToString();
                project.DeliveryDate = rdr["DeliveryDate"].ToString();
                project.NextVisitDate = rdr["NextVisitDate"].ToString();
                project.Quantity = rdr["Quantity"].ToString();
                project.StepNameA = rdr["StepNameA"].ToString();
                project.StepNameB = rdr["StepNameB"].ToString();
                project.RefWeekDate = rdr["RefWeekDate"].ToString();
                project.Ref1 = rdr["Ref1"].ToString();
                project.Ref2 = rdr["Ref2"].ToString();
                project.Ref3 = rdr["Ref3"].ToString();
                project.RefRemark = rdr["RefRemark"].ToString();
                project.StepID = rdr["StepID"].ToString();
                project.StatusNameEn = rdr["StatusNameEn"].ToString();
                projects.Add(project);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(projects));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataProjectHistory(string ProjectID)
        {
            List<GetDataProjectHistory> histories = new List<GetDataProjectHistory>();
            SqlCommand comm = new SqlCommand("spGetProjectHistory", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@ProjectID", Value = ProjectID };
            comm.Parameters.Add(param1);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataProjectHistory history = new GetDataProjectHistory();
                history.WeekDate = rdr["WeekDate"].ToString();
                history.WeekTime = rdr["WeekTime"].ToString();
                history.TransNameEN = rdr["TransNameEN"].ToString();
                history.StepNameEn = rdr["StepNameEn"].ToString();
                history.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                history.ProdNameEN = rdr["ProdNameEN"].ToString();
                history.BiddingName1 = rdr["BiddingName1"].ToString();
                history.AwardMC = rdr["AwardMC"].ToString();
                history.AwardRF = rdr["AwardRF"].ToString();
                history.Quantity = rdr["Quantity"].ToString();
                history.Remark = rdr["Remark"].ToString();
                history.NextVisitDate = rdr["NextVisitDate"].ToString();
                histories.Add(history);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(histories));
            conn.CloseConn();
        }


        [WebMethod]
        public void GetUpdateWeeklyReportViaSupervisor(string ID, string WeekDate, string WeekTime, string CompanyName, string ArchitecID,
                                            string Name, string Location, string ProdTypeID,
                                            string ProdTypeNameEN, string ProdID, string ProdNameEN, string ProfNameEN, string DeliveryDate,
                                            string NextVisitDate, string Quantity, string StepNameEn, string Ref1, string Ref2,
                                            string Remark, string StepID, string StatusID, string ProjectID, string RefDocuNo, string jobname,
                                            string bidding1, string biddingname1, string bidding2, string biddingname2, string bidding3, string biddingname3,
                                            string awardmc, string awardmcname, string awardrf, string awardrfname)
        {
            SqlCommand comm = new SqlCommand("spGetUpdateWeeklyReportViaSupervisor", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            try
            {
                SqlParameter param1 = new SqlParameter() { ParameterName = "@ID", Value = ID };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@WeekDate", Value = WeekDate };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@WeekTime", Value = WeekTime };
                SqlParameter param4 = new SqlParameter() { ParameterName = "@CompanyName", Value = CompanyName };
                SqlParameter param5 = new SqlParameter() { ParameterName = "@ArchitecID", Value = ArchitecID };
                SqlParameter param6 = new SqlParameter() { ParameterName = "@Name", Value = Name };
                SqlParameter param7 = new SqlParameter() { ParameterName = "@Location", Value = Location };
                SqlParameter param8 = new SqlParameter() { ParameterName = "@ProdTypeID", Value = ProdTypeID };
                SqlParameter param9 = new SqlParameter() { ParameterName = "@ProdTypeNameEN", Value = ProdTypeNameEN };
                SqlParameter param10 = new SqlParameter() { ParameterName = "@ProdID", Value = ProdID };
                SqlParameter param11 = new SqlParameter() { ParameterName = "@ProdNameEN", Value = ProdNameEN };
                SqlParameter param12 = new SqlParameter() { ParameterName = "@ProfNameEN", Value = ProfNameEN };
                SqlParameter param13 = new SqlParameter() { ParameterName = "@DeliveryDate", Value = DeliveryDate };
                SqlParameter param14 = new SqlParameter() { ParameterName = "@NextVisitDate", Value = NextVisitDate };
                SqlParameter param15 = new SqlParameter() { ParameterName = "@Quantity", Value = Quantity };
                SqlParameter param16 = new SqlParameter() { ParameterName = "@StepNameEn", Value = StepNameEn };
                SqlParameter param17 = new SqlParameter() { ParameterName = "@Ref1", Value = Ref1 };
                SqlParameter param18 = new SqlParameter() { ParameterName = "@Ref2", Value = Ref2 };
                SqlParameter param19 = new SqlParameter() { ParameterName = "@Remark", Value = Remark };
                SqlParameter param20 = new SqlParameter() { ParameterName = "@StepID", Value = StepID };
                SqlParameter param21 = new SqlParameter() { ParameterName = "@StatusID", Value = StatusID };
                SqlParameter param22 = new SqlParameter() { ParameterName = "@ProjectID", Value = ProjectID };
                SqlParameter param23 = new SqlParameter() { ParameterName = "@RefDocuNo", Value = RefDocuNo };
                SqlParameter param24 = new SqlParameter() { ParameterName = "@jobname", Value = jobname };

                SqlParameter param25 = new SqlParameter() { ParameterName = "@bidding1", Value = bidding1 };
                SqlParameter param26 = new SqlParameter() { ParameterName = "@biddingname1", Value = biddingname1 };
                SqlParameter param27 = new SqlParameter() { ParameterName = "@bidding2", Value = bidding2 };
                SqlParameter param28 = new SqlParameter() { ParameterName = "@biddingname2", Value = biddingname2 };
                SqlParameter param29 = new SqlParameter() { ParameterName = "@bidding3", Value = bidding3 };
                SqlParameter param30 = new SqlParameter() { ParameterName = "@biddingname3", Value = biddingname3 };

                SqlParameter param31 = new SqlParameter() { ParameterName = "@awardmc", Value = awardmc };
                SqlParameter param32 = new SqlParameter() { ParameterName = "@awardmcname", Value = awardmcname };

                SqlParameter param33 = new SqlParameter() { ParameterName = "@awardrf", Value = awardrf };
                SqlParameter param34 = new SqlParameter() { ParameterName = "@awardrfname", Value = awardrfname };

                comm.Parameters.Add(param1);
                comm.Parameters.Add(param2);
                comm.Parameters.Add(param3);
                comm.Parameters.Add(param4);
                comm.Parameters.Add(param5);
                comm.Parameters.Add(param6);
                comm.Parameters.Add(param7);
                comm.Parameters.Add(param8);
                comm.Parameters.Add(param9);
                comm.Parameters.Add(param10);
                comm.Parameters.Add(param11);
                comm.Parameters.Add(param12);
                comm.Parameters.Add(param13);
                comm.Parameters.Add(param14);
                comm.Parameters.Add(param15);
                comm.Parameters.Add(param16);
                comm.Parameters.Add(param17);
                comm.Parameters.Add(param18);
                comm.Parameters.Add(param19);
                comm.Parameters.Add(param20);
                comm.Parameters.Add(param21);
                comm.Parameters.Add(param22);
                comm.Parameters.Add(param23);
                comm.Parameters.Add(param24);
                comm.Parameters.Add(param25);
                comm.Parameters.Add(param26);
                comm.Parameters.Add(param27);
                comm.Parameters.Add(param28);
                comm.Parameters.Add(param29);
                comm.Parameters.Add(param30);
                comm.Parameters.Add(param31);
                comm.Parameters.Add(param32);
                comm.Parameters.Add(param33);
                comm.Parameters.Add(param34);
                comm.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                string strMsgAlert = "";
                strMsgAlert = "<div class=\"alert alert-danger box-title txtLabel\"> " +
                        "      <strong>Error rptPrintIntakeProjectReport..!</strong> " + ex.Message + " " +
                        "</div>";
                return;
            }
            conn.CloseConn();
        }



        [WebMethod]
        public void DataReportGetArchitect(string id)
        {

            List<GetDataReportGetArchitect> architects = new List<GetDataReportGetArchitect>();
            SqlCommand comm = new SqlCommand("spReportGetArchitect", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@id", Value = id };
            comm.Parameters.Add(param1);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataReportGetArchitect architect = new GetDataReportGetArchitect();
                architect.ArchitecID = rdr["ArchitecID"].ToString();
                architect.ArchitectName = rdr["ArchitectName"].ToString();
                architects.Add(architect);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(architects));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataspGetProjectInfoByid2(string ArchitecID, string StartYearDate, string EndYearDate, string Search)
        {
            List<GetDataspGetProjectInfoByid2> project = new List<GetDataspGetProjectInfoByid2>();
            SqlCommand comm = new SqlCommand("spGetProjectInfoByid2", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@ArchitecID", Value = ArchitecID };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@StartYearDate", Value = StartYearDate };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@EndYearDate", Value = EndYearDate };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = Search };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataspGetProjectInfoByid2 projects = new GetDataspGetProjectInfoByid2();
                projects.No = rdr["No"].ToString();
                projects.ProjectID = rdr["ProjectID"].ToString();
                projects.ProjectYear = rdr["ProjectYear"].ToString();
                projects.ProjectMonth = rdr["ProjectMonth"].ToString();
                projects.ProjectName = rdr["ProjectName"].ToString();
                projects.CompanyID = rdr["CompanyID"].ToString();
                projects.CompanyName = rdr["CompanyName"].ToString();
                projects.ArchitecID = rdr["ArchitecID"].ToString();
                projects.Name = rdr["Name"].ToString();
                projects.Location = rdr["Location"].ToString();
                projects.TurnKey = rdr["TurnKey"].ToString();
                projects.MainCons = rdr["MainCons"].ToString();
                projects.RefRfDf = rdr["RefRfDf"].ToString();
                projects.ProjStep = rdr["ProjStep"].ToString();
                projects.ProductType = rdr["ProductType"].ToString();
                projects.RefProfile = rdr["RefProfile"].ToString();
                projects.ProdTypeID = rdr["ProdTypeID"].ToString();
                projects.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                projects.ProdID = rdr["ProdID"].ToString();
                projects.ProdNameEN = rdr["ProdNameEN"].ToString();
                projects.ProfID = rdr["ProfID"].ToString();
                projects.ProfNameEN = rdr["ProfNameEN"].ToString();
                projects.StatusID = rdr["StatusID"].ToString();
                projects.StatusNameEn = rdr["StatusNameEn"].ToString();
                projects.Quantity = rdr["Quantity"].ToString();
                projects.RefType = rdr["RefType"].ToString();
                projects.DeliveryDate = rdr["DeliveryDate"].ToString();
                projects.Drawing = rdr["Drawing"].ToString();
                projects.TypeID = rdr["TypeID"].ToString();
                projects.SaleSpec = rdr["SaleSpec"].ToString();
                projects.StatusConID = rdr["StatusConID"].ToString();
                projects.CreatedDate = rdr["CreatedDate"].ToString();
                projects.LastUpdate = rdr["LastUpdate"].ToString();
                project.Add(projects);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(project));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSumProjectInfoByid2(string ArchitecID, string StartYearDate, string EndYearDate, string Search)
        {
            List<GetDataSumProjectInfoByid2> project = new List<GetDataSumProjectInfoByid2>();
            SqlCommand comm = new SqlCommand("spGetSumProjectInfoByid2", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@ArchitecID", Value = ArchitecID };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@StartYearDate", Value = StartYearDate };
            SqlParameter param3 = new SqlParameter() { ParameterName = "@EndYearDate", Value = EndYearDate };
            SqlParameter param4 = new SqlParameter() { ParameterName = "@Search", Value = Search };
            comm.Parameters.Add(param1);
            comm.Parameters.Add(param2);
            comm.Parameters.Add(param3);
            comm.Parameters.Add(param4);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetDataSumProjectInfoByid2 projects = new GetDataSumProjectInfoByid2();

                projects.SumQuantity = rdr["SumQuantity"].ToString();
                project.Add(projects);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(project));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetActiviteEvent()
        {
            List<GetActivityEvent> data = new List<GetActivityEvent>();
            SqlCommand comm = new SqlCommand("spGetActiviteEvent", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetActivityEvent datas = new GetActivityEvent();
                datas.architect_id = rdr["architect_id"].ToString();
                datas.Name = rdr["Name"].ToString();
                datas.NickName = rdr["NickName"].ToString();
                datas.Birthday = rdr["Birthday"].ToString();
                datas.Mobile = rdr["Mobile"].ToString();
                datas.CompanyID = rdr["CompanyID"].ToString();
                datas.CompanyName = rdr["CompanyName"].ToString();
                datas.id = rdr["id"].ToString();
                datas.event_id = rdr["event_id"].ToString();
                datas.event_desc = rdr["event_desc"].ToString();
                datas.title_id = rdr["title_id"].ToString();
                datas.title_desc = rdr["title_desc"].ToString();
                datas.trans_date = rdr["trans_date"].ToString();
                datas.details = rdr["details"].ToString();
                datas.inv_id = rdr["inv_id"].ToString();
                datas.inv_desc = rdr["inv_desc"].ToString();
                datas.attn_id = rdr["attn_id"].ToString();
                datas.attn_desc = rdr["attn_desc"].ToString();
                datas.remark = rdr["remark"].ToString();
                datas.userid = rdr["userid"].ToString();
                datas.created_date = rdr["created_date"].ToString();
                datas.lasted_date = rdr["lasted_date"].ToString();
                datas.isdelete = rdr["isdelete"].ToString();
                data.Add(datas);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(data));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetActiviteReward()
        {
            List<GetActivityEvent> data = new List<GetActivityEvent>();
            SqlCommand comm = new SqlCommand("spGetActiviteReward", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                GetActivityEvent datas = new GetActivityEvent();
                datas.architect_id = rdr["architect_id"].ToString();
                datas.Name = rdr["Name"].ToString();
                datas.NickName = rdr["NickName"].ToString();
                datas.Birthday = rdr["Birthday"].ToString();
                datas.Mobile = rdr["Mobile"].ToString();
                datas.CompanyID = rdr["CompanyID"].ToString();
                datas.CompanyName = rdr["CompanyName"].ToString();
                datas.id = rdr["id"].ToString();
                datas.event_id = rdr["event_id"].ToString();
                datas.event_desc = rdr["event_desc"].ToString();
                datas.title_id = rdr["title_id"].ToString();
                datas.title_desc = rdr["title_desc"].ToString();
                datas.trans_date = rdr["trans_date"].ToString();
                datas.details = rdr["details"].ToString();
                datas.inv_id = rdr["inv_id"].ToString();
                datas.inv_desc = rdr["inv_desc"].ToString();
                datas.attn_id = rdr["attn_id"].ToString();
                datas.attn_desc = rdr["attn_desc"].ToString();
                datas.remark = rdr["remark"].ToString();
                datas.userid = rdr["userid"].ToString();
                datas.created_date = rdr["created_date"].ToString();
                datas.lasted_date = rdr["lasted_date"].ToString();
                datas.isdelete = rdr["isdelete"].ToString();
                data.Add(datas);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(data));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSOSProjectMapping(string strOption, string strDateStart, string strDateEnd, string strUserID, string strQtyStart, string strQtyEnd, string strSearch)
        {
            List<GetSOSProjectMapping> projects = new List<GetSOSProjectMapping>();
           
                SqlCommand comm = new SqlCommand("spGetSOSProjectMapping", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter() { ParameterName = "@strOption", Value = strOption };
                SqlParameter param2 = new SqlParameter() { ParameterName = "@strDateStart", Value = strDateStart };
                SqlParameter param3 = new SqlParameter() { ParameterName = "@strDateEnd", Value = strDateEnd };
                SqlParameter param4 = new SqlParameter() { ParameterName = "@strUserID", Value = strUserID };
                SqlParameter param5 = new SqlParameter() { ParameterName = "@strQtyStart", Value = strQtyStart };
                SqlParameter param6 = new SqlParameter() { ParameterName = "@strQtyEnd", Value = strQtyEnd };
                SqlParameter param7 = new SqlParameter() { ParameterName = "@strSearch", Value = strSearch };

                comm.Parameters.Add(param1);
                comm.Parameters.Add(param2);
                comm.Parameters.Add(param3);
                comm.Parameters.Add(param4);
                comm.Parameters.Add(param5);
                comm.Parameters.Add(param6);
                comm.Parameters.Add(param7);

              
                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    GetSOSProjectMapping project = new GetSOSProjectMapping();

                    project.ID = rdr["ID"].ToString();
                    project.UserID = rdr["UserID"].ToString();
                    project.WeekDate = rdr["WeekDate"].ToString();
                    project.WeekTime = rdr["WeekTime"].ToString();
                    project.CompanyName = rdr["CompanyName"].ToString();
                    project.ArchitectID = rdr["ArchitecID"].ToString();
                    project.Name = rdr["Name"].ToString();
                    project.ProjectID = rdr["ProjectID"].ToString();
                    project.ProjectName = rdr["ProjectName"].ToString();
                    project.Location = rdr["Location"].ToString();
                    project.ProdTypeID = rdr["ProdTypeID"].ToString();
                    project.ProdTypeNameEN = rdr["ProdTypeNameEN"].ToString();
                    project.ProdID = rdr["ProdID"].ToString();
                    project.ProdNameEN = rdr["ProdNameEN"].ToString();
                    project.ProfNameEN = rdr["ProfNameEN"].ToString();
                    project.DeliveryDate = rdr["DeliveryDate"].ToString();
                    project.NextVisitDate = rdr["NextVisitDate"].ToString();
                    project.Quantity = rdr["Quantity"].ToString();
                    project.StepNameA = rdr["StepNameA"].ToString();
                    project.StepNameB = rdr["StepNameB"].ToString();
                    project.RefWeekDate = rdr["RefWeekDate"].ToString();
                    project.Ref1 = rdr["Ref1"].ToString();
                    project.Ref2 = rdr["Ref2"].ToString();
                    project.Ref3 = rdr["Ref3"].ToString();
                    project.RefRemark = rdr["RefRemark"].ToString();
                    project.StepID = rdr["StepID"].ToString();
                    projects.Add(project);
                }
          
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(projects));
            conn.CloseConn();
        }
    }
}
