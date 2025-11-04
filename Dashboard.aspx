<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Web.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .dashboard-wrapper {
            background-color: #ffffff;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 50px 40px;
        }

        .page-title {
            font-size: 2.8em;
            font-weight: bold;
            color: #111827;
            margin-top: 0;
            margin-bottom: 40px;
        }

        /* Grid for the two main cards */
        .dashboard-grid {
            display: grid;
            /* Creates two columns on wider screens, one on smaller screens */
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
        }

        /* Styling for the navigation cards */
        .nav-card {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            padding: 30px;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
        }
        
        .nav-card .title {
            font-size: 1.8em;
            font-weight: bold;
            color: #111827;
            margin: 0 0 10px 0;
        }
        
        .nav-card .description {
            font-size: 1.1em;
            color: #6b7280;
            margin: 0;
            flex-grow: 1; /* Pushes the button to the bottom */
            margin-bottom: 30px;
        }
        
        /* Button (styled link) */
        .btn {
            display: inline-block;
            background-color: #3b82f6;
            color: #ffffff !important; /* Important to override default link color */
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s;
            align-self: flex-start; /* Align button to the left */
        }
        .btn:hover { 
            background-color: #2563eb; 
        }

    </style>

    <div class="dashboard-wrapper">
        <h1 class="page-title">Dashboard</h1>

        <div class="dashboard-grid">
            <!-- Lessons Card -->
            <div class="nav-card">
                <div>
                    <h2 class="title">Explore Lessons</h2>
                    <p class="description">
                        Browse our full library of grammar and vocabulary lessons to enhance your skills.
                    </p>
                </div>
                <a href="Lessons.aspx" class="btn">Browse Lessons</a>
            </div>

            <!-- Quizzes Card -->
            <div class="nav-card">
                 <div>
                    <h2 class="title">Test Your Knowledge</h2>
                    <p class="description">
                        Take interactive quizzes to reinforce what you've learned and check your understanding.
                    </p>
                </div>
                <a href="Quizzes.aspx" class="btn">Browse Quizzes</a>
            </div>
        </div>
    </div>

</asp:Content> 