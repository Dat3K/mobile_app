import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/services/logger_service.dart';
import '../providers/csrf_provider.dart';
import 'http_client_interface.dart';
import 'interceptors/csrf_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:mobile_app/core/services/cookie_service.dart';
import 'package:flutter/foundation.dart';

/// Dio instance provider
final dioProvider = Provider<Dio>((ref) => Dio());

/// Dio Client provider
final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  final logger = ref.watch(loggerServiceProvider);
  final csrfRepo = ref.watch(csrfRepositoryProvider);
  final cookieService = ref.watch(cookieServiceProvider);
  return DioClient(
    dio,
    logger: logger,
    csrfRepo: csrfRepo,
    cookieService: cookieService,
  );
});

class DioClient implements IHttpClient {
  final Dio dio;
  final LoggerService _logger;
  final CsrfRepository _csrfRepo;
  final CookieService _cookieService;

  DioClient(
    this.dio, {
    required LoggerService logger,
    required CsrfRepository csrfRepo,
    required CookieService cookieService,
  })  : _logger = logger,
        _csrfRepo = csrfRepo,
        _cookieService = cookieService {
    _initDio();
  }

  Future<void> _initDio() async {
    await _cookieService.init();
    
    dio.options.baseUrl = AppConstants.apiBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.validateStatus = (status) => status! < 500;

    // Cấu hình đặc biệt cho web
    if (kIsWeb) {
      // Cấu hình CORS
      dio.options.extra = {
        'withCredentials': true,
      };
      
      // Headers cho CORS và bảo mật
      dio.options.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Credentials': 'true',
      });

      _logger.d('Web CORS configuration enabled for anhvietnguyen.id.vn');
    } else {
      dio.interceptors.add(CookieManager(_cookieService.cookieJar));
    }

    // Thêm CSRF interceptor
    dio.interceptors.add(CsrfInterceptor(_csrfRepo, dio, _logger));

    dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
      ),
    ]);
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
      final response = await dio.get<T>(
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
      final response = await dio.post<T>(
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
      final response = await dio.put<T>(
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
      final response = await dio.delete<T>(
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
