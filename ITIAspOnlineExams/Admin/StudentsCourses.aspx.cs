using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class StudentsCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsPostBack)
                {
                    string cnnStr = ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString;
                    SqlConnection sqlConnection = new SqlConnection(cnnStr);
                    SqlCommand sqlCommand = new SqlCommand()
                    {
                        Connection = sqlConnection,
                        CommandText = "SELECT ST_ID, (CONVERT(VARCHAR(10), ST_ID) + ' - ' + ST_FNAME + ' ' + ST_LNAME) AS ST_NAME FROM STUDENT"
                    };
                    sqlConnection.Open();
                    var reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                        filterByStudent.Items.Add(new ListItem(reader["ST_NAME"].ToString(), reader["ST_ID"].ToString()));
                    reader.Close();
                    sqlCommand.CommandText = "SELECT Crs_Id, (CONVERT(VARCHAR(10), Crs_Id) + ' - ' + Crs_Name) AS Crs_Name FROM Course";
                    reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                        filterByCourse.Items.Add(new ListItem(reader["Crs_Name"].ToString(), reader["Crs_Id"].ToString()));
                    reader.Close();
                    sqlConnection.Close();
                }
            }
        }
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string studId = filterByStudent.SelectedValue;
            string crsId = filterByCourse.SelectedValue;

            string select = "select s.St_Id, (s.St_Fname + ' ' + s.St_Lname) as St_Name, sc.Crs_Id, c.Crs_Name, sc.Grade from Stud_Course sc inner join Student s on sc.St_Id = s.St_Id inner join Course c on c.Crs_Id = sc.Crs_Id";
            if (!string.IsNullOrEmpty(studId) && !string.IsNullOrEmpty(crsId))
                select += $" where s.St_Id = {studId} And c.Crs_Id = {crsId}";
            else if (!string.IsNullOrEmpty(studId))
                select += $" where s.St_Id = {studId}";
            else if (!string.IsNullOrEmpty(crsId))
                select += $" where c.Crs_Id = {crsId}";
            StudentsCoursesDS.SelectCommand = select;
            GridView1.DataBind();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            filterByStudent.ClearSelection();
            filterByCourse.ClearSelection();
            btnFilter_Click(sender, e);
        }
        protected void filter_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnFilter_Click(sender, e);
        }

        protected void btnCreateNew_Click(object sender, EventArgs e)
        {
            string studId = filterByStudent.SelectedValue;
            string crsId = filterByCourse.SelectedValue;
            if (!string.IsNullOrEmpty(studId) && !string.IsNullOrEmpty(crsId))
            {
                SqlConnection cnn = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString);
                SqlCommand command = new SqlCommand()
                {
                    Connection = cnn,
                    CommandText = $"SELECT COUNT(ST_ID) FROM STUD_COURSE WHERE ST_ID = {studId} AND CRS_ID = {crsId};"
                };
                cnn.Open();
                int count = int.Parse(command.ExecuteScalar().ToString());
                if (count == 0)
                    command.CommandText = $"INSERT INTO STUD_COURSE(CRS_ID, ST_ID) VALUES({crsId},{studId});";
                else
                    Master.ShowAlert("Error", "Cannot insert a row with the provided data");
                command.ExecuteNonQuery();
                Master.ShowAlert("Success", "Row inserted successfully");
                cnn.Close();
                btnFilter_Click(sender, e);
                GridView1.DataBind();
            }
        }
    }
}