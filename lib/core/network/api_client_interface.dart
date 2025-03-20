import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';

/// Interface chung cho các API client (REST và GraphQL)
abstract class IApiClient {
  /// Thực hiện GET request (REST) hoặc query (GraphQL)
  Future<Either<Failure, T>> fetch<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  });

  /// Thực hiện POST request (REST) hoặc mutation (GraphQL)
  Future<Either<Failure, T>> send<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  });

  /// Thực hiện PUT request (REST)
  Future<Either<Failure, T>> update<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  });

  /// Thực hiện DELETE request (REST)
  Future<Either<Failure, T>> remove<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic> data) fromJson,
  });

  /// Xóa tất cả các request đang chạy
  void cancelRequests();

  /// Xóa cache
  Future<void> clearCache();
}