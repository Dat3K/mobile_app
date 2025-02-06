import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CsrfInterceptor extends Interceptor {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  static const String _csrfTokenKey = 'csrf_token';
  static const String _csrfHeaderKey = 'X-CSRF-TOKEN';

  CsrfInterceptor({
    required Dio dio,
    FlutterSecureStorage? storage,
  })  : _dio = dio,
        _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Không cần CSRF token cho các request GET
    if (options.method == 'GET') {
      return handler.next(options);
    }

    try {
      // Lấy CSRF token từ storage
      String? csrfToken = await _storage.read(key: _csrfTokenKey);

      // Nếu không có token, refresh token mới
      csrfToken ??= await refreshCsrfToken();

      // Thêm CSRF token vào header
      options.headers[_csrfHeaderKey] = csrfToken;
      return handler.next(options);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to get CSRF token: $e',
        ),
      );
    }
  }

  /// Lấy CSRF token mới từ server
  Future<String> refreshCsrfToken() async {
    try {
      final response = await _dio.get('/csrf-token');
      
      // Lấy token từ cookie
      String? csrfToken = _extractCsrfTokenFromCookie(response);
      
      if (csrfToken == null) {
        throw Exception('CSRF token not found in response');
      }

      // Lưu token vào storage
      await _storage.write(key: _csrfTokenKey, value: csrfToken);
      return csrfToken;
    } catch (e) {
      throw Exception('Failed to refresh CSRF token: $e');
    }
  }

  /// Xóa CSRF token hiện tại
  Future<void> clearCsrfToken() async {
    await _storage.delete(key: _csrfTokenKey);
  }

  /// Trích xuất CSRF token từ cookie trong response
  String? _extractCsrfTokenFromCookie(Response response) {
    final cookies = response.headers['set-cookie'];
    if (cookies == null) return null;

    for (final cookie in cookies) {
      if (cookie.contains('XSRF-TOKEN=')) {
        final token = cookie.split('XSRF-TOKEN=')[1].split(';')[0];
        return Uri.decodeComponent(token);
      }
    }
    return null;
  }
}
