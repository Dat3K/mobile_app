import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/student/presentation/providers/student_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';

part 'student_provider.freezed.dart';
part 'student_provider.g.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState({
    @Default([]) List<StudentEntity> students,
    @Default(false) bool isLoading,
    Failure? failure,
    StudentEntity? currentStudent,
  }) = _StudentState;

  const StudentState._();

  bool get hasError => failure != null;
  bool get hasStudent => currentStudent != null;
}

@Riverpod(keepAlive: true)
class StudentNotifier extends _$StudentNotifier {
  @override
  StudentState build() {
    // Khởi tạo state mặc định
    _loadCurrentStudent();
    return const StudentState();
  }

  Future<void> _loadCurrentStudent() async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('User not authenticated'),
      );
      return;
    }

    state = state.copyWith(isLoading: true, failure: null);

    try {
      final getCurrentStudent = ref.read(getCurrentStudentUseCaseProvider);
      final result = await getCurrentStudent(user.id);

      state = result.fold(
        (failure) => state.copyWith(
          isLoading: false,
          failure: failure,
        ),
        (student) => state.copyWith(
          isLoading: false,
          currentStudent: student,
          failure: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Error loading student: ${e.toString()}'),
      );
    }
  }

  Future<void> refreshStudent() async {
    await _loadCurrentStudent();
  }
}

@riverpod
StudentEntity? getCurrentStudent(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.currentStudent));
}

@riverpod
bool isStudentLoading(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.isLoading));
}

@riverpod
bool hasStudentError(Ref ref) {
  return ref.watch(studentNotifierProvider.select((state) => state.hasError));
}

@riverpod
String? studentErrorMessage(Ref ref) {
  final failure = ref.watch(studentNotifierProvider.select((state) => state.failure));
  return failure?.message;
}