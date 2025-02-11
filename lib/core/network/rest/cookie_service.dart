import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_app/core/utils/logger.dart';

/// Service để quản lý cookie trong ứng dụng
class CookieService {
  final LoggerService _logger;
  CookieManager? _cookieManager;
  static const String _cookiePath = '.cookies';

  CookieService({required LoggerService logger}) : _logger = logger;

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

  /// Tạo cookie jar phù hợp với platform
  Future<CookieJar> _createCookieJar() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    
    return PersistCookieJar(
      storage: FileStorage("$appDocPath/$_cookiePath/"),
      ignoreExpires: true, // Không xóa cookie hết hạn
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