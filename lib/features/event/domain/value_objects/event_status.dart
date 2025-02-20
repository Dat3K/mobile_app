enum EventStatus {
  draft,
  published,
  inProgress,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case EventStatus.draft:
        return 'Draft';
      case EventStatus.published:
        return 'Published';
      case EventStatus.inProgress:
        return 'In Progress';
      case EventStatus.completed:
        return 'Completed';
      case EventStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isDraft => this == EventStatus.draft;
  bool get isPublished => this == EventStatus.published;
  bool get isInProgress => this == EventStatus.inProgress;
  bool get isCompleted => this == EventStatus.completed;
  bool get isCancelled => this == EventStatus.cancelled;
  bool get canEdit => this == EventStatus.draft;
  bool get canPublish => this == EventStatus.draft;
  bool get canCancel => this != EventStatus.completed && this != EventStatus.cancelled;
} 