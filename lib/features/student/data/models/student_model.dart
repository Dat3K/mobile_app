import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/student.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

@freezed
class StudentModel with _$StudentModel {
  const factory StudentModel({
    required String id,
    required String name,
    required String email,
    required String grade,
    required DateTime createdAt,
  }) = _StudentModel;

  const StudentModel._();

  // API serialization
  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  // Convert from domain entity
  factory StudentModel.fromEntity(Student student) => StudentModel(
        id: student.id,
        name: student.name,
        email: student.email,
        grade: student.grade,
        createdAt: student.createdAt,
      );

  // Convert to domain entity
  Student toEntity() => Student(
        id: id,
        name: name,
        email: email,
        grade: grade,
        createdAt: createdAt,
      );

  // API specific transformations if needed
  Map<String, dynamic> toCreateJson() => {
    'name': name,
    'email': email,
    'grade': grade,
  };

  Map<String, dynamic> toUpdateJson() => {
    'name': name,
    'email': email,
    'grade': grade,
  };
}
