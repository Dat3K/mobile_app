// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_checker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityServiceHash() =>
    r'9f186c77a642b819ec14f52ae01837976263ed6d';

/// Provider for the ConnectivityService
///
/// Copied from [connectivityService].
@ProviderFor(connectivityService)
final connectivityServiceProvider =
    AutoDisposeProvider<ConnectivityService>.internal(
  connectivityService,
  name: r'connectivityServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectivityServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityServiceRef = AutoDisposeProviderRef<ConnectivityService>;
String _$isConnectedHash() => r'd7aa49725e9634f657eec4764eaf21537afb3c5d';

/// Provider to check if the device is currently connected to the internet
///
/// Copied from [isConnected].
@ProviderFor(isConnected)
final isConnectedProvider = AutoDisposeProvider<bool>.internal(
  isConnected,
  name: r'isConnectedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isConnectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsConnectedRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
