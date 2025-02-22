import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/entities/event_participation_entity.dart';
import 'participation_role_model.dart';
import 'participation_status_model.dart';

part 'event_participation_model.g.dart';
part 'event_participation_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.eventParticipation)
class EventParticipationModel with _$EventParticipationModel {
  const factory EventParticipationModel({
    @HiveField(0) required String id,
    @HiveField(1) required String eventId,
    @HiveField(2) required String userId,
    @HiveField(3) required ParticipationRoleModel role,
    @HiveField(4) required ParticipationStatusModel status,
    @HiveField(5) required bool attendance,
    @HiveField(6) required DateTime registeredAt,
    @HiveField(7) DateTime? interviewTime,
    @HiveField(8) String? interviewNotes,
    @HiveField(9) Map<String, dynamic>? additionalData,
  }) = _EventParticipationModel;

  factory EventParticipationModel.fromJson(Map<String, dynamic> json) =>
      _$EventParticipationModelFromJson(json);

  const EventParticipationModel._();

  EventParticipationEntity toDomain() => EventParticipationEntity(
        id: id,
        eventId: eventId,
        userId: userId,
        role: role.toDomain(),
        status: status.toDomain(),
        attendance: attendance,
        registeredAt: registeredAt,
        interviewTime: interviewTime,
        interviewNotes: interviewNotes,
        additionalData: additionalData,
      );

  static EventParticipationModel fromDomain(EventParticipationEntity entity) =>
      EventParticipationModel(
        id: entity.id,
        eventId: entity.eventId,
        userId: entity.userId,
        role: ParticipationRoleModel.fromDomain(entity.role),
        status: ParticipationStatusModel.fromDomain(entity.status),
        attendance: entity.attendance,
        registeredAt: entity.registeredAt,
        interviewTime: entity.interviewTime,
        interviewNotes: entity.interviewNotes,
        additionalData: entity.additionalData,
      );
} 