import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'dart:async';

class ApiClient {
  late Dio _dio;
  final int _maxRetries = 3;
  final Duration _retryDelay = const Duration(seconds: 2);

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      receiveDataWhenStatusError: true,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     final session = Hive.box('authBox').get('session');
    //     if (session != null) {
    //       options.headers['Authorization'] = 'Bearer ${session['access_token']}';
    //     }
    //     return handler.next(options);
    //   },
    // ));

    _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true, error: true));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return _retry(() => _dio.get(path, queryParameters: queryParameters));
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _retry(() => _dio.post(path, data: data));
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _retry(() => _dio.put(path, data: data));
  }

  Future<Response> delete(String path) async {
    return _retry(() => _dio.delete(path));
  }

  Future<Response> _retry(Future<Response> Function() request) async {
    int retryCount = 0;
    while (true) {
      try {
        return await request();
      } on DioException catch (e) {
        if (retryCount >= _maxRetries || !_shouldRetry(e)) {
          throw _handleError(e);
        }
        retryCount++;
        await Future.delayed(_retryDelay * retryCount);
      }
    }
  }

  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.badResponse;
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerException('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return RequestCancelledException('Request cancelled');
      default:
        return NetworkException('Network error: ${e.message}');
    }
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}