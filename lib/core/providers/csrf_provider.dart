import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/core/constants/csrf_constants.dart';

final csrfRepositoryProvider = Provider<CsrfRepository>((ref) {
  return CsrfRepository(storage: FlutterSecureStorage());
});

class CsrfRepository {
  final FlutterSecureStorage storage;
  static const String _csrfTokenStorageKey = CsrfConstants.csrfTokenStorageKey;

  CsrfRepository({required this.storage});

  Future<String?> getCsrfToken() async {
    return await storage.read(key: _csrfTokenStorageKey);
  }

  Future<void> setCsrfToken(String token) async {
    await storage.write(
      key: _csrfTokenStorageKey,
      value: token,
    );
  }

  Future<void> deleteCsrfToken() async {
    await storage.delete(key: _csrfTokenStorageKey);
  }
}
