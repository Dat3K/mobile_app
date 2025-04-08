import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/error/dio_exceptions.dart';
import 'package:mobile_app/core/error/error_handler.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/network/rest/csrf_interceptor.dart';
import 'package:mobile_app/core/network/rest/dio_client.dart';
import 'package:mobile_app/core/network/rest/rest_service_interface.dart';
import 'package:mobile_app/core/services/cookie_service.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rest_service.g.dart';

/// Provider cho DioClient - giữ instance trong suốt vòng đời ứng dụng
@riverpod
DioService dioService(Ref ref) {
  final dio = ref.watch(dioProvider);
  final logger = ref.watch(loggerServiceProvider);
  final cookieService = ref.watch(cookieServiceProvider);
  final csrfInterceptor = ref.watch(csrfInterceptorProvider);
  final errorHandler = ref.watch(errorHandlerProvider.notifier);

  return DioService(
    dio: dio,
    logger: logger,
    cookieService: cookieService,
    csrfInterceptor: csrfInterceptor,
    errorHandler: errorHandler,
  );
}

/// HTTP client sử dụng Dio với đầy đủ interceptor và cấu hình
class DioService implements IRestService {
  final Dio _dio;
  final LoggerService _logger;
  final CookieService _cookieService;
  final CsrfInterceptor _csrfInterceptor;
  final ErrorHandler _errorHandler;
  final _cancelTokens = <CancelToken>[];

  DioService({
    required Dio dio,
    required LoggerService logger,
    required CookieService cookieService,
    required CsrfInterceptor csrfInterceptor,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _logger = logger,
        _cookieService = cookieService,
        _csrfInterceptor = csrfInterceptor,
        _errorHandler = errorHandler {
    _initDio();
  }

  Future<void> _initDio() async {
    // Cấu hình đặc biệt cho web
    if (kIsWeb) {
      _configureForWeb();
    } else {
      await _configureForMobile();
    }

    // Thêm CSRF interceptor
    _dio.interceptors.add(_csrfInterceptor);

    // Khởi tạo CSRF token
    try {
      _logger.d('CSRF token initialized successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to initialize CSRF token', e, stackTrace);
      _errorHandler.handleException(e, stackTrace);
    }
  }

  /// Cấu hình cho web platform
  void _configureForWeb() {
    _dio.options.extra = {
      'withCredentials': true,
    };

    _dio.options.headers.addAll({
      'Access-Control-Allow-Credentials': 'true',
    });

    _logger.d('Web CORS configuration enabled');
  }

  /// Cấu hình cho mobile platform
  Future<void> _configureForMobile() async {
    try {
      final cookieManager = await _cookieService.init();
      if (cookieManager != null) {
        _dio.interceptors.add(cookieManager);
        _logger.d('Cookie manager initialized for mobile');
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to initialize cookie manager', e, stackTrace);
      _errorHandler.handleException(e, stackTrace);
    }
  }

  /// Hủy tất cả các request đang chạy
  void cancelAllRequests([String? reason]) {
    for (var token in _cancelTokens) {
      if (!token.isCancelled) {
        token.cancel(reason);
      }
    }
    _cancelTokens.clear();
  }

  /// Xóa tất cả cookies
  Future<void> clearCookies() async {
    try {
      await _cookieService.clearCookies();
    } catch (e, stackTrace) {
      _logger.e('Failed to clear cookies', e, stackTrace);
      _errorHandler.handleException(e, stackTrace);
    }
  }

  /// Xử lý lỗi từ Dio Exception
  Future<Never> _handleError(DioException e, StackTrace stackTrace) async {
    _logger.e('DioError: ${e.message}', e, stackTrace);

    // Sử dụng DioExceptionHandler để chuyển đổi exception thành Failure
    final failure = DioExceptionHandler.handleDioException(e);

    // Báo lỗi cho ErrorHandler toàn cục
    _errorHandler.handleError(failure, stackTrace: stackTrace);
    
    throw failure;
  }

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool forceRefresh = false,
  }) async {
    try {
      final cancelToken = CancelToken();
      _cancelTokens.add(cancelToken);

      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: forceRefresh
              ? {
                  'dio_cache_interceptor_force_refresh': true,
                }
              : null,
        ),
        cancelToken: cancelToken,
      );

      _cancelTokens.remove(cancelToken);

      if (response.data == null) {
        final nullResponseFailure = DioExceptionHandler.handleNullResponse();
        _errorHandler.handleError(nullResponseFailure);
        throw nullResponseFailure;
      }

      return response.data as T;
    } on DioException catch (e, stackTrace) {
      throw await _handleError(e, stackTrace);
    } catch (e, stackTrace) {
      // Xử lý các lỗi khác không phải từ Dio
      _logger.e('Non-Dio error during GET request to $path', e, stackTrace);
      final nonDioFailure = DioExceptionHandler.handleNonDioError(e);
      _errorHandler.handleException(e, stackTrace);
      throw nonDioFailure;
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
      final cancelToken = CancelToken();
      _cancelTokens.add(cancelToken);

      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      _cancelTokens.remove(cancelToken);

      if (response.data == null) {
        final nullResponseFailure = DioExceptionHandler.handleNullResponse();
        _errorHandler.handleError(nullResponseFailure);
        throw nullResponseFailure;
      }

      return response.data as T;
    } on DioException catch (e, stackTrace) {
      throw await _handleError(e, stackTrace);
    } catch (e, stackTrace) {
      _logger.e('Non-Dio error during POST request to $path', e, stackTrace);
      final nonDioFailure = DioExceptionHandler.handleNonDioError(e);
      _errorHandler.handleException(e, stackTrace);
      throw nonDioFailure;
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
      final cancelToken = CancelToken();
      _cancelTokens.add(cancelToken);

      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      _cancelTokens.remove(cancelToken);

      if (response.data == null) {
        final nullResponseFailure = DioExceptionHandler.handleNullResponse();
        _errorHandler.handleError(nullResponseFailure);
        throw nullResponseFailure;
      }

      return response.data as T;
    } on DioException catch (e, stackTrace) {
      throw await _handleError(e, stackTrace);
    } catch (e, stackTrace) {
      _logger.e('Non-Dio error during PUT request to $path', e, stackTrace);
      final nonDioFailure = DioExceptionHandler.handleNonDioError(e);
      _errorHandler.handleException(e, stackTrace);
      throw nonDioFailure;
    }
  }

  @override
  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final cancelToken = CancelToken();
      _cancelTokens.add(cancelToken);

      final response = await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      _cancelTokens.remove(cancelToken);

      if (response.data == null) {
        final nullResponseFailure = DioExceptionHandler.handleNullResponse();
        _errorHandler.handleError(nullResponseFailure);
        throw nullResponseFailure;
      }

      return response.data as T;
    } on DioException catch (e, stackTrace) {
      throw await _handleError(e, stackTrace);
    } catch (e, stackTrace) {
      _logger.e('Non-Dio error during DELETE request to $path', e, stackTrace);
      final nonDioFailure = DioExceptionHandler.handleNonDioError(e);
      _errorHandler.handleException(e, stackTrace);
      throw nonDioFailure;
    }
  }

  /// Dispose client
  void dispose() {
    cancelAllRequests('Client disposed');
    _dio.close(force: true);
  }
}
