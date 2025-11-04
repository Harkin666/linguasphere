using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Web.Data
{
    public static class DatabaseInitializer
    {
        private const string MasterConn = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;Connect Timeout=30";

        public static void EnsureCreated()
        {
            // 1) Create DB if missing
            using (var con = new SqlConnection(MasterConn))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"
IF DB_ID(N'LinguaSphere') IS NULL
BEGIN
    CREATE DATABASE [LinguaSphere];
END";
                cmd.ExecuteNonQuery();
            }

            // 2) Create tables and seed admin
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            using (var cmd = con.CreateCommand())
            {
                con.Open();
                cmd.CommandText = @"
IF OBJECT_ID(N'dbo.Users', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Users(
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        FullName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(256) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(64) NOT NULL,
        Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Student','Admin')),
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME()
    );
END;

IF OBJECT_ID(N'dbo.Lessons', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Lessons(
        LessonId INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Category NVARCHAR(100) NULL,
        Difficulty TINYINT NOT NULL DEFAULT 1,
        Content NVARCHAR(MAX) NULL,
        VideoUrl NVARCHAR(500) NULL,
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME()
    );
END;

IF OBJECT_ID(N'dbo.Quizzes', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Quizzes(
        QuizId INT IDENTITY(1,1) PRIMARY KEY,
        LessonId INT NOT NULL
            CONSTRAINT FK_Quizzes_Lessons REFERENCES dbo.Lessons(LessonId) ON DELETE CASCADE,
        Title NVARCHAR(200) NOT NULL,
        Difficulty TINYINT NOT NULL DEFAULT 1,
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME()
    );
    CREATE INDEX IX_Quizzes_LessonId ON dbo.Quizzes(LessonId);
END;

IF OBJECT_ID(N'dbo.Questions', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Questions(
        QuestionId INT IDENTITY(1,1) PRIMARY KEY,
        QuizId INT NOT NULL
            CONSTRAINT FK_Questions_Quizzes REFERENCES dbo.Quizzes(QuizId) ON DELETE CASCADE,
        [Text] NVARCHAR(MAX) NOT NULL,
        Points INT NOT NULL DEFAULT 1,
        OrderIndex INT NOT NULL DEFAULT 0
    );
    CREATE INDEX IX_Questions_QuizId ON dbo.Questions(QuizId);
END;

IF OBJECT_ID(N'dbo.Options', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Options(
        OptionId INT IDENTITY(1,1) PRIMARY KEY,
        QuestionId INT NOT NULL
            CONSTRAINT FK_Options_Questions REFERENCES dbo.Questions(QuestionId) ON DELETE CASCADE,
        [Text] NVARCHAR(500) NOT NULL,
        IsCorrect BIT NOT NULL,
        OrderIndex INT NOT NULL DEFAULT 0
    );
    CREATE INDEX IX_Options_QuestionId ON dbo.Options(QuestionId);
END;

IF OBJECT_ID(N'dbo.Attempts', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Attempts(
        AttemptId INT IDENTITY(1,1) PRIMARY KEY,
        QuizId INT NOT NULL
            CONSTRAINT FK_Attempts_Quizzes REFERENCES dbo.Quizzes(QuizId) ON DELETE CASCADE,
        UserId INT NOT NULL
            CONSTRAINT FK_Attempts_Users REFERENCES dbo.Users(UserId) ON DELETE CASCADE,
        Score INT NOT NULL,
        Total INT NOT NULL,
        StartedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        SubmittedAt DATETIME2 NULL
    );
    CREATE INDEX IX_Attempts_UserId ON dbo.Attempts(UserId);
END;

IF NOT EXISTS(SELECT 1 FROM dbo.Users WHERE Email='admin@linguasphere.local')
BEGIN
    INSERT INTO dbo.Users(FullName, Email, PasswordHash, Role)
    VALUES (N'Administrator','admin@linguasphere.local',
            CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'Admin@123'), 2),
            'Admin');
END;";
                cmd.ExecuteNonQuery();
            }
        }
    }
}