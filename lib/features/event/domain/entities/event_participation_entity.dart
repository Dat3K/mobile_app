import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/participation_role.dart';
import '../value_objects/participation_status.dart';

part 'event_participation_entity.freezed.dart';

@freezed
class EventParticipationEntity with _$EventParticipationEntity {
  const factory EventParticipationEntity({
    required String id,
    required String eventId,
    required String userId,
    required ParticipationRole role,
    required ParticipationStatus status,
    required bool attendance,
    required DateTime registeredAt,
    DateTime? interviewTime,
    String? interviewNotes,
    Map<String, dynamic>? additionalData,
  }) = _EventParticipationEntity;

  const EventParticipationEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    eventId.isNotEmpty &&
    userId.isNotEmpty;

  // Business logic methods
  bool get hasInterview => interviewTime != null;
  bool get hasNotes => interviewNotes?.isNotEmpty ?? false;
  bool get isActive => status == ParticipationStatus.approved;
  bool get needsAction => status == ParticipationStatus.pending;
  bool get canAttend => status == ParticipationStatus.approved;
  bool get canBeInterviewed => 
    status == ParticipationStatus.pending || 
    status == ParticipationStatus.waitlisted;
  
  Duration? get timeUntilInterview => 
    interviewTime?.difference(DateTime.now());
} 