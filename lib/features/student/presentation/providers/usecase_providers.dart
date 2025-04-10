import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/create_student_usecase.dart';
import '../../domain/usecases/delete_student_usecase.dart';
import '../../domain/usecases/get_all_students_usecase.dart';
import '../../domain/usecases/get_student_by_user_id_usecase.dart';
import '../../domain/usecases/get_student_usecase.dart';
import '../../domain/usecases/get_students_usecase.dart';
import '../../domain/usecases/update_student_usecase.dart';
import 'repository_providers.dart';

part 'usecase_providers.g.dart';

/// Provider for GetStudentUseCase
@riverpod
GetStudentUseCase getStudentUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetStudentUseCase(repository);
}

/// Provider for GetStudentByUserIdUseCase
@riverpod
GetStudentByUserIdUseCase getStudentByUserIdUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetStudentByUserIdUseCase(repository);
}

/// Provider for GetAllStudentsUseCase
@riverpod
GetAllStudentsUseCase getAllStudentsUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetAllStudentsUseCase(repository);
}

/// Provider for CreateStudentUseCase
@riverpod
CreateStudentUseCase createStudentUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return CreateStudentUseCase(repository);
}

/// Provider for UpdateStudentUseCase
@riverpod
UpdateStudentUseCase updateStudentUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return UpdateStudentUseCase(repository);
}

/// Provider for DeleteStudentUseCase
@riverpod
DeleteStudentUseCase deleteStudentUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return DeleteStudentUseCase(repository);
}

/// Provider for GetStudentsUseCase
@riverpod
GetStudentsUseCase getStudentsUseCase(Ref ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return GetStudentsUseCase(repository);
}
