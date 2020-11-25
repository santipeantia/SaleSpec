using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.IO;
using System.Text;
//using SaleSpec;

public partial class pages_users_login : System.Web.UI.Page
{
    SaleSpec.dbConnection dbConn = new SaleSpec.dbConnection();

    string ssql;
    DataTable dt = new DataTable();

    public static string strErorConn="";

    SqlConnection Conn = new SqlConnection();
    SqlCommand Comm = new SqlCommand();
    SqlDataAdapter da = new SqlDataAdapter();
    SqlTransaction transac;

    public string strMsgAlert = "";
    public string strTblDetail = "";
    public string strTblActive = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            strErorConn = "";
            Session["isLogin"] = 0;
        }
    }

    protected void btnLogin_click(object sender, EventArgs e)
    {
        try
            {
            string strUserName = Request.Form["inpUserName"];
            string strPassWord = Request.Form["inpPassWord"];

            string encassword = encryptpass(strPassWord);
            //string decassword = Decryptdata(strPassWord);

            ssql = "SELECT	a.UserID, a.EmpCode, a.Password, b.id, b.sEmpID, b.sEmpOrgLevel2, c.sEngName, " +
                        "        b.sEmpNamePrefix, b.sEmpFirstName, b.sEmpLastName, b.sEmpEngNamePrefix,  " +
                        "        b.sEmpEngFirstName, b.sEmpEngLastName, b.sEmpNickName " +
                        "FROM    adUserLogin a left join " +
                        "        adEmployee b on a.EmpCode = b.sEmpID left join " +
                        "        adDepartment c on b.sEmpOrgLevel2 = c.sCode2 collate Thai_CI_AS" +
                        "        WHERE a.UserID = '" + strUserName + "' and a.Password = '" + encassword + "' and StatusID='true' ";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    Session["UserID"] = dt.Rows[0]["UserID"].ToString();
                    Session["EmpCode"] = dt.Rows[0]["EmpCode"].ToString();
                    Session["id"] = dt.Rows[0]["UserID"].ToString();
                    Session["sEmpID"] = dt.Rows[0]["sEmpID"].ToString();
                    Session["sEmpOrgLevel2"] = dt.Rows[0]["sEmpOrgLevel2"].ToString();
                    Session["sEngName"] = dt.Rows[0]["sEngName"].ToString();
                    Session["sEmpNamePrefix"] = dt.Rows[0]["sEmpNamePrefix"].ToString();
                    Session["sEmpFirstName"] = dt.Rows[0]["sEmpFirstName"].ToString();
                    Session["sEmpLastName"] = dt.Rows[0]["sEmpLastName"].ToString();
                    Session["sEmpEngNamePrefix"] = dt.Rows[0]["sEmpEngNamePrefix"].ToString();
                    Session["sEmpEngFirstName"] = dt.Rows[0]["sEmpEngFirstName"].ToString();
                    Session["sEmpEngLastName"] = dt.Rows[0]["sEmpEngLastName"].ToString();
                    Session["sEmpNickName"] = dt.Rows[0]["sEmpNickName"].ToString();

                    //Response.Redirect("../byksales/salesrecords?opt=salerec");
                    Response.Redirect("../../pages/home/");

                }
                else
                {

                Session["isLogin"] = Convert.ToInt32(Session["isLogin"].ToString()) + 1;

                if (Convert.ToInt32(Session["isLogin"]) == 3)
                    {
                        strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Password is wrong 3 times, this account is locked please contact administrator..!</div>";
                    }
                    else
                    {
                        strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Incorrect username or password..!</div>";
                    }

                    return;
                }
            }
            catch (Exception ex)
            {
                strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Incorrect username or password <br /> " + ex.Message + "</div> ";
                //divWraning.Visible = true;
            }
    }

    public string encryptpass(string password)
    {
        string strpass = string.Empty;
        byte[] encode = new byte[password.Length];
        encode = Encoding.UTF8.GetBytes(password);
        strpass = Convert.ToBase64String(encode);
        return strpass;
    }

    //public static string Encryptdata(string password)
    //{
    //    string strmsg = string.Empty;
    //    byte[] encode = new byte[password.Length];
    //    encode = Encoding.UTF8.GetBytes(password);
    //    strmsg = Convert.ToBase64String(encode);
    //    return strmsg;
    //}

    public static string Decryptdata(string encryptpwd)
    {
        string decryptpwd = string.Empty;
        UTF8Encoding encodepwd = new UTF8Encoding();
        Decoder Decode = encodepwd.GetDecoder();
        byte[] todecode_byte = Convert.FromBase64String(encryptpwd);
        int charCount = Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
        char[] decoded_char = new char[charCount];
        Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
        decryptpwd = new String(decoded_char);
        return decryptpwd;
    }

}