USE [LinguaSphere];
GO

-- Lesson 1: Everyday Greetings
DECLARE @lessonId INT = NULL;
SELECT @lessonId = LessonId FROM dbo.Lessons WHERE Title = N'Everyday Greetings';
IF @lessonId IS NULL
BEGIN
    INSERT INTO dbo.Lessons(Title, Category, Difficulty, Content, VideoUrl)
    VALUES (
        N'Everyday Greetings',
        N'Conversation',
        1,
        N'Learn how to greet people politely in everyday situations, including informal and formal settings.',
        N'https://example.com/videos/greetings'
    );
    SET @lessonId = SCOPE_IDENTITY();
END;

DECLARE @quizId INT = NULL;
SELECT @quizId = QuizId FROM dbo.Quizzes WHERE Title = N'Greetings Basics' AND LessonId = @lessonId;
IF @quizId IS NULL
BEGIN
    INSERT INTO dbo.Quizzes(LessonId, Title, Difficulty)
    VALUES (@lessonId, N'Greetings Basics', 1);
    SET @quizId = SCOPE_IDENTITY();
END;

DECLARE @questionId INT = NULL;
SELECT @questionId = QuestionId FROM dbo.Questions WHERE QuizId = @quizId AND [Text] = N'Which greeting is most appropriate in a formal business email?';
IF @questionId IS NULL
BEGIN
    INSERT INTO dbo.Questions(QuizId, [Text], Points, OrderIndex)
    VALUES (@quizId, N'Which greeting is most appropriate in a formal business email?', 1, 1);
    SET @questionId = SCOPE_IDENTITY();
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Hey there!')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Hey there!', 0, 1);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Dear Mr. Johnson,')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Dear Mr. Johnson,', 1, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Yo!')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Yo!', 0, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Hi buddy,')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Hi buddy,', 0, 4);

SET @questionId = NULL;
SELECT @questionId = QuestionId FROM dbo.Questions WHERE QuizId = @quizId AND [Text] = N'Choose the best response to: "How are you?"';
IF @questionId IS NULL
BEGIN
    INSERT INTO dbo.Questions(QuizId, [Text], Points, OrderIndex)
    VALUES (@quizId, N'Choose the best response to: "How are you?"', 1, 2);
    SET @questionId = SCOPE_IDENTITY();
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'I am fine, thank you. How about you?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'I am fine, thank you. How about you?', 1, 1);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'None of your business.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'None of your business.', 0, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Bye.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Bye.', 0, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Later.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Later.', 0, 4);

GO

-- Lesson 2: Ordering Food
SET @lessonId = NULL;
SELECT @lessonId = LessonId FROM dbo.Lessons WHERE Title = N'Ordering Food at a Restaurant';
IF @lessonId IS NULL
BEGIN
    INSERT INTO dbo.Lessons(Title, Category, Difficulty, Content, VideoUrl)
    VALUES (
        N'Ordering Food at a Restaurant',
        N'Practical English',
        2,
        N'Practice phrases for ordering food, asking for recommendations, and handling special requests.',
        N'https://example.com/videos/ordering-food'
    );
    SET @lessonId = SCOPE_IDENTITY();
END;

SET @quizId = NULL;
SELECT @quizId = QuizId FROM dbo.Quizzes WHERE Title = N'Restaurant Dialogues' AND LessonId = @lessonId;
IF @quizId IS NULL
BEGIN
    INSERT INTO dbo.Quizzes(LessonId, Title, Difficulty)
    VALUES (@lessonId, N'Restaurant Dialogues', 2);
    SET @quizId = SCOPE_IDENTITY();
END;

SET @questionId = NULL;
SELECT @questionId = QuestionId FROM dbo.Questions WHERE QuizId = @quizId AND [Text] = N'What is a polite way to ask for the bill in a restaurant?';
IF @questionId IS NULL
BEGIN
    INSERT INTO dbo.Questions(QuizId, [Text], Points, OrderIndex)
    VALUES (@quizId, N'What is a polite way to ask for the bill in a restaurant?', 1, 1);
    SET @questionId = SCOPE_IDENTITY();
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Check, please.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Check, please.', 1, 1);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Give me the bill now.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Give me the bill now.', 0, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'You charge me?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'You charge me?', 0, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Bill, table now.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Bill, table now.', 0, 4);

SET @questionId = NULL;
SELECT @questionId = QuestionId FROM dbo.Questions WHERE QuizId = @quizId AND [Text] = N'Choose the best phrase to request a vegetarian option.';
IF @questionId IS NULL
BEGIN
    INSERT INTO dbo.Questions(QuizId, [Text], Points, OrderIndex)
    VALUES (@quizId, N'Choose the best phrase to request a vegetarian option.', 1, 2);
    SET @questionId = SCOPE_IDENTITY();
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Do you have any vegetarian dishes?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Do you have any vegetarian dishes?', 1, 1);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'I hate meat.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'I hate meat.', 0, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Bring something green.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Bring something green.', 0, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'It better be vegetables.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'It better be vegetables.', 0, 4);

GO

-- Lesson 3: Travel English Essentials
SET @lessonId = NULL;
SELECT @lessonId = LessonId FROM dbo.Lessons WHERE Title = N'Travel English Essentials';
IF @lessonId IS NULL
BEGIN
    INSERT INTO dbo.Lessons(Title, Category, Difficulty, Content, VideoUrl)
    VALUES (
        N'Travel English Essentials',
        N'Travel',
        2,
        N'Key expressions for checking in at airports, booking hotels, and asking for directions.',
        N'https://example.com/videos/travel-english'
    );
    SET @lessonId = SCOPE_IDENTITY();
END;

SET @quizId = NULL;
SELECT @quizId = QuizId FROM dbo.Quizzes WHERE Title = N'Travel Situations' AND LessonId = @lessonId;
IF @quizId IS NULL
BEGIN
    INSERT INTO dbo.Quizzes(LessonId, Title, Difficulty)
    VALUES (@lessonId, N'Travel Situations', 2);
    SET @quizId = SCOPE_IDENTITY();
END;

SET @questionId = NULL;
SELECT @questionId = QuestionId FROM dbo.Questions WHERE QuizId = @quizId AND [Text] = N'What should you say when you want to confirm your flight at the airport check-in desk?';
IF @questionId IS NULL
BEGIN
    INSERT INTO dbo.Questions(QuizId, [Text], Points, OrderIndex)
    VALUES (@quizId, N'What should you say when you want to confirm your flight at the airport check-in desk?', 1, 1);
    SET @questionId = SCOPE_IDENTITY();
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Could you please confirm my flight to London?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Could you please confirm my flight to London?', 1, 1);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Is this the plane?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Is this the plane?', 0, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'We go now?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'We go now?', 0, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Just take my bags.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Just take my bags.', 0, 4);

SET @questionId = NULL;
SELECT @questionId = QuestionId FROM dbo.Questions WHERE QuizId = @quizId AND [Text] = N'Select the most polite way to ask for directions to the train station.';
IF @questionId IS NULL
BEGIN
    INSERT INTO dbo.Questions(QuizId, [Text], Points, OrderIndex)
    VALUES (@quizId, N'Select the most polite way to ask for directions to the train station.', 1, 2);
    SET @questionId = SCOPE_IDENTITY();
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Excuse me, could you tell me how to get to the train station?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Excuse me, could you tell me how to get to the train station?', 1, 1);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Where station?')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Where station?', 0, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'You take me there now.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'You take me there now.', 0, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.Options WHERE QuestionId = @questionId AND [Text] = N'Walk with me to the station.')
    INSERT INTO dbo.Options(QuestionId, [Text], IsCorrect, OrderIndex) VALUES (@questionId, N'Walk with me to the station.', 0, 4);

GO
