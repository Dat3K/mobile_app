import 'package:mobile_app/core/services/cookie_service.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/features/auth/data/models/user_model.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<void> clearAllData();
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  final CookieService _cookieService;
  final SecureStorageService _secureStorage;
  final HiveStorageService _hiveStorage;
  final LoggerService _logger;

  AuthLocalDataSource({
    required HiveStorageService hiveStorage,
    required CookieService cookieService,
    required SecureStorageService secureStorage,
    required LoggerService logger,
  })  : _hiveStorage = hiveStorage,
        _cookieService = cookieService,
        _secureStorage = secureStorage,
        _logger = logger;

  @override
  Future<void> saveUser(UserModel user) async {
    await _hiveStorage.put('user', user, 'user');
    _logger.i('User saved to local storage');
  }

  @override
  Future<UserModel?> getUser() async {
    final user = await _hiveStorage.get('user', 'user');
    _logger.i('User retrieved from local storage');
    return user as UserModel?;

  }

  @override
  Future<void> clearUser() async {
    await _hiveStorage.delete('user', 'user');
    _logger.i('User deleted from local storage');
  }

  @override
  Future<void> clearAllData() async {
    // Clear data in sequence to avoid race conditions
    // 1. Clear secure storage first (tokens, etc)
    await _secureStorage.deleteAll();
    
    // 2. Clear cookies after tokens
    await _cookieService.clearCookies();
    
    // 3. Finally clear user data
    await clearUser();
    _logger.i('All data cleared from local storage');
  }
}
