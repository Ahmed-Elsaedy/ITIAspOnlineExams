using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Student
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (!string.IsNullOrEmpty((string)Session["examId"]))
                {
                    Response.Redirect("Exam.aspx");
                    return;
                }
                string cnnStr = ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString;
                SqlConnection sqlConnection = new SqlConnection(cnnStr);
                SqlCommand sqlCommand = new SqlCommand()
                {
                    Connection = sqlConnection,
                    CommandText = $"select St_Id from aspnet_Users where UserName = '{User.Identity.Name}';"
                };
                sqlConnection.Open();
                var studId = sqlCommand.ExecuteScalar().ToString();
                Session["studentId"] = studId;
                sqlCommand.CommandText = $"select e.*, 'Exam ' +  (CONVERT(varchar(10), e.Exam_Id) + ' - ' + c.Crs_Name) as Exam_Title from Exam e inner join Course c on c.Crs_Id = e.Crs_Id where e.St_Id = {studId}";
                var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                    examsList.Items.Add(new ListItem(reader["Exam_Title"].ToString(), reader["Exam_Id"].ToString()));
                reader.Close();
                sqlConnection.Close();
            }
        }
        protected void btnStart_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(examsList.SelectedValue))
            {
                Session["examId"] = examsList.SelectedValue;
                Session["studentAnswers"] = new List<StudentAnswer>();
                Response.Redirect("Exam.aspx");
                Session["count"] = 0;
                Session["complete"] = false;
            }
        }
    }
}