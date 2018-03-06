using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITIAspOnlineExams.Masters
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (AlertVisible)
                AlertVisible = false;
        }
        public void ShowAlert(string title, string msg)
        {
            alertTitle.Text = title;
            alertMsg.Text = msg;
            alertDiv.Visible = true;
        }
        public bool AlertVisible
        {
            get { return alertDiv.Visible; }
            set { alertDiv.Visible = value; }
        }
    }
}