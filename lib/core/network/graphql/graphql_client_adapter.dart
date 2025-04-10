import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/network/api_client_interface.dart';
import 'package:mobile_app/core/network/graphql/base_graphql_service.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'graphql_client_adapter.g.dart';

/// Provider cho GraphQLClientAdapter - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
GraphQLClientAdapter graphQLClientAdapter(Ref ref) {
  final graphQLService = ref.watch(baseGraphQLServiceProvider);
  final logger = ref.watch(loggerServiceProvider);
  return GraphQLClientAdapter(service: graphQLService, logger: logger);
}

/// Class adapter để kết nối GraphQL service với IApiClient interface
class GraphQLClientAdapter implements IApiClient {
  final IGraphQLService _graphQLService;
  final LoggerService _logger;

  GraphQLClientAdapter({
    required IGraphQLService service,
    required LoggerService logger,
  })  : _graphQLService = service,
        _logger = logger;

  @override
  Future<Either<Failure, T>> fetch<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      return await _graphQLService.query<T>(
        query: endpoint,
        variables: params ?? {},
        fromJson: fromJson,
      );
    } catch (error) {
      _logger.e('GraphQLClientAdapter fetch error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(GraphQLFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, T>> send<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      // Combine data and params for GraphQL variables
      final variables = <String, dynamic>{};

      if (params != null) {
        variables.addAll(params);
      }

      if (data is Map<String, dynamic>) {
        variables.addAll(data);
      } else if (data != null) {
        variables['input'] = data;
      }

      return await _graphQLService.mutation<T>(
        mutation: endpoint,
        variables: variables,
        fromJson: fromJson,
      );
    } catch (error) {
      _logger.e('GraphQLClientAdapter send error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(GraphQLFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, T>> update<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      // GraphQL không phân biệt giữa send và update, cả hai đều là mutation
      // nên chỉ cần forward tới send
      return await send<T>(
        endpoint: endpoint,
        data: data,
        params: params,
        fromJson: fromJson,
      );
    } catch (error) {
      _logger.e('GraphQLClientAdapter update error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(GraphQLFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, T>> remove<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      // GraphQL không phân biệt các HTTP methods
      // remove cũng là một mutation
      return await send<T>(
        endpoint: endpoint,
        params: params,
        fromJson: fromJson,
      );
    } catch (error) {
      _logger.e('GraphQLClientAdapter remove error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(GraphQLFailure(error.toString()));
    }
  }

  @override
  void cancelRequests() {
    _logger.d('Cancel requests không được hỗ trợ trong GraphQL client');
  }

  @override
  Future<void> clearCache() async {
    _logger.d('Clear cache chưa được hỗ trợ trong GraphQL client');
  }
}