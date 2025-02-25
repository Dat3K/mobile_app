// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticipationStatusModelAdapter
    extends TypeAdapter<ParticipationStatusModel> {
  @override
  final int typeId = 10;

  @override
  ParticipationStatusModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ParticipationStatusModel.pending;
      case 1:
        return ParticipationStatusModel.approved;
      case 2:
        return ParticipationStatusModel.rejected;
      case 3:
        return ParticipationStatusModel.waitlisted;
      case 4:
        return ParticipationStatusModel.withdrawn;
      default:
        return ParticipationStatusModel.pending;
    }
  }

  @override
  void write(BinaryWriter writer, ParticipationStatusModel obj) {
    switch (obj) {
      case ParticipationStatusModel.pending:
        writer.writeByte(0);
        break;
      case ParticipationStatusModel.approved:
        writer.writeByte(1);
        break;
      case ParticipationStatusModel.rejected:
        writer.writeByte(2);
        break;
      case ParticipationStatusModel.waitlisted:
        writer.writeByte(3);
        break;
      case ParticipationStatusModel.withdrawn:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticipationStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
