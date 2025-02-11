import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/network/rest/cookie_service.dart';
import 'package:mobile_app/core/providers/logger_providers.dart';

/// Provider cho CookieService
final cookieServiceProvider = Provider<CookieService>((ref) {
  return CookieService(
    logger: ref.watch(loggerServiceProvider),
  );
}); 