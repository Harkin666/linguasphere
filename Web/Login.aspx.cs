using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using Web.Data;

namespace Web
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var email = txtEmail.Text.Trim();
            var pwd = txtPassword.Text;
            var hash = Sha256Hex(pwd);

            var result = UsersRepo.Authenticate(email, hash);
            if (result != null)
            {
                Session["UserId"] = result.Value.userId;
                Session["Role"] = result.Value.role;
                Response.Redirect("~/Dashboard.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid credentials');</script>");
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