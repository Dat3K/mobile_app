import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/entities/notification_entity.dart';
import 'notification_type_model.dart';

part 'notification_model.g.dart';
part 'notification_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.notification)
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String content,
    @HiveField(3) required NotificationTypeModel type,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required List<String> recipientIds,
    @HiveField(6) Map<String, dynamic>? metadata,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  const NotificationModel._();

  NotificationEntity toDomain() => NotificationEntity(
        id: id,
        title: title,
        content: content,
        type: type.toDomain(),
        createdAt: createdAt,
        recipientIds: recipientIds,
        metadata: metadata,
      );

  static NotificationModel fromDomain(NotificationEntity entity) =>
      NotificationModel(
        id: entity.id,
        title: entity.title,
        content: entity.content,
        type: NotificationTypeModel.fromDomain(entity.type),
        createdAt: entity.createdAt,
        recipientIds: entity.recipientIds,
        metadata: entity.metadata,
      );
} 