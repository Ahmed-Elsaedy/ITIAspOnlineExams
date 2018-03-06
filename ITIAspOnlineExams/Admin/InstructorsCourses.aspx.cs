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
    public partial class InstructorsCourses : System.Web.UI.Page
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
                        CommandText = "SELECT Ins_Id , (CONVERT(varchar(10), Ins_Id) + ' - ' + Ins_Name ) as Ins_Name from Instructor"
                    };
                    sqlConnection.Open();
                    var reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                        filterByInstructor.Items.Add(new ListItem(reader["Ins_Name"].ToString(), reader["Ins_Id"].ToString()));
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
            string insId = filterByInstructor.SelectedValue;
            string crsId = filterByCourse.SelectedValue;

            string select = "select i.Ins_Id, i.Ins_Name, ic.Crs_Id, c.Crs_Name, ic.Evaluation from Ins_Course ic inner join Instructor i on i.Ins_Id = ic.Ins_Id inner join Course c on c.Crs_Id = ic.Crs_Id";
            if (!string.IsNullOrEmpty(insId) && !string.IsNullOrEmpty(crsId))
                select += $" where i.Ins_Id = {insId} And c.Crs_Id = {crsId}";
            else if (!string.IsNullOrEmpty(insId))
                select += $" where i.Ins_Id = {insId}";
            else if (!string.IsNullOrEmpty(crsId))
                select += $" where c.Crs_Id = {crsId}";
            InstructorsCoursesDS.SelectCommand = select;
            GridView1.DataBind();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            filterByInstructor.ClearSelection();
            filterByCourse.ClearSelection();
            btnFilter_Click(sender, e);
        }
        protected void filter_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnFilter_Click(sender, e);
        }

        protected void btnCreateNew_Click(object sender, EventArgs e)
        {
            string insId = filterByInstructor.SelectedValue;
            string crsId = filterByCourse.SelectedValue;
            if (!string.IsNullOrEmpty(insId) && !string.IsNullOrEmpty(crsId))
            {
                SqlConnection cnn = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["OnlineExamsProject"].ConnectionString);
                SqlCommand command = new SqlCommand()
                {
                    Connection = cnn,
                    CommandText = $"SELECT COUNT(Ins_Id) FROM Ins_COURSE WHERE Ins_Id = {insId} AND CRS_ID = {crsId};"
                };
                cnn.Open();
                int count = int.Parse(command.ExecuteScalar().ToString());
                if (count == 0)
                    command.CommandText = $"INSERT INTO Ins_COURSE(Ins_Id, Crs_Id) VALUES({insId},{crsId});";
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