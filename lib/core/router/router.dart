import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_routes.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/student/presentation/pages/student_home_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      // Nếu đang loading, không redirect
      if (authState.isLoading) return null;

      final isLoggedIn = authState.user != null;
      final isLoginPage = state.matchedLocation == AppRoutes.login;

      // Nếu chưa đăng nhập và không ở trang login, chuyển đến trang login
      if (!isLoggedIn && !isLoginPage) {
        return AppRoutes.login;
      }

      // Nếu đã đăng nhập và đang ở trang login, chuyển đến trang tương ứng với role
      if (isLoggedIn && isLoginPage) {
        return authState.user!.role == UserRole.student 
          ? AppRoutes.student 
          : AppRoutes.enterprise;
      }

      // Nếu đã đăng nhập, đảm bảo user đang ở đúng route theo role của họ
      if (isLoggedIn) {
        final isStudent = authState.user!.role == UserRole.student;
        final isStudentRoute = state.matchedLocation == AppRoutes.student;
        final isEnterpriseRoute = state.matchedLocation == AppRoutes.enterprise;

        if (isStudent && !isStudentRoute) {
          return AppRoutes.student;
        }
        if (!isStudent && !isEnterpriseRoute) {
          return AppRoutes.enterprise;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.student,
        name: 'student',
        builder: (context, state) => const StudentHomePage(),
      ),
      GoRoute(
        path: AppRoutes.enterprise,
        name: 'enterprise',
        builder: (context, state) => const EnterpriseHomePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Error: ${state.error}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    ),
  );
});
