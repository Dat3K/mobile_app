import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_app/features/student/presentation/pages/student_home_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import 'package:mobile_app/core/widgets/error_display.dart';
import 'package:mobile_app/core/widgets/app_scaffold.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:flutter/material.dart';

part 'router.g.dart';

/// Provider cho router - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Có thể watch auth state để redirect
  // final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RoutePaths.login,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => FullscreenErrorDisplay(
      failure: HttpFailure(state.error?.toString() ?? 'Navigation error'),
      onRetry: () => context.go(RoutePaths.login),
    ),
    routes: [
      // Public routes (không yêu cầu đăng nhập)
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      
      // Student Routes
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.student,
            name: 'student',
            builder: (context, state) => const StudentHomePage(),
          ),
          GoRoute(
            path: RoutePaths.studentRegister,
            name: 'studentRegister',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Register Page')),
            ),
          ),
          GoRoute(
            path: RoutePaths.studentNotifications,
            name: 'studentNotifications',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Notifications Page')),
            ),
          ),
          GoRoute(
            path: RoutePaths.studentProfile,
            name: 'studentProfile',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Profile Page')),
            ),
          ),
        ],
      ),
      
      // Enterprise Routes - Sử dụng Bottom Nav
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: [
          // Trang chủ doanh nghiệp
          GoRoute(
            path: RoutePaths.enterprise,
            name: 'enterprise',
            builder: (context, state) => const EnterpriseHomePage(),
          ),
          // Trang ứng viên
          GoRoute(
            path: RoutePaths.enterpriseApplicants,
            name: 'enterpriseApplicants',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Applicants Page')),
            ),
          ),
          // Trang quản lý sự kiện
          GoRoute(
            path: RoutePaths.enterpriseEvents,
            name: 'enterpriseEvents',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Manage Events Page')),
            ),
          ),
          // Trang hồ sơ doanh nghiệp
          GoRoute(
            path: RoutePaths.enterpriseProfile,
            name: 'enterpriseProfile',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Enterprise Profile Page')),
            ),
          ),
        ],
      ),
    ],
  );
} 