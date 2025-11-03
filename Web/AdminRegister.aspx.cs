using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using Web.Data;

namespace Web
{
    public partial class AdminRegister : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            var name = txtFullName.Text.Trim();
            var email = txtEmail.Text.Trim();
            var pwd = txtPassword.Text;
            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(pwd))
            {
                Response.Write("<script>alert('Please fill all fields');</script>");
                return;
            }

            var hash = Sha256Hex(pwd);
            try
            {
                UsersRepo.Create(name, email, hash, "Admin");
                Response.Redirect("~/AdminLogin.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Register failed: " + ex.Message.Replace("'","") + "');</script>");
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