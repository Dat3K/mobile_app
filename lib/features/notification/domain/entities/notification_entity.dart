import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/notification_type.dart';

part 'notification_entity.freezed.dart';

@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required String id,
    required String title,
    required String content,
    required NotificationType type,
    required DateTime createdAt,
    required List<String> recipientIds,
    Map<String, dynamic>? metadata,
  }) = _NotificationEntity;

  const NotificationEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    title.isNotEmpty &&
    content.isNotEmpty &&
    recipientIds.isNotEmpty;

  // Business logic methods
  bool get isRecent => 
    DateTime.now().difference(createdAt).inHours < 24;
  
  bool get requiresAction => type.requiresAction;
  bool get isEventRelated => type.isEventRelated;
  bool get isSystemNotice => type.isSystem;
  
  bool hasRecipient(String userId) => 
    recipientIds.contains(userId);
  
  Map<String, dynamic> get eventData => 
    type.isEventRelated ? (metadata ?? {}) : {};
} 