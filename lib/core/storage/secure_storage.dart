import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

/// Provider cho FlutterSecureStorage instance
@riverpod
FlutterSecureStorage secureStorage(ref) {
  return const FlutterSecureStorage();
}

/// Provider cho SecureStorageService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(ref) {
  final storage = ref.watch(secureStorageProvider);
  return SecureStorageService(storage: storage);
}

/// Service để quản lý storage bảo mật
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      return {};
    }
  }
} 