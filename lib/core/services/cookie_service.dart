import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final cookieServiceProvider = Provider<CookieService>((ref) => CookieService());

class CookieService {
  late CookieJar _cookieJar;
  
  Future<void> init() async {
    if (kIsWeb) {
      // Trên web, chúng ta không sử dụng cookie manager
      // Cookie sẽ được xử lý tự động bởi browser
      _cookieJar = CookieJar(); 
      return;
    }

    try {
      // Chỉ sử dụng persistent storage trên mobile
      final appDocDir = await getApplicationDocumentsDirectory();
      final appDocPath = appDocDir.path;
      
      _cookieJar = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage("$appDocPath/.cookies/"),
      );
    } catch (e) {
      _cookieJar = CookieJar();
    }
  }

  CookieJar get cookieJar => _cookieJar;

  Future<void> clearCookies() async {
    if (kIsWeb) {
      return;
    }


    try {
      await _cookieJar.deleteAll();
    } catch (e) {
      rethrow;
    }

  }

  Future<List<Cookie>> loadForRequest(Uri uri) async {
    if (kIsWeb) {
      // Trên web, return empty list vì cookie được xử lý bởi browser
      return [];
    }

    try {
      return await _cookieJar.loadForRequest(uri);
    } catch (e) {
      return [];
    }

  }

  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
    if (kIsWeb) {
      // Trên web, không cần lưu cookie vì browser đã xử lý
      return;
    }

    try {
      await _cookieJar.saveFromResponse(uri, cookies);
    } catch (e) {
      rethrow;
    }

  }
} 