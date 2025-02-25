// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticipationRoleModelAdapter
    extends TypeAdapter<ParticipationRoleModel> {
  @override
  final int typeId = 9;

  @override
  ParticipationRoleModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ParticipationRoleModel.participant;
      case 1:
        return ParticipationRoleModel.organizer;
      case 2:
        return ParticipationRoleModel.mentor;
      case 3:
        return ParticipationRoleModel.judge;
      default:
        return ParticipationRoleModel.participant;
    }
  }

  @override
  void write(BinaryWriter writer, ParticipationRoleModel obj) {
    switch (obj) {
      case ParticipationRoleModel.participant:
        writer.writeByte(0);
        break;
      case ParticipationRoleModel.organizer:
        writer.writeByte(1);
        break;
      case ParticipationRoleModel.mentor:
        writer.writeByte(2);
        break;
      case ParticipationRoleModel.judge:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticipationRoleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
