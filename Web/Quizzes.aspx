<%@ Page Title="All Quizzes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quizzes.aspx.cs" Inherits="Web.Quizzes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .quiz-page-wrapper { background-color: #ffffff; color: #1f2937; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 50px 40px; }
        .page-title { font-size: 2.8em; font-weight: bold; color: #111827; margin-bottom: 30px; }
        .quizzes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 30px; }
        .quiz-card { background-color: #ffffff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 25px; display: flex; flex-direction: column; justify-content: space-between; }
        .tag { padding: 6px 14px; border-radius: 20px; font-size: 0.9em; font-weight: bold; display: inline-block; margin-bottom: 20px; }
        .tag-beginner { background-color: #d1fae5; color: #10b981; }
        .quiz-title { font-size: 1.6em; font-weight: bold; color: #111827; margin: 0 0 10px 0; }
        .question-count { font-size: 1.1em; color: #6b7280; margin-bottom: 25px; }
        

        .btn-view {
            display: block;
            background-color: #3b82f6;
            color: #ffffff !important;
            padding: 15px;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .btn-view:hover { background-color: #2563eb; }
    </style>

    <div class="quiz-page-wrapper">
        <main>
            <h1 class="page-title">All Quizzes</h1>
            <div class="quizzes-grid">
                <asp:Repeater ID="rptQuizzes" runat="server">
                    <ItemTemplate>
                        <div class="quiz-card">
                            <div>
                                <span class='tag <%# GetTagClass(Eval("Difficulty").ToString()) %>'><%# Eval("Difficulty") %></span>
                                <h2 class="quiz-title"><%# Eval("Title") %></h2>
                                <p class="question-count"><%# Eval("QuestionCount") %> questions</p>
                            </div>
 
                            <a href='<%# "TakeQuiz.aspx?id=" + Eval("Id") %>' class="btn-view">View Quiz</a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </main>
    </div>
</asp:Content>