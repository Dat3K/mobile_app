// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentStudentHash() => r'1a1c38886ff9e5ba714634f854153dba918cdd1d';

/// Provider to expose the current student
///
/// Copied from [currentStudent].
@ProviderFor(currentStudent)
final currentStudentProvider = AutoDisposeProvider<StudentEntity?>.internal(
  currentStudent,
  name: r'currentStudentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentStudentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentStudentRef = AutoDisposeProviderRef<StudentEntity?>;
String _$allStudentsHash() => r'bef024da2229d88e9977b359af55535a0eb3fd10';

/// Provider to expose all students
///
/// Copied from [allStudents].
@ProviderFor(allStudents)
final allStudentsProvider = AutoDisposeProvider<List<StudentEntity>>.internal(
  allStudents,
  name: r'allStudentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allStudentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllStudentsRef = AutoDisposeProviderRef<List<StudentEntity>>;
String _$hasStudentErrorHash() => r'6e8d801530cbd3409277451e5e01ec632cf24df1';

/// Provider to check if there's an active error
///
/// Copied from [hasStudentError].
@ProviderFor(hasStudentError)
final hasStudentErrorProvider = AutoDisposeProvider<bool>.internal(
  hasStudentError,
  name: r'hasStudentErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasStudentErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasStudentErrorRef = AutoDisposeProviderRef<bool>;
String _$isStudentLoadingHash() => r'5b0511b74e7f88f6e09f149d59810a8a413769ec';

/// Provider to check if there's a loading state
///
/// Copied from [isStudentLoading].
@ProviderFor(isStudentLoading)
final isStudentLoadingProvider = AutoDisposeProvider<bool>.internal(
  isStudentLoading,
  name: r'isStudentLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isStudentLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsStudentLoadingRef = AutoDisposeProviderRef<bool>;
String _$studentNotifierHash() => r'd9b4fa84b69c4d5b5cebe4ed8d4639bf76be20a9';

/// Student notifier to manage student state
///
/// Copied from [StudentNotifier].
@ProviderFor(StudentNotifier)
final studentNotifierProvider =
    AutoDisposeNotifierProvider<StudentNotifier, StudentState>.internal(
  StudentNotifier.new,
  name: r'studentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StudentNotifier = AutoDisposeNotifier<StudentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
