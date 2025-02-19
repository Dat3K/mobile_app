import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/network/rest/cookie_service.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<void> clearAllData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box _userBox;
  final CookieService _cookieService;
  final SecureStorageService _secureStorage;

  AuthLocalDataSourceImpl({
    required Box userBox,
    required CookieService cookieService,
    required SecureStorageService secureStorage,
  })  : _userBox = userBox,
        _cookieService = cookieService,
        _secureStorage = secureStorage;

  @override
  Future<void> saveUser(UserModel user) async {
    await _userBox.put('user', user);
  }

  @override
  Future<UserModel?> getUser() async {
    final user = _userBox.get('user');
    return user as UserModel?;
  }

  @override
  Future<void> clearUser() async {
    await _userBox.delete('user');
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
  }
}
