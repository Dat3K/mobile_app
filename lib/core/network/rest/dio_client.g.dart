// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cacheOptionsHash() => r'1a793fe66f94ecb2c93e61c37986829ae6df2e00';

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
String _$dioHash() => r'bbcbc1ee1395ad41d48c401d393489a008b631a8';

/// Provider cho Dio client - giữ instance trong suốt vòng đời ứng dụng
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = AutoDisposeProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
