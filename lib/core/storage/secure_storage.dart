import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'secure_storage.g.dart';

/// Provider cho FlutterSecureStorage instance
@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

/// Provider cho SecureStorageService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerServiceProvider);
  return SecureStorageService(
    storage: storage,
    logger: logger,
  );
}

/// Service để quản lý storage bảo mật
class SecureStorageService {
  final FlutterSecureStorage _storage;
  final LoggerService _logger;

  SecureStorageService({
    required FlutterSecureStorage storage,
    required LoggerService logger,
  })  : _storage = storage,
        _logger = logger;

  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      _logger.d('Read from secure storage: $key');
      return value;
    } catch (e, stackTrace) {
      _logger.e('Error reading from secure storage', e, stackTrace);
      return null;
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      _logger.d('Written to secure storage: $key');
    } catch (e, stackTrace) {
      _logger.e('Error writing to secure storage', e, stackTrace);
      rethrow;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
      _logger.d('Deleted from secure storage: $key');
    } catch (e, stackTrace) {
      _logger.e('Error deleting from secure storage', e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteSecurityTokens() async {
    try {
      final allData = await readAll();
      final securityKeys = allData.keys.where((key) => 
        key.startsWith(StorageKeys.cookiePrefix) || 
        key == StorageKeys.csrfTokenKey
      );
      
      await Future.wait([
        for (final key in securityKeys)
          delete(key),
      ]);
      
      _logger.i('All security tokens (cookies and CSRF) deleted from secure storage');
    } catch (e, stackTrace) {
      _logger.e('Error deleting security tokens from secure storage', e, stackTrace);
      rethrow;
    }
  }


  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      _logger.i('All secure storage data deleted');
    } catch (e, stackTrace) {
      _logger.e('Error deleting all secure storage data', e, stackTrace);
      rethrow;
    }
  }

  Future<Map<String, String>> readAll() async {
    try {
      final data = await _storage.readAll();
      _logger.d('Read all secure storage data: ${data.length} items');
      return data;
    } catch (e, stackTrace) {
      _logger.e('Error reading all secure storage data', e, stackTrace);
      return {};
    }
  }
}

/// Extension cho debug
extension SecureStorageServiceDebugX on SecureStorageService {
  /// In ra trạng thái của secure storage
  Future<void> debugPrintStorageStatus() async {
    try {
      _logger.w('🧹 Checking secure storage status...');
      
      final allData = await readAll();
      final totalItems = allData.length;
      
      final buffer = StringBuffer();
      buffer.writeln('\n📦 Secure Storage Status:');
      buffer.writeln('Total items: $totalItems');
      
      if (totalItems > 0) {
        buffer.writeln('\nKeys stored:');
        for (final key in allData.keys) {
          buffer.writeln('  - $key');
        }
      } else {
        buffer.writeln('No items stored');
      }
      
      buffer.writeln('\n✨ Secure storage status check completed');
      
      // In tất cả thông tin một lần
      _logger.i(buffer.toString());
    } catch (e, stackTrace) {
      _logger.e('Failed to check secure storage status', e, stackTrace);
      rethrow;
    }
  }
} 