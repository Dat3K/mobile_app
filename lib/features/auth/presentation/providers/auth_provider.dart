import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import 'package:mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/auth/presentation/providers/usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

/// Auth state
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserEntity? user,
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    Failure? failure,
  }) = _AuthState;

  const AuthState._();

  bool get hasError => failure != null;
}

/// Auth notifier để quản lý state authentication
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Khởi tạo state mặc định
    Future.microtask(() => _checkAuthOnStartup());
    return const AuthState();
  }

  Future<void> _checkAuthOnStartup() async {
    try {
      await checkAuth();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        failure: ServerFailure('Lỗi khởi tạo authentication: ${e.toString()}'),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, failure: null);

    try {
      final loginUseCase = ref.read(loginUseCaseProvider);
      final result = await loginUseCase(
        LoginParams(email: email, password: password),
      );

      state = result.fold(
        (failure) => state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          failure: failure,
        ),
        (authResult) {
          _navigateBasedOnRole(authResult.user);
          return state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: authResult.user,
            failure: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        failure: ServerFailure('Lỗi đăng nhập: ${e.toString()}'),
      );
    }
  }

  Future<void> logout() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, failure: null);

    try {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      final result = await logoutUseCase(NoParams());

      state = result.fold(
        (failure) => state.copyWith(
          isLoading: false,
          failure: failure,
        ),
        (_) {
          _navigateToLogin();
          return const AuthState();
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Lỗi đăng xuất: ${e.toString()}'),
      );
    }
  }

  Future<void> checkAuth() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, failure: null);

    try {
      final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
      final result = await getCurrentUser(NoParams());

      state = result.fold(
        (failure) {
          _navigateToLogin();
          return state.copyWith(
            isLoading: false,
            isAuthenticated: false,
            failure: null,
          );
        },
        (user) {
            _navigateBasedOnRole(user);
            return state.copyWith(
              isLoading: false,
              isAuthenticated: true,
              user: user,
            failure: null,
          );
        },
      );
    } catch (e) {
      _navigateToLogin();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        failure: ServerFailure('Lỗi kiểm tra xác thực: ${e.toString()}'),
      );
    }
  }

  void _navigateBasedOnRole(UserEntity user) {
    final navigation = ref.read(navigationServiceProvider);
    
    switch (user.role) {
      case UserRole.student:
        navigation.replace(RoutePaths.student);
        break;
      case UserRole.enterprise:
        navigation.replace(RoutePaths.enterprise);
        break;
    }
  }

  void _navigateToLogin() {
    final navigation = ref.read(navigationServiceProvider);
    navigation.replace(RoutePaths.login);
  }
}

/// Provider cho current user
@riverpod
UserEntity? currentUser(Ref ref) {
  return ref.watch(authNotifierProvider.select((state) => state.user));
}

/// Provider cho user role
@riverpod
UserRole? userRole(Ref ref) {
  return ref.watch(authNotifierProvider.select((state) => state.user?.role));
}

/// Provider cho auth status
@riverpod
bool isAuthenticated(Ref ref) {
  return ref.watch(authNotifierProvider.select((state) => state.isAuthenticated));
}

/// Provider cho loading status
@riverpod
bool isLoading(Ref ref) {
  return ref.watch(authNotifierProvider.select((state) => state.isLoading));
}

/// Provider cho error status
@riverpod
bool hasError(Ref ref) {
  return ref.watch(authNotifierProvider.select((state) => state.hasError));
}

/// Provider cho failure message
@riverpod
String? failureMessage(Ref ref) {
  final failure = ref.watch(authNotifierProvider.select((state) => state.failure));
  return failure?.message;
}
