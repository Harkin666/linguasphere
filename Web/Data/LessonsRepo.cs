using System;
using System.Data;
using System.Data.SqlClient;

namespace Web.Data
{
    public static class LessonsRepo
    {
        public static int Insert(string title, string category, int difficulty, string content, string videoUrl)
        {
            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"INSERT INTO dbo.Lessons(Title, Category, Difficulty, Content, VideoUrl)
                                    VALUES(@t,@c,@d,@ct,@v);
                                    SELECT CAST(SCOPE_IDENTITY() AS INT)";
                cmd.Parameters.AddWithValue("@t", title);
                cmd.Parameters.AddWithValue("@c", (object)category ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@d", difficulty);
                cmd.Parameters.AddWithValue("@ct", (object)content ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@v", (object)videoUrl ?? DBNull.Value);
                return (int)cmd.ExecuteScalar();
            }
        }

        public static DataTable List()
        {
            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            using (var da = new SqlDataAdapter(cmd))
            {
                con.Open();
                cmd.CommandText = @"SELECT LessonId AS Id, Title, Category,
                                           CASE Difficulty WHEN 1 THEN 'Beginner' WHEN 2 THEN 'Intermediate' ELSE 'Advanced' END AS Difficulty
                                    FROM dbo.Lessons ORDER BY LessonId DESC";
                var dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}