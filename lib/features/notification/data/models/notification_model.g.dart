// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 11;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      type: fields[3] as NotificationTypeModel,
      createdAt: fields[4] as DateTime,
      recipientIds: (fields[5] as List).cast<String>(),
      metadata: (fields[6] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.recipientIds)
      ..writeByte(6)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      type: $enumDecode(_$NotificationTypeModelEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      recipientIds: (json['recipientIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'recipientIds': instance.recipientIds,
      'metadata': instance.metadata,
    };

const _$NotificationTypeModelEnumMap = {
  NotificationTypeModel.eventInvitation: 'eventInvitation',
  NotificationTypeModel.eventUpdate: 'eventUpdate',
  NotificationTypeModel.eventReminder: 'eventReminder',
  NotificationTypeModel.applicationStatus: 'applicationStatus',
  NotificationTypeModel.systemNotice: 'systemNotice',
  NotificationTypeModel.feedback: 'feedback',
};
