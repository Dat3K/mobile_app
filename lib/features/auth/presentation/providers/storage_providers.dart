import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';

part 'storage_providers.g.dart';

/// Provider cho auth storage services
@riverpod
AuthStorageServices authStorageServices(ref) {
  final hiveStorage = ref.watch(hiveStorageServiceProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AuthStorageServices(hiveStorage, secureStorage);
}

/// Class để quản lý các storage services cho auth
class AuthStorageServices {
  final HiveStorageService _hiveStorage;
  final SecureStorageService _secureStorage;

  AuthStorageServices(this._hiveStorage, this._secureStorage);

  HiveStorageService get hive => _hiveStorage;
  SecureStorageService get secure => _secureStorage;
}