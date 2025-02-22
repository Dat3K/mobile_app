import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Provider cho CsrfTokenService
part 'csrf_token_service.g.dart';

@Riverpod(keepAlive: true)
CsrfTokenService csrfTokenService(ref) {
  return CsrfTokenService(
    storage: ref.watch(secureStorageServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
}

/// Service để quản lý CSRF token
class CsrfTokenService{
  final SecureStorageService _storage;
  final LoggerService _logger;

  CsrfTokenService({
    required SecureStorageService storage,
    required LoggerService logger,
  })  : _storage = storage,
        _logger = logger;

  Future<String?> getToken() async {
    try {
      final token = await _storage.read(StorageKeys.csrfTokenKey);
      _logger.d('Đã lấy CSRF token${token != null ? "" : " (null)"}');
      return token;
    } catch (e) {
      _logger.e('Lỗi khi lấy CSRF token: $e');
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await _storage.write(StorageKeys.csrfTokenKey, token);
      _logger.d('Đã lưu CSRF token mới');
    } catch (e) {
      _logger.e('Lỗi khi lưu CSRF token: $e');
      rethrow;
    }
  }

  Future<void> deleteToken() async {
    try {
      await _storage.delete(StorageKeys.csrfTokenKey);
      _logger.d('Đã xóa CSRF token');
    } catch (e) {
      _logger.e('Lỗi khi xóa CSRF token: $e');
      rethrow;
    }
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
} 