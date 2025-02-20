import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/entities/student_entity.dart';

part 'student_model.g.dart';
part 'student_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.student)
class StudentModel with _$StudentModel {
  const factory StudentModel({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String fullName,
    @HiveField(3) required String major,
    @HiveField(4) required int graduationYear,
    @HiveField(5) required int enrollmentYear,
    @HiveField(6) required List<String> skills,
    @HiveField(7) String? currentEnterpriseId,
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  const StudentModel._();

  StudentEntity toDomain() => StudentEntity(
        id: id,
        userId: userId,
        fullName: fullName,
        major: major,
        graduationYear: graduationYear,
        enrollmentYear: enrollmentYear,
        skills: skills,
        currentEnterpriseId: currentEnterpriseId,
      );

  static StudentModel fromDomain(StudentEntity entity) => StudentModel(
        id: entity.id,
        userId: entity.userId,
        fullName: entity.fullName,
        major: entity.major,
        graduationYear: entity.graduationYear,
        enrollmentYear: entity.enrollmentYear,
        skills: entity.skills,
        currentEnterpriseId: entity.currentEnterpriseId,
      );

  Map<String, dynamic> toCreateJson() => {
        'userId': userId,
        'fullName': fullName,
        'major': major,
        'graduationYear': graduationYear,
        'enrollmentYear': enrollmentYear,
        'skills': skills,
        'currentEnterpriseId': currentEnterpriseId,
      };

  Map<String, dynamic> toUpdateJson() => {
        'fullName': fullName,
        'major': major,
        'graduationYear': graduationYear,
        'enrollmentYear': enrollmentYear,
        'skills': skills,
        'currentEnterpriseId': currentEnterpriseId,
      };
}
