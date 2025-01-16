import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import 'dart:async';

/// A custom exception class for handling API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message';
}

/// API Client for handling HTTP requests
/// Uses Dio for making HTTP requests and handles errors consistently
class ApiClient {
  late final Dio _dio;
  
  /// Creates an instance of ApiClient with default configuration
  ApiClient() {
    _dio = Dio(_baseOptions);
    _addInterceptors();
  }

  /// Base options for Dio client
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) => status != null && status < 500,
      );

  /// Adds interceptors for logging and auth token
  void _addInterceptors() {
    // Auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        // final token = await _getAuthToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Handle 401 errors and token refresh
        if (error.response?.statusCode == 401) {
          // Implement token refresh logic here
          // if (await _refreshToken()) {
          //   return handler.resolve(await _retry(error.requestOptions));
          // }
        }
        return handler.next(error);
      },
    ));

    // Logging interceptor only in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ));
    }
  }

  /// Handles API response and errors consistently
  Future<T> _handleResponse<T>(Future<Response> Function() request) async {
    try {
      final response = await request();
      return _processResponse<T>(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(message: 'Unexpected error occurred: $e');
    }
  }

  /// Processes the API response
  T _processResponse<T>(Response response) {
    if (response.statusCode == 204 || response.data == null) {
      return {} as T;
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data is T) {
        return response.data;
      }
      return response.data as T;
    }

    throw ApiException(
      message: response.statusMessage ?? 'Request failed',
      statusCode: response.statusCode,
      data: response.data,
    );
  }

  /// Handles Dio specific errors
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          message: error.response?.statusMessage ?? 'Server error occurred',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request was cancelled');
      default:
        return ApiException(
          message: 'Network error occurred. Please check your connection.',
          statusCode: error.response?.statusCode,
        );
    }
  }

  /// Makes a GET request to the specified endpoint
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleResponse(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// Makes a POST request to the specified endpoint
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleResponse(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// Makes a PUT request to the specified endpoint
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleResponse(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// Makes a DELETE request to the specified endpoint
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleResponse(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// Makes a PATCH request to the specified endpoint
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleResponse(() => _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// Disposes resources
  void dispose() {
    _dio.close(force: true);
  }
}