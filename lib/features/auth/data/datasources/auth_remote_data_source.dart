import 'package:mobile_app/core/error/failures.dart';
import '../../../../core/network/http_client_interface.dart';
import '../../../../core/network/http_error.dart';
import '../../../../core/network/dio_client.dart';
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
  final IHttpClient _client;

  AuthRemoteDataSourceImpl({
    required IHttpClient client,
  }) : _client = client;

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      // Đảm bảo có CSRF token mới trước khi login
      if (_client is DioClient) {
        await (_client as DioClient).refreshCsrfToken();
      }

      final response =
          await _client.post<Map<String, dynamic>>('/login', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response);
    } on HttpError catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<AuthResponse> register(
      String email, String password, String fullName, UserRole role) async {
    try {
      // Đảm bảo có CSRF token mới trước khi register
      if (_client is DioClient) {
        await (_client as DioClient).refreshCsrfToken();
      }

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
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      // Đảm bảo có CSRF token mới trước khi gửi yêu cầu reset password
      if (_client is DioClient) {
        await (_client as DioClient).refreshCsrfToken();
      }

      await _client.post<void>('/auth/forgot-password', data: {
        'email': email,
      });
    } on HttpError catch (e) {
      throw ServerFailure(e.message);
    }
  }
}
