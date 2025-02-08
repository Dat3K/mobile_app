import 'package:mobile_app/core/error/failures.dart';
import '../../../../core/network/http_client_interface.dart';
import '../../../../core/error/http_error.dart';
import '../models/user_model.dart';
import '../../domain/value_objects/user_role.dart';

class AuthResponse {
  final UserModel user;

  AuthResponse({required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const ServerFailure('Response data is null');
    }

    if (!json.containsKey('user') || json['user'] == null) {
      throw const ServerFailure('User data is required but was null');
    }

    if (json['user'] is! Map<String, dynamic>) {
      throw const ServerFailure('Invalid user data format');
    }

    try {
      return AuthResponse(
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      );
    } catch (e) {
      throw ServerFailure('Error parsing user data: $e');
    }
  }
}

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
      String email, String password, String fullName, UserRole role);
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final IHttpClient _client;

  AuthRemoteDataSourceImpl({
    required IHttpClient client,
  }) : _client = client;

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _client.post<Map<String, dynamic>>('/login', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response);
    } on HttpError catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<AuthResponse> register(
      String email, String password, String fullName, UserRole role) async {
    try {
      final response =
          await _client.post<Map<String, dynamic>>('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullName,
        'role': role.name,
      });
      return AuthResponse.fromJson(response);
    } on HttpError catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _client.post<void>('/auth/forgot-password', data: {
        'email': email,
      });
    } on HttpError catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
