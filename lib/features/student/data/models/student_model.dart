import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/student_entity.dart';

part 'student_model.g.dart';
part 'student_model.freezed.dart';

// Freezed model for business logic
@freezed
class StudentModel with _$StudentModel {
  const factory StudentModel({
    required String id,
    required String userId,
    required String major,
    required int graduationYear,
    required int enrollmentYear,
    required List<String> skills,
    String? currentEnterpriseId,
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  const StudentModel._();

  StudentEntity toDomain() => StudentEntity(
        id: id,
        userId: userId,
        major: major,
        graduationYear: graduationYear,
        enrollmentYear: enrollmentYear,
        skills: skills,
        currentEnterpriseId: currentEnterpriseId,
      );

  static StudentModel fromDomain(StudentEntity entity) => StudentModel(
        id: entity.id,
        userId: entity.userId,
        major: entity.major,
        graduationYear: entity.graduationYear,
        enrollmentYear: entity.enrollmentYear,
        skills: entity.skills,
        currentEnterpriseId: entity.currentEnterpriseId ?? '',
      );

  Map<String, dynamic> toCreateJson() => {
        'userId': userId,
        'major': major,
        'graduationYear': graduationYear,
        'enrollmentYear': enrollmentYear,
        'skills': skills,
        'currentEnterpriseId': currentEnterpriseId,
  };

  Map<String, dynamic> toUpdateJson() => {
        'major': major,
        'graduationYear': graduationYear,
        'enrollmentYear': enrollmentYear,
        'skills': skills,
        'currentEnterpriseId': currentEnterpriseId,
  };
}
