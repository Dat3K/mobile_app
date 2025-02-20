// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventTypeModelAdapter extends TypeAdapter<EventTypeModel> {
  @override
  final int typeId = 6;

  @override
  EventTypeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EventTypeModel.internship;
      case 1:
        return EventTypeModel.workshop;
      case 2:
        return EventTypeModel.seminar;
      case 3:
        return EventTypeModel.jobFair;
      case 4:
        return EventTypeModel.competition;
      default:
        return EventTypeModel.internship;
    }
  }

  @override
  void write(BinaryWriter writer, EventTypeModel obj) {
    switch (obj) {
      case EventTypeModel.internship:
        writer.writeByte(0);
        break;
      case EventTypeModel.workshop:
        writer.writeByte(1);
        break;
      case EventTypeModel.seminar:
        writer.writeByte(2);
        break;
      case EventTypeModel.jobFair:
        writer.writeByte(3);
        break;
      case EventTypeModel.competition:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
