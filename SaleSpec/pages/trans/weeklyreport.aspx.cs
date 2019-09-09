using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SaleSpec.pages.trans
{
    public partial class weeklyreport : System.Web.UI.Page
    {
        public string sPage = "trans/weeklyreport";

        protected void Page_Load(object sender, EventArgs e)
        {
            //string strUserID = Session["UserID"].ToString();
            if (Session["UserID"] == null)
            {
                Response.Redirect("../../pages/users/login");
            }
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            string strSelect = selectTrans.Value;

            if (strSelect == "0")
            {
                Response.Redirect("../../pages/trans/apprequest-new?opt=reqf");
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Redirect to page " + strSelect + "');", true);
            }
            else if (strSelect == "1")
            {
                Response.Redirect("../../pages/trans/projects-update?opt=wkr");
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Redirect to page " + strSelect + "');", true);
            }
            else if (strSelect == "2")
            {
                Response.Redirect("../../pages/master/architect?opt=sarc");
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Redirect to page " + strSelect + "');", true);
            }
            else if (strSelect == "3")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Redirect to page " + strSelect + "');", true);
            }
            else
            {
                Response.Redirect("../../pages/trans/weeklyreport-update?opt=wkr");
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Redirect to page " + strSelect + "');", true);
            }



        }

    }
}