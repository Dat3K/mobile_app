/// Constants for Hive box names and keys
class StorageKeys {
  StorageKeys._(); // Private constructor to prevent instantiation

  // Box Names
  static const String userBox = 'users';
  static const String studentBox = 'students';
  static const String enterpriseBox = 'enterprises';
  static const String eventBox = 'events';
  static const String notificationBox = 'notifications';
  static const String documentBox = 'documents';
  static const String settingsBox = 'settings';

  // Auth Keys
  static const String userKey = 'user';
  static const String studentKey = 'student';

  // CSRF Keys
  static const String csrfTokenKey = 'csrf_token';

  // Cookie Keys
  static const String cookiePrefix = 'cookie_';

  // Box Maintenance
  static const Duration compactionInterval = Duration(days: 1);
  static const Duration inactivityTimeout = Duration(minutes: 5); // Đóng box sau 5 phút không sử dụng
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(milliseconds: 200);

  // Prefixes for dynamic keys
  static const String cachePrefix = 'cache_';
  static const String tempPrefix = 'temp_';
  static const String draftPrefix = 'draft_';

  // Get all box names
  static List<String> get allBoxes => [
        userBox,
        studentBox,
        enterpriseBox,
        eventBox,
        notificationBox,
        documentBox,
        settingsBox,
      ];
}