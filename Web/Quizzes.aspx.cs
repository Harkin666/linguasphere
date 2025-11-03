using System;
using System.Data;
using System.Web.UI;
using Web.Data;

namespace Web
{
    public partial class Quizzes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindQuizzes();
            }
        }

        private void BindQuizzes()
        {
            var dt = QuizzesRepo.ListWithQuestionCount();
            rptQuizzes.DataSource = dt;
            rptQuizzes.DataBind();
        }

        protected string GetTagClass(string difficulty)
        {
            if (string.IsNullOrEmpty(difficulty)) return "";
            switch (difficulty.ToLower())
            {
                case "beginner": return "tag-beginner";
                case "intermediate": return "tag-intermediate";
                case "advanced": return "tag-advanced";
                default: return "";
            }
        }
    }
}