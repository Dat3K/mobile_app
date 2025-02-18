import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/providers/storage_providers.dart';
import '../network/rest/cookie_service.dart';
import 'logger_providers.dart';
import 'security_providers.dart';

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