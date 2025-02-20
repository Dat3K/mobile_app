enum EventType {
  internship,
  workshop,
  seminar,
  jobFair,
  competition;

  String get displayName {
    switch (this) {
      case EventType.internship:
        return 'Internship';
      case EventType.workshop:
        return 'Workshop';
      case EventType.seminar:
        return 'Seminar';
      case EventType.jobFair:
        return 'Job Fair';
      case EventType.competition:
        return 'Competition';
    }
  }
} 