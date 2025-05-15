class Api {
  static const String baseUrl = 'http://182.93.94.210:3064/api/v1/';
  static const String course = '${baseUrl}list-courses';
  static String userFollowers(String userID) =>
      '${baseUrl}user-followers/$userID';
  static String userFollowing(String userID) =>
      '${baseUrl}user-following/$userID';
  static const String notificationsMarkAllRead =
      '${baseUrl}notifications/mark-all-read';
  static const String notificationMarkRead =
      '${baseUrl}notifications/mark-read';
}
