import 'package:mobile_app/core/error/failures.dart';
import '../../../../core/api/api_client.dart';
import '../models/user_model.dart';
import '../../domain/value_objects/user_role.dart';

class AuthResponse {
  final UserModel user;

  AuthResponse({required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json['user']),
    );
  }
}

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
      String email, String password, String fullName, UserRole role);
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _client;

  AuthRemoteDataSourceImpl({
    required ApiClient client,
  }) : _client = client;

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response =
          await _client.post<Map<String, dynamic>>('/login', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response);
    } on ApiException catch (e) {
      throw ServerFailure(e.message);
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

      if (response['statusCode'] == 201) {
        return AuthResponse.fromJson(response);
      } else {
        throw ServerFailure(response['message'] ?? 'Registration failed');
      }
    } on ApiException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _client.post('/auth/forgot-password', data: {
      'email': email,
    });
  }
}
