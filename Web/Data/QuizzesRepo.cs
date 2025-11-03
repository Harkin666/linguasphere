using System;
using System.Data;
using System.Data.SqlClient;

namespace Web.Data
{
    public static class QuizzesRepo
    {
        public static int Insert(int lessonId, string title, int difficulty)
        {
            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"INSERT INTO dbo.Quizzes(LessonId, Title, Difficulty)
                                    VALUES(@l,@t,@d);
                                    SELECT CAST(SCOPE_IDENTITY() AS INT)";
                cmd.Parameters.AddWithValue("@l", lessonId);
                cmd.Parameters.AddWithValue("@t", title);
                cmd.Parameters.AddWithValue("@d", difficulty);
                return (int)cmd.ExecuteScalar();
            }
        }

        public static DataTable ListWithQuestionCount()
        {
            using (var con = new SqlConnection(Db.ConnString))
            using (var cmd = con.CreateCommand())
            using (var da = new SqlDataAdapter(cmd))
            {
                con.Open();
                cmd.CommandText = @"
SELECT q.QuizId AS Id, q.Title,
       COUNT(qq.QuestionId) AS QuestionCount,
       CASE q.Difficulty WHEN 1 THEN 'Beginner' WHEN 2 THEN 'Intermediate' ELSE 'Advanced' END AS Difficulty
FROM dbo.Quizzes q
LEFT JOIN dbo.Questions qq ON q.QuizId = qq.QuizId
GROUP BY q.QuizId, q.Title, q.Difficulty
ORDER BY q.QuizId DESC";
                var dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}