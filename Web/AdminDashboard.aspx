<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Web.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .admin-wrapper {
            background-color: #ffffff;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 50px 40px;
        }
        .page-title { font-size: 2.8em; font-weight: bold; color: #111827; margin-top: 0; margin-bottom: 40px; }
        .management-card { background-color: #ffffff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 25px 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; }
        .section-title { font-size: 1.8em; font-weight: bold; color: #111827; }
        .summary-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 30px; }
        .btn-primary { background-color: #3b82f6; color: #ffffff; padding: 10px 20px; border: none; border-radius: 8px; font-size: 1em; font-weight: bold; cursor: pointer; transition: background-color 0.3s; }
        .btn-primary:hover { background-color: #2563eb; }
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); display: none; justify-content: center; align-items: flex-start; z-index: 1000; padding-top: 50px; overflow-y: auto; }
        .modal-content { background-color: #2a2a4a; color: #ffffff; padding: 25px 30px; border-radius: 12px; width: 100%; max-width: 600px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); margin-bottom: 50px; }
        .modal-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #3e4e6a; padding-bottom: 15px; margin-bottom: 25px; }
        .modal-title { font-size: 1.8em; font-weight: bold; }
        .modal-close { font-size: 2em; font-weight: bold; color: #a0a0b0; cursor: pointer; border: none; background: none; }
        .modal-body .form-group { margin-bottom: 20px; }
        .modal-body .form-label { display: block; margin-bottom: 8px; font-size: 1em; color: #c0c0d0; }
        .modal-input, .modal-textarea { width: 100%; padding: 12px 15px; border-radius: 8px; border: 1px solid #3e4e6a; background-color: #1a1a2e; color: #ffffff; font-size: 1em; box-sizing: border-box; font-family: inherit; }
        .modal-textarea { resize: vertical; min-height: 120px; }
        .modal-footer { text-align: right; padding-top: 20px; margin-top: 20px; border-top: 1px solid #3e4e6a; }
        .btn-secondary { background-color: #4b5563; color: #ffffff; padding: 10px 20px; border: none; border-radius: 8px; font-size: 1em; font-weight: bold; cursor: pointer; margin-right: 10px; }
        .btn-secondary:hover { background-color: #6b7280; }
        .quiz-form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .questions-container .section-label { font-size: 1.2em; font-weight: bold; color: #ffffff; margin-top: 15px; margin-bottom: 15px; }
        .question-block { background-color: #1a1a2e; border: 1px solid #3e4e6a; border-radius: 8px; padding: 20px; margin-bottom: 20px; }
        .btn-add-question { background: none; border: 1px dashed #4b5563; color: #a0a0b0; width: 100%; padding: 15px; border-radius: 8px; cursor: pointer; font-size: 1em; font-weight: bold; transition: all 0.3s; }
        .btn-add-question:hover { border-color: #6b7280; color: #ffffff; }
    </style>

    <div class="admin-wrapper">
        <h1 class="page-title">Admin Dashboard</h1>

        <div class="management-card">
            <h2 class="section-title">User Management</h2>
            <button type="button" class="btn-primary" onclick="openUserModal()">Add New User</button>
        </div>

        <div class="summary-grid">
            <div class="management-card">
                <h2 class="section-title"><asp:Label ID="lblLessons" runat="server" Text="Lessons (0)"></asp:Label></h2>
                <button type="button" class="btn-primary" onclick="openLessonModal()">Add Lesson</button>
            </div>
            <div class="management-card">
                <h2 class="section-title"><asp:Label ID="lblQuizzes" runat="server" Text="Quizzes (0)"></asp:Label></h2>
                <button type="button" class="btn-primary" onclick="openQuizModal()">Add Quiz</button>
            </div>
        </div>
    </div>
    <div id="addUserModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header"><h2 class="modal-title">Add New User</h2><button type="button" class="modal-close" onclick="closeUserModal()">&times;</button></div>
            <div class="modal-body">
                <div class="form-group"><label class="form-label">Full Name</label><asp:TextBox ID="txtNewUserName" runat="server" CssClass="modal-input"></asp:TextBox></div>
                <div class="form-group"><label class="form-label">Email Address</label><asp:TextBox ID="txtNewUserEmail" runat="server" CssClass="modal-input" TextMode="Email"></asp:TextBox></div>
                <div class="form-group"><label class="form-label">Role</label><asp:DropDownList ID="ddlUserRole" runat="server" CssClass="modal-input"></asp:DropDownList></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-secondary" onclick="closeUserModal()">Cancel</button>
                <asp:Button ID="btnSaveUser" runat="server" Text="Save User" CssClass="btn-primary" OnClick="btnSaveUser_Click" />
            </div>
        </div>
    </div>

    <div id="addLessonModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header"><h2 class="modal-title">Add New Lesson</h2><button type="button" class="modal-close" onclick="closeLessonModal()">&times;</button></div>
            <div class="modal-body">
                <div class="form-group"><label class="form-label">Lesson Title</label><asp:TextBox ID="txtLessonTitle" runat="server" CssClass="modal-input"></asp:TextBox></div>
                <div class="form-group"><label class="form-label">Category (e.g., Grammar)</label><asp:TextBox ID="txtLessonCategory" runat="server" CssClass="modal-input"></asp:TextBox></div>
                <div class="form-group"><label class="form-label">Level</label><asp:DropDownList ID="ddlLessonLevel" runat="server" CssClass="modal-input"></asp:DropDownList></div>
                <div class="form-group"><label class="form-label">Content (HTML allowed)</label><asp:TextBox ID="txtLessonContent" runat="server" CssClass="modal-textarea" TextMode="MultiLine" Rows="5"></asp:TextBox></div>
                <div class="form-group"><label class="form-label">Video URL (Optional)</label><asp:TextBox ID="txtLessonVideoUrl" runat="server" CssClass="modal-input" TextMode="Url"></asp:TextBox></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-secondary" onclick="closeLessonModal()">Cancel</button>
                <asp:Button ID="btnSaveLesson" runat="server" Text="Save Lesson" CssClass="btn-primary" OnClick="btnSaveLesson_Click" />
            </div>
        </div>
    </div>

    <div id="addQuizModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header"><h2 class="modal-title">Add New Quiz</h2><button type="button" class="modal-close" onclick="closeQuizModal()">&times;</button></div>
            <div class="modal-body">
                <div class="form-group"><label class="form-label">Quiz Title</label><asp:TextBox ID="txtQuizTitle" runat="server" CssClass="modal-input"></asp:TextBox></div>
                <div class="quiz-form-grid">
                    <div class="form-group"><label class="form-label">Associated Lesson</label><asp:DropDownList ID="ddlAssociatedLesson" runat="server" CssClass="modal-input"></asp:DropDownList></div>
                    <div class="form-group"><label class="form-label">Level</label><asp:DropDownList ID="ddlQuizLevel" runat="server" CssClass="modal-input"></asp:DropDownList></div>
                </div>
                <div id="questionsContainer" class="questions-container">
                    <div class="section-label">Questions</div>
                    <asp:Panel ID="pnlQuestions" runat="server"></asp:Panel>
                </div>
                <asp:Button ID="btnAddQuestion" runat="server" Text="Add Another Question" CssClass="btn-add-question" OnClick="btnAddQuestion_Click" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-secondary" onclick="closeQuizModal()">Cancel</button>
                <asp:Button ID="btnSaveQuiz" runat="server" Text="Save Quiz" CssClass="btn-primary" OnClick="btnSaveQuiz_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        const userModal = document.getElementById('addUserModal');
        const lessonModal = document.getElementById('addLessonModal');
        const quizModal = document.getElementById('addQuizModal');

        function openUserModal() { userModal.style.display = 'flex'; }
        function closeUserModal() { userModal.style.display = 'none'; }
        function openLessonModal() { lessonModal.style.display = 'flex'; }
        function closeLessonModal() { lessonModal.style.display = 'none'; }
        function openQuizModal() { quizModal.style.display = 'flex'; }
        function closeQuizModal() { quizModal.style.display = 'none'; }

        window.onclick = function (event) {
            if (event.target == userModal) { closeUserModal(); }
            if (event.target == lessonModal) { closeLessonModal(); }
            if (event.target == quizModal) { closeQuizModal(); }
        }
    </script>
</asp:Content>
