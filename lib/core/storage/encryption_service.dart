import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';

final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return EncryptionService(secureStorage);
});

class EncryptionService {
  final FlutterSecureStorage _secureStorage;
  Uint8List? _cachedKey;

  EncryptionService(this._secureStorage);

  /// Generate a new encryption key
  Uint8List _generateEncryptionKey() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(StorageKeys.encryptionKeyLength, (i) => random.nextInt(256)),
    );
  }

  /// Get the encryption key, generating and storing if necessary
  Future<Uint8List> getEncryptionKey() async {
    try {
      if (_cachedKey != null) {
        return _cachedKey!;
      }

      // Try to get existing key
      final keyString = await _secureStorage.read(key: StorageKeys.encryptionKeyKey);
      if (keyString != null) {
        _cachedKey = Uint8List.fromList(keyString.split(',').map(int.parse).toList());
        return _cachedKey!;
      }

      // Generate new key if none exists
      final newKey = _generateEncryptionKey();
      await _secureStorage.write(
        key: StorageKeys.encryptionKeyKey,
        value: newKey.join(','),
      );
      _cachedKey = newKey;
      return newKey;
    } catch (e) {
      throw CacheException('Failed to get encryption key: $e');
    }
  }

  /// Clear the encryption key (use with caution)
  Future<void> clearEncryptionKey() async {
    try {
      await _secureStorage.delete(key: StorageKeys.encryptionKeyKey);
      _cachedKey = null;
    } catch (e) {
      throw CacheException('Failed to clear encryption key: $e');
    }
  }

  /// Rotate the encryption key (for security purposes)
  Future<Uint8List> rotateEncryptionKey() async {
    try {
      await clearEncryptionKey();
      return await getEncryptionKey();
    } catch (e) {
      throw CacheException('Failed to rotate encryption key: $e');
    }
  }
} 