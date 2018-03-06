using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class Members : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void roleType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (roleType.SelectedValue == "Instructor")
            {
                roleTarget.Visible = true;
                roleTarget.DataSourceID = "InstructorsDS";
                roleTarget.DataTextField = "Ins_Name";
                roleTarget.DataValueField = "Ins_Id";
                roleTarget.DataBind();
            }
            else if (roleType.SelectedValue == "Student")
            {
                roleTarget.Visible = true;
                roleTarget.DataSourceID = "StudentsDS";
                roleTarget.DataTextField = "ST_Name";
                roleTarget.DataValueField = "ST_ID";
                roleTarget.DataBind();
            }
            else
            {
                roleTarget.Visible = false;
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txt_user.Text) && !string.IsNullOrEmpty(txt_passw.Text))
            {
                var user = Membership.GetUser(txt_user.Text);
                if (user == null)
                {
                    string updateStatment = null;
                    Membership.CreateUser(txt_user.Text, txt_passw.Text);
                    if (roleType.SelectedValue == "Administrator")
                        Roles.AddUserToRole(txt_user.Text, "Admins");
                    else if (roleType.SelectedValue == "Student")
                    {
                        Roles.AddUserToRole(txt_user.Text, "Students");
                        updateStatment = $"update dbo.aspnet_Users set St_Id = {roleTarget.SelectedValue}, RoleType = '{roleType.SelectedValue}' where UserName = '{txt_user.Text}'";
                    }
                    else if (roleType.SelectedValue == "Instructor")
                    {
                        Roles.AddUserToRole(txt_user.Text, "Instructors");
                        updateStatment = $"update dbo.aspnet_Users set Ins_Id = {roleTarget.SelectedValue}, RoleType = '{roleType.SelectedValue}' where UserName = '{txt_user.Text}'";
                    }
                    if (updateStatment == null)
                        updateStatment = $"update dbo.aspnet_Users set RoleType = '{roleType.SelectedValue}' where UserName = '{txt_user.Text}'";
                    string cnnStr = ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString;
                    SqlConnection sqlConnection = new SqlConnection(cnnStr);
                    SqlCommand sqlCommand = new SqlCommand()
                    {
                        Connection = sqlConnection,
                        CommandText = updateStatment
                    };
                    sqlConnection.Open();
                    sqlCommand.ExecuteNonQuery();
                    sqlConnection.Close();
                    GridView1.DataBind();
                    btnClear_Click(sender, e);
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txt_passw.Text = txt_user.Text = "";
            roleTarget.ClearSelection();
            roleType_SelectedIndexChanged(sender, e);
        }
    }
}