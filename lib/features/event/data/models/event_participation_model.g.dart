// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_participation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventParticipationModelAdapter
    extends TypeAdapter<EventParticipationModel> {
  @override
  final int typeId = 8;

  @override
  EventParticipationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventParticipationModel(
      id: fields[0] as String,
      eventId: fields[1] as String,
      userId: fields[2] as String,
      role: fields[3] as ParticipationRoleModel,
      status: fields[4] as ParticipationStatusModel,
      attendance: fields[5] as bool,
      registeredAt: fields[6] as DateTime,
      interviewTime: fields[7] as DateTime?,
      interviewNotes: fields[8] as String?,
      additionalData: (fields[9] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventParticipationModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.eventId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.attendance)
      ..writeByte(6)
      ..write(obj.registeredAt)
      ..writeByte(7)
      ..write(obj.interviewTime)
      ..writeByte(8)
      ..write(obj.interviewNotes)
      ..writeByte(9)
      ..write(obj.additionalData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventParticipationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventParticipationModelImpl _$$EventParticipationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventParticipationModelImpl(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      role: $enumDecode(_$ParticipationRoleModelEnumMap, json['role']),
      status: $enumDecode(_$ParticipationStatusModelEnumMap, json['status']),
      attendance: json['attendance'] as bool,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      interviewTime: json['interviewTime'] == null
          ? null
          : DateTime.parse(json['interviewTime'] as String),
      interviewNotes: json['interviewNotes'] as String?,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EventParticipationModelImplToJson(
        _$EventParticipationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'role': instance.role,
      'status': instance.status,
      'attendance': instance.attendance,
      'registeredAt': instance.registeredAt.toIso8601String(),
      'interviewTime': instance.interviewTime?.toIso8601String(),
      'interviewNotes': instance.interviewNotes,
      'additionalData': instance.additionalData,
    };

const _$ParticipationRoleModelEnumMap = {
  ParticipationRoleModel.participant: 'participant',
  ParticipationRoleModel.organizer: 'organizer',
  ParticipationRoleModel.mentor: 'mentor',
  ParticipationRoleModel.judge: 'judge',
};

const _$ParticipationStatusModelEnumMap = {
  ParticipationStatusModel.pending: 'pending',
  ParticipationStatusModel.approved: 'approved',
  ParticipationStatusModel.rejected: 'rejected',
  ParticipationStatusModel.waitlisted: 'waitlisted',
  ParticipationStatusModel.withdrawn: 'withdrawn',
};
