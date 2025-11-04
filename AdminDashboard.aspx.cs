using System;
using System.Text;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.Data;

namespace Web
{
    public partial class AdminDashboard : Page
    {
        private int NumberOfQuestions
        {
            get { return (int)(ViewState["NumberOfQuestions"] ?? 1); }
            set { ViewState["NumberOfQuestions"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NumberOfQuestions = 1;
                BindLessonsToDropdown();
                BindRoleDropdown();
                BindLevelDropdowns();
            }
        }

        private void BindLessonsToDropdown()
        {
            var dt = LessonsRepo.List(); // expects columns: Id, Title
            ddlAssociatedLesson.DataSource = dt;
            ddlAssociatedLesson.DataTextField = "Title";
            ddlAssociatedLesson.DataValueField = "Id";
            ddlAssociatedLesson.DataBind();
            ddlAssociatedLesson.Items.Insert(0, new ListItem("-- Select lesson --", ""));
        }

        // >>> add: fills the Role dropdown
        private void BindRoleDropdown()
        {
            ddlUserRole.Items.Clear();
            ddlUserRole.Items.Add(new ListItem("Student", "Student"));
            ddlUserRole.Items.Add(new ListItem("Admin", "Admin"));
        }

        // >>> add: fills the Level dropdowns for lesson/quiz
        private void BindLevelDropdowns()
        {
            var levels = new[]
            {
                new ListItem("Beginner", "1"),
                new ListItem("Intermediate", "2"),
                new ListItem("Advanced", "3")
            };

            ddlLessonLevel.Items.Clear();
            ddlLessonLevel.Items.AddRange(levels);

            ddlQuizLevel.Items.Clear();
            foreach (var li in levels)
                ddlQuizLevel.Items.Add(new ListItem(li.Text, li.Value));
        }

        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            NumberOfQuestions++;
            // If you render dynamic question blocks, recreate them here.
        }

        protected void btnSaveLesson_Click(object sender, EventArgs e)
        {
            var title = txtLessonTitle.Text.Trim();
            var category = txtLessonCategory.Text.Trim();
            var content = txtLessonContent.Text.Trim();
            var video = txtLessonVideoUrl.Text.Trim();
            int diff = 1; int.TryParse(ddlLessonLevel.SelectedValue, out diff);

            if (string.IsNullOrWhiteSpace(title))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Title is required');", true);
                return;
            }

            LessonsRepo.Insert(
                title,
                string.IsNullOrWhiteSpace(category) ? null : category,
                diff,
                string.IsNullOrWhiteSpace(content) ? null : content,
                string.IsNullOrWhiteSpace(video) ? null : video
            );

            ScriptManager.RegisterStartupScript(this, GetType(), "closeLesson", "closeLessonModal();", true);
            BindLessonsToDropdown();
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
            int lessonId; int.TryParse(ddlAssociatedLesson.SelectedValue, out lessonId);
            var title = txtQuizTitle.Text.Trim();
            int diff = 1; int.TryParse(ddlQuizLevel.SelectedValue, out diff);

            if (lessonId <= 0 || string.IsNullOrWhiteSpace(title))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Lesson and title are required');", true);
                return;
            }

            var quizId = QuizzesRepo.Insert(lessonId, title, diff);
            // TODO: if you add dynamic question blocks, persist them here with quizId.

            NumberOfQuestions = 1;
            ScriptManager.RegisterStartupScript(this, GetType(), "closeQuiz", "closeQuizModal();", true);
        }

        protected void btnSaveUser_Click(object sender, EventArgs e)
        {
            var fullName = txtNewUserName.Text.Trim();
            var email = txtNewUserEmail.Text.Trim();
            var role = ddlUserRole.SelectedValue ?? "Student";

            if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(email))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Name and email are required');", true);
                return;
            }

            try
            {
                var defaultPwdHash = Sha256("Password@123");
                UsersRepo.Create(fullName, email, defaultPwdHash, role);
                ScriptManager.RegisterStartupScript(this, GetType(), "closeUser", "closeUserModal();", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Create user failed: " + ex.Message);
                ScriptManager.RegisterStartupScript(this, GetType(), "err", "alert('Create user failed');", true);
            }
        }

        private static string Sha256(string input)
        {
            using (var sha = SHA256.Create())
            {
                var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(input));
                var sb = new StringBuilder(bytes.Length * 2);
                foreach (var b in bytes) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}
