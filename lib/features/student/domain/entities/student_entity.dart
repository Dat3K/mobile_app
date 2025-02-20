import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_entity.freezed.dart';

@freezed
class StudentEntity with _$StudentEntity {
  const factory StudentEntity({
    required String id,
    required String userId,
    required String fullName,
    required String major,
    required int graduationYear,
    required int enrollmentYear,
    required List<String> skills,
    String? currentEnterpriseId,
  }) = _StudentEntity;

  const StudentEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    userId.isNotEmpty &&
    fullName.isNotEmpty &&
    major.isNotEmpty &&
    graduationYear > enrollmentYear &&
    enrollmentYear > 2000;

  // Business logic methods
  bool get isGraduated => DateTime.now().year >= graduationYear;
  bool get isCurrentlyEmployed => currentEnterpriseId != null;
  int get yearsOfStudy => graduationYear - enrollmentYear;
  bool hasSkill(String skill) => skills.contains(skill.toLowerCase());
  bool get canApplyForInternship => !isGraduated && !isCurrentlyEmployed;
  bool get canUpdate => id.isNotEmpty && userId.isNotEmpty;
} 