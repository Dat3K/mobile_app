// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventStatusModelAdapter extends TypeAdapter<EventStatusModel> {
  @override
  final int typeId = 7;

  @override
  EventStatusModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EventStatusModel.draft;
      case 1:
        return EventStatusModel.published;
      case 2:
        return EventStatusModel.inProgress;
      case 3:
        return EventStatusModel.completed;
      case 4:
        return EventStatusModel.cancelled;
      default:
        return EventStatusModel.draft;
    }
  }

  @override
  void write(BinaryWriter writer, EventStatusModel obj) {
    switch (obj) {
      case EventStatusModel.draft:
        writer.writeByte(0);
        break;
      case EventStatusModel.published:
        writer.writeByte(1);
        break;
      case EventStatusModel.inProgress:
        writer.writeByte(2);
        break;
      case EventStatusModel.completed:
        writer.writeByte(3);
        break;
      case EventStatusModel.cancelled:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
