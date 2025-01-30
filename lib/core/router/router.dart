import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_routes.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import 'package:mobile_app/features/enterprise/presentation/widgets/enterprise_scaffold.dart';
import 'package:mobile_app/features/student/presentation/pages/student_home_page.dart';
import 'package:mobile_app/features/student/presentation/widgets/student_scaffold.dart';
import 'package:mobile_app/core/widgets/error_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import 'router_state.dart';
import 'package:mobile_app/features/student/presentation/pages/courses_page.dart';
import 'package:mobile_app/features/student/presentation/pages/assignments_page.dart';
import 'package:mobile_app/features/student/presentation/pages/grades_page.dart';
import 'package:mobile_app/features/student/presentation/pages/events_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/jobs_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/applicants_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/profile_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/analytics_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
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
  // Student Shell Route
  ShellRoute(
    builder: (context, state, child) => StudentScaffold(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.student,
        builder: (context, state) => const StudentHomePage(),
        routes: [
          GoRoute(
            path: 'courses',
            builder: (context, state) => const CoursesPage(),
          ),
          GoRoute(
            path: 'assignments',
            builder: (context, state) => const AssignmentsPage(),
          ),
          GoRoute(
            path: 'grades',
            builder: (context, state) => const GradesPage(),
          ),
          GoRoute(
            path: 'events',
            builder: (context, state) => const EventsPage(),
          ),
        ],
      ),
    ],
  ),
  // Enterprise Shell Route
  ShellRoute(
    builder: (context, state, child) => EnterpriseScaffold(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.enterprise,
        builder: (context, state) => const EnterpriseHomePage(),
        routes: [
          GoRoute(
            path: 'jobs',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const JobsPage(),
          ),
          GoRoute(
            path: 'applicants',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const ApplicantsPage(),
          ),
          GoRoute(
            path: 'profile',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: 'analytics',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const AnalyticsPage(),
          ),
        ],
      ),
    ],
  ),
];
