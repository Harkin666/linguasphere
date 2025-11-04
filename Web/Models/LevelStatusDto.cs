using System;

namespace Web.Models
{
    public class LevelStatusDto
    {
        public string LevelName { get; set; }
        public int LevelRank { get; set; }
        public int PointsTowardsNextLevel { get; set; }
        public int PointsRequiredForNextLevel { get; set; }
        public DateTime EffectiveAt { get; set; }
    }
}
