import 'package:dio/dio.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/services/logger_service.dart';
import 'package:mobile_app/core/services/secure_storage_service.dart';
import 'package:mobile_app/core/network/rest/csrf_interceptor.dart';
import 'package:mobile_app/core/network/rest/cookie_manager.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:io' show Cookie;
import 'http_client_interface.dart';
import 'package:flutter/foundation.dart';

class DioClient implements IRestClient {
  final Dio _dio;
  final LoggerService _logger;
  final SecureStorageService _storage;
  late final CsrfInterceptor _csrfInterceptor;
  CookieManager? _cookieManager;

  DioClient(
    this._dio, {
    required LoggerService logger,
    required SecureStorageService storage,
  })  : _logger = logger,
        _storage = storage {
    _initDio();
  }

  Future<void> _initDio() async {
    _dio.options.baseUrl = AppConstants.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.validateStatus = (status) => status! < 500;

    // Cấu hình đặc biệt cho web
    if (kIsWeb) {
      // Cấu hình CORS
      _dio.options.extra = {
        'withCredentials': true,
      };
      
      // Headers cho CORS và bảo mật
      _dio.options.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Credentials': 'true',
      });

      _logger.d('Web CORS configuration enabled');
    } else {
      // Khởi tạo và thêm cookie manager chỉ cho mobile
      _cookieManager = await AppCookieManager.create();
      if (_cookieManager != null) {
        _dio.interceptors.add(_cookieManager!);
        _logger.d('Cookie manager initialized for mobile');
      }
    }

    // Thêm CSRF interceptor
    _csrfInterceptor = CsrfInterceptor(_dio, _storage);
    _dio.interceptors.add(_csrfInterceptor);

    _dio.interceptors.add(
      LogInterceptor(
        error: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
      ),
    );

    // Khởi tạo CSRF token
    try {
      await _csrfInterceptor.initCsrfToken();
      _logger.d('CSRF token initialized successfully');
    } catch (e) {
      _logger.e('Failed to initialize CSRF token: $e');
    }
  }

  /// Xóa tất cả cookies
  Future<void> clearCookies() async {
    await AppCookieManager.clearCookies(_cookieManager);
    _logger.d('All cookies cleared');
  }

  /// Lấy danh sách cookies cho domain
  Future<List<Cookie>> getCookies(String domain) async {
    return AppCookieManager.getCookies(_cookieManager, domain);
  }

  Future<Response> _handleError(DioException e) async {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw TimeoutFailure(e.message.toString());
    }

    if (e.type == DioExceptionType.connectionError) {
      throw NetworkFailure(e.message.toString());
    }

    if (e.response?.statusCode != null) {
      final statusCode = e.response!.statusCode!;
      if (statusCode >= 500 && statusCode < 600) {
        throw ServerFailure(e.message.toString());
      } else if (statusCode == 401) {
        throw UnauthorizedFailure(e.message.toString());
      } else if (statusCode == 403) {
        throw ForbiddenFailure(e.message.toString());
      } else if (statusCode == 404) {
        throw NotFoundFailure(e.message.toString());
      } else {
        throw ServerFailure(e.message.toString());
      }
    }

    if (e.type == DioExceptionType.cancel) {
      throw CancelFailure(e.message.toString());
    }

    if (e.type == DioExceptionType.badResponse) {
      throw BadResponseFailure(e.message.toString());
    }

    if (e.type == DioExceptionType.badCertificate) {
      throw BadCertificateFailure(e.message.toString());
    }

    throw ServerFailure(e.message.toString());
  }

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.data == null) {
        if (T.toString() == 'void' || T.toString() == 'dynamic') {
          return null as T;
        }
        throw ServerFailure('Response data is null');
      }

      return response.data as T;
    } on DioException catch (e) {
      throw await _handleError(e);
    }
  }

  @override
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.data == null) {
        if (T.toString() == 'void' || T.toString() == 'dynamic') {
          return null as T;
        }
        throw ServerFailure('Response data is null');
      }

      return response.data as T;
    } on DioException catch (e) {
      throw await _handleError(e);
    }
  }

  @override
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.data == null) {
        if (T.toString() == 'void' || T.toString() == 'dynamic') {
          return null as T;
        }
        throw ServerFailure('Response data is null');
      }

      return response.data as T;
    } on DioException catch (e) {
      throw await _handleError(e);
    }
  }

  @override
  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data as T;
    } on DioException catch (e) {
      throw await _handleError(e);
    }
  }
}
