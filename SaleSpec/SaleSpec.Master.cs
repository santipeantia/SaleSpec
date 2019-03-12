﻿using System;
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


        public string strActiveTransaction = "";
        public string strTextRequestForm = "";
        public string strTextArchitectCenter = "";
        public string strTextProjectCenter = "";
        public string strTextWeeklyReport = "";



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
            try
            {
                strOpt = Request.Params["opt"].ToString();

                //if (strOpt == "vendors") { strActiveSettingGroup = "active"; strActiveVendors = "active"; strTextItemsVendor = "text-red"; } else { strTextItemsVendor = ""; }
                if (strOpt == "cus") { strActiveMasterSetup = "active"; strTextCustomerType = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomerType = ""; }
                if (strOpt == "cusg") { strActiveMasterSetup = "active"; strTextCustomerGrade = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomerGrade = ""; }
                if (strOpt == "prdg") { strActiveMasterSetup = "active"; strTextProductGroup = "text-red"; return; } else { strActiveMasterSetup = ""; strTextProductGroup = ""; }
                if (strOpt == "spc") { strActiveMasterSetup = "active"; strTextSpecifier = "text-red"; return; } else { strActiveMasterSetup = ""; strTextSpecifier = ""; }
                if (strOpt == "sarc") { strActiveMasterSetup = "active"; strTextArchitect = "text-red"; return; } else { strActiveMasterSetup = ""; strTextArchitect = ""; }
                if (strOpt == "scus") { strActiveMasterSetup = "active"; strTextCustomers = "text-red"; return; } else { strActiveMasterSetup = ""; strTextCustomers = ""; }
                

                if (strOpt == "reqf") { strActiveTransaction = "active"; strTextRequestForm = "text-red"; return; } else { strActiveTransaction = ""; strTextRequestForm = ""; }
                if (strOpt == "arc") { strActiveTransaction = "active"; strTextArchitectCenter = "text-red"; return; } else { strActiveTransaction = ""; strTextArchitectCenter = ""; }
                if (strOpt == "pjc") { strActiveTransaction = "active"; strTextProjectCenter = "text-red"; return; } else { strActiveTransaction = ""; strTextProjectCenter = ""; }
                if (strOpt == "wkr") { strActiveTransaction = "active"; strTextWeeklyReport = "text-red"; return; } else { strActiveTransaction = ""; strTextWeeklyReport = ""; }
            
            }
            catch
            {
               
                return;
            }
            
        }
    }
}