using System;

namespace Web.Models
{
    public class UserBadgeDto
    {
        public int BadgeId { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string IconUrl { get; set; }
        public DateTime AwardedAt { get; set; }
    }
}
