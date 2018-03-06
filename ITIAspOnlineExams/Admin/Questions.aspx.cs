using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class Questions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cnnStr = ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString;
                SqlConnection sqlConnection = new SqlConnection(cnnStr);
                SqlCommand sqlCommand = new SqlCommand()
                {
                    Connection = sqlConnection,
                    CommandText = "SELECT * FROM COURSE"
                };
                sqlConnection.Open();
                var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                    filterByCourse.Items.Add(new ListItem(reader["Crs_Name"].ToString(), reader["Crs_Id"].ToString()));
                reader.Close();
                sqlConnection.Close();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string typeFilter = filterByType.SelectedValue;
            string courseFilter = filterByCourse.SelectedValue;
            string examFilter = filterByExam.Text;

            if (!string.IsNullOrEmpty(typeFilter))
                typeFilter = $"[Qstn_Type] = '{typeFilter}'";
            if (!string.IsNullOrEmpty(courseFilter))
                courseFilter = $"C.[Crs_Id] = {courseFilter}";
            if (!string.IsNullOrEmpty(examFilter))
                examFilter = $"[Exam_Id] = {examFilter}";

            if (!string.IsNullOrEmpty(examFilter))
            {
                string select = $"SELECT * FROM QUESTION Q INNER JOIN EXAM_QUESTION EQ ON Q.QSTN_ID = EQ.QSTN_ID INNER JOIN COURSE C ON Q.CRS_ID = C.CRS_ID WHERE {examFilter} ";
                if (!string.IsNullOrEmpty(typeFilter))
                    select += $" And {typeFilter}";
                if (!string.IsNullOrEmpty(courseFilter))
                    select += $" And {courseFilter}";
                select += ";";
                QuestionsDS.SelectCommand = select;
            }
            else
            {
                string select = "SELECT Q.*, C.Crs_Name FROM QUESTION Q INNER JOIN COURSE C ON Q.CRS_ID = C.CRS_ID";
                if (!string.IsNullOrEmpty(typeFilter))
                    select += $" AND {typeFilter}";
                if (!string.IsNullOrEmpty(courseFilter))
                    select += $" AND {courseFilter}";
                select = select.Replace("C.CRS_ID AND", "C.CRS_ID WHERE ");
                select += ";";
                QuestionsDS.SelectCommand = select;
            }
            GridView1.DataBind();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            filterByExam.Text = "";
            filterByCourse.ClearSelection();
            filterByType.ClearSelection();
            btnFilter_Click(sender, e);
        }
    }
}