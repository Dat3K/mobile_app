import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import 'http_client_interface.dart';
import 'http_error.dart';
import 'csrf_interceptor.dart';

class DioClient implements IHttpClient {
  late final Dio _dio;
  late final CsrfInterceptor _csrfInterceptor;
  
  DioClient() {
    _dio = Dio(_baseOptions);
    _csrfInterceptor = CsrfInterceptor(dio: _dio);
    _addInterceptors();
  }

  /// Base options cho Dio client
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 500,
      );

  /// Thêm interceptors cho logging và authentication
  void _addInterceptors() {
    // CSRF interceptor
    _dio.interceptors.add(_csrfInterceptor);

    // Auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: Implement auth token logic
        return handler.next(options);
      },
      onError: (error, handler) async {
        // TODO: Implement refresh token logic
        if (error.response?.statusCode == 401) {
          // Implement token refresh logic here
        }
        return handler.next(error);
      },
    ));

    // Logging interceptor (chỉ trong debug mode)
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ));
    }
  }

  /// Xử lý response và errors
  Future<T> _handleResponse<T>(Future<Response> Function() request) async {
    try {
      final response = await request();
      return _processResponse<T>(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      throw HttpError(
        message: 'Unexpected error occurred: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Xử lý response
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

    throw HttpError.fromResponse(response);
  }

  /// Xử lý Dio errors
  HttpError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return HttpError.timeout();
      case DioExceptionType.connectionError:
        return HttpError.network('Connection error occurred');
      case DioExceptionType.badResponse:
        return HttpError.fromResponse(error.response, error.stackTrace);
      default:
        return HttpError(
          message: error.message ?? 'Unknown error occurred',
          stackTrace: error.stackTrace,
        );
    }
  }

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _handleResponse(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  @override
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _handleResponse(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  @override
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _handleResponse(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  @override
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _handleResponse(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  @override
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _handleResponse(() => _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// Xóa CSRF token
  Future<void> clearCsrfToken() async {
    await _csrfInterceptor.clearCsrfToken();
  }

  /// Refresh CSRF token
  Future<String> refreshCsrfToken() async {
    return await _csrfInterceptor.refreshCsrfToken();
  }
}
