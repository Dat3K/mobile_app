import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import '../../../../core/api/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String fullName, UserRole role);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post('/login', data: {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<UserModel> register(String email, String password, String fullName, UserRole role) async {
    final response = await client.post('/auth/register', data: {
      'email': email,
      'password': password,
      'fullName': fullName,
      'role': role.name,
    });
    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<void> logout() async {
    await client.post('/auth/logout');
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await client.get('/auth/me');
    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await client.post('/auth/forgot-password', data: {
      'email': email,
    });
  }
}
