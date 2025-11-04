-- Ensure the LinguaSphere database exists
IF DB_ID(N'LinguaSphere') IS NULL
BEGIN
    CREATE DATABASE [LinguaSphere];
END;
GO

USE [LinguaSphere];
GO

-- Users table holds authentication and role information
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
GO

-- Align legacy Users schema if the table already existed
IF COL_LENGTH(N'dbo.Users', N'FullName') IS NULL
BEGIN
    ALTER TABLE dbo.Users ADD FullName NVARCHAR(100) NULL;
    EXEC(N'UPDATE dbo.Users SET FullName = ISNULL(FullName, N'''')');
    ALTER TABLE dbo.Users ALTER COLUMN FullName NVARCHAR(100) NOT NULL;
END;
GO

IF COL_LENGTH(N'dbo.Users', N'Role') IS NULL
BEGIN
    ALTER TABLE dbo.Users ADD Role NVARCHAR(20) NULL;
    EXEC(N'UPDATE dbo.Users SET Role = ''Student'' WHERE Role IS NULL');
    ALTER TABLE dbo.Users ALTER COLUMN Role NVARCHAR(20) NOT NULL;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.check_constraints
    WHERE parent_object_id = OBJECT_ID(N'dbo.Users')
      AND definition LIKE '%Role%IN (''Student'',''Admin'')%'
)
BEGIN
    ALTER TABLE dbo.Users ADD CONSTRAINT CK_Users_Role CHECK (Role IN ('Student','Admin'));
END;
GO

-- Lessons table stores lesson metadata and content
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
GO

-- Quizzes are linked to lessons
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
GO

-- Questions belong to quizzes
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
GO

-- Options store possible answers for each question
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
GO

-- Attempts track quiz submissions
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
GO

-- Seed the default admin account if needed
IF NOT EXISTS(SELECT 1 FROM dbo.Users WHERE Email = 'admin@linguasphere.local')
BEGIN
    INSERT INTO dbo.Users(FullName, Email, PasswordHash, Role)
    VALUES (
        N'Administrator',
        'admin@linguasphere.local',
        CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'Admin@123'), 2),
        'Admin'
    );
END;
ELSE
BEGIN
    UPDATE dbo.Users
    SET FullName = N'Administrator',
        PasswordHash = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'Admin@123'), 2),
        Role = 'Admin'
    WHERE Email = 'admin@linguasphere.local';
END;
GO
