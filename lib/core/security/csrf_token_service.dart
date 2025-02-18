import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';

/// Service để quản lý CSRF token
class CsrfTokenService {
  static const String _tokenKey = 'csrf_token';
  final SecureStorageService _storage;
  final LoggerService _logger;

  CsrfTokenService({
    required SecureStorageService storage,
    required LoggerService logger,
  })  : _storage = storage,
        _logger = logger;

  /// Lấy CSRF token hiện tại
  Future<String?> getToken() async {
    try {
      final token = await _storage.read(_tokenKey);
      _logger.d('Đã lấy CSRF token${token != null ? "" : " (null)"}');
      return token;
    } catch (e) {
      _logger.e('Lỗi khi lấy CSRF token: $e');
      return null;
    }
  }

  /// Lưu CSRF token mới
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(_tokenKey, token);
      _logger.d('Đã lưu CSRF token mới');
    } catch (e) {
      _logger.e('Lỗi khi lưu CSRF token: $e');
      rethrow;
    }
  }

  /// Xóa CSRF token
  Future<void> deleteToken() async {
    try {
      await _storage.delete(_tokenKey);
      _logger.d('Đã xóa CSRF token');
    } catch (e) {
      _logger.e('Lỗi khi xóa CSRF token: $e');
      rethrow;
    }
  }

  /// Kiểm tra xem có CSRF token hay không
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
} 