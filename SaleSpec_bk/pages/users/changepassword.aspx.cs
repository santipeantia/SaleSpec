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

namespace SaleSpec.pages.users
{
    public partial class changepassword : System.Web.UI.Page
    {
        string ssql;
        DataTable dt = new DataTable();

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        public string strMsgAlert = "";
        public string strTblDetail = "";
        public string strTblActive = "";

        bool bflag = false;

        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void confirmChange_click(object sender, EventArgs e)
        {
            try
            {
                string strUserID = Session["UserID"].ToString();
                string strEmpCode = Session["EmpCode"].ToString();
                string strOldPassword = encryptpass(Request.Form["oldpasssword"]);

                string strNewPassword = encryptpass(Request.Form["newpasssword"]);
                string strConfirmPassword = encryptpass(Request.Form["confirmpasssword"]);

                CheckCurrentPassword(strUserID, strOldPassword);

                //check current username and password
                if (bflag == false)
                {
                    strMsgAlert = " <div class=\"fad fad-in alert alert-danger\"> " +
                                "   <strong>Warning!</strong><br />Your current password is wrong..!</div>";
                    return;
                }

                //check equal new password
                if ((strNewPassword != strConfirmPassword) || (strNewPassword== "") || (strConfirmPassword==""))
                {
                    strMsgAlert = " <div class=\"fad fad-in alert alert-danger\"> " +
                                "   <strong>Warning!</strong><br />Your password is incorrect..!</div>";
                    bflag = false;
                    return;
                }
                else
                {
                    bflag = true;
                }

                if (bflag == true)
                {
                    //update confirmpassword to table
                    ssql = "update adUserLogin set Password = '"+ strConfirmPassword + "' " +
                           "WHERE UserID = '" + strUserID + "' and EmpCode = '" + strEmpCode + "'  ";

                    dbConn = new dbConnection();
                    SqlCommand comm = new SqlCommand(ssql, dbConn.OpenConn());
                    comm.ExecuteNonQuery();


                    strMsgAlert = " <div class=\"fad fad-in alert alert-success\"> " +
                               "   <strong>Success!</strong><br />Change new password...!</div>";
                }
            }
            catch (Exception ex)
            {
                strMsgAlert = " <div class=\"fad fad-in alert alert-danger\"> " +
                                "   <strong>Warning!</strong><br />" + ex.Message + "...!</div>";
            }
        }

        protected void CheckCurrentPassword(string strUserID, string strOldpassword)
        {
            try
            {
                ssql = "SELECT	a.UserID, a.EmpCode, a.Password, b.id, b.sEmpID, b.sEmpOrgLevel2, c.sEngName, " +
                        "        b.sEmpNamePrefix, b.sEmpFirstName, b.sEmpLastName, b.sEmpEngNamePrefix,  " +
                        "        b.sEmpEngFirstName, b.sEmpEngLastName, b.sEmpNickName " +
                        "FROM    adUserLogin a left join " +
                        "        adEmployee b on a.EmpCode = b.sEmpID left join " +
                        "        adDepartment c on b.sEmpOrgLevel2 = c.sCode2 collate Thai_CI_AS" +
                        "        WHERE a.UserID = '" + strUserID + "' and a.Password = '" + strOldpassword + "'";

                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    bflag = true;
                }
            }
            catch (Exception ex)
            {
                bflag = false;
                strMsgAlert = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />" + ex.Message + "...!</div>";
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
}