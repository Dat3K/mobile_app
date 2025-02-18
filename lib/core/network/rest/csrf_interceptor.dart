import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/network/rest/cookie_service.dart';
import 'package:mobile_app/core/security/csrf_token_service.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';


final csrfTokenServiceProvider = Provider<CsrfTokenService>((ref) {
  return CsrfTokenService(
    storage: ref.watch(secureStorageServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
});

class CsrfInterceptor extends Interceptor {
  /// Service để quản lý CSRF token
  final CsrfTokenService _csrfTokenService;

  /// Service để quản lý cookie
  final CookieService _cookieService;

  /// Dio client để gọi API lấy token
  final Dio _dio;

  /// Key của header chứa CSRF token
  static const String _csrfHeaderKey = 'X-XSRF-TOKEN';

  /// Endpoint để lấy CSRF token
  static const String _csrfEndpoint = '/csrf-token';

  /// Error message khi CSRF token không hợp lệ
  static const String _invalidCsrfMessage = 'Invalid_CsrfToken';
  static const String _invalidCookieMessage = 'Invalid_CsrfCookie';

  /// Constructor
  CsrfInterceptor(this._dio, this._csrfTokenService, this._cookieService);

  /// Khởi tạo CSRF token nếu chưa có
  Future<void> initCsrfToken() async {
    final hasToken = await _csrfTokenService.hasToken();
    if (!hasToken) {
      await _fetchAndSaveToken();
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String? token = await _csrfTokenService.getToken();

      // Nếu chưa có token và không phải là request lấy token
      if (token == null && !_isCsrfRequest(options.path)) {
        await _fetchAndSaveToken();
        token = await _csrfTokenService.getToken();
      }

      // Thêm token vào header và body nếu có
      if (token != null) {
        _addTokenToHeader(options, token);
      }

      handler.next(options);
    } catch (e) {
      // Nếu có lỗi, vẫn cho phép request tiếp tục
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (_isInvalidCsrfResponse(response)) {
      // Lấy request gốc
      final originalRequest = response.requestOptions;

      try {
        // Lấy CSRF token mới
        await _fetchAndSaveToken();
        final newToken = await _csrfTokenService.getToken();

        if (newToken != null) {
          // Cập nhật token trong request
          _addTokenToHeader(originalRequest, newToken);

          // Thử lại request với token mới
          final retryResponse = await _dio.fetch(originalRequest);
          return handler.next(retryResponse);
        }
      } catch (e) {
        // Nếu có lỗi khi lấy token mới, trả về response gốc
        return handler.next(response);
      }
    }

    return handler.next(response);
  }

  /// Thêm token vào header của request
  void _addTokenToHeader(RequestOptions options, String token) {
    options.headers[_csrfHeaderKey] = token;
  }

  /// Kiểm tra xem có phải là request lấy CSRF token không
  bool _isCsrfRequest(String path) {
    return path.contains(_csrfEndpoint);
  }

  /// Lấy và lưu CSRF token mới
  Future<void> _fetchAndSaveToken() async {
    try {
      final response = await _dio.get(_csrfEndpoint);
      final token = _extractTokenFromResponse(response.data);
      await _csrfTokenService.saveToken(token);
    } catch (e) {
      rethrow;
    }
  }

  /// Trích xuất token từ response data
  String _extractTokenFromResponse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      throw Exception('Invalid response format: expected Map with token');
    }

    final token = responseData['token'] as String?;
    if (token == null) {
      throw Exception('CSRF token not found in response');
    }

    return token;
  }

  /// Kiểm tra xem response có phải là lỗi CSRF không
  bool _isInvalidCsrfResponse(Response response) {
    try {
      if (response.statusCode != 403) return false;
      
      final data = response.data;
      if (data is! Map<String, dynamic>) return false;
      
      final message = data['message']?.toString() ?? '';
      return message.contains(_invalidCsrfMessage) || 
             message.contains(_invalidCookieMessage);
    } catch (e) {
      return false;
    }
  }
}
