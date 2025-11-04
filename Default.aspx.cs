using System;
using System.Web.UI;

namespace Web
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
   
        }

 
        protected void btnLoginAsUser_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/Dashboard.aspx");
        }

     
        protected void btnLoginAsAdmin_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/AdminDashboard.aspx");
        }
    }
}