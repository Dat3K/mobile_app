import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_dependencies.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthState {
  final bool isLoading;
  final UserEntity? user;
  final Failure? failure;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.failure,
  });

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    Failure? failure,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      failure: failure,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required RegisterUseCase registerUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _registerUseCase = registerUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        super(const AuthState()) {
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoading: true, failure: null);
    
    final result = await _getCurrentUserUseCase(NoParams());
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        user: null,
        failure: failure,
      ),
      (user) => state = state.copyWith(
        isLoading: false,
        user: user,
        failure: null,
      ),
    );
  }

  Future<void> login(String email, String password) async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, failure: null);
    
    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        user: null,
        failure: failure,
      ),
      (authResult) => state = state.copyWith(
        isLoading: false,
        user: authResult.user,
        failure: null,
      ),
    );
  }

  Future<void> register(
    String email,
    String password,
    String fullName,
    UserRole role,
  ) async {
    state = state.copyWith(isLoading: true, failure: null);
    
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
        failure: failure,
        user: null,
      ),
      (authResult) => state = state.copyWith(
        isLoading: false,
        user: authResult.user,
        failure: null,
      ),
    );
  }

  Future<void> logout() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, failure: null);
    
    final result = await _logoutUseCase(NoParams());
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (_) => state = state.copyWith(
        isLoading: false,
        user: null,
        failure: null,
      ),
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    loginUseCase: ref.watch(loginUseCaseProvider),
    logoutUseCase: ref.watch(logoutUseCaseProvider),
    registerUseCase: ref.watch(registerUseCaseProvider),
    getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
  );
});
