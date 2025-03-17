// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCurrentStudentHash() => r'6a4e803252dd954568d41fe61d13ec30ff346944';

/// See also [getCurrentStudent].
@ProviderFor(getCurrentStudent)
final getCurrentStudentProvider = AutoDisposeProvider<StudentEntity?>.internal(
  getCurrentStudent,
  name: r'getCurrentStudentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentStudentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCurrentStudentRef = AutoDisposeProviderRef<StudentEntity?>;
String _$isStudentLoadingHash() => r'5b0511b74e7f88f6e09f149d59810a8a413769ec';

/// See also [isStudentLoading].
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
String _$hasStudentErrorHash() => r'6e8d801530cbd3409277451e5e01ec632cf24df1';

/// See also [hasStudentError].
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
String _$studentErrorMessageHash() =>
    r'3680e78a8b112031c74ffba808bde50224c20d65';

/// See also [studentErrorMessage].
@ProviderFor(studentErrorMessage)
final studentErrorMessageProvider = AutoDisposeProvider<String?>.internal(
  studentErrorMessage,
  name: r'studentErrorMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentErrorMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StudentErrorMessageRef = AutoDisposeProviderRef<String?>;
String _$studentNotifierHash() => r'b14ad4dc2295c2e26656c6c3ebbb28d2268a7698';

/// See also [StudentNotifier].
@ProviderFor(StudentNotifier)
final studentNotifierProvider =
    NotifierProvider<StudentNotifier, StudentState>.internal(
  StudentNotifier.new,
  name: r'studentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StudentNotifier = Notifier<StudentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
