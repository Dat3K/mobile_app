// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRoleModelAdapter extends TypeAdapter<UserRoleModel> {
  @override
  final int typeId = 3;

  @override
  UserRoleModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserRoleModel.faculty;
      case 1:
        return UserRoleModel.student;
      case 2:
        return UserRoleModel.enterprise;
      default:
        return UserRoleModel.faculty;
    }
  }

  @override
  void write(BinaryWriter writer, UserRoleModel obj) {
    switch (obj) {
      case UserRoleModel.faculty:
        writer.writeByte(0);
        break;
      case UserRoleModel.student:
        writer.writeByte(1);
        break;
      case UserRoleModel.enterprise:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
