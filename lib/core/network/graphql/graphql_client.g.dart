// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$graphQLCacheHash() => r'd74e562d44af4b2046189ecb6f83858e4ddc06db';

/// Provider cho GraphQL cache options
///
/// Copied from [graphQLCache].
@ProviderFor(graphQLCache)
final graphQLCacheProvider = AutoDisposeProvider<GraphQLCache>.internal(
  graphQLCache,
  name: r'graphQLCacheProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$graphQLCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GraphQLCacheRef = AutoDisposeProviderRef<GraphQLCache>;
String _$graphQLPoliciesHash() => r'15e8b4acde3152b5d7d702ebccab84dbda33e594';

/// Provider cho GraphQL policies
///
/// Copied from [graphQLPolicies].
@ProviderFor(graphQLPolicies)
final graphQLPoliciesProvider = AutoDisposeProvider<DefaultPolicies>.internal(
  graphQLPolicies,
  name: r'graphQLPoliciesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$graphQLPoliciesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GraphQLPoliciesRef = AutoDisposeProviderRef<DefaultPolicies>;
String _$graphQLClientHash() => r'fb819920bb84776fe22c17a4d2bd09fdd98202a2';

/// Provider cho GraphQL client - giữ instance trong suốt vòng đời ứng dụng
///
/// Copied from [graphQLClient].
@ProviderFor(graphQLClient)
final graphQLClientProvider = Provider<GraphQLClient>.internal(
  graphQLClient,
  name: r'graphQLClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$graphQLClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GraphQLClientRef = ProviderRef<GraphQLClient>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
