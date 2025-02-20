import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/event_status.dart';

part 'event_status_model.g.dart';

@HiveType(typeId: HiveTypeIds.eventStatus)
enum EventStatusModel {
  @JsonValue('draft')
  @HiveField(0)
  draft,

  @JsonValue('published')
  @HiveField(1)
  published,

  @JsonValue('inProgress')
  @HiveField(2)
  inProgress,

  @JsonValue('completed')
  @HiveField(3)
  completed,

  @JsonValue('cancelled')
  @HiveField(4)
  cancelled;

  // Convert to domain value object
  EventStatus toDomain() {
    switch (this) {
      case EventStatusModel.draft:
        return EventStatus.draft;
      case EventStatusModel.published:
        return EventStatus.published;
      case EventStatusModel.inProgress:
        return EventStatus.inProgress;
      case EventStatusModel.completed:
        return EventStatus.completed;
      case EventStatusModel.cancelled:
        return EventStatus.cancelled;
    }
  }

  // Convert from domain value object
  static EventStatusModel fromDomain(EventStatus status) {
    return EventStatusModel.values.firstWhere((e) => e.name == status.name);
  }

  // For API serialization
  String toJson() => name;
  
  static EventStatusModel fromJson(String json) {
    return EventStatusModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => EventStatusModel.draft,
    );
  }
} 