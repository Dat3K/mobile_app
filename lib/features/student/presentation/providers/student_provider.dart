import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/student/presentation/providers/usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/data/repositories/student_repository_impl.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';
import 'package:mobile_app/features/student/domain/usecases/get_students.dart';
import 'package:mobile_app/features/student/domain/usecases/get_student_by_id.dart';
import 'package:mobile_app/features/student/domain/usecases/create_student.dart';
import 'package:mobile_app/features/student/domain/usecases/update_student.dart';
import 'package:mobile_app/features/student/domain/usecases/delete_student.dart';

part 'student_provider.freezed.dart';
part 'student_provider.g.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState({
    @Default([]) List<StudentEntity> students,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = _StudentState;
}

@Riverpod(keepAlive: true)
class StudentNotifier extends _$StudentNotifier {
  @override
  StudentState build() => const StudentState();

  // Sử dụng provider của use case
  late final GetStudents _getStudents = ref.watch(getStudentsProvider);
  late final GetStudentById _getStudentById = ref.watch(getStudentByIdProvider);
  late final CreateStudent _createStudent = ref.watch(createStudentProvider);
  late final UpdateStudent _updateStudent = ref.watch(updateStudentProvider);
  late final DeleteStudent _deleteStudent = ref.watch(deleteStudentProvider);

  Future<void> getStudents() async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _getStudents();
    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (students) => state.copyWith(students: students, isLoading: false),
    );
  }

  Future<void> getStudentById(String id) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _getStudentById(id);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (student) => state.copyWith(
        students: [...state.students, student],
        isLoading: false,
      ),
    );
  }

  Future<void> createStudent(StudentEntity student) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _createStudent(student);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (newStudent) => state.copyWith(
        students: [...state.students, newStudent],
        isLoading: false,
      ),
    );
  }

  Future<void> updateStudent(StudentEntity student) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _updateStudent(student);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (updatedStudent) => state.copyWith(
        students: state.students
            .map((s) => s.id == student.id ? updatedStudent : s)
            .toList(),
        isLoading: false,
      ),
    );
  }

  Future<void> deleteStudent(String id) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _deleteStudent(id);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (_) => state.copyWith(
        students: state.students.where((s) => s.id != id).toList(),
        isLoading: false,
      ),
    );
  }
}