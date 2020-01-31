using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SaleSpec.pages.report
{
    public class GetLevelHistory
    {
        public int id { get; set; }
        public int inYear { get; set; }
        public string ArchitecID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string level_id { get; set; }
        public string level_desc { get; set; }
        public string isactive { get; set; }
        public string last_update { get; set; }
    }
}