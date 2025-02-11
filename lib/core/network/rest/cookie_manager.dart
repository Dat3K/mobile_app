import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Cookie;

class AppCookieManager {
  static Future<CookieManager?> create() async {
    // Không sử dụng cookie manager trong môi trường web
    if (kIsWeb) {
      return null;
    }

    // Sử dụng persistent cookie jar cho mobile
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final cookieJar = PersistCookieJar(
      storage: FileStorage("$appDocPath/.cookies/"),
      ignoreExpires: true, // Không xóa cookie hết hạn
    );

    return CookieManager(cookieJar);
  }

  static Future<void> clearCookies(CookieManager? manager) async {
    if (manager == null) return;
    await manager.cookieJar.deleteAll();
  }

  static Future<List<Cookie>> getCookies(
    CookieManager? manager,
    String domain,
  ) async {
    if (manager == null) return [];
    return manager.cookieJar.loadForRequest(Uri.parse(domain));
  }
} 