<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Web.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <h3>Your contact page.</h3>
        <address>
            APU<br />
  
        </address>

        <address>
            <strong>:</strong>   <a href="mailto:@apu.edu.my">@apu.edu.my</a><br />
            <strong>:</strong> <a href="mailto:@apu.edu.my">@apu.edu.my</a>
        </address>
    </main>
</asp:Content>
