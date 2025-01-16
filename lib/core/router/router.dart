import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/app_routes.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/student/presentation/pages/student_home_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.initial,
    redirect: (context, state) {
      // Nếu đang loading, không redirect
      if (authState.isLoading) return null;

      // Nếu có redirectPath từ AuthState, sử dụng nó
      if (authState.redirectPath != null && 
          authState.redirectPath != state.matchedLocation) {
        return authState.redirectPath;
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
