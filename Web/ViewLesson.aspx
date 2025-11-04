<%@ Page Title="Mastering Articles: A, An, The" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLesson.aspx.cs" Inherits="Web.ViewLesson" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .lesson-view-wrapper {
            background-color: #ffffff;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 40px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 30px;
        }

        .lesson-header .lesson-title {
            font-size: 2.8em;
            font-weight: bold;
            color: #111827; 
            margin: 0 0 5px 0;
        }

        .lesson-header .lesson-meta {
            font-size: 1.2em;
            color: #6b7280;
            margin-bottom: 40px;
        }
        
        .lesson-content {
            font-size: 1.1em;
            line-height: 1.7;
        }

        .lesson-content h3 {
            font-size: 1.6em;
            font-weight: bold;
            margin-top: 30px;
            margin-bottom: 10px;
            color: #111827;
        }

        .lesson-content p {
            margin-bottom: 20px;
        }

        .test-knowledge-panel {
            background-color: #f3f4f6;
            border: 1px solid #e5e7eb; 
            border-radius: 12px;
            padding: 25px 30px;
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .test-knowledge-panel .title {
            font-size: 1.4em;
            font-weight: bold;
            color: #111827;
        }
        
        .test-knowledge-panel .subtitle {
            font-size: 1em;
            color: #6b7280;
        }

        .btn-primary {
            background-color: #3b82f6;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #2563eb;
        }
    </style>

    <div class="lesson-view-wrapper">
        <div class="container">
            <a href="Lessons.aspx" class="back-link">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/></svg>
                Back to Lessons
            </a>

            <header class="lesson-header">
                <h1 class="lesson-title">Mastering Articles: A, An, The</h1>
                <p class="lesson-meta">Grammar • Beginner</p>
            </header>

            <article class="lesson-content">
                <h3>Using Articles Correctly</h3>
                <p>Articles are words that define a noun as specific or unspecific.</p>
                <h3>'A' and 'An' (Indefinite Articles)</h3>
                <p>Used for non-specific nouns. 'A' is used before words starting with a consonant sound, and 'An' before words starting with a vowel sound. Example: "I saw a cat." / "She ate an apple."</p>
                <h3>'The' (Definite Article)</h3>
                <p>Used for specific nouns that both the speaker and listener know about. Example: "The sun is bright."</p>
            </article>

            <div class="test-knowledge-panel">
                <div>
                    <div class="title">Test Your Knowledge</div>
                    <div class="subtitle">Take the quiz for "Quiz on Articles"</div>
                </div>
                <a href="TakeQuiz.aspx" class="btn-primary">Start Quiz</a>
            </div>
        </div>
    </div>
</asp:Content>