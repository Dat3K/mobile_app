import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/features/auth/data/models/user_model.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<void> clearAllData();
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  final SecureStorageService _secureStorage;
  final IStorageService _hiveStorage;
  final ILoggerService _logger;

  AuthLocalDataSource({
    required IStorageService hiveStorage,
    required SecureStorageService secureStorage,
    required ILoggerService logger,
  })  : _hiveStorage = hiveStorage,
        _secureStorage = secureStorage,
        _logger = logger;

  @override
  Future<void> saveUser(UserModel user) async {
    await _hiveStorage.put<UserModel>(StorageKeys.userKey, user, StorageKeys.userBox);
    _logger.i('User saved to local storage');
  }

  @override
  Future<UserModel?> getUser() async {
    final user = await _hiveStorage.get<UserModel>(StorageKeys.userKey, StorageKeys.userBox);
    _logger.i('User retrieved from local storage');
    return user;
  }

  @override
  Future<void> clearUser() async {
    await _hiveStorage.delete(StorageKeys.userKey, StorageKeys.userBox);
    _logger.i('User deleted from local storage');
  }

  @override
  Future<void> clearAllData() async {
    await _secureStorage.deleteSecurityTokens();
    await _hiveStorage.clear();
    _logger.i('All data cleared from local storage');
  }
}
