// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentErrorHash() => r'8ad661ba5bd735ce8140310580cfd4f6b4740f23';

/// Provider to expose the current error
///
/// Copied from [currentError].
@ProviderFor(currentError)
final currentErrorProvider = AutoDisposeProvider<Failure?>.internal(
  currentError,
  name: r'currentErrorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentErrorRef = AutoDisposeProviderRef<Failure?>;
String _$hasErrorHash() => r'c4a3ea756891d85e9a0d1dd4f0aabedc1ec315bf';

/// Provider to check if there's an active error
///
/// Copied from [hasError].
@ProviderFor(hasError)
final hasErrorProvider = AutoDisposeProvider<bool>.internal(
  hasError,
  name: r'hasErrorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hasErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasErrorRef = AutoDisposeProviderRef<bool>;
String _$errorHandlerHash() => r'7390aa2db288f3560d9a063049b1f7a42d8b02e0';

/// Global error handler notifier to manage errors across the app
///
/// Copied from [ErrorHandler].
@ProviderFor(ErrorHandler)
final errorHandlerProvider =
    AutoDisposeNotifierProvider<ErrorHandler, ErrorHandlerState>.internal(
  ErrorHandler.new,
  name: r'errorHandlerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$errorHandlerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ErrorHandler = AutoDisposeNotifier<ErrorHandlerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
