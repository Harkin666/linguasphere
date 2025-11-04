using System;
using System.Web;
using Web.Services;

namespace Web.Utilities
{
    public static class ThemeManager
    {
        private const string CookieName = "ls-theme";

        public static string ResolveTheme(int? userId, string timeZone)
        {
            var explicitChoice = GetExplicitTheme(userId);
            if (!string.IsNullOrWhiteSpace(explicitChoice) && explicitChoice != "auto")
                return explicitChoice;

            TimeZoneInfo tz;
            try
            {
                tz = string.IsNullOrWhiteSpace(timeZone) ? TimeZoneInfo.Utc : TimeZoneInfo.FindSystemTimeZoneById(timeZone);
            }
            catch (TimeZoneNotFoundException)
            {
                tz = TimeZoneInfo.Utc;
            }
            catch (InvalidTimeZoneException)
            {
                tz = TimeZoneInfo.Utc;
            }

            var now = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, tz);
            var hour = now.Hour;
            return hour >= 19 || hour < 6 ? "dark" : "light";
        }

        public static void PersistTheme(int? userId, string theme)
        {
            if (!string.IsNullOrWhiteSpace(theme))
            {
                theme = theme.ToLowerInvariant();
                if (theme != "dark" && theme != "light" && theme != "auto")
                    theme = "auto";
            }

            if (userId.HasValue)
            {
                var prefs = ProfileService.GetPreferences(userId.Value) ?? new Models.UserPreferenceDto { UserId = userId.Value };
                prefs.Theme = theme;
                ProfileService.UpdatePreferences(userId.Value, prefs);
            }

            var cookie = new HttpCookie(CookieName, theme ?? "auto")
            {
                Expires = DateTime.UtcNow.AddYears(1),
                HttpOnly = false
            };
            HttpContext.Current.Response.Cookies.Add(cookie);
        }

        private static string GetExplicitTheme(int? userId)
        {
            if (userId.HasValue)
            {
                var prefs = ProfileService.GetPreferences(userId.Value);
                if (prefs != null && !string.IsNullOrWhiteSpace(prefs.Theme))
                    return prefs.Theme.ToLowerInvariant();
            }

            var cookie = HttpContext.Current?.Request?.Cookies[CookieName];
            return cookie?.Value?.ToLowerInvariant();
        }
    }
}
