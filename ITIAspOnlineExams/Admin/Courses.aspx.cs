using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                CourseDS.InsertParameters["Crs_Id"].DefaultValue = txt_courseId.Text;
                CourseDS.InsertParameters["Crs_Name"].DefaultValue = txt_courseName.Text;
                CourseDS.InsertParameters["Crs_Duration"].DefaultValue = txt_courseDuration.Text;
                CourseDS.Insert();
                txt_courseDuration.Text = txt_courseName.Text = txt_courseId.Text = "";
                GridView1.DataBind();
                Master.ShowAlert("Success", "Row inserted successfully");
            }
            catch (Exception)
            { Master.ShowAlert("Error", "Cannot insert a row with the provided data"); }
        }
    }
}