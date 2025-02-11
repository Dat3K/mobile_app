import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CsrfInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;
  static const String _csrfTokenKey = 'XSRF-TOKEN';
  static const String _csrfHeaderKey = 'X-XSRF-TOKEN';

  CsrfInterceptor(this._dio, this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: _csrfTokenKey);
    if (token != null) {
      options.headers[_csrfHeaderKey] = token;
    }
    handler.next(options);
  }

  Future<void> fetchCsrfToken() async {
    try {
      final response = await _dio.get('/csrf-token');
      
      // Lấy token từ body response
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      final String? csrfToken = data['token'] as String?;
      
      if (csrfToken != null) {
        await _storage.write(key: _csrfTokenKey, value: csrfToken);
      } else {
        throw Exception('CSRF token not found in response');
      }
    } catch (e) {
      // Xử lý lỗi khi không thể lấy CSRF token
      rethrow;
    }
  }
} 