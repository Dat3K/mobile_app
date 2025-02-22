import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/network/rest/dio_client.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'graphql_client.g.dart';

/// Provider cho GraphQL cache options
@riverpod
GraphQLCache graphQLCache(ref) {
  return GraphQLCache(
    store: HiveStore(),
    partialDataPolicy: PartialDataCachePolicy.accept,
  );
}

/// Provider cho GraphQL policies
@riverpod
DefaultPolicies graphQLPolicies(ref) {
  return DefaultPolicies(
    query: Policies(
      fetch: FetchPolicy.networkOnly,
    ),
    mutate: Policies(
      fetch: FetchPolicy.networkOnly,
    ),
    subscribe: Policies(
      fetch: FetchPolicy.networkOnly,
    ),
  );
}

/// Provider cho GraphQL client - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
GraphQLClient graphQLClient(ref) {
  final dio = ref.watch(dioProvider);
  final logger = ref.watch(loggerServiceProvider);
  final cache = ref.watch(graphQLCacheProvider);
  final policies = ref.watch(graphQLPoliciesProvider);

  // Create DioLink with custom configuration
  final dioLink = DioLink(
    AppConstants.graphqlEndpoint,
    client: dio,
    defaultHeaders: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  // Create error link for error handling
  final errorLink = ErrorLink(
    onGraphQLError: (request, forward, response) {
      logger.e(
        'GraphQL Errors [${request.operation.operationName}]: ${response.errors}',
      );
      return Stream.value(response);
    },
    onException: (request, forward, exception) {
      logger.e(
        'Network Exception [${request.operation.operationName}]',
      );
      return Stream.error(exception);
    },
  );

  // Add logging link with detailed information
  final loggingLink = Link.function((request, [forward]) async* {
    final operationName = request.operation.operationName ?? 'Unnamed Operation';

    logger.i('GraphQL Request: $operationName');
    logger.d('Variables: ${request.variables}');
    
    final stopwatch = Stopwatch()..start();
    final stream = forward!(request);
    
    await for (final response in stream) {
      stopwatch.stop();
      logger.i('GraphQL Response [$operationName] - ${stopwatch.elapsedMilliseconds}ms');
      
      if (response.data != null) {
        logger.d('Data: ${response.data}');
      }
      
      yield response;
    }
  });

  // Add auth link if needed
  // final authLink = AuthLink(
  //   getToken: () => 'Bearer ${ref.read(authTokenProvider)}',
  // );

  // Combine links in proper order
  final link = Link.from([
    errorLink,
    loggingLink,
    // authLink, // Uncomment when auth is needed
    dioLink,
  ]);

  // Create and return GraphQLClient with optimized configuration
  return GraphQLClient(
    cache: cache,
    link: link,
    defaultPolicies: policies,
  );
} 