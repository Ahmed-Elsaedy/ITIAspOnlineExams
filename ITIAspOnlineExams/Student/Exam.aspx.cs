using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;
using System.Linq;
using System.Data.SqlClient;
using System.Configuration;

namespace ITIAspOnlineExams.Student
{
    public partial class Exam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["examId"] != null)
                {
                    ExamQuestionsDS.SelectCommand = $"select eq.Exam_Id, q.*, eq.Qstn_stAnswer from Exam_Question eq inner join Question q on eq.Qstn_Id = q.Qstn_Id where Exam_Id = {Session["examId"]}";
                    questionsGridView.DataBind();
                    Session["count"] = questionsGridView.PageCount;
                }
                else
                    Response.Redirect("Default.aspx");
            }
        }
        protected void questionsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string questionID = questionsGridView.DataKeys[e.Row.RowIndex].Value.ToString();
                var answers = (List<StudentAnswer>)Session["studentAnswers"];
                var answer = answers.SingleOrDefault(x => x.Qstn_Id == questionID);
                if (answer == null)
                {
                    answer = new StudentAnswer()
                    {
                        Exam_Id = Session["examId"].ToString(),
                        Qstn_Id = questionID
                    };
                    answers.Add(answer);
                }
                GridView choicesGrid = (GridView)e.Row.FindControl("choicesGridView");
                SqlDataSource source = (SqlDataSource)e.Row.FindControl("ChoicesDS");
                source.SelectCommand = $"select * from Choice where Qstn_Id = {questionID};";
                choicesGrid.DataBind();
                if (choicesGrid.Rows.Count == 0)
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("Chc_Id");
                    dataTable.Columns.Add("Chc_Text");
                    dataTable.Columns.Add("Qstn_Id");
                    DataRow row = dataTable.NewRow();
                    row[0] = 0;
                    row[1] = "TRUE";
                    row[2] = questionID;
                    dataTable.Rows.Add(row);
                    row = dataTable.NewRow();
                    row[0] = 1;
                    row[1] = "FALSE";
                    row[2] = questionID;
                    dataTable.Rows.Add(row);
                    choicesGrid.DataSourceID = null;
                    choicesGrid.DataSource = dataTable;
                    choicesGrid.DataBind();
                }
                if (!string.IsNullOrEmpty(answer.Qstn_stAnswerIndex))
                    choicesGrid.SelectRow(int.Parse(answer.Qstn_stAnswerIndex));

                var lblAnswer = (Label)e.Row.FindControl("lblAnswer");
                if ((bool)Session["complete"])
                {
                    lblAnswer.Visible = true;
                    lblAnswer.Text = "Answer " + questionsGridView.DataKeys[e.Row.RowIndex].Values[1].ToString();
                }
                else
                    lblAnswer.Visible = false;
            }
        }
        protected void questionsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            questionsGridView.PageIndex = e.NewPageIndex;
            ExamQuestionsDS.SelectCommand = $"select eq.Exam_Id, q.*, eq.Qstn_stAnswer from Exam_Question eq inner join Question q on eq.Qstn_Id = q.Qstn_Id where Exam_Id = {Session["examId"]}";
            questionsGridView.DataBind();
        }
        protected void choicesGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView choicesGrid = (GridView)sender;
            var answers = (List<StudentAnswer>)Session["studentAnswers"];
            var answer = answers[questionsGridView.PageIndex];
            answer.Qstn_stAnswerIndex = choicesGrid.SelectedIndex.ToString();
            answer.Qstn_stAnswer = choicesGrid.SelectedDataKey.Value.ToString();
            Session["studentAnswers"] = answers;
            UpdateFinish(answers);
        }
        private void UpdateFinish(List<StudentAnswer> answers)
        {
            if (answers.Count != (int)Session["count"] || answers.Any(x => string.IsNullOrEmpty(x.Qstn_stAnswerIndex)))
                btnFinish.CssClass = "btn btn-primary disabled";
            else
                btnFinish.CssClass = "btn btn-primary";
        }
        protected void btnFinish_Click(object sender, EventArgs e)
        {
            var answers = (List<StudentAnswer>)Session["studentAnswers"];
            string cnnStr = ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(cnnStr);
            sqlConnection.Open();

            Session["complete"] = true;
            questionsGridView.SetPageIndex(0);

            foreach (var item in answers)
            {
                // True
                if (item.Qstn_stAnswer == "0")
                {
                    SqlCommand sqlCommand1 = new SqlCommand()
                    {
                        Connection = sqlConnection,
                        CommandText = $"update Exam_Question set Qstn_stAnswer = 'TRUE' where Qstn_Id = {int.Parse(item.Qstn_Id)} And Exam_Id = {int.Parse(Session["examId"].ToString())}"
                    };
                    sqlCommand1.ExecuteNonQuery();
                }
                else if (item.Qstn_stAnswer == "1") // False
                {
                    SqlCommand sqlCommand2 = new SqlCommand()
                    {
                        Connection = sqlConnection,
                        CommandText = $"update Exam_Question set Qstn_stAnswer = 'FALSe' where Qstn_Id = {int.Parse(item.Qstn_Id)} And Exam_Id = {int.Parse(Session["examId"].ToString())}"
                    };
                    sqlCommand2.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand sqlCommand3 = new SqlCommand()
                    {
                        Connection = sqlConnection,
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "proc_AnswerExamQuestion"
                    };
                    sqlCommand3.Parameters.Add(new SqlParameter("@examId", int.Parse(item.Exam_Id)));
                    sqlCommand3.Parameters.Add(new SqlParameter("@qstnId", int.Parse(item.Qstn_Id)));
                    sqlCommand3.Parameters.Add(new SqlParameter("@stAnswer", item.Qstn_stAnswer.ToString()));
                    sqlCommand3.ExecuteNonQuery();
                }
            }
            SqlCommand sqlCommand = new SqlCommand()
            {
                Connection = sqlConnection,
                CommandType = CommandType.StoredProcedure,
                CommandText = "proc_CorrectExam"
            };
            sqlCommand.Parameters.Add(new SqlParameter("@examId", int.Parse(Session["examId"].ToString())));
            sqlCommand.Parameters.Add(new SqlParameter("@grd", SqlDbType.Int) {  Direction= ParameterDirection.Output});
            sqlCommand.ExecuteNonQuery();

            var grade = Convert.ToInt32(sqlCommand.Parameters["@grd"].Value);

            lblResult.Visible = true;
            lblResult.Text = $"You Result: {grade} / 10";
            sqlConnection.Close();
        }
        protected void choicesGridView_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            if ((bool)Session["complete"])
                e.Cancel = true;
        }
    }
}