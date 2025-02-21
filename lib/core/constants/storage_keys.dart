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

  // Common Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme';
  static const String localeKey = 'locale';
  static const String onboardingKey = 'onboarding_completed';
  static const String lastSyncKey = 'last_sync';

  // Version Control
  static const String versionKey = 'box_version';
  static const int currentVersion = 1;

  // Encryption
  static const String encryptionKeyKey = 'hive_encryption_key';
  static const int encryptionKeyLength = 32;

  // Box Maintenance
  static const Duration compactionInterval = Duration(days: 1);
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

  // Get secure box names (boxes that need encryption)
  static List<String> get secureBoxes => [
        userBox,
        authTokenKey,
        refreshTokenKey,
      ];
} 