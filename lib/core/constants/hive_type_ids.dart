/// Constants for Hive type IDs to avoid conflicts
class HiveTypeIds {
  HiveTypeIds._(); // Private constructor to prevent instantiation

  // Auth Types (0-1)
  static const int user = 0;
  static const int userRole = 1;

  // Student Types (2)
  static const int student = 2;

  // Enterprise Types (3-4)
  static const int enterprise = 3;
  static const int enterprisePosition = 4;

  // Event Types (5-8)
  static const int event = 5;
  static const int eventType = 6;
  static const int eventStatus = 7;
  static const int eventParticipation = 8;

  // Participation Types (9-10)
  static const int participationRole = 9;
  static const int participationStatus = 10;

  // Notification Types (11-12)
  static const int notification = 11;
  static const int notificationType = 12;

  // Document Types (13-14)
  static const int document = 13;
  static const int documentType = 14;
} 