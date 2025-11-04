using System.Web;

namespace Web.Utilities
{
    public static class AuthContext
    {
        public static bool IsAuthenticated =>
            HttpContext.Current?.User?.Identity?.IsAuthenticated ?? false;

        public static int? CurrentUserId
        {
            get
            {
                var userId = HttpContext.Current?.Session?["UserId"];
                return userId as int?;
            }
            set
            {
                if (HttpContext.Current?.Session != null)
                    HttpContext.Current.Session["UserId"] = value;
            }
        }

        public static string CurrentRole
        {
            get => HttpContext.Current?.Session?["Role"] as string;
            set
            {
                if (HttpContext.Current?.Session != null)
                    HttpContext.Current.Session["Role"] = value;
            }
        }
    }
}
