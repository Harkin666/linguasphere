<%@ Page Title="Welcome" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .welcome-wrapper {
            background-color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 60px 20px;
            text-align: center;
        }

        .welcome-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .welcome-title {
            font-size: 3em;
            font-weight: bold;
            color: #111827;
            margin-bottom: 15px;
        }

        .welcome-subtitle {
            font-size: 1.2em;
            color: #6b7280;
            margin-bottom: 50px;
            line-height: 1.6;
            max-width: 650px;
            margin-left: auto;
            margin-right: auto;
        }

    
        .portal-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

    
        .portal-card {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 30px;
            transition: box-shadow 0.3s, transform 0.3s;
        }

        .portal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }

        .portal-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #111827;
            margin-bottom: 10px;
        }

        .portal-description {
            color: #6b7280;
            margin-bottom: 30px;
            min-height: 50px; 
        }
        
        .portal-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn {
            padding: 10px 25px;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: #3b82f6;
            color: #ffffff;
            border: 1px solid #3b82f6;
        }
        .btn-primary:hover {
            background-color: #2563eb;
        }
        
        .btn-secondary {
            background-color: #ffffff;
            color: #374151;
            border: 1px solid #d1d5db;
        }
        .btn-secondary:hover {
            background-color: #f3f4f6;
        }
        
  
        @media (max-width: 768px) {
            .portal-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="welcome-wrapper">
        <div class="welcome-container">
            <h1 class="welcome-title">Welcome to LinguaSphere</h1>
            <p class="welcome-subtitle">
                Your journey to mastering a new language starts here. Choose your path below to get started.
            </p>

            <div class="portal-grid">

                <div class="portal-card">
                    <h2 class="portal-title">I am a Student</h2>
                    <p class="portal-description">
                        Access your lessons, take quizzes, and track your learning progress.
                    </p>
                    <div class="portal-actions">
                        <a href="Login.aspx" class="btn btn-primary">Login</a>
                        <a href="Register.aspx" class="btn btn-secondary">Register</a>
                    </div>
                </div>


                <div class="portal-card">
                    <h2 class="portal-title">I am an Administrator</h2>
                    <p class="portal-description">
                        Manage users, create and edit lessons, and oversee quiz content.
                    </p>
                    <div class="portal-actions">
                        <a href="AdminLogin.aspx" class="btn btn-primary">Admin Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>