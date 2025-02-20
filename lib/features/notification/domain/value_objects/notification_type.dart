enum NotificationType {
  eventInvitation,
  eventUpdate,
  eventReminder,
  applicationStatus,
  systemNotice,
  feedback;

  String get displayName {
    switch (this) {
      case NotificationType.eventInvitation:
        return 'Event Invitation';
      case NotificationType.eventUpdate:
        return 'Event Update';
      case NotificationType.eventReminder:
        return 'Event Reminder';
      case NotificationType.applicationStatus:
        return 'Application Status';
      case NotificationType.systemNotice:
        return 'System Notice';
      case NotificationType.feedback:
        return 'Feedback';
    }
  }

  bool get isEventRelated => 
    this == NotificationType.eventInvitation ||
    this == NotificationType.eventUpdate ||
    this == NotificationType.eventReminder;
  
  bool get requiresAction =>
    this == NotificationType.eventInvitation ||
    this == NotificationType.applicationStatus;
  
  bool get isSystem => this == NotificationType.systemNotice;
} 