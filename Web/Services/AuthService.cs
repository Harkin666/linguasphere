using System;
using System.Web;
using System.Web.Security;
using Web.Data;
using Web.Models;

namespace Web.Services
{
    /// <summary>
    /// Central entry point for authentication and user session operations.
    /// </summary>
    public static class AuthService
    {
        public static bool SignIn(string emailOrUserName, string password, bool rememberMe, out string failureReason)
        {
            failureReason = null;
            emailOrUserName = (emailOrUserName ?? string.Empty).Trim();
            var passwordHash = PasswordHasher.Compute(password);

            var match = UsersRepo.Authenticate(emailOrUserName, passwordHash);
            if (match == null)
            {
                failureReason = "Invalid credentials.";
                return false;
            }

            var ticket = new FormsAuthenticationTicket(
                1,
                emailOrUserName,
                DateTime.UtcNow,
                DateTime.UtcNow.AddMinutes(FormsAuthentication.Timeout.TotalMinutes),
                rememberMe,
                match.Value.role);

            var encrypted = FormsAuthentication.Encrypt(ticket);
            var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encrypted)
            {
                HttpOnly = true,
                Secure = FormsAuthentication.RequireSSL,
                Expires = rememberMe ? ticket.Expiration : DateTime.MinValue
            };
            HttpContext.Current.Response.Cookies.Add(cookie);
            HttpContext.Current.Session["UserId"] = match.Value.userId;
            HttpContext.Current.Session["Role"] = match.Value.role;
            return true;
        }

        public static void SignOut()
        {
            FormsAuthentication.SignOut();
            HttpContext.Current?.Session?.Clear();
        }

        public static int? GetCurrentUserId()
        {
            return HttpContext.Current?.Session?["UserId"] as int?;
        }
    }
}
