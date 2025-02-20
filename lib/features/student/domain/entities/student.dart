import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.student)
class Student with _$Student {
  const factory Student({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
    @HiveField(3) required String grade,
    @HiveField(4) required DateTime createdAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  const Student._();

  // Validation methods
  bool get isValid => 
    id.isNotEmpty && 
    name.isNotEmpty && 
    email.contains('@') &&
    grade.isNotEmpty;

  bool get canUpdate =>
    name.isNotEmpty && 
    email.contains('@') &&
    grade.isNotEmpty;

  // Business logic methods
  bool isInGrade(String targetGrade) => grade == targetGrade;
  bool isCreatedAfter(DateTime date) => createdAt.isAfter(date);
  bool isCreatedBefore(DateTime date) => createdAt.isBefore(date);
} 