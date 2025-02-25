// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 5;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      id: fields[0] as String,
      creatorId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      startDate: fields[4] as DateTime,
      endDate: fields[5] as DateTime,
      eventType: fields[6] as EventTypeModel,
      status: fields[7] as EventStatusModel,
      positionsAvailable: fields[8] as int,
      maxParticipants: fields[9] as int,
      location: fields[10] as String,
      applicationDeadline: fields[11] as DateTime,
      requiredSkills: (fields[12] as List).cast<String>(),
      additionalFields: (fields[13] as Map).cast<String, dynamic>(),
      createdAt: fields[14] as DateTime,
      updatedAt: fields[15] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.creatorId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(6)
      ..write(obj.eventType)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.positionsAvailable)
      ..writeByte(9)
      ..write(obj.maxParticipants)
      ..writeByte(10)
      ..write(obj.location)
      ..writeByte(11)
      ..write(obj.applicationDeadline)
      ..writeByte(12)
      ..write(obj.requiredSkills)
      ..writeByte(13)
      ..write(obj.additionalFields)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      creatorId: json['creatorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      eventType: $enumDecode(_$EventTypeModelEnumMap, json['eventType']),
      status: $enumDecode(_$EventStatusModelEnumMap, json['status']),
      positionsAvailable: (json['positionsAvailable'] as num).toInt(),
      maxParticipants: (json['maxParticipants'] as num).toInt(),
      location: json['location'] as String,
      applicationDeadline:
          DateTime.parse(json['applicationDeadline'] as String),
      requiredSkills: (json['requiredSkills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      additionalFields: json['additionalFields'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorId': instance.creatorId,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'eventType': instance.eventType,
      'status': instance.status,
      'positionsAvailable': instance.positionsAvailable,
      'maxParticipants': instance.maxParticipants,
      'location': instance.location,
      'applicationDeadline': instance.applicationDeadline.toIso8601String(),
      'requiredSkills': instance.requiredSkills,
      'additionalFields': instance.additionalFields,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$EventTypeModelEnumMap = {
  EventTypeModel.internship: 'internship',
  EventTypeModel.workshop: 'workshop',
  EventTypeModel.seminar: 'seminar',
  EventTypeModel.jobFair: 'jobFair',
  EventTypeModel.competition: 'competition',
};

const _$EventStatusModelEnumMap = {
  EventStatusModel.draft: 'draft',
  EventStatusModel.published: 'published',
  EventStatusModel.inProgress: 'inProgress',
  EventStatusModel.completed: 'completed',
  EventStatusModel.cancelled: 'cancelled',
};
