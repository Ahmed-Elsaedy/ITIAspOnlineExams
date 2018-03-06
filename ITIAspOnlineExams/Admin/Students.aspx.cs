using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class Students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                StudentsDS.InsertParameters["St_Id"].DefaultValue = studId.Text;
                StudentsDS.InsertParameters["St_Fname"].DefaultValue = studFName.Text;
                StudentsDS.InsertParameters["St_Lname"].DefaultValue = studLName.Text;
                StudentsDS.InsertParameters["St_Address"].DefaultValue = studAddress.Text;
                StudentsDS.InsertParameters["St_Age"].DefaultValue = studAge.Text;
                StudentsDS.InsertParameters["Dept_Id"].DefaultValue = studDepartment.SelectedValue;
                StudentsDS.Insert();
                studId.Text = studFName.Text = studLName.Text = studAddress.Text = studAge.Text = "";
                GridView1.DataBind();
                Master.ShowAlert("Success", "Row inserted successfully");
            }
            catch (Exception)
            { Master.ShowAlert("Error", "Cannot insert a row with the provided data"); }
        }
    }
}