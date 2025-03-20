import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/network/api_client_interface.dart';
import 'package:mobile_app/features/auth/data/models/user_model.dart';

/// API endpoints for auth-related operations
class AuthEndpoints {
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
}

abstract class IAuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final IApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await _apiClient.send<UserModel>(
        endpoint: AuthEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
        fromJson: (data) {
          if (data['user'] == null) {
            throw AuthFailure.invalidCredentials();
          }
          return UserModel.fromJson(data['user']);
        },
      );
      
      return result.fold(
        (failure) => throw AuthFailure.invalidCredentials(),
        (user) => user,
      );
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw AuthFailure.invalidCredentials();
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final result = await _apiClient.send<UserModel>(
        endpoint: AuthEndpoints.register,
        data: {
          'email': email,
          'password': password,
        },
        fromJson: (data) {
          if (data['user'] == null) {
            throw ValidationFailure.invalidFormat();
          }
          return UserModel.fromJson(data['user']);
        },
      );
      
      return result.fold(
        (failure) {
          if (failure.message.contains('409')) {
            throw ValidationFailure.invalidValue();
          }
          throw ValidationFailure.invalidFormat();
        },
        (user) => user,
      );
    } catch (e) {
      if (e is ValidationFailure) rethrow;
      throw ValidationFailure.invalidFormat();
    }
  }

  @override
  Future<void> logout() async {
    try {
      final result = await _apiClient.send<bool>(
        endpoint: AuthEndpoints.logout,
        fromJson: (data) => true,
      );
      
      result.fold(
        (failure) => throw AuthFailure.requiresLogin(),
        (_) => null,
      );
    } catch (e) {
      throw AuthFailure.requiresLogin();
    }
  }
}
