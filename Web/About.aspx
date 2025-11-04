<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Web.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .about-wrapper {
            background-color: #ffffff;
            color: #1f2937; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 60px 40px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            text-align: center; 
        }

        .page-title {
            font-size: 3em;
            font-weight: bold;
            color: #111827;
            margin-top: 0;
            margin-bottom: 15px;
        }

        .page-subtitle {
            font-size: 1.5em;
            color: #3b82f6;
            margin-bottom: 30px;
            font-weight: 500;
        }

        .content-body p {
            font-size: 1.1em;
            color: #6b7280;
            line-height: 1.8;
            text-align: left; 
            margin-bottom: 20px;
        }
        

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 50px;
            text-align: left;
        }
        
        .feature-card {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            padding: 25px;
            border-radius: 12px;
        }
        
        .feature-card h3 {
            font-size: 1.25em;
            color: #111827;
            margin-top: 0;
        }

    </style>

    <div class="about-wrapper">
        <div class="container">
            <h1 class="page-title">About LinguaSphere</h1>

            <div class="content-body">
                <p>
                    At LinguaSphere, we believe that learning a new language should be an engaging, accessible, and rewarding journey. Our platform is meticulously designed to provide you with the tools and resources you need to build confidence and fluency, one lesson at a time.
                </p>
                <p>
                    Whether you're starting with the basics of grammar, expanding your vocabulary, or testing your knowledge with interactive quizzes, LinguaSphere is here to support you. Our mission is to break down language barriers and connect people through the power of communication.
                </p>
            <div> </div>
</asp:Content>