// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enterprise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnterpriseModelAdapter extends TypeAdapter<EnterpriseModel> {
  @override
  final int typeId = 3;

  @override
  EnterpriseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnterpriseModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      industry: fields[3] as String,
      imagePath: fields[4] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EnterpriseModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.industry)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnterpriseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnterpriseModelImpl _$$EnterpriseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EnterpriseModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      industry: json['industry'] as String,
      imagePath: json['imagePath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EnterpriseModelImplToJson(
        _$EnterpriseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'industry': instance.industry,
      'imagePath': instance.imagePath,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
