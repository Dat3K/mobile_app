import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/student/data/repositories/student_repository_impl.dart';
import 'package:mobile_app/features/student/domain/usecases/get_students.dart';
import 'package:mobile_app/features/student/domain/usecases/get_student_by_id.dart';
import 'package:mobile_app/features/student/domain/usecases/create_student.dart';
import 'package:mobile_app/features/student/domain/usecases/update_student.dart';
import 'package:mobile_app/features/student/domain/usecases/delete_student.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecase_provider.g.dart';

// Provider cho các use case
@riverpod
GetStudents getStudents(Ref ref) {
  return GetStudents(repository: ref.watch(studentRepositoryProvider));
}

@riverpod
GetStudentById getStudentById(Ref ref) {
  return GetStudentById(repository: ref.watch(studentRepositoryProvider));
}

@riverpod
CreateStudent createStudent(Ref ref) {
  return CreateStudent(repository: ref.watch(studentRepositoryProvider));
}

@riverpod
UpdateStudent updateStudent(Ref ref) {
  return UpdateStudent(repository: ref.watch(studentRepositoryProvider));
}

@riverpod
DeleteStudent deleteStudent(Ref ref) {
  return DeleteStudent(repository: ref.watch(studentRepositoryProvider));
}
