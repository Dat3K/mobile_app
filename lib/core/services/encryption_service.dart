import 'dart:math';
import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'encryption_service.g.dart';

/// Provider cho EncryptionService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
EncryptionService encryptionService(ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerServiceProvider);
  return EncryptionService(secureStorage: secureStorage, logger: logger);
}

/// Service để quản lý encryption key cho ứng dụng
class EncryptionService {
  final FlutterSecureStorage _secureStorage;
  final LoggerService _logger;
  Uint8List? _cachedKey;

  EncryptionService({
    required FlutterSecureStorage secureStorage,
    required LoggerService logger,
  })  : _secureStorage = secureStorage,
        _logger = logger;

  /// Generate a new encryption key
  Uint8List _generateEncryptionKey() {
    try {
      final random = Random.secure();
      final key = Uint8List.fromList(
        List<int>.generate(
            StorageKeys.encryptionKeyLength, (i) => random.nextInt(256)),
      );
      _logger.d('Generated new encryption key');
      return key;
    } catch (e) {
      _logger.e('Failed to generate encryption key', e);
      throw CacheException('Failed to generate encryption key: $e');
    }
  }

  /// Get the encryption key, generating and storing if necessary
  Future<Uint8List> getEncryptionKey() async {
    try {
      if (_cachedKey != null) {
        _logger.d('Using cached encryption key');
        return _cachedKey!;
      }

      // Try to get existing key
      final keyString =
          await _secureStorage.read(key: StorageKeys.encryptionKeyKey);
      if (keyString != null) {
        _cachedKey =
            Uint8List.fromList(keyString.split(',').map(int.parse).toList());
        _logger.d('Retrieved existing encryption key');
        return _cachedKey!;
      }

      // Generate new key if none exists
      _logger.d('No existing key found, generating new one');
      final newKey = _generateEncryptionKey();
      await _secureStorage.write(
        key: StorageKeys.encryptionKeyKey,
        value: newKey.join(','),
      );
      _cachedKey = newKey;
      _logger.i('New encryption key generated and stored');
      return newKey;
    } catch (e) {
      _logger.e('Failed to get encryption key', e);
      throw CacheException('Failed to get encryption key: $e');
    }
  }

  /// Clear the encryption key (use with caution)
  Future<void> clearEncryptionKey() async {
    try {
      await _secureStorage.delete(key: StorageKeys.encryptionKeyKey);
      _cachedKey = null;
      _logger.w('Encryption key cleared');
    } catch (e) {
      _logger.e('Failed to clear encryption key', e);
      throw CacheException('Failed to clear encryption key: $e');
    }
  }

  /// Rotate the encryption key (for security purposes)
  Future<Uint8List> rotateEncryptionKey() async {
    try {
      _logger.i('Starting encryption key rotation');
      await clearEncryptionKey();
      final newKey = await getEncryptionKey();
      _logger.i('Encryption key rotation completed');
      return newKey;
    } catch (e) {
      _logger.e('Failed to rotate encryption key', e);
      throw CacheException('Failed to rotate encryption key: $e');
    }
  }

  /// Kiểm tra xem key có tồn tại không
  Future<bool> hasEncryptionKey() async {
    try {
      if (_cachedKey != null) return true;
      final keyString =
          await _secureStorage.read(key: StorageKeys.encryptionKeyKey);
      return keyString != null;
    } catch (e) {
      _logger.e('Failed to check encryption key existence', e);
      return false;
    }
  }
}
