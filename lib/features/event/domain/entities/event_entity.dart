import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/event_status.dart';
import '../value_objects/event_type.dart';

part 'event_entity.freezed.dart';

@freezed
class EventEntity with _$EventEntity {
  const factory EventEntity({
    required String id,
    required String creatorId,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required EventType eventType,
    required EventStatus status,
    required int positionsAvailable,
    required int maxParticipants,
    required String location,
    required DateTime applicationDeadline,
    required List<String> requiredSkills,
    required Map<String, dynamic> additionalFields,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EventEntity;

  const EventEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    creatorId.isNotEmpty &&
    title.isNotEmpty &&
    description.isNotEmpty &&
    startDate.isAfter(DateTime.now()) &&
    endDate.isAfter(startDate) &&
    positionsAvailable > 0 &&
    maxParticipants > 0 &&
    location.isNotEmpty &&
    applicationDeadline.isBefore(startDate) &&
    requiredSkills.isNotEmpty;

  // Business logic methods
  bool get isOngoing => 
    DateTime.now().isAfter(startDate) && 
    DateTime.now().isBefore(endDate);
  
  bool get isUpcoming => DateTime.now().isBefore(startDate);
  bool get isPast => DateTime.now().isAfter(endDate);
  bool get isAcceptingApplications => 
    DateTime.now().isBefore(applicationDeadline) && 
    status == EventStatus.published;
  
  bool get isFull => maxParticipants <= 0;
  bool get hasAvailablePositions => positionsAvailable > 0;
  
  Duration get timeUntilStart => startDate.difference(DateTime.now());
  Duration get timeUntilEnd => endDate.difference(DateTime.now());
  Duration get timeUntilDeadline => applicationDeadline.difference(DateTime.now());
  
  bool hasRequiredSkill(String skill) => 
    requiredSkills.contains(skill.toLowerCase());
} 