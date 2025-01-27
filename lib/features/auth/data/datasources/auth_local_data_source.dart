import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box _userBox;

  AuthLocalDataSourceImpl(this._userBox);

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
}
