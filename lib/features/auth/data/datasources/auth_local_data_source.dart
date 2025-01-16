import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<void> saveSession(SessionModel session);
  Future<UserModel?> getUser();
  Future<SessionModel?> getSession();
  Future<void> clearUser();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box _userBox;
  final Box _sessionBox;

  AuthLocalDataSourceImpl(this._userBox, this._sessionBox);

  @override
  Future<void> saveUser(UserModel user) async {
    await _userBox.put('user', user);
  }

  @override
  Future<void> saveSession(SessionModel session) async {
    await _sessionBox.put('session', session);
  }

  @override
  Future<UserModel?> getUser() async {
    final user = _userBox.get('user');
    return user as UserModel?;
  }

  @override
  Future<SessionModel?> getSession() async {
    final session = _sessionBox.get('session');
    return session as SessionModel?;
  }

  @override
  Future<void> clearUser() async {
    await _userBox.delete('user');
  }

  @override
  Future<void> clearSession() async {
    await _sessionBox.delete('session');
  }
}
