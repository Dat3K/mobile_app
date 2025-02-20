import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/notification_type.dart';

part 'notification_type_model.g.dart';

@HiveType(typeId: HiveTypeIds.notificationType)
enum NotificationTypeModel {
  @JsonValue('eventInvitation')
  @HiveField(0)
  eventInvitation,

  @JsonValue('eventUpdate')
  @HiveField(1)
  eventUpdate,

  @JsonValue('eventReminder')
  @HiveField(2)
  eventReminder,

  @JsonValue('applicationStatus')
  @HiveField(3)
  applicationStatus,

  @JsonValue('systemNotice')
  @HiveField(4)
  systemNotice,

  @JsonValue('feedback')
  @HiveField(5)
  feedback;

  // Convert to domain value object
  NotificationType toDomain() {
    switch (this) {
      case NotificationTypeModel.eventInvitation:
        return NotificationType.eventInvitation;
      case NotificationTypeModel.eventUpdate:
        return NotificationType.eventUpdate;
      case NotificationTypeModel.eventReminder:
        return NotificationType.eventReminder;
      case NotificationTypeModel.applicationStatus:
        return NotificationType.applicationStatus;
      case NotificationTypeModel.systemNotice:
        return NotificationType.systemNotice;
      case NotificationTypeModel.feedback:
        return NotificationType.feedback;
    }
  }

  // Convert from domain value object
  static NotificationTypeModel fromDomain(NotificationType type) {
    return NotificationTypeModel.values.firstWhere((e) => e.name == type.name);
  }

  // For API serialization
  String toJson() => name;
  
  static NotificationTypeModel fromJson(String json) {
    return NotificationTypeModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => NotificationTypeModel.systemNotice,
    );
  }
} 