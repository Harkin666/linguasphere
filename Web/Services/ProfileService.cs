using System;
using System.Collections.Generic;
using Web.Data;
using Web.Models;

namespace Web.Services
{
    public static class ProfileService
    {
        public static UserProfileDto GetProfile(int userId)
        {
            var core = UsersRepo.GetProfile(userId);
            if (core == null)
                return null;

            var privacy = UsersRepo.GetPrivacySettings(userId);
            var badges = UsersRepo.GetBadges(userId);
            var level = UsersRepo.GetLevelStatus(userId);
            var progress = UsersRepo.GetProgressSnapshot(userId);

            return new UserProfileDto
            {
                UserId = core.Value.userId,
                UserName = core.Value.userName,
                DisplayName = core.Value.displayName,
                Email = core.Value.email,
                AvatarUrl = core.Value.avatarUrl,
                TimeZone = core.Value.timeZone,
                OccupationStage = core.Value.occupationStage,
                Bio = core.Value.bio,
                CurrentCourseId = core.Value.currentCourseId,
                CurrentCourseTitle = core.Value.currentCourseTitle,
                PrivacyMap = privacy,
                Badges = badges,
                LevelStatus = level,
                ProgressSnapshot = progress
            };
        }

        public static void UpdateProfile(int userId, UserProfileDto input)
        {
            UsersRepo.UpdateProfile(userId, input);
            UsersRepo.UpdatePrivacy(userId, input.PrivacyMap);
        }

        public static UserPreferenceDto GetPreferences(int userId)
        {
            return UsersRepo.GetPreferences(userId);
        }

        public static void UpdatePreferences(int userId, UserPreferenceDto prefs)
        {
            UsersRepo.UpdatePreferences(userId, prefs);
        }
    }
}
