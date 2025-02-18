import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/providers/navigation_providers.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/auth/presentation/providers/usecase_providers.dart';
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
      user: user,
      failure: failure,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final NavigationService _navigationService;

  AuthController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required RegisterUseCase registerUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required NavigationService navigationService,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _registerUseCase = registerUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _navigationService = navigationService,
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
      (user) {
        state = state.copyWith(
          isLoading: false,
          user: user,
          failure: null,
        );
        _navigateBasedOnRole(user);
      },
    );
  }

  void _navigateBasedOnRole(UserEntity user) {
    switch (user.role) {
      case UserRole.student:
        _navigationService.replace(RoutePaths.student);
        break;
      case UserRole.faculty:
        _navigationService.replace(RoutePaths.faculty);
        break;
      case UserRole.enterprise:
        _navigationService.replace(RoutePaths.enterprise);
        break;
    }
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
      (authResult) {
        state = state.copyWith(
          isLoading: false,
          user: authResult.user,
          failure: null,
        );
        _navigateBasedOnRole(authResult.user);
      },
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
      (authResult) {
        state = state.copyWith(
          isLoading: false,
          user: authResult.user,
          failure: null,
        );
        _navigateBasedOnRole(authResult.user);
      },
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
      (_) {
        state = state.copyWith(
          isLoading: false,
          user: null,
          failure: null,
        );
        _navigationService.replace(RoutePaths.login);
      },
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
    navigationService: ref.watch(navigationServiceProvider),
  );
});
