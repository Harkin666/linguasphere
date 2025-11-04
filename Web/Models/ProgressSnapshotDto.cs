namespace Web.Models
{
    public class ProgressSnapshotDto
    {
        public int LessonsCompleted { get; set; }
        public int LessonsTotal { get; set; }
        public int QuizzesPassed { get; set; }
        public int QuizzesTotal { get; set; }
        public int ExamsPassed { get; set; }
        public int ExamsTotal { get; set; }
        public decimal CourseCompletionPercent { get; set; }
        public decimal AccuracyPercent { get; set; }
    }
}
