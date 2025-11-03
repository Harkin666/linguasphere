<%@ Page Title="Quiz on English Tenses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeQuiz.aspx.cs" Inherits="Web.TakeQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .quiz-view-wrapper {
            background-color: #ffffff;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 40px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .quiz-top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .back-link {
            display: inline-flex; align-items: center; gap: 8px;
            color: #3b82f6; text-decoration: none; font-weight: 500;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid #d1d5db;
            color: #374151;
            padding: 8px 16px; border-radius: 8px;
            font-size: 0.9em; font-weight: bold; cursor: pointer;
            text-decoration: none; transition: all 0.3s;
        }
        .btn-outline:hover { background-color: #f3f4f6; }
        
        .quiz-header .quiz-title {
            font-size: 2.2em;
            font-weight: bold;
            color: #111827;
            margin: 0;
        }

        .quiz-progress {
            margin-top: 15px;
        }

        .progress-info {
            display: flex;
            justify-content: flex-end;
            font-size: 0.9em;
            color: #6b7280;
            margin-bottom: 8px;
        }
        
        .progress-bar-bg {
            background-color: #e5e7eb;
            height: 8px;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .progress-bar-fill {
            background-color: #3b82f6;
            height: 100%;
            width: 33%;
            border-radius: 4px;
        }

        .question-panel {
            margin-top: 40px;
        }
        
        .question-text {
            font-size: 1.4em;
            font-weight: 500;
            color: #111827;
            margin-bottom: 30px;
        }


        .answer-options-list { list-style: none; padding: 0; }
        .answer-options-list li { margin-bottom: 15px; }

        .answer-options-list label {
            display: block;
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 15px 20px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .answer-options-list input[type="radio"] {
            display: none;
        }
        
        .answer-options-list input[type="radio"]:checked + label {
            border-color: #3b82f6;
            background-color: #eff6ff;
            color: #1d4ed8;
            font-weight: bold;
        }

        .quiz-footer {
            margin-top: 40px;
            text-align: right;
        }
        
        .btn-primary {
            background-color: #3b82f6; color: #ffffff; padding: 12px 30px;
            border: none; border-radius: 8px; font-size: 1em; font-weight: bold;
            cursor: pointer; text-decoration: none; transition: background-color 0.3s;
        }
        .btn-primary:hover { background-color: #2563eb; }
    </style>

    <div class="quiz-view-wrapper">
        <div class="container">
            <div class="quiz-top-bar">
                <a href="Quizzes.aspx" class="back-link">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/></svg>
                    Back to Quizzes
                </a>
                <a href="ViewLesson.aspx" class="btn-outline">View Associated Lesson</a>
            </div>

            <header class="quiz-header">
                <h1 class="quiz-title">Quiz on English Tenses</h1>
                <div class="quiz-progress">
                    <div class="progress-info">
                        <span>Question 1 of 3</span>
                    </div>
                    <div class="progress-bar-bg">
                        <div class="progress-bar-fill"></div>
                    </div>
                </div>
            </header>

            <div class="question-panel">
                <p class="question-text">Which sentence is in the present tense?</p>
                <asp:RadioButtonList ID="rblAnswers" runat="server" CssClass="answer-options-list">
                    <asp:ListItem Value="1">He went to the store.</asp:ListItem>
                    <asp:ListItem Value="2">She is singing a song.</asp:ListItem>
                    <asp:ListItem Value="3">They will come later.</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="quiz-footer">
                <asp:Button ID="btnNextQuestion" runat="server" Text="Next Question" CssClass="btn-primary" />
            </div>
        </div>
    </div>
</asp:Content>