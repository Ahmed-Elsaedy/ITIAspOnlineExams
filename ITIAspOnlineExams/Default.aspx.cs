using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ReturnUrl"] != null)
                Response.Redirect("Default.aspx");
        }
        protected void Login1_LoggedIn(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole(Login1.UserName, "Instructors"))
                Response.Redirect("Instructor/Default.aspx");
            else if (Roles.IsUserInRole(Login1.UserName, "Students"))
                Response.Redirect("Student/Default.aspx");
            else if (Roles.IsUserInRole(Login1.UserName, "Admins"))
                Response.Redirect("Admin/Default.aspx");
        }
    }
}