import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/constants/csrf_constants.dart';
import 'package:mobile_app/core/services/cookie_service.dart';
import 'package:mobile_app/core/network/rest/dio_client.dart';
import 'package:mobile_app/core/services/csrf_token_service.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'dart:io' show Cookie;

part 'csrf_interceptor.g.dart';

/// Provider cho CSRF interceptor - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
CsrfInterceptor csrfInterceptor(Ref ref) {
  return CsrfInterceptor(
    dio: ref.watch(dioProvider),
    csrfTokenService: ref.watch(csrfTokenServiceProvider),
    cookieService: ref.watch(cookieServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
}

/// Interceptor để xử lý CSRF token trong các request
class CsrfInterceptor extends Interceptor {
  final Dio _dio;
  final CsrfTokenService _csrfTokenService;
  final CookieService _cookieService;
  final ILoggerService _logger;

  CsrfInterceptor({
    required Dio dio,
    required CsrfTokenService csrfTokenService,
    required CookieService cookieService,
    required ILoggerService logger,
  })  : _dio = dio,
        _csrfTokenService = csrfTokenService,
        _cookieService = cookieService,
        _logger = logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (_shouldSkipCsrf(options)) {
        return handler.next(options);
      }

      String? token = await _csrfTokenService.getToken();
      _logger.d('Current CSRF token: ${token ?? 'null'}');

      if (token == null) {
        _logger.d('No CSRF token found, fetching new one');
        await _fetchAndSaveToken();
        token = await _csrfTokenService.getToken();
      }

      if (token != null) {
        options.headers[CsrfConstants.csrfHeaderKey] = token;
        _logger.d('Added CSRF token to request headers');
      }

      handler.next(options);
    } catch (e, stackTrace) {
      _logger.e('Error in CSRF request interceptor', e, stackTrace);
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Lỗi khi xử lý CSRF token: $e',
        ),
      );
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (!_isInvalidCsrfResponse(response)) {
      return handler.next(response);
    }

    final retryCount = response.requestOptions.extra['csrfRetryCount'] as int? ?? 0;
    _logger.d('CSRF token invalid, retry attempt: $retryCount');

    if (retryCount >= CsrfConstants.maxRetries) {
      _logger.e('Maximum CSRF retry attempts reached');
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: 'Đã vượt quá số lần thử lại tối đa cho CSRF token',
        ),
      );
    }

    try {
      await _handleTokenRefresh(response, handler, retryCount);
    } catch (e, stackTrace) {
      _logger.e('Error refreshing CSRF token', e, stackTrace);
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: 'Lỗi khi làm mới CSRF token: $e',
        ),
      );
    }
  }

  Future<void> _handleTokenRefresh(
    Response response,
    ResponseInterceptorHandler handler,
    int retryCount,
  ) async {
    try {
      final originalRequest = response.requestOptions;
      originalRequest.extra['csrfRetryCount'] = retryCount + 1;

      await _fetchAndSaveToken();
      final newToken = await _csrfTokenService.getToken();

      if (newToken != null) {
        originalRequest.headers[CsrfConstants.csrfHeaderKey] = newToken;
        _logger.d('Retrying request with new CSRF token');
        
        final retryResponse = await _dio.fetch(originalRequest);
        handler.next(retryResponse);
      } else {
        throw Exception('Không thể lấy token mới sau khi refresh');
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to refresh token and retry request', e, stackTrace);
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: 'Lỗi khi refresh token và retry request: $e',
        ),
      );
    }
  }

  Future<void> _fetchAndSaveToken() async {
    try {
      _logger.d('Fetching new CSRF token');
      final response = await _dio.get(CsrfConstants.csrfEndpoint);
      
      if (response.data is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      final token = response.data['token'] as String?;
      if (token == null) {
        throw Exception('CSRF token not found in response');
      }

      await _csrfTokenService.saveToken(token);
      _logger.d('New CSRF token saved');

      await _handleCsrfCookie(response);
    } catch (e, stackTrace) {
      _logger.e('Error fetching new CSRF token', e, stackTrace);
      throw Exception('Không thể lấy CSRF token mới: $e');
    }
  }

  Future<void> _handleCsrfCookie(Response response) async {
    final cookies = response.headers['set-cookie'];
    if (cookies != null) {
      for (final cookieStr in cookies) {
        if (cookieStr.contains(CsrfConstants.cookieName)) {
          await _cookieService.saveCookie(
            _dio.options.baseUrl,
            Cookie.fromSetCookieValue(cookieStr),
          );
          _logger.d('CSRF cookie saved');
          break;
        }
      }
    }
  }

  bool _isInvalidCsrfResponse(Response response) {
    if (response.statusCode != 403 || response.data is! Map<String, dynamic>) {
      return false;
    }
    
    final message = response.data['message']?.toString() ?? '';
    return message.contains(CsrfConstants.invalidCsrfMessage) || 
           message.contains(CsrfConstants.invalidCookieMessage);
  }

  bool _shouldSkipCsrf(RequestOptions options) {
    return options.path.contains(CsrfConstants.csrfEndpoint) ||
           options.method.toUpperCase() == 'GET';
  }
}
