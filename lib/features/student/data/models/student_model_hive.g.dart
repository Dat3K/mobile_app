// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelHiveAdapter extends TypeAdapter<StudentModelHive> {
  @override
  final int typeId = 2;

  @override
  StudentModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModelHive()
      ..id = fields[0] as String
      ..userId = fields[1] as String
      ..major = fields[2] as String
      ..graduationYear = fields[3] as int
      ..enrollmentYear = fields[4] as int
      ..skills = (fields[5] as List).cast<String>()
      ..currentEnterpriseId = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, StudentModelHive obj) {
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
      other is StudentModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
