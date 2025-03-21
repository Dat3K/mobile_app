import 'package:cookie_jar/cookie_jar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'secure_storage.dart';

part 'cookie_storage.g.dart';

/// Provider cho SecureCookieStorage - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
SecureCookieStorage secureCookieStorage(Ref ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return SecureCookieStorage(storage: secureStorage);
}

class SecureCookieStorage implements Storage {
  final SecureStorageService _storage;

  SecureCookieStorage({
    required SecureStorageService storage,
  }) : _storage = storage;

  @override
  Future<void> delete(String key) async {
    await _storage.delete(StorageKeys.cookiePrefix + key);
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    for (final key in keys) {
      await delete(key);
    }
  }

  @override
  Future<void> init(bool persistSession, bool ignoreExpires) async {}

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(StorageKeys.cookiePrefix + key, value);
  }

  @override
  Future<String?> read(String key) async {
    return await _storage.read(StorageKeys.cookiePrefix + key);
  }

  /// Đọc tất cả cookie được lưu trữ
  Future<Map<String, String>> readAll() async {
    final allData = await _storage.readAll();
    return Map.fromEntries(
      allData.entries.where((e) => e.key.startsWith(StorageKeys.cookiePrefix)).map(
            (e) => MapEntry(
              e.key.substring(StorageKeys.cookiePrefix.length),
              e.value,
            ),
          ),
    );
  }
}
