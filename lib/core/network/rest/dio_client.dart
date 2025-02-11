import 'package:dio/dio.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/network/rest/csrf_interceptor.dart';
import 'package:mobile_app/core/network/rest/cookie_service.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:io' show Cookie;
import 'http_client_interface.dart';
import 'package:flutter/foundation.dart';

/// HTTP client sử dụng Dio với đầy đủ interceptor và cấu hình
class DioClient implements IRestClient {
  final Dio _dio;
  final LoggerService _logger;
  final SecureStorageService _storage;
  final CookieService _cookieService;
  late final CsrfInterceptor _csrfInterceptor;

  DioClient(
    this._dio, {
    required LoggerService logger,
    required SecureStorageService storage,
    required CookieService cookieService,
  })  : _logger = logger,
        _storage = storage,
        _cookieService = cookieService {
    _initDio();
  }

  Future<void> _initDio() async {
    _dio.options.baseUrl = AppConstants.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.validateStatus = (status) => status! < 500;

    // Cấu hình đặc biệt cho web
    if (kIsWeb) {
      _configureForWeb();
    } else {
      await _configureForMobile();
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

    // Lấy cookies
    final cookies = await _cookieService.getCookies(AppConstants.apiBaseUrl);
    _logger.d('Cookies: $cookies');
  }

  /// Cấu hình cho web platform
  void _configureForWeb() {
    _dio.options.extra = {
      'withCredentials': true,
    };
    
    _dio.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Credentials': 'true',
    });

    _logger.d('Web CORS configuration enabled');
  }

  /// Cấu hình cho mobile platform
  Future<void> _configureForMobile() async {
    final cookieManager = await _cookieService.init();
    if (cookieManager != null) {
      _dio.interceptors.add(cookieManager);
      _logger.d('Cookie manager initialized for mobile');
    }
  }

  /// Xóa tất cả cookies
  Future<void> clearCookies() async {
    await _cookieService.clearCookies();
  }

  /// Lấy danh sách cookies cho domain
  Future<List<Cookie>> getCookies(String domain) async {
    return _cookieService.getCookies(domain);
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
