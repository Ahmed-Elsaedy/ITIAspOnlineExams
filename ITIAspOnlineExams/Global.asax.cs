using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace ITIAspOnlineExams
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            if (!Roles.RoleExists("Admins"))
                Roles.CreateRole("Admins");

            if (!Roles.RoleExists("Students"))
                Roles.CreateRole("Students");

            if (!Roles.RoleExists("Instructors"))
                Roles.CreateRole("Instructors");

            var admin = Membership.GetUser("admin");
            if (admin == null)
            {
                Membership.CreateUser("admin", "123");
                Roles.AddUserToRole("admin", "Admins");
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session.Add("studentId", null);
            Session.Add("studentAnswers", new List<StudentAnswer>());
            Session.Add("examId", null);
            Session.Add("count", 0);
            Session.Add("complete", false);
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }

    public class StudentAnswer
    {
        public string Exam_Id { get; set; }
        public string Qstn_Id { get; set; }
        public string Qstn_stAnswerIndex { get; set; }
        public string Qstn_stAnswer { get; set; }
        public int PageIndex { get; internal set; }
    }
}