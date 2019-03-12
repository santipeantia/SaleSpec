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
        protected void Page_Load(object sender, EventArgs e)
        {
            string display = "Your dispaly";

            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + display + "');", true);//this will dispaly the alert box


            ScriptManager.RegisterStartupScript(this, this.GetType(), "Close_Window", "self.close();", true);//this will close the page on button click
        }

        protected void ContineButton_Click(object sender, EventArgs e)
        {
            //this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.close()", true);
            Page.ClientScript.RegisterOnSubmitStatement(typeof(Page), "closePage", "window.onunload = CloseWindow();");
        }
    }
}