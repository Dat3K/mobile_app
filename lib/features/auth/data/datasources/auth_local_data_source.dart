import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final String _userBoxName = 'userBox';
  final String _userKey = 'currentUser';

  @override
  Future<void> cacheUser(UserModel user) async {
    final box = await Hive.openBox(_userBoxName);
    await box.put(_userKey, user.toJson());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final box = await Hive.openBox(_userBoxName);
    final userData = box.get(_userKey);
    if (userData != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    final box = await Hive.openBox(_userBoxName);
    await box.delete(_userKey);
  }
}
