using System;

namespace Web.Models
{
    public class UserPreferenceDto
    {
        public int UserId { get; set; }
        public string Theme { get; set; } = "auto";
        public bool EmailOptIn { get; set; } = true;
        public DateTime UpdatedAt { get; set; }
    }
}
