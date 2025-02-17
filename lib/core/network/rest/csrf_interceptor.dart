import 'package:dio/dio.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';

/// Interceptor để xử lý CSRF token trong các request
/// 
/// Tự động lấy và thêm CSRF token vào header của mỗi request.
/// Token được lưu trữ an toàn trong SecureStorage.
class CsrfInterceptor extends Interceptor {
  /// Storage service để lưu trữ token
  final SecureStorageService _storage;
  
  /// Dio client để gọi API lấy token
  final Dio _dio;

  /// Key để lưu CSRF token trong storage
  static const String _csrfTokenKey = 'XSRF-TOKEN';
  
  /// Key của header chứa CSRF token
  static const String _csrfHeaderKey = 'X-XSRF-TOKEN';
  
  /// Endpoint để lấy CSRF token
  static const String _csrfEndpoint = '/csrf-token';

  /// Error message khi CSRF token không hợp lệ
  static const String _invalidCsrfMessage = 'Invalid_CsrfToken';

  /// Số lần thử lại tối đa khi gặp lỗi CSRF
  static const int _maxRetries = 1;

  /// Constructor
  CsrfInterceptor(this._dio, this._storage);

  /// Khởi tạo CSRF token nếu chưa có trong storage
  /// 
  /// Kiểm tra token trong storage, nếu chưa có sẽ gọi API để lấy token mới
  Future<void> initCsrfToken() async {
    final token = await _readToken();
    if (token == null) {
      await _fetchAndSaveToken();
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String? token = await _readToken();
      
      // Nếu chưa có token và không phải là request lấy token
      if (token == null && !_isCsrfRequest(options.path)) {
        await _fetchAndSaveToken();
        token = await _readToken();
      }

      // Thêm token vào header và body nếu có
      if (token != null) {
        _addTokenToHeader(options, token);
        // Chỉ thêm vào body nếu không phải là GET request
        if (options.method != 'GET') {
          _addTokenToBody(options, token);
        }
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
        final newToken = await _readToken();
        
        if (newToken != null) {
          // Cập nhật token trong request
          _addTokenToHeader(originalRequest, newToken);
          if (originalRequest.method != 'GET') {
            _addTokenToBody(originalRequest, newToken);
          }
          
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

  /// Đọc token từ storage
  Future<String?> _readToken() async {
    return _storage.read(_csrfTokenKey);
  }

  /// Thêm token vào header của request
  void _addTokenToHeader(RequestOptions options, String token) {
    options.headers[_csrfHeaderKey] = token;
  }

  /// Thêm token vào body của request
  void _addTokenToBody(RequestOptions options, String token) {
    if (options.data is Map) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(options.data);
      data['_csrf'] = token;
      options.data = data;
    } else if (options.data == null) {
      options.data = {'_csrf': token};
    }
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
      await _saveToken(token);
    } catch (e) {
      rethrow;
    }
  }

  /// Trích xuất token từ response data
  String _extractTokenFromResponse(dynamic responseData) {
    if (responseData is! String) {
      throw Exception('Invalid response format: expected string');
    }
    return responseData;
  }

  /// Lưu token vào storage
  Future<void> _saveToken(String token) async {
    await _storage.write(_csrfTokenKey, token);
  }

  /// Kiểm tra xem response có phải là lỗi Invalid CSRF Token không
  bool _isInvalidCsrfResponse(Response response) {
    try {
      final data = response.data;
      return response.statusCode == 403 && 
             data is Map<String, dynamic> && 
             data['message']?.toString().contains(_invalidCsrfMessage) == true;
    } catch (e) {
      return false;
    }
  }
} 