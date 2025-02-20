// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationTypeModelAdapter extends TypeAdapter<NotificationTypeModel> {
  @override
  final int typeId = 11;

  @override
  NotificationTypeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationTypeModel.eventInvitation;
      case 1:
        return NotificationTypeModel.eventUpdate;
      case 2:
        return NotificationTypeModel.eventReminder;
      case 3:
        return NotificationTypeModel.applicationStatus;
      case 4:
        return NotificationTypeModel.systemNotice;
      case 5:
        return NotificationTypeModel.feedback;
      default:
        return NotificationTypeModel.eventInvitation;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationTypeModel obj) {
    switch (obj) {
      case NotificationTypeModel.eventInvitation:
        writer.writeByte(0);
        break;
      case NotificationTypeModel.eventUpdate:
        writer.writeByte(1);
        break;
      case NotificationTypeModel.eventReminder:
        writer.writeByte(2);
        break;
      case NotificationTypeModel.applicationStatus:
        writer.writeByte(3);
        break;
      case NotificationTypeModel.systemNotice:
        writer.writeByte(4);
        break;
      case NotificationTypeModel.feedback:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
