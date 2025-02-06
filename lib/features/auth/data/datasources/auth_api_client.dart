import '../../../../core/network/http_client_interface.dart';

class AuthApiClient {
  final IHttpClient _httpClient;

  AuthApiClient(this._httpClient);

  /// Login với email và password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await _httpClient.post<Map<String, dynamic>>(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  /// Đăng ký tài khoản mới
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    return await _httpClient.post<Map<String, dynamic>>(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
      },
    );
  }

  /// Refresh token
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    return await _httpClient.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {
        'refresh_token': refreshToken,
      },
    );
  }

  /// Logout
  Future<void> logout() async {
    await _httpClient.post<void>(
      '/auth/logout',
    );
  }
}
