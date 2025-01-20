import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_routes.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import 'package:mobile_app/shared/widgets/error_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/student/presentation/pages/student_home_page.dart';
import 'router_state.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    refreshListenable: notifier,
    redirect: (context, state) => ref.read(routerStateProvider.notifier).redirect(state),
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    routes: _routes,
  );
});

final routerStateProvider = StateNotifierProvider<RouterStateNotifier, RouterState>((ref) {
  return RouterStateNotifier(ref);
});

// Chỉ để notify GoRouter khi auth state thay đổi
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authControllerProvider, (previous, next) {
      // Only notify if auth state actually changed
      if (previous?.user != next.user || previous?.isLoading != next.isLoading) {
        notifyListeners();
      }
    });
  }
}

// Quản lý state và logic điều hướng
class RouterStateNotifier extends StateNotifier<RouterState> {
  final Ref _ref;

  RouterStateNotifier(this._ref) : super(const RouterState());

  String? redirect(GoRouterState goState) {
    final authState = _ref.read(authControllerProvider);
    
    // Don't redirect while loading
    if (authState.isLoading) return null;

    final location = RouteLocation.fromPath(goState.matchedLocation);
    final isLoggedIn = authState.user != null;
    
    // Always redirect to login if not logged in (including after logout)
    if (!isLoggedIn) {
      // Only redirect if not already on login page
      if (location != RouteLocation.login) {
        state = state.copyWith(redirectPath: AppRoutes.login);
        return AppRoutes.login;
      }
      return null;
    }

    // Case 2: Logged in, on login page
    if (location == RouteLocation.login) {
      final homeRoute = _getHomeRouteByRole(authState.user!.role);
      state = state.copyWith(redirectPath: homeRoute);
      return homeRoute;
    }

    // Case 3: Logged in, but not authorized for current route
    if (!location.isAuthorizedFor(authState.user!.role)) {
      final homeRoute = _getHomeRouteByRole(authState.user!.role);
      state = state.copyWith(redirectPath: homeRoute);
      return homeRoute;
    }

    state = state.copyWith(redirectPath: null);
    return null;
  }

  String _getHomeRouteByRole(UserRole role) {
    return switch (role) {
      UserRole.student => AppRoutes.student,
      UserRole.enterprise => AppRoutes.enterprise,
      _ => AppRoutes.login,
    };
  }
}

final _routes = <RouteBase>[
  GoRoute(
    path: AppRoutes.login,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: AppRoutes.student,
    builder: (context, state) => const StudentHomePage(),
    routes: [
      GoRoute(
        path: 'courses',
        builder: (context, state) => const StudentHomePage(), // Replace with actual page
      ),
      GoRoute(
        path: 'assignments',
        builder: (context, state) => const StudentHomePage(), // Replace with actual page
      ),
      GoRoute(
        path: 'grades',
        builder: (context, state) => const StudentHomePage(), // Replace with actual page
      ),
      GoRoute(
        path: 'events',
        builder: (context, state) => const StudentHomePage(), // Replace with actual page
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.enterprise,
    builder: (context, state) => const EnterpriseHomePage(),
    routes: [
      // Add enterprise specific sub-routes here
    ],
  ),
];
