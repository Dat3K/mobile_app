enum ParticipationRole {
  participant,
  organizer,
  mentor,
  judge;

  String get displayName {
    switch (this) {
      case ParticipationRole.participant:
        return 'Participant';
      case ParticipationRole.organizer:
        return 'Organizer';
      case ParticipationRole.mentor:
        return 'Mentor';
      case ParticipationRole.judge:
        return 'Judge';
    }
  }

  bool get isParticipant => this == ParticipationRole.participant;
  bool get isOrganizer => this == ParticipationRole.organizer;
  bool get isMentor => this == ParticipationRole.mentor;
  bool get isJudge => this == ParticipationRole.judge;
  bool get canEditEvent => this == ParticipationRole.organizer;
  bool get canReviewParticipants => this != ParticipationRole.participant;
} 