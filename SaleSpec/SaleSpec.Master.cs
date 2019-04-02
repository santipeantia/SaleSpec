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
        public string strTextSaleOnspec = "";


        public string strActiveTransaction = "";
        public string strTextRequestForm = "";
        public string strTextArchitectCenter = "";
        public string strTextProjectCenter = "";
        public string strTextWeeklyReport = "";

        public string strFullName = "";
        public string strDept = "";

        public string strActiveReporting = "";
        public string strTextSaleWeeklyReport = "";
        public string strTextReportForecasting = "";
        public string strTextSaleIntake = "";
        public string strTextCompanyReport = "";
        public string strTextArchitectReport = "";
        public string strTextProjectReport = "";

        public string strActiveActivity = "";
        public string strTextEventActivity = "";
        public string strTextPremiumGift = "";
        public string strTextSurprise = "";



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

        DataTable dt = new DataTable();
        SqlConnection sqlConn = new SqlConnection();
        SqlTransaction transac;

        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../users/login");
            }

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
                if (strOpt == "sos") { strActiveTransaction = "active"; strTextSaleOnspec = "text-red"; return; } else { strActiveTransaction = ""; strTextSaleOnspec = ""; }

                if (strOpt == "evt") { strActiveActivity = "active"; strTextEventActivity = "text-red"; return; } else { strActiveActivity = ""; strTextEventActivity = ""; }
                if (strOpt == "preg") { strActiveActivity = "active"; strTextPremiumGift = "text-red"; return; } else { strActiveActivity = ""; strTextPremiumGift = ""; }
                if (strOpt == "spg") { strActiveActivity = "active"; strTextSurprise = "text-red"; return; } else { strActiveActivity = ""; strTextSurprise = ""; }

                


                if (strOpt == "rptswr") { strActiveReporting = "active"; strTextSaleWeeklyReport = "text-red"; return; } else { strActiveReporting = ""; strTextSaleWeeklyReport = ""; }
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
    }
}