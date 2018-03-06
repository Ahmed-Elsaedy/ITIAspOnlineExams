using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class Departments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Master.AlertVisible)
                Master.AlertVisible = false;
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                DepartmentsDS.InsertParameters["Dept_Id"].DefaultValue = deptId.Text;
                DepartmentsDS.InsertParameters["Dept_Name"].DefaultValue = deptName.Text;
                DepartmentsDS.InsertParameters["Dept_Desc"].DefaultValue = deptDescription.Text;
                DepartmentsDS.InsertParameters["Dept_Location"].DefaultValue = deptLocation.Text;
                DepartmentsDS.Insert();
                deptId.Text = deptName.Text = deptLocation.Text = deptDescription.Text = "";
                GridView1.DataBind();
                Master.ShowAlert("Success", "Row inserted successfully");
            }
            catch (Exception)
            { Master.ShowAlert("Error", "Cannot insert a row with the provided data"); }
        }
    }
}