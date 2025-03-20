import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/network/api_client_interface.dart';
import 'package:mobile_app/core/network/rest/rest_service.dart';
import 'package:mobile_app/core/network/rest/rest_service_interface.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'rest_client_adapter.g.dart';

/// Provider cho RestClientAdapter - giữ instance trong suốt vòng đời ứng dụng
@riverpod
RestClientAdapter restClientAdapter(Ref ref) {
  final restService = ref.watch(dioServiceProvider);
  final logger = ref.watch(loggerServiceProvider);
  return RestClientAdapter(client: restService, logger: logger);
}

/// Class adapter để kết nối IRestClient với IApiClient interface
class RestClientAdapter implements IApiClient {
  final IRestService _restService;
  final LoggerService _logger;

  RestClientAdapter({
    required IRestService client,
    required LoggerService logger,
  })  : _restService = client,
        _logger = logger;

  @override
  Future<Either<Failure, T>> fetch<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      final response = await _restService.get(
        endpoint,
        queryParameters: params,
      );
      
      if (response is Map<String, dynamic>) {
        return Right(fromJson(response));
      }
      
      // Nếu response không phải Map<String, dynamic>, cần convert
      if (response is List) {
        return Right(fromJson({'data': response}));
      }
      
      return Left(ServerFailure('Invalid response format'));
    } catch (error) {
      _logger.e('RestClientAdapter fetch error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(ServerFailure(error.toString()));
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
      final response = await _restService.post(
        endpoint,
        data: data,
        queryParameters: params,
      );
      
      if (response is Map<String, dynamic>) {
        return Right(fromJson(response));
      }
      
      // Nếu response không phải Map<String, dynamic>, cần convert
      if (response is List) {
        return Right(fromJson({'data': response}));
      }
      
      return Left(ServerFailure('Invalid response format'));
    } catch (error) {
      _logger.e('RestClientAdapter send error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(ServerFailure(error.toString()));
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
      final response = await _restService.put(
        endpoint,
        data: data,
        queryParameters: params,
      );
      
      if (response is Map<String, dynamic>) {
        return Right(fromJson(response));
      }
      
      // Nếu response không phải Map<String, dynamic>, cần convert
      if (response is List) {
        return Right(fromJson({'data': response}));
      }
      
      return Left(ServerFailure('Invalid response format'));
    } catch (error) {
      _logger.e('RestClientAdapter update error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, T>> remove<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      final response = await _restService.delete(
        endpoint,
        queryParameters: params,
      );
      
      if (response is Map<String, dynamic>) {
        return Right(fromJson(response));
      }
      
      // Nếu response không phải Map<String, dynamic>, cần convert
      if (response is List) {
        return Right(fromJson({'data': response}));
      }
      
      return Left(ServerFailure('Invalid response format'));
    } catch (error) {
      _logger.e('RestClientAdapter remove error: $error');
      if (error is Failure) {
        return Left(error);
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  void cancelRequests() {
    if (_restService is DioService) {
      _restService.cancelAllRequests();
    }
  }

  @override
  Future<void> clearCache() async {
    if (_restService is DioService) {
      await _restService.clearCookies();
    }
  }
} 