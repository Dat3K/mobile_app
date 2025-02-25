import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/core/storage/cookie_storage.dart';

part 'cookie_service.g.dart';

/// Provider cho CookieService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
CookieService cookieService(Ref ref) {
  return CookieService(
    logger: ref.watch(loggerServiceProvider),
    secureCookieStorage: ref.watch(secureCookieStorageProvider),
  );
}

/// Service để quản lý cookie trong ứng dụng
class CookieService {
  final LoggerService _logger;
  final SecureCookieStorage _secureCookieStorage;
  CookieManager? _cookieManager;
  PersistCookieJar? _cookieJar;

  CookieService({
    required LoggerService logger,
    required SecureCookieStorage secureCookieStorage,
  })  : _logger = logger,
        _secureCookieStorage = secureCookieStorage;

  /// Khởi tạo cookie manager
  Future<CookieManager?> init() async {
    try {
      if (kIsWeb) return null;

      _cookieJar = PersistCookieJar(
        storage: _secureCookieStorage,
        ignoreExpires: true,
        persistSession: true
      );
      
      _cookieManager = CookieManager(_cookieJar!);
      return _cookieManager;
    } catch (e) {
      _logger.e('Lỗi khi khởi tạo cookie manager: $e');
      return null;
    }
  }

  /// Xóa tất cả cookie
  Future<void> clearCookies() async {
    try {
      await _cookieJar?.deleteAll();
    } catch (e) {
      _logger.e('Lỗi khi xóa cookie: $e');
      rethrow;
    }
  }

  /// Lưu cookie cho domain
  Future<void> saveCookie(String domain, Cookie cookie) async {
    try {
      if (_cookieJar == null) {
        throw Exception('Cookie jar chưa được khởi tạo');
      }
      await _cookieJar!.saveFromResponse(
        Uri.parse(domain),
        [cookie],
      );
    } catch (e) {
      _logger.e('Lỗi khi lưu cookie cho domain $domain: $e');
      rethrow;
    }
  }

  /// Lấy cookie manager đã được khởi tạo
  CookieManager? get cookieManager => _cookieManager;
} 