enum ParticipationStatus {
  pending,
  approved,
  rejected,
  waitlisted,
  withdrawn;

  String get displayName {
    switch (this) {
      case ParticipationStatus.pending:
        return 'Pending';
      case ParticipationStatus.approved:
        return 'Approved';
      case ParticipationStatus.rejected:
        return 'Rejected';
      case ParticipationStatus.waitlisted:
        return 'Waitlisted';
      case ParticipationStatus.withdrawn:
        return 'Withdrawn';
    }
  }

  bool get isPending => this == ParticipationStatus.pending;
  bool get isApproved => this == ParticipationStatus.approved;
  bool get isRejected => this == ParticipationStatus.rejected;
  bool get isWaitlisted => this == ParticipationStatus.waitlisted;
  bool get isWithdrawn => this == ParticipationStatus.withdrawn;
  bool get canWithdraw => this != ParticipationStatus.withdrawn && this != ParticipationStatus.rejected;
  bool get canApprove => this == ParticipationStatus.pending || this == ParticipationStatus.waitlisted;
  bool get canReject => this == ParticipationStatus.pending || this == ParticipationStatus.waitlisted;
  bool get canWaitlist => this == ParticipationStatus.pending;
} 