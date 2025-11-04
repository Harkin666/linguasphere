using System.Configuration;

namespace Web.Data
{
    public static class Db
    {
        public static string ConnString =>
            ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    }
}