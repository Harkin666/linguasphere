<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="Web.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .auth-wrapper {
            background-color: #ffffff;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
        }
        .form-container { width: 100%; max-width: 450px; text-align: center; }
        .header .brand { font-size: 3em; font-weight: bold; color: #3b82f6; margin-bottom: 10px; }
        .header .subtitle { font-size: 1.5em; font-weight: bold; color: #111827; margin-bottom: 40px; }
        .form-panel { background-color: #f9fafb; border: 1px solid #e5e7eb; padding: 40px; border-radius: 12px; text-align: left; }
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; margin-bottom: 8px; font-size: 1em; color: #4b5563; }
        .form-input { width: 100%; padding: 12px 15px; border-radius: 8px; border: 1px solid #d1d5db; background-color: #ffffff; color: #111827; font-size: 1em; box-sizing: border-box; }
        .form-input:focus { outline: none; border-color: #3b82f6; }
        .btn-primary { width: 100%; padding: 15px; background-color: #3b82f6; color: #ffffff; border: none; border-radius: 8px; font-size: 1.1em; font-weight: bold; cursor: pointer; transition: background-color 0.3s; margin-top: 15px; }
        .btn-primary:hover { background-color: #2563eb; }
        .form-link { text-align: center; margin-top: 25px; font-size: 1em; color: #6b7280; }
        .form-link a { color: #3b82f6; text-decoration: none; font-weight: bold; }
        .form-link a:hover { text-decoration: underline; }
    </style>

    <div class="auth-wrapper">
        <div class="form-container">
            <header class="header">
                <div class="brand">LinguaSphere</div>
                <div class="subtitle">Administrator Login</div>
            </header>
            <div class="form-panel">
                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input" TextMode="Password"></asp:TextBox>
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn-primary" OnClick="btnLogin_Click" />
                <div class="form-link">
                    Need to create an admin account? <a href="AdminRegister.aspx">Register here</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>