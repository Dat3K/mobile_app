import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/services/logger_service.dart';
import '../providers/csrf_provider.dart';
import 'http_client_interface.dart';
import 'interceptors/csrf_interceptor.dart';

/// Dio instance provider
final dioProvider = Provider<Dio>((ref) => Dio());

/// Dio Client provider
final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  final logger = ref.watch(loggerServiceProvider);
  final csrfRepo = ref.watch(csrfRepositoryProvider);
  return DioClient(dio, logger: logger, csrfRepo: csrfRepo);
});

class DioClient implements IHttpClient {
  final Dio dio;
  final LoggerService _logger;
  final CsrfRepository _csrfRepo;

  DioClient(
    this.dio, {
    required LoggerService logger,
    required CsrfRepository csrfRepo,
  })  : _logger = logger,
        _csrfRepo = csrfRepo {
    _initDio();
  }

  Future<void> _initDio() async {
    dio.options.baseUrl = AppConstants.apiBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.validateStatus = (status) => status! < 500;

    // Thêm debug logging interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('Request URL: ${options.uri}');
          _logger.d('Request Headers: ${options.headers}');
          _logger.d('Request Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d('Response Status: ${response.statusCode}');
          _logger.d('Response Headers: ${response.headers}');
          _logger.d('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          _logger.e('Error: ${error.message}');
          _logger.e('Error Response: ${error.response}');
          return handler.next(error);
        },
      ),
    );

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
        logPrint: (obj) => _logger.d(obj.toString()),
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
