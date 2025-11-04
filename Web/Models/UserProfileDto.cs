using System;
using System.Collections.Generic;

namespace Web.Models
{
    /// <summary>
    /// Represents the editable and display-ready profile data for a user.
    /// </summary>
    public class UserProfileDto
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string DisplayName { get; set; }
        public string Email { get; set; }
        public string AvatarUrl { get; set; }
        public string TimeZone { get; set; }
        public string OccupationStage { get; set; }
        public string Bio { get; set; }
        public int? CurrentCourseId { get; set; }
        public string CurrentCourseTitle { get; set; }
        public IReadOnlyDictionary<string, bool> PrivacyMap { get; set; } = new Dictionary<string, bool>();
        public IReadOnlyList<UserBadgeDto> Badges { get; set; } = Array.Empty<UserBadgeDto>();
        public LevelStatusDto LevelStatus { get; set; }
        public ProgressSnapshotDto ProgressSnapshot { get; set; }
    }
}
