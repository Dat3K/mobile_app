import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/models/user.dart';
import 'package:get_it/get_it.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  return AuthViewModel(GetIt.instance<AuthService>());
});

class AuthViewModel extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;

  AuthViewModel(this._authService) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.login(email, password);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> register(String email, String password, String fullName, String role) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.register(email, password, fullName, role);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AsyncValue.data(null);
  }

  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }
}