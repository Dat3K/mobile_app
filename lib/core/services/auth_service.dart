import 'package:hive/hive.dart';
import '../api/api_client.dart';
import '../models/user.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final user = User.fromJson(response.data['user']);
      final token = response.data['token'];

      await Hive.box('authBox').put('token', token);
      await Hive.box('authBox').put('user', user);

      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register(String email, String password, String fullName, String role) async {
    try {
      final response = await _apiClient.post('/auth/register', data: {
        'email': email,
        'password': password,
        'full_name': fullName,
        'role': role,
      });

      final user = User.fromJson(response.data['user']);
      final token = response.data['token'];

      await Hive.box('authBox').put('token', token);
      await Hive.box('authBox').put('user', user);

      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    await Hive.box('authBox').delete('token');
    await Hive.box('authBox').delete('user');
  }

  bool isLoggedIn() {
    return Hive.box('authBox').get('token') != null;
  }

  User? getCurrentUser() {
    return Hive.box('authBox').get('user');
  }
}