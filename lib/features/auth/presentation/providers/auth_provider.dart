import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/value_objects/user_role.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import './auth_dependencies.dart';

// States
class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);
  return AuthNotifier(
    loginUseCase,
    registerUseCase,
  );
});

// Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthNotifier(this._loginUseCase, this._registerUseCase) : super(AuthState());

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _loginUseCase(
        LoginParams(email: email, password: password),
      );

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
        (user) => state = state.copyWith(
          isLoading: false,
          user: user,
          error: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  Future<void> register(String email, String password, String fullName, UserRole role) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _registerUseCase(
        RegisterParams(
          email: email,
          password: password,
          fullName: fullName,
          role: role,
        ),
      );

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
        (user) => state = state.copyWith(
          isLoading: false,
          user: user,
          error: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void logout() {
    state = AuthState();
  }
}
