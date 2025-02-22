import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'graphql_client.dart';

part 'base_graphql_service.g.dart';

/// Interface định nghĩa các phương thức cơ bản cho GraphQL service
abstract class IGraphQLService {
  /// Thực hiện GraphQL query
  Future<Either<Failure, T>> query<T>({
    required String query,
    Map<String, dynamic> variables,
    required T Function(Map<String, dynamic> data) fromJson,
  });

  /// Thực hiện GraphQL mutation
  Future<Either<Failure, T>> mutation<T>({
    required String mutation,
    Map<String, dynamic> variables,
    required T Function(Map<String, dynamic> data) fromJson,
  });
}

/// Base implementation của GraphQL service
abstract class BaseGraphQLService implements IGraphQLService {
  final GraphQLClient _client;

  BaseGraphQLService({
    required GraphQLClient client,
  }) : _client = client;

  @override
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
          // Thêm các options phổ biến
          fetchPolicy: FetchPolicy.networkOnly,
          errorPolicy: ErrorPolicy.all,
        ),
      );

      if (result.hasException) {
        return Left(_handleGraphQLException(result.exception));
      }

      if (result.data == null) {
        return const Left(GraphQLFailure('No data returned'));
      }

      return Right(fromJson(result.data!));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
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
          // Thêm các options phổ biến
          fetchPolicy: FetchPolicy.networkOnly,
          errorPolicy: ErrorPolicy.all,
        ),
      );

      if (result.hasException) {
        return Left(_handleGraphQLException(result.exception));
      }

      if (result.data == null) {
        return const Left(GraphQLFailure('No data returned'));
      }

      return Right(fromJson(result.data!));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  /// Xử lý GraphQL exception
  Failure _handleGraphQLException(OperationException? exception) {
    if (exception == null) {
      return const GraphQLFailure('Unknown GraphQL error');
    }

    // Xử lý các loại lỗi GraphQL cụ thể
    if (exception.linkException != null) {
      return GraphQLFailure('Network error: ${exception.linkException}');
    }

    final errors = exception.graphqlErrors;
    if (errors.isNotEmpty) {
      return GraphQLFailure(errors.map((e) => e.message).join(', '));
    }

    return GraphQLFailure(exception.toString());
  }

  /// Xử lý các lỗi khác
  Failure _handleError(Object error) {
    return GraphQLFailure(error.toString());
  }
}

/// Provider cho BaseGraphQLService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
BaseGraphQLService baseGraphQLService(ref) {
  final client = ref.watch(graphQLClientProvider);
  return _BaseGraphQLServiceImpl(client: client);
}

/// Implementation của BaseGraphQLService
class _BaseGraphQLServiceImpl extends BaseGraphQLService {
  _BaseGraphQLServiceImpl({
    required super.client,
  });
}
