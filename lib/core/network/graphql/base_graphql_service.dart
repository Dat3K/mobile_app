import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'graphql_client.dart';

abstract class BaseGraphQLService {
  final GraphQLClient _client;

  BaseGraphQLService(this._client);

  Future<Either<Failure, T>> query<T>({
    required String query,
    Map<String, dynamic> variables = const {},
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(query),
          variables: variables,
        ),
      );

      if (result.hasException) {
        return Left(GraphQLFailure(result.exception.toString()));
      }

      return Right(fromJson(result.data!));
    } catch (e) {
      return Left(GraphQLFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> mutation<T>({
    required String mutation,
    Map<String, dynamic> variables = const {},
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(mutation),
          variables: variables,
        ),
      );

      if (result.hasException) {
        return Left(GraphQLFailure(result.exception.toString()));
      }

      return Right(fromJson(result.data!));
    } catch (e) {
      return Left(GraphQLFailure(e.toString()));
    }
  }
}

// Provider for BaseGraphQLService
final baseGraphQLServiceProvider = Provider<BaseGraphQLService>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return _BaseGraphQLServiceImpl(client);
});

class _BaseGraphQLServiceImpl extends BaseGraphQLService {
  _BaseGraphQLServiceImpl(GraphQLClient client) : super(client);
} 