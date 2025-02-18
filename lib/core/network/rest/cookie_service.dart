import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/network/rest/csrf_interceptor.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/core/storage/cookie_storage.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/security/csrf_token_service.dart';

/// Provider cho CookieService
final cookieServiceProvider = Provider<CookieService>((ref) {
  final logger = ref.watch(loggerServiceProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final csrfTokenService = ref.watch(csrfTokenServiceProvider);
  
  return CookieService(
    logger: logger,
    secureStorage: secureStorage,
    csrfTokenService: csrfTokenService,
  );
});

/// Service để quản lý cookie trong ứng dụng
class CookieService {
  final LoggerService _logger;
  final SecureStorageService _secureStorage;
  final CsrfTokenService _csrfTokenService;
  CookieManager? _cookieManager;

  CookieService({
    required LoggerService logger,
    required SecureStorageService secureStorage,
    required CsrfTokenService csrfTokenService,
  })  : _logger = logger,
        _secureStorage = secureStorage,
        _csrfTokenService = csrfTokenService;

  /// Khởi tạo cookie manager
  Future<CookieManager?> init() async {
    try {
      if (kIsWeb) {
        _logger.d('Cookie manager không được sử dụng trên web');
        return null;
      }

      final cookieJar = await _createCookieJar();
      _cookieManager = CookieManager(cookieJar);
      _logger.d('Cookie manager được khởi tạo thành công');
      return _cookieManager;
    } catch (e) {
      _logger.e('Lỗi khi khởi tạo cookie manager: $e');
      return null;
    }
  }

  /// Tạo cookie jar với SecureCookieStorage
  Future<CookieJar> _createCookieJar() async {
    final storage = SecureCookieStorage(_secureStorage);
    
    return PersistCookieJar(
      storage: storage,
      ignoreExpires: true,
      persistSession: true
    );
  }

  /// Xóa tất cả cookie
  Future<void> clearCookies() async {
    try {
      await _cookieManager?.cookieJar.deleteAll();
      _logger.d('Đã xóa tất cả cookie');
    } catch (e) {
      _logger.e('Lỗi khi xóa cookie: $e');
    }
  }

  /// Xóa tất cả dữ liệu bao gồm cookie và CSRF token
  Future<void> clearAllData() async {
    try {
      await clearCookies();
      await _csrfTokenService.deleteToken();
      _logger.d('Đã xóa tất cả cookie và CSRF token');
    } catch (e) {
      _logger.e('Lỗi khi xóa dữ liệu: $e');
      rethrow;
    }
  }

  /// Lấy danh sách cookie cho domain
  Future<List<Cookie>> getCookies(String domain) async {
    try {
      if (_cookieManager == null) {
        return [];
      }
      final cookies = await _cookieManager!.cookieJar.loadForRequest(
        Uri.parse(domain),
      );
      _logger.d('Đã lấy ${cookies.length} cookie cho domain $domain');
      return cookies;
    } catch (e) {
      _logger.e('Lỗi khi lấy cookie cho domain $domain: $e');
      return [];
    }
  }

  /// Lấy cookie manager đã được khởi tạo
  CookieManager? get cookieManager => _cookieManager;

  /// Kiểm tra xem cookie manager đã được khởi tạo chưa
  bool get isInitialized => _cookieManager != null;
} 