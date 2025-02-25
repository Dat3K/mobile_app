// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$secureStorageHash() => r'273dc403a965c1f24962aaf4d40776611a26f8b8';

/// Provider cho FlutterSecureStorage instance
///
/// Copied from [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider =
    AutoDisposeProvider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageRef = AutoDisposeProviderRef<FlutterSecureStorage>;
String _$secureStorageServiceHash() =>
    r'7cad5030f3f28e9019eb3520bf97be87371ffa79';

/// Provider cho SecureStorageService - giữ instance trong suốt vòng đời ứng dụng
///
/// Copied from [secureStorageService].
@ProviderFor(secureStorageService)
final secureStorageServiceProvider = Provider<SecureStorageService>.internal(
  secureStorageService,
  name: r'secureStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageServiceRef = ProviderRef<SecureStorageService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
