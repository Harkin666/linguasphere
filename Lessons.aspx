<%@ Page Title="All Lessons" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="Web.Lessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .lesson-page-wrapper {
            background-color: #ffffff;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 50px 40px;
        }
        .page-title { font-size: 2.8em; font-weight: bold; color: #111827; margin-bottom: 30px; }
        .lessons-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 30px; }
        .lesson-card { background-color: #ffffff; border: 1px solid #e5e7eb; border-radius: 12px; display: flex; flex-direction: column; justify-content: space-between; padding: 25px; }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .category { font-size: 1em; color: #6b7280; }
        .tag { padding: 6px 14px; border-radius: 20px; font-size: 0.9em; font-weight: bold; }
        .tag-beginner { background-color: #d1fae5; color: #10b981; }
        .tag-advanced { background-color: #fee2e2; color: #ef4444; }
        .lesson-title { font-size: 1.6em; font-weight: bold; color: #111827; margin-bottom: 25px; }
   
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

    <div class="lesson-page-wrapper">
        <main>
            <h1 class="page-title">All Lessons</h1>
            <div class="lessons-grid">
                <asp:Repeater ID="rptLessons" runat="server">
                    <ItemTemplate>
                        <div class="lesson-card">
                            <div>
                                <div class="card-header">
                                    <span class='tag <%# GetTagClass(Eval("Difficulty").ToString()) %>'><%# Eval("Difficulty") %></span>
                                    <span class="category"><%# Eval("Category") %></span>
                                </div>
                                <h2 class="lesson-title"><%# Eval("Title") %></h2>
                            </div>
                         
                            <a href='<%# "ViewLesson.aspx?id=" + Eval("Id") %>' class="btn-view">View Lesson</a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </main>
    </div>
</asp:Content>