// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      email: fields[1] as String,
      role: fields[2] as UserRoleModel,
      isActive: fields[3] as bool,
      avatarPath: fields[4] as String,
      lastLogin: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.avatarPath)
      ..writeByte(5)
      ..write(obj.lastLogin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleModelEnumMap, json['role']),
      isActive: json['isActive'] as bool,
      avatarPath: json['avatarPath'] as String,
      lastLogin: DateTime.parse(json['lastLogin'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'isActive': instance.isActive,
      'avatarPath': instance.avatarPath,
      'lastLogin': instance.lastLogin.toIso8601String(),
    };

const _$UserRoleModelEnumMap = {
  UserRoleModel.student: 'student',
  UserRoleModel.enterprise: 'enterprise',
};
