import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/entities/event_entity.dart';
import 'event_status_model.dart';
import 'event_type_model.dart';

part 'event_model.g.dart';
part 'event_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.event)
class EventModel with _$EventModel {
  const factory EventModel({
    @HiveField(0) required String id,
    @HiveField(1) required String creatorId,
    @HiveField(2) required String title,
    @HiveField(3) required String description,
    @HiveField(4) required DateTime startDate,
    @HiveField(5) required DateTime endDate,
    @HiveField(6) required EventTypeModel eventType,
    @HiveField(7) required EventStatusModel status,
    @HiveField(8) required int positionsAvailable,
    @HiveField(9) required int maxParticipants,
    @HiveField(10) required String location,
    @HiveField(11) required DateTime applicationDeadline,
    @HiveField(12) required List<String> requiredSkills,
    @HiveField(13) required Map<String, dynamic> additionalFields,
    @HiveField(14) required DateTime createdAt,
    @HiveField(15) required DateTime updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  const EventModel._();

  EventEntity toDomain() => EventEntity(
        id: id,
        creatorId: creatorId,
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        eventType: eventType.toDomain(),
        status: status.toDomain(),
        positionsAvailable: positionsAvailable,
        maxParticipants: maxParticipants,
        location: location,
        applicationDeadline: applicationDeadline,
        requiredSkills: requiredSkills,
        additionalFields: additionalFields,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static EventModel fromDomain(EventEntity entity) => EventModel(
        id: entity.id,
        creatorId: entity.creatorId,
        title: entity.title,
        description: entity.description,
        startDate: entity.startDate,
        endDate: entity.endDate,
        eventType: EventTypeModel.fromDomain(entity.eventType),
        status: EventStatusModel.fromDomain(entity.status),
        positionsAvailable: entity.positionsAvailable,
        maxParticipants: entity.maxParticipants,
        location: entity.location,
        applicationDeadline: entity.applicationDeadline,
        requiredSkills: entity.requiredSkills,
        additionalFields: entity.additionalFields,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
} 