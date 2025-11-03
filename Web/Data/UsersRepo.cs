using System;
using System.Data;
using System.Data.SqlClient;

namespace Web.Data
{
    public static class UsersRepo
    {
        public static int Create(string fullName, string email, string passwordHash, string role)
        {
            fullName = (fullName ?? string.Empty).Trim();
            email = (email ?? string.Empty).Trim();
            passwordHash = (passwordHash ?? string.Empty).Trim().ToUpperInvariant();
            role = string.IsNullOrWhiteSpace(role) ? "Student" : role.Trim();

            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"
INSERT INTO dbo.Users(FullName, Email, PasswordHash, Role)
VALUES(@n, @e, @p, @r);
SELECT CAST(SCOPE_IDENTITY() AS INT);";
                cmd.Parameters.AddWithValue("@n", (object)fullName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@e", (object)email ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@p", (object)passwordHash ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@r", (object)role ?? DBNull.Value);
                return (int)cmd.ExecuteScalar();
            }
        }

        public static (int userId, string role)? Authenticate(string email, string passwordHash)
        {
            email = (email ?? string.Empty).Trim();
            passwordHash = (passwordHash ?? string.Empty).Trim();

            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"
SELECT TOP 1 UserId, Role
FROM dbo.Users
WHERE LOWER(LTRIM(RTRIM(Email))) = LOWER(LTRIM(RTRIM(@e)))
  AND UPPER(LTRIM(RTRIM(PasswordHash))) = UPPER(LTRIM(RTRIM(@p)));";
                cmd.Parameters.AddWithValue("@e", (object)email ?? string.Empty);
                cmd.Parameters.AddWithValue("@p", (object)passwordHash ?? string.Empty);

                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                        return (rd.GetInt32(0), rd.GetString(1));
                }
            }
            return null;
        }

        public static bool ExistsByEmail(string email)
        {
            email = (email ?? string.Empty).Trim();
            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"
SELECT COUNT(1)
FROM dbo.Users
WHERE LOWER(LTRIM(RTRIM(Email))) = LOWER(LTRIM(RTRIM(@e)));";
                cmd.Parameters.AddWithValue("@e", (object)email ?? string.Empty);
                return (int)cmd.ExecuteScalar() > 0;
            }
        }
    }
}
