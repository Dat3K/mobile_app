// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 2;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      major: fields[2] as String,
      graduationYear: fields[3] as int,
      enrollmentYear: fields[4] as int,
      skills: (fields[5] as List).cast<String>(),
      currentEnterpriseId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.major)
      ..writeByte(3)
      ..write(obj.graduationYear)
      ..writeByte(4)
      ..write(obj.enrollmentYear)
      ..writeByte(5)
      ..write(obj.skills)
      ..writeByte(6)
      ..write(obj.currentEnterpriseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentModelImpl _$$StudentModelImplFromJson(Map<String, dynamic> json) =>
    _$StudentModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      major: json['major'] as String,
      graduationYear: (json['graduationYear'] as num).toInt(),
      enrollmentYear: (json['enrollmentYear'] as num).toInt(),
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      currentEnterpriseId: json['currentEnterpriseId'] as String?,
    );

Map<String, dynamic> _$$StudentModelImplToJson(_$StudentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'major': instance.major,
      'graduationYear': instance.graduationYear,
      'enrollmentYear': instance.enrollmentYear,
      'skills': instance.skills,
      'currentEnterpriseId': instance.currentEnterpriseId,
    };
