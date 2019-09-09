using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SaleSpec.Class
{
    public class GetInsertWeeklyReport
    {
        public string WeekDate { get; set; }
        public string WeekTime { get; set; }
        public string CompanyID { get; set; }
        public string CompanyName { get; set; }
        public string ArchitecID { get; set; }
        public string Name { get; set; }
        public string TransID { get; set; }
        public string TransNameEN { get; set; }
        public string ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string Location { get; set; }
        public string TurnKey { get; set; }
        public string StepID { get; set; }
        public string StepNameEn { get; set; }
        public string BiddingName1 { get; set; }
        public string OwnerName1 { get; set; }
        public string BiddingName2 { get; set; }
        public string OwnerName2 { get; set; }
        public string BiddingName3 { get; set; }
        public string OwnerName3 { get; set; }
        public string AwardMC { get; set; }
        public string ContactMC { get; set; }
        public string AwardRF { get; set; }
        public string ContactRF { get; set; }
        public string ProdTypeID { get; set; }
        public string ProdTypeNameEN { get; set; }
        public string ProdID { get; set; }
        public string ProdNameEN { get; set; }
        public string ProfID { get; set; }
        public string ProfNameEN { get; set; }
        public string Quantity { get; set; }
        public string DeliveryDate { get; set; }
        public string NextVisitDate { get; set; }
        public string StatusID { get; set; }
        public string StatusNameEn { get; set; }
        public string NewArchitect { get; set; }
        public string HaveFiles { get; set; }
        public string FileName { get; set; }
        public string Remark { get; set; }
        public string UserID { get; set; }
        public string EmpCode { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
    }
}