import 'package:mobile_app/core/error/failures.dart';
import '../../../../core/network/rest/http_client_interface.dart';
import '../models/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final IRestClient _client;

  AuthRemoteDataSource(this._client);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _client.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response == null) {
        throw AuthFailure.invalidCredentials();
      }

      if (response['user'] == null) {
        throw AuthFailure.invalidCredentials();
      }
      
      return UserModel.fromJson(response['user']);
    } catch (e) {
      throw AuthFailure.invalidCredentials();
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response == null || response['user'] == null) {
        throw ValidationFailure.invalidFormat();
      }

      return UserModel.fromJson(response['user']);
    } catch (e) {
      if (e is ValidationFailure) rethrow;
      throw ValidationFailure.invalidFormat();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.post('/auth/logout');
    } catch (e) {
      throw AuthFailure.requiresLogin();
    }
  }
}
