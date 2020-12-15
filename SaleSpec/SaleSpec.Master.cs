using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using CrystalDecisions.CrystalReports.Engine;
using System.Security.Cryptography;

namespace SaleSpec
{
    public partial class SaleSpec : System.Web.UI.MasterPage
    {
        public string strActiveDashboard = "";
        public string strTextRedDashboard = "";

        //public string strActiveSettingGroup = "";

        public string strActiveMasterSetup = "";
        public string strTextCustomerType = "";
        public string strTextCustomerGrade = "";
        public string strTextProductGroup = "";
        public string strTextSpecifier = "";
        public string strTextArchitect = "";
        public string strTextCustomers = "";
        public string strTextProjectsetup = "";
        


        public string strActiveTransaction = "";
        public string strTextRequestForm = "";
        public string strTextArchitectCenter = "";
        public string strTextProjectCenter = "";
        public string strTextWeeklyReport = "";

        public string strFullName = "";
        public string strDept = "";

        public string strActiveReporting = "";
        public string strTextSaleWeeklyReport = "";
        public string strTextNewProjectReport = "";

        public string strTextReportForecasting = "";
        public string strTextSaleIntake = "";
        public string strTextCompanyReport = "";
        public string strTextArchitectReport = "";
        public string strTextProjectReport = "";

        public string strActiveActivity = "";
        public string strTextEventActivity = "";
        public string strTextPremiumGift = "";
        public string strTextSurprise = "";

        public string strActiveActivitiesReporting = "";
        public string strTextReportEvent = "";
        public string strTextReportReward = "";

        public string strSaleOnSpecActive = "";
        public string strTextSaleOnspec = "";
        public string strTextSOSMapping = "";
        public string strSaleOnSpecTrans = "";
        public string strTextSaleOnspecFilter = "";

        //public string strTextPremiumGift = "";
        //public string strTextSurprise = "";


        //public string strTextProductGroup = "";

        //public string strActiveItemsGroup = "";
        //public string strTextItemsGroup = "";
        //public string strTextItemsCategory = "";
        //public string strTextItemsType = "";
        //public string strTextItemsUnit = "";
        //public string strTextProdItems = "";
        //public string strTextWarehouse = "";

        //public string strActiveVendors = "";
        //public string strTextItemsVendor = "";
        //public string strTextVendorrLevel = "";
        //public string strTextVendorList = "";

        //public string strActiveCustomer = "";

        //public string strTextCustomerLevel = "";
        //public string strTextCustomerList = "";

        //public string strActiveGeneral = "";
        //public string strTextCompany = "";
        //public string strTextCountry = "";
        //public string strTextProvince = "";
        //public string strTextBusiness = "";
        //public string strTextBusinessGroup = "";
        //public string strTextDivision = "";
        //public string strTextDepartment = "";
        //public string strTextPosition = "";
        //public string strTextPayment = "";
        //public string strTextCurrency = "";
        //public string strTextExchange = "";
        //public string strTextUnitStandard = "";

        //public string strActiveEmployee = "";
        //public string strTextEducation = "";
        //public string strTextPrefix = "";
        //public string strTextReligion = "";
        //public string strTextMarried = "";
        //public string strTextEmployee = "";

        //public string strActiveSaleRecord = "";
        //public string strTextSaleRecord = "";

        //public string strForecastingGroup = "";
        //public string strActiveForecast = "";
        //public string strTextForecast = "";
        //public string strTextActualSale = "";
        //public string strTextForBySupp = "";
        //public string strTextTarketKPI = "";
        //public string strTextShelflife = "";
        //public string strTextQForeSupp = "";
        //public string strTextQForeCust = "";
        //public string strTextQActualSupp = "";
        //public string strTextQActualCust = "";
        //public string strTextQExpiryDate = "";
        //public string strTextQCompareSales = "";
        //public string strTextQInvMonthReport = "";
        //public string strActiveQForecast = "";

        //public string strPurchaseGroup = "";
        //public string strActivePurchase = "";
        //public string strTextReqPR = "";

        string ssql;
        string strOpt = "";

        DataTable dt;
        //SqlConnection sqlConn = new SqlConnection();
        //SqlTransaction transac;

        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../users/login");
            }
            string sEmpCode = Session["EmpCode"].ToString();
            GetAllowNavigation(sEmpCode);

            strFullName = Session["sEmpEngFirstName"].ToString() + "  "  + Session["sEmpEngLastName"].ToString();
            strDept =  Session["sEngName"].ToString();

            try
            {
                strOpt = Request.Params["opt"].ToString();

                ssql = "Query String";

                //if (strOpt == "vendors") { strActiveSettingGroup = "active"; strActiveVendors = "active"; strTextItemsVendor = "text-red"; } else { strTextItemsVendor = ""; }
                if (strOpt == "cus") { strActiveMasterSetup = "active"; strTextCustomerType = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomerType = ""; }
                if (strOpt == "cusg") { strActiveMasterSetup = "active"; strTextCustomerGrade = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomerGrade = ""; }
                if (strOpt == "prdg") { strActiveMasterSetup = "active"; strTextProductGroup = "text-red"; return; } else { strActiveMasterSetup = ""; strTextProductGroup = ""; }
                if (strOpt == "spc") { strActiveMasterSetup = "active"; strTextSpecifier = "text-red"; return; } else { strActiveMasterSetup = ""; strTextSpecifier = ""; }
                if (strOpt == "sarc") { strActiveMasterSetup = "active"; strTextArchitect = "text-red"; return; } else { strActiveMasterSetup = ""; strTextArchitect = ""; }
                if (strOpt == "scus") { strActiveMasterSetup = "active"; strTextCustomers = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomers = ""; }
                if (strOpt == "comp") { strActiveMasterSetup = "active"; strTextCustomers = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomers = ""; }
                if (strOpt == "prjs") { strActiveMasterSetup = "active"; strTextProjectsetup = "text-red"; return; } else { strActiveMasterSetup = ""; strTextProjectsetup = ""; }
                

                if (strOpt == "reqf") { strActiveTransaction = "active"; strTextRequestForm = "text-red"; return; } else { strActiveTransaction = ""; strTextRequestForm = ""; }
                if (strOpt == "arc") { strActiveTransaction = "active"; strTextArchitectCenter = "text-red"; return; } else { strActiveTransaction = ""; strTextArchitectCenter = ""; }
                if (strOpt == "pjc") { strActiveTransaction = "active"; strTextProjectCenter = "text-red"; return; } else { strActiveTransaction = ""; strTextProjectCenter = ""; }
                if (strOpt == "wkr") { strActiveTransaction = "active"; strTextWeeklyReport = "text-red"; return; } else { strActiveTransaction = ""; strTextWeeklyReport = ""; }
               
                if (strOpt == "evt") { strActiveActivity = "active"; strTextEventActivity = "text-red"; return; } else { strActiveActivity = ""; strTextEventActivity = ""; }
                if (strOpt == "preg") { strActiveActivity = "active"; strTextPremiumGift = "text-red"; return; } else { strActiveActivity = ""; strTextPremiumGift = ""; }
                if (strOpt == "spg") { strActiveActivity = "active"; strTextSurprise = "text-red"; return; } else { strActiveActivity = ""; strTextSurprise = ""; }

                if (strOpt == "actev") { strActiveActivity = "active"; strTextReportEvent = "text-red"; return; } else { strActiveActivity = ""; strTextReportEvent = ""; }
                if (strOpt == "actre") { strActiveActivity = "active"; strTextReportReward = "text-red"; return; } else { strActiveActivity = ""; strTextReportReward = ""; }

                                
                if (strOpt == "sos") { strSaleOnSpecActive = "active"; strTextSaleOnspec = "text-red"; return; } else { strSaleOnSpecActive = ""; strTextSaleOnspec = ""; }
                if (strOpt == "sof") { strSaleOnSpecActive = "active"; strTextSaleOnspecFilter = "text-red"; return; } else { strSaleOnSpecActive = ""; strTextSaleOnspecFilter = ""; }
                if (strOpt == "spm") { strSaleOnSpecActive = "active"; strTextSOSMapping = "text-red"; return; } else { strSaleOnSpecActive = ""; strTextSOSMapping = ""; }


                if (strOpt == "rptswr") { strActiveReporting = "active"; strTextSaleWeeklyReport = "text-red"; return; } else { strActiveReporting = ""; strTextSaleWeeklyReport = ""; }
                if (strOpt == "rptnprj") { strActiveReporting = "active"; strTextNewProjectReport = "text-red"; return; } else { strActiveReporting = ""; strTextNewProjectReport = ""; }
                               

                if (strOpt == "rcom") { strActiveReporting = "active"; strTextCompanyReport = "text-red"; return; } else { strActiveReporting = ""; strTextCompanyReport = ""; }
                if (strOpt == "rarc") { strActiveReporting = "active"; strTextArchitectReport = "text-red"; return; } else { strActiveReporting = ""; strTextArchitectReport = ""; }
                if (strOpt == "rpjc") { strActiveReporting = "active"; strTextProjectReport = "text-red"; return; } else { strActiveReporting = ""; strTextProjectReport = ""; }

                if (strOpt == "rfoc") { strActiveReporting = "active"; strTextReportForecasting = "text-red"; return; } else { strActiveReporting = ""; strTextReportForecasting = ""; }
                if (strOpt == "itk") { strActiveReporting = "active"; strTextSaleIntake = "text-red"; return; } else { strActiveReporting = ""; strTextSaleIntake = ""; }

                
                





            }
            catch
            {
               
                return;
            }
            
        }

        protected void GetAllowNavigation(string strEmpCode)
        {
            try
            {
                ssql = "SELECT  mid, UserID, EmpCode, PageURL, isAllow " +
                        "FROM adUserPermission  " +
                        "WHERE (EmpCode = '"+ strEmpCode + "') and isAllow='1' ";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        string xPage = dt.Rows[i]["PageURL"].ToString();

                        
                        if (xPage == "Enterprise") { mnuenterprise.Visible = true; }
                        if (xPage == "masters/customergrade") { mascusgrade.Visible = true; }
                        if (xPage == "masters/customertype") { mascustype.Visible = true; }
                        if (xPage == "masters/productgroup") { masprodgroup.Visible = true; }
                        if (xPage == "masters/specifier") { masspecifier.Visible = true; }
                        if (xPage == "masters/company") { mascompany.Visible = true; }
                        if (xPage == "masters/architect") { masarchitect.Visible = true; }
                        if (xPage == "masters/projectsetup") { masprojsetup.Visible = true; }

                        if (xPage == "trans/weeklyreport") { transwkr.Visible = true; }
                        if (xPage == "trans/projects") { transproject.Visible = true; }
                        if (xPage == "trans/apprequest-new") { transappreqnew.Visible = true; }
                        if (xPage == "trans/apprequest") { transapprequest.Visible = true; }


                       // if (xPage == "SaleOnSpec") { menusaleonspec.Visible = true; }
                        if (xPage == "trans/saleonspec") { transsaleonspec.Visible = true; }
                        if (xPage == "trans/sosmapping") { sosprojectmapping.Visible = true; }
                        if (xPage == "trans/saleonspecfilter") { sosfinalfilter.Visible = true; }

                        if (xPage == "report/saleweeklyreport") { reportsalewrk.Visible = true; }
                        if (xPage == "report/newprojectreport") { reportnewproject.Visible = true; }


                        if (xPage == "report/companyreport") { reportcomreport.Visible = true; }
                        if (xPage == "report/architectreport") { reportarchitect.Visible = true; }
                        if (xPage == "report/projectreport") { reportproject.Visible = true; }
                        if (xPage == "report/forecastingreport") { reportforecasting.Visible = true; }
                        if (xPage == "report/specintakereport") { reportspecintake.Visible = true; }




                        if (xPage == "report/activity_event") { mnuactivity.Visible = true; }
                        
                        
                    }
                }
            }
            catch
            {

            }
        }
    }
}