using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.IO;
using System.Globalization;

public partial class pages_users_login : System.Web.UI.Page
{
    //dbConnectionSQL dbConnSQL = new dbConnectionSQL();
    string ssql;
    DataTable dt = new DataTable();

    public static string strErorConn="";

    protected void Page_Load(object sender, EventArgs e)
    {

        //divWraning.Visible = false;
    }

    protected void btnLogin_click(object sender, EventArgs e)
    {

        #region 'test identity'
        
        #endregion  

        //try
        //{
        //    string strUserName = Request.Form["inpUserName"];
        //    string strPassWord = Request.Form["inpPassWord"];

        //    ssql = "SELECT UserID, UserName, PassWord, FirstName, LastName, IsActive, CreatedBy, CreatedDate, UserTypeID " +
        //           "FROM    tblUsers WHERE UserName='" + strUserName + "' and PassWord='" + strPassWord + "' and IsActive='true' ";

        //    dt = new DataTable();
        //    dt = dbConnSQL.GetDataTable(ssql);

        //    if (dt.Rows.Count != 0)
        //    {
        //        Session["UserID"] = dt.Rows[0]["UserID"].ToString();
        //        Session["UserName"] = dt.Rows[0]["UserName"].ToString();
        //        Session["FirstName"] = dt.Rows[0]["FirstName"].ToString();
        //        Session["LastName"] = dt.Rows[0]["LastName"].ToString();

        //        //Response.Redirect("../byksales/salesrecords?opt=salerec");
        Response.Redirect("../../pages/");

        //    }
        //    else
        //    {
        //        divWraning.Visible = true;
        //        return;
        //    }
        //}
        //catch (Exception ex)
        //{
        //    strErorConn = ex.Message;
        //    divWraning.Visible = true;
        //}
       
    }
}