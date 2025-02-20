import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/core/network/rest/csrf_interceptor.dart';
import 'package:mobile_app/core/network/rest/cookie_service.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'http_client_interface.dart';
import 'package:flutter/foundation.dart';

/// Provider cho cache options
final cacheOptionsProvider = Provider<CacheOptions>((ref) {
  return CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: [401, 403],
    maxStale: const Duration(days: 1),
    priority: CachePriority.normal,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );
});

/// Provider cho Dio client
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  // Thêm các interceptors
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // Thêm retry interceptor
  dio.interceptors.add(RetryInterceptor(
    dio: dio,
    logPrint: (message) => debugPrint(message),
    retries: 3,
    retryDelays: const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
  ));

  // Thêm cache interceptor
  dio.interceptors.add(DioCacheInterceptor(
    options: ref.read(cacheOptionsProvider),
  ));

  return dio;
});

// Provider cho DioClient
final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  final logger = ref.watch(loggerServiceProvider);
  final cookieService = ref.watch(cookieServiceProvider);
  final csrfInterceptor = ref.watch(csrfInterceptorProvider);
  return DioClient(
      dio: dio,
      logger: logger,
      cookieService: cookieService,
      csrfInterceptor: csrfInterceptor);
});

/// HTTP client sử dụng Dio với đầy đủ interceptor và cấu hình
class DioClient implements IRestClient {
  final Dio _dio;
  final LoggerService _logger;
  final CookieService _cookieService;
  final CsrfInterceptor _csrfInterceptor;
  final _cancelTokens = <CancelToken>[];

  DioClient({
    required Dio dio,
    required LoggerService logger,
    required CookieService cookieService,
    required CsrfInterceptor csrfInterceptor,
  })  : _dio = dio,
        _logger = logger,
        _cookieService = cookieService,
        _csrfInterceptor = csrfInterceptor {
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
    } catch (e) {
      _logger.e('Failed to initialize CSRF token: $e');
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
    final cookieManager = await _cookieService.init();
    if (cookieManager != null) {
      _dio.interceptors.add(cookieManager);
      _logger.d('Cookie manager initialized for mobile');
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
    await _cookieService.clearCookies();
  }

  /// Xử lý lỗi từ Dio Exception
  Future<Never> _handleError(DioException e) async {
    _logger.e('DioError: ${e.message}');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw TimeoutFailure(e.message ?? 'Request timeout');

      case DioExceptionType.connectionError:
        throw NetworkFailure(e.message ?? 'Network connection error');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode != null) {
          if (statusCode >= 500) {
            throw ServerFailure(e.response?.data?['message'] ?? 'Server error');
          } else if (statusCode == 401) {
            throw UnauthorizedFailure(
                e.response?.data?['message'] ?? 'Unauthorized');
          } else if (statusCode == 403) {
            throw ForbiddenFailure(
                e.response?.data?['message'] ?? 'Access forbidden');
          } else if (statusCode == 404) {
            throw NotFoundFailure(
                e.response?.data?['message'] ?? 'Resource not found');
          }
        }
        throw BadResponseFailure(e.message ?? 'Bad response');

      case DioExceptionType.cancel:
        throw CancelFailure(e.message ?? 'Request cancelled');

      case DioExceptionType.badCertificate:
        throw BadCertificateFailure(e.message ?? 'Bad certificate');

      default:
        throw ServerFailure(e.message ?? 'Unknown error occurred');
    }
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
        throw ServerFailure('Response data is null');
      }

      return response.data as T;
    } on DioException catch (e) {
      throw await _handleError(e);
    }
  }

  /// Dispose client
  void dispose() {
    cancelAllRequests('Client disposed');
    _dio.close(force: true);
  }
}
