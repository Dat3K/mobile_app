import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/data/repositories/student_repository_impl.dart';
import 'package:mobile_app/features/student/domain/entities/student.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

part 'student_provider.freezed.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState({
    @Default([]) List<Student> students,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = _StudentState;
}

final studentStateProvider =
    StateNotifierProvider<StudentNotifier, StudentState>((ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return StudentNotifier(repository);
});

class StudentNotifier extends StateNotifier<StudentState> {
  final IStudentRepository _repository;

  StudentNotifier(this._repository) : super(const StudentState());

  Future<void> getStudents() async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _repository.getStudents();

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (students) => state.copyWith(students: students, isLoading: false),
    );
  }

  Future<void> getStudentById(String id) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _repository.getStudentById(id);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (student) => state.copyWith(
        students: [...state.students, student],
        isLoading: false,
      ),
    );
  }

  Future<void> createStudent(Student student) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _repository.createStudent(student);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (newStudent) => state.copyWith(
        students: [...state.students, newStudent],
        isLoading: false,
      ),
    );
  }

  Future<void> updateStudent(Student student) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _repository.updateStudent(student);

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

    final result = await _repository.deleteStudent(id);

    state = result.fold(
      (failure) => state.copyWith(failure: failure, isLoading: false),
      (_) => state.copyWith(
        students: state.students.where((s) => s.id != id).toList(),
        isLoading: false,
      ),
    );
  }
}
