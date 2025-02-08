import 'package:dio/dio.dart';
import 'package:mobile_app/core/constants/csrf_constants.dart';
import 'package:mobile_app/core/providers/csrf_provider.dart';
import 'package:mobile_app/core/services/logger_service.dart';

class CsrfInterceptor extends Interceptor {
  final CsrfRepository _csrfRepo;
  final Dio _dio;
  final LoggerService _logger;
  String? _csrfToken;
  bool _isRefreshing = false;
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(milliseconds: 500);

  CsrfInterceptor(this._csrfRepo, this._dio, this._logger);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_shouldAttachCsrfToken(options.method)) {
      return handler.next(options);
    }

    try {
      final token = await _getCsrfToken();
      options.headers[CsrfConstants.csrfTokenHeader] = token;
      _logger.d('CSRF token attached to ${options.path}');

      // Thêm CSRF token vào body nếu là POST, PUT, DELETE
      if (['POST', 'PUT', 'DELETE'].contains(options.method.toUpperCase())) {
        if (options.data is Map) {
          final Map<String, dynamic> data =
              Map<String, dynamic>.from(options.data);
          data['_csrf'] = token;
          options.data = data;
        } else if (options.data is FormData) {
          options.data.fields.add(MapEntry('_csrf', token));
        } else {
          options.data ??= {'_csrf': token};
        }

        _logger.d('Added CSRF token to request body: ${options.data}');
      }

      return handler.next(options);
    } catch (e) {
      _logger.e('Failed to get CSRF token: $e');
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to get CSRF token: $e',
        ),
      );
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Kiểm tra và cập nhật CSRF token từ response header nếu có
    final newToken = response.headers.value('X-CSRF-Token');
    if (newToken != null) {
      _csrfRepo.setCsrfToken(newToken);
      _logger.d('Updated CSRF token from response');
    }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 &&
        err.response?.data['message']?.toString().contains('CSRF') == true) {
      _logger.w('CSRF token rejected, attempting refresh and retry');

      try {
        final token = await _refreshToken();
        final retryResponse =
            await _retryRequestWithBackoff(err.requestOptions, token);
        _logger.i('Request retry successful after CSRF refresh');
        return handler.resolve(retryResponse);
      } catch (e) {
        _logger.e('Failed to retry request after CSRF refresh: $e');
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }

  Future<String> _getCsrfToken() async {
    if (_csrfToken != null) {
      // Kiểm tra token từ repository để đảm bảo tính nhất quán
      final storedToken = await _csrfRepo.getCsrfToken();
      if (storedToken != null && storedToken == _csrfToken) {
        return _csrfToken!;
      }
    }

    if (_isRefreshing) {
      _logger.d('Waiting for CSRF token refresh to complete');
      int attempts = 0;
      while (_isRefreshing && attempts < 30) {
        // Timeout sau 3 giây
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }
      if (_csrfToken != null) return _csrfToken!;
      throw Exception('CSRF token refresh timeout');
    }

    return _refreshToken();
  }

  Future<String> _refreshToken() async {
    _isRefreshing = true;
    try {
      _logger.i('Refreshing CSRF token');
      final response = await _dio.get(
        '/csrf-token',
        options: Options(
          headers: {CsrfConstants.csrfTokenHeader: null},
          // Không retry cho request lấy token để tránh vòng lặp vô tận
          extra: {'noRetry': true},
        ),
      );

      if (response.data == null || response.data['token'] == null) {
        throw Exception('Invalid CSRF token response format');
      }

      _csrfToken = response.data['token'] as String;
      await _csrfRepo.setCsrfToken(_csrfToken!);
      _logger.d('CSRF token refreshed successfully');
      return _csrfToken!;
    } catch (e) {
      _logger.e('Failed to refresh CSRF token: $e');
      throw Exception('Failed to refresh CSRF token: $e');
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retryRequestWithBackoff(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    int attempts = 0;
    DioException? lastError;

    while (attempts < _maxRetries) {
      try {
        final response = await _retryRequest(requestOptions, newToken);
        return response;
      } catch (e) {
        lastError = e as DioException;
        attempts++;
        if (attempts < _maxRetries) {
          _logger
              .w('Retry attempt $attempts failed, waiting before next attempt');
          await Future.delayed(_retryDelay * attempts);
        }
      }
    }

    throw lastError ??
        DioException(
          requestOptions: requestOptions,
          error: 'Max retry attempts reached',
        );
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String newToken,
  ) {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        CsrfConstants.csrfTokenHeader: newToken,
      },
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  bool _shouldAttachCsrfToken(String method) {
    return method != 'GET' && method != 'HEAD' && method != 'OPTIONS';
  }
}
