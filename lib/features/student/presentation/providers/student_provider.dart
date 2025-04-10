import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/models/pagination/paging_model.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/student_filter_model.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/usecases/get_students_usecase.dart';
import '../../domain/usecases/create_student_usecase.dart';
import '../../domain/usecases/delete_student_usecase.dart';
import '../../domain/usecases/get_student_by_user_id_usecase.dart';
import '../../domain/usecases/get_student_usecase.dart';
import '../../domain/usecases/update_student_usecase.dart';
import 'usecase_providers.dart';

part 'student_provider.freezed.dart';
part 'student_provider.g.dart';

/// Student state
@freezed
class StudentState with _$StudentState {
  const factory StudentState({
    StudentEntity? currentStudent,
    @Default([]) List<StudentEntity> students,
    @Default(false) bool isLoading,
    Failure? failure,
    PaginatedResult<StudentEntity>? paginatedStudents,
    @Default(1) int currentPage,
    @Default(10) int pageSize,
    @Default(false) bool hasMorePages,
  }) = _StudentState;

  const StudentState._();

  bool get hasError => failure != null;
  bool get hasPaginatedStudents => paginatedStudents != null;
}

/// Student notifier to manage student state
@riverpod
class StudentNotifier extends _$StudentNotifier {
  late final LoggerService _logger;

  @override
  StudentState build() {
    _logger = ref.read(loggerServiceProvider);
    return const StudentState();
  }

  /// Get a student by ID
  Future<void> getStudent(String id) async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      final getStudentUseCase = ref.read(getStudentUseCaseProvider);
      final result = await getStudentUseCase(GetStudentParams(id: id));

      state = result.fold(
        (failure) {
          _logger.e('Failed to get student: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (student) {
          _logger.i('Successfully got student: ${student.id}');
          return state.copyWith(
            isLoading: false,
            currentStudent: student,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error getting student', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error getting student: ${e.toString()}'),
      );
    }
  }

  /// Get a student by user ID
  Future<void> getStudentByUserId(String userId) async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      final getStudentByUserIdUseCase = ref.read(getStudentByUserIdUseCaseProvider);
      final result = await getStudentByUserIdUseCase(GetStudentByUserIdParams(userId: userId));

      state = result.fold(
        (failure) {
          _logger.e('Failed to get student by user ID: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (student) {
          _logger.i('Successfully got student by user ID: ${student.id}');
          return state.copyWith(
            isLoading: false,
            currentStudent: student,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error getting student by user ID', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error getting student by user ID: ${e.toString()}'),
      );
    }
  }

  /// Get all students
  Future<void> getAllStudents() async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      final getAllStudentsUseCase = ref.read(getAllStudentsUseCaseProvider);
      final result = await getAllStudentsUseCase(NoParams());

      state = result.fold(
        (failure) {
          _logger.e('Failed to get all students: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (students) {
          _logger.i('Successfully got all students: ${students.length} students');
          return state.copyWith(
            isLoading: false,
            students: students,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error getting all students', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error getting all students: ${e.toString()}'),
      );
    }
  }

  /// Get students with pagination and filtering
  Future<void> getStudents({
    StudentFilterModel? filter,
    int page = 1,
    int pageSize = 10,
    bool resetList = false,
  }) async {
    if (resetList) {
      state = state.copyWith(
        isLoading: true,
        failure: null,
        paginatedStudents: null,
        currentPage: 1,
      );
    } else {
      state = state.copyWith(isLoading: true, failure: null);
    }

    try {
      final getStudentsUseCase = ref.read(getStudentsUseCaseProvider);
      final paging = PagingModel(index: page, take: pageSize);

      final result = await getStudentsUseCase(GetStudentsParams(
        filter: filter,
        paging: paging,
      ));

      state = result.fold(
        (failure) {
          _logger.e('Failed to get paginated students: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (paginatedResult) {
          _logger.i('Successfully got paginated students: ${paginatedResult.items.length} students');

          // If we're loading the first page or resetting, replace the list
          // Otherwise, append to the existing list
          List<StudentEntity> updatedStudents;
          if (resetList || page == 1) {
            updatedStudents = paginatedResult.items;
          } else {
            updatedStudents = List<StudentEntity>.from(state.students);
            updatedStudents.addAll(paginatedResult.items);
          }

          return state.copyWith(
            isLoading: false,
            students: updatedStudents,
            paginatedStudents: paginatedResult,
            currentPage: paginatedResult.currentPage,
            pageSize: paginatedResult.pageSize,
            hasMorePages: paginatedResult.hasNext,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error getting paginated students', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error getting paginated students: ${e.toString()}'),
      );
    }
  }

  /// Load the next page of students
  Future<void> loadMoreStudents({
    StudentFilterModel? filter,
  }) async {
    if (state.isLoading || !state.hasMorePages) return;

    final nextPage = state.currentPage + 1;
    await getStudents(
      filter: filter,
      page: nextPage,
      pageSize: state.pageSize,
      resetList: false,
    );
  }

  /// Create a new student
  Future<void> createStudent(StudentEntity student) async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      final createStudentUseCase = ref.read(createStudentUseCaseProvider);
      final result = await createStudentUseCase(CreateStudentParams(student: student));

      state = result.fold(
        (failure) {
          _logger.e('Failed to create student: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (createdStudent) {
          _logger.i('Successfully created student: ${createdStudent.id}');

          // Add the new student to the list
          final updatedStudents = List<StudentEntity>.from(state.students)
            ..add(createdStudent);

          return state.copyWith(
            isLoading: false,
            currentStudent: createdStudent,
            students: updatedStudents,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error creating student', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error creating student: ${e.toString()}'),
      );
    }
  }

  /// Update an existing student
  Future<void> updateStudent(StudentEntity student) async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      final updateStudentUseCase = ref.read(updateStudentUseCaseProvider);
      final result = await updateStudentUseCase(UpdateStudentParams(student: student));

      state = result.fold(
        (failure) {
          _logger.e('Failed to update student: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (updatedStudent) {
          _logger.i('Successfully updated student: ${updatedStudent.id}');

          // Update the student in the list
          final updatedStudents = state.students.map((s) {
            return s.id == updatedStudent.id ? updatedStudent : s;
          }).toList();

          return state.copyWith(
            isLoading: false,
            currentStudent: updatedStudent,
            students: updatedStudents,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error updating student', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error updating student: ${e.toString()}'),
      );
    }
  }

  /// Delete a student
  Future<void> deleteStudent(String id) async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      final deleteStudentUseCase = ref.read(deleteStudentUseCaseProvider);
      final result = await deleteStudentUseCase(DeleteStudentParams(id: id));

      state = result.fold(
        (failure) {
          _logger.e('Failed to delete student: ${failure.message}');
          return state.copyWith(
            isLoading: false,
            failure: failure,
          );
        },
        (_) {
          _logger.i('Successfully deleted student: $id');

          // Remove the student from the list
          final updatedStudents = state.students.where((s) => s.id != id).toList();

          // Clear current student if it was the deleted one
          final currentStudent = state.currentStudent?.id == id
              ? null
              : state.currentStudent;

          return state.copyWith(
            isLoading: false,
            currentStudent: currentStudent,
            students: updatedStudents,
            failure: null,
          );
        },
      );
    } catch (e) {
      _logger.e('Error deleting student', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error deleting student: ${e.toString()}'),
      );
    }
  }

  /// Clear the current error
  void clearError() {
    state = state.copyWith(failure: null);
  }
}

/// Provider to expose the current student
@riverpod
StudentEntity? currentStudent(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.currentStudent));
}

/// Provider to expose all students
@riverpod
List<StudentEntity> allStudents(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.students));
}

/// Provider to check if there's an active error
@riverpod
bool hasStudentError(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.hasError));
}

/// Provider to check if there's a loading state
@riverpod
bool isStudentLoading(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.isLoading));
}
