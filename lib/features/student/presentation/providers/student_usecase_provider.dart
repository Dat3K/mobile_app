import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/student/domain/usecases/get_students.dart';
import 'package:mobile_app/features/student/domain/usecases/get_student_by_id.dart';
import 'package:mobile_app/features/student/domain/usecases/create_student.dart';
import 'package:mobile_app/features/student/domain/usecases/update_student.dart';
import 'package:mobile_app/features/student/domain/usecases/delete_student.dart';
import 'package:mobile_app/features/student/domain/usecases/get_current_student.dart';
import 'package:mobile_app/features/student/presentation/providers/student_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_usecase_provider.g.dart';

// Provider cho các use case
@riverpod
GetStudentsUseCase getStudents(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetStudentsUseCase(repository: repository);
}

@riverpod
GetStudentByIdUseCase getStudentById(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetStudentByIdUseCase(repository: repository);
}

@riverpod
CreateStudentUseCase createStudent(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return CreateStudentUseCase(repository: repository);
}

@riverpod
UpdateStudentUseCase updateStudent(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return UpdateStudentUseCase(repository: repository);
}

@riverpod
DeleteStudentUseCase deleteStudent(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return DeleteStudentUseCase(repository: repository);
}

@riverpod
GetCurrentStudentUseCase getCurrentStudentUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetCurrentStudentUseCase(repository: repository);
}
