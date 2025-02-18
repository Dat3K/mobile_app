import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../security/csrf_token_service.dart';
import 'storage_providers.dart';
import 'logger_providers.dart';

final csrfTokenServiceProvider = Provider<CsrfTokenService>((ref) {
  return CsrfTokenService(
    storage: ref.watch(secureStorageServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
}); 