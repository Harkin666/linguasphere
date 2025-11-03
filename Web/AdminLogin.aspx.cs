using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using Web.Data;

namespace Web
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var email = txtEmail.Text.Trim();
            var pwd = txtPassword.Text;
            var hash = Sha256Hex(pwd);

            var result = UsersRepo.Authenticate(email, hash);
            if (result != null && string.Equals(result.Value.role, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Session["UserId"] = result.Value.userId;
                Session["Role"] = "Admin";
                Response.Redirect("~/AdminDashboard.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid admin credentials');</script>");
            }
        }

        private static string Sha256Hex(string s)
        {
            using (var sha = SHA256.Create())
            {
                var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(s));
                return BitConverter.ToString(bytes).Replace("-", "").ToLowerInvariant();
            }
        }
    }
}