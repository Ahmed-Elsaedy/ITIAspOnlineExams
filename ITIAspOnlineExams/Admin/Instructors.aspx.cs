using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Admin
{
    public partial class Instructors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }


        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                InstructorsDS.InsertParameters["Ins_Id"].DefaultValue = instId.Text;
                InstructorsDS.InsertParameters["Ins_Name"].DefaultValue = insName.Text;
                InstructorsDS.InsertParameters["Ins_Degree"].DefaultValue = insDegree.Text;
                InstructorsDS.InsertParameters["Salary"].DefaultValue = insSalary.Text;
                InstructorsDS.InsertParameters["Dept_Id"].DefaultValue = insDepartment.SelectedValue;
                InstructorsDS.Insert();
                instId.Text = insName.Text = insDegree.Text = insSalary.Text = "";
                GridView1.DataBind();
                Master.ShowAlert("Success", "Row inserted successfully");
            }
            catch (Exception)
            { Master.ShowAlert("Error", "Cannot insert a row with the provided data"); }
        }
    }
}