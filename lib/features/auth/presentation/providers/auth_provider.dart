import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import 'package:mobile_app/core/utils/logger.dart';
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
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final ILoggerService _logger;
  late final NavigationService _navigationService;
  
  @override
  AuthState build() {
    // Khởi tạo logger
    _logger = ref.read(loggerServiceProvider);
    // Khởi tạo navigation service
    _navigationService = ref.read(navigationServiceProvider);
    // Khởi tạo state mặc định
    Future.microtask(() => _checkAuthOnStartup());
    return const AuthState();
  }

  Future<void> _checkAuthOnStartup() async {
    try {
      await checkAuth();
    } catch (e) {
      _logger.e('Lỗi khởi tạo authentication', e);
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
    _logger.i('Đang đăng nhập với email: $email');

    try {
      final loginUseCase = ref.read(loginUseCaseProvider);
      final result = await loginUseCase(
        LoginParams(email: email, password: password),
      );

      state = result.fold(
        (failure) {
          _logger.w('Đăng nhập thất bại: ${failure.message}');
          // Khi đăng nhập thất bại, repository đã xóa secure storage
          return state.copyWith(
            isLoading: false,
            isAuthenticated: false,
            failure: failure,
          );
        },
        (authResult) {
          _logger.i('Đăng nhập thành công: ${authResult.user.email}');
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
      _logger.e('Lỗi không xác định khi đăng nhập', e);
      // Khi có lỗi không xác định, repository đã xóa secure storage
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
    _logger.i('Đang đăng xuất');

    try {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      final result = await logoutUseCase(NoParams());

      result.fold(
        (failure) {
          _logger.w('Đăng xuất thất bại: ${failure.message}');
          state = state.copyWith(
            isLoading: false,
            failure: failure,
          );
          _navigateToLogin();
        },
        (_) {
          _logger.i('Đăng xuất thành công');
          // Đặt state trước khi chuyển trang
          state = const AuthState();
          // Sau đó chuyển trang và xóa stack
          _navigateToLogin();
        },
      );
    } catch (e) {
      _logger.e('Lỗi không xác định khi đăng xuất', e);
      state = state.copyWith(
        isLoading: false,
        failure: ServerFailure('Lỗi đăng xuất: ${e.toString()}'),
      );
    }
  }

  Future<void> checkAuth() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, failure: null);
    _logger.i('Đang kiểm tra trạng thái xác thực');

    try {
      final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
      final result = await getCurrentUser(NoParams());

      state = result.fold(
        (failure) {
          _logger.i('Không tìm thấy phiên đăng nhập');
          _navigateToLogin();
          return state.copyWith(
            isLoading: false,
            isAuthenticated: false,
            failure: null,
          );
        },
        (user) {
          _logger.i('Tìm thấy phiên đăng nhập: ${user.email}');
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
      _logger.e('Lỗi kiểm tra trạng thái xác thực', e);
      _navigateToLogin();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        failure: ServerFailure('Lỗi kiểm tra xác thực: ${e.toString()}'),
      );
    }
  }

  void _navigateBasedOnRole(UserEntity user) {
    switch (user.role) {
      case UserRole.student:
        _navigationService.replace(RoutePaths.student);
        break;
      case UserRole.enterprise:
        _navigationService.replace(RoutePaths.enterprise);
        break;
    }
  }

  void _navigateToLogin() {
    _navigationService.replace(RoutePaths.login);
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
