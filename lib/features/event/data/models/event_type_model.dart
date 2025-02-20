import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/event_type.dart';

part 'event_type_model.g.dart';

@HiveType(typeId: HiveTypeIds.eventType)
enum EventTypeModel {
  @JsonValue('internship')
  @HiveField(0)
  internship,

  @JsonValue('workshop')
  @HiveField(1)
  workshop,

  @JsonValue('seminar')
  @HiveField(2)
  seminar,

  @JsonValue('jobFair')
  @HiveField(3)
  jobFair,

  @JsonValue('competition')
  @HiveField(4)
  competition;

  // Convert to domain value object
  EventType toDomain() {
    switch (this) {
      case EventTypeModel.internship:
        return EventType.internship;
      case EventTypeModel.workshop:
        return EventType.workshop;
      case EventTypeModel.seminar:
        return EventType.seminar;
      case EventTypeModel.jobFair:
        return EventType.jobFair;
      case EventTypeModel.competition:
        return EventType.competition;
    }
  }

  // Convert from domain value object
  static EventTypeModel fromDomain(EventType type) {
    return EventTypeModel.values.firstWhere((e) => e.name == type.name);
  }

  // For API serialization
  String toJson() => name;
  
  static EventTypeModel fromJson(String json) {
    return EventTypeModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => EventTypeModel.internship,
    );
  }
} 