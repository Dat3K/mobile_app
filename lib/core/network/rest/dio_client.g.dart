// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cacheOptionsHash() => r'fb2ebf1a02e80097002120d0ea10336135fdebfc';

/// Provider cho cache options
///
/// Copied from [cacheOptions].
@ProviderFor(cacheOptions)
final cacheOptionsProvider = AutoDisposeProvider<CacheOptions>.internal(
  cacheOptions,
  name: r'cacheOptionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cacheOptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheOptionsRef = AutoDisposeProviderRef<CacheOptions>;
String _$dioHash() => r'6e17abc643aca57087a6ab057b08dc77d643487c';

/// Provider cho Dio client - giữ instance trong suốt vòng đời ứng dụng
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = ProviderRef<Dio>;
String _$dioClientHash() => r'54cf4ca72423b08b5633eedc718104693d599e2d';

/// Provider cho DioClient - giữ instance trong suốt vòng đời ứng dụng
///
/// Copied from [dioClient].
@ProviderFor(dioClient)
final dioClientProvider = Provider<DioClient>.internal(
  dioClient,
  name: r'dioClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioClientRef = ProviderRef<DioClient>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
