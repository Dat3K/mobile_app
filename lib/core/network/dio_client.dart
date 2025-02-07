import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_constants.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/services/logger_service.dart';
import '../constants/csrf_constants.dart';
import '../providers/csrf_provider.dart';
import 'http_client_interface.dart';

/// Dio instance provider
final dioProvider = Provider<Dio>((ref) => Dio());

/// Dio Client provider
final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  final logger = ref.watch(loggerServiceProvider);
  return DioClient(dio, logger: logger, ref: ref);
});

class DioClient implements IHttpClient {
  final Dio dio;
  final LoggerService _logger;
  final Ref _ref;

  DioClient(this.dio, {required LoggerService logger, required Ref ref})
      : _logger = logger,
        _ref = ref {
    dio.options.baseUrl = AppConstants.apiBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
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
    addCsrfInterceptor(_ref);
  }

  void addCsrfInterceptor(Ref ref) {
    final csrfRepo = ref.read(csrfRepositoryProvider);
    csrfRepo.getCsrfToken().then((token) {
      if (token != null) {
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              if (_shouldAttachCsrfToken(options.method)) {
                options.headers[CsrfConstants.csrfTokenHeader] = token;
              }
              return handler.next(options);
            },
          ),
        );
      } else {
        _refreshCsrfToken(csrfRepo).then((newToken) {
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) async {
                options.headers[CsrfConstants.csrfTokenHeader] = newToken;
                return handler.next(options);
              },
            ),
          );
        });
      }
    });
  }

  Future<String> _refreshCsrfToken(CsrfRepository csrfRepo) async {
    try {
      final response = await dio.get(
        '/csrf-token',
      );

      final newToken = response.data['token'] as String;
      await csrfRepo.setCsrfToken(newToken);
      return newToken;
    } on DioException catch (e) {
      _logger.e('Failed to refresh CSRF token: ${e.message}');
      throw ServerFailure(e.message.toString());
    }
  }

  bool _shouldAttachCsrfToken(String method) {
    return method.toUpperCase() == 'POST' ||
        method.toUpperCase() == 'PUT' ||
        method.toUpperCase() == 'PATCH' ||
        method.toUpperCase() == 'DELETE';
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
