import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/features/intro/views/introduction_animation_screen.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/student/views/student_event_view.dart';
import '../../features/enterprise/views/enterprise_event_view.dart';
import '../services/auth_service.dart';
import 'package:get_it/get_it.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authService = GetIt.instance<AuthService>();

  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          if (!authService.isLoggedIn()) {
            return '/login';
          }
          return null;
        },
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/student/events',
        builder: (context, state) => const StudentEventView(),
      ),
      GoRoute(
        path: '/enterprise/events',
        builder: (context, state) => const EnterpriseEventView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
    redirect: (context, state) {
      final isLoggedIn = authService.isLoggedIn();
      final isLoginRoute = state.matchedLocation == '/login';
      final isRegisterRoute = state.matchedLocation == '/register';

      if (!isLoggedIn && !isLoginRoute && !isRegisterRoute) {
        return '/login';
      }

      if (isLoggedIn && (isLoginRoute || isRegisterRoute)) {
        final user = authService.getCurrentUser();
        if (user != null) {
          if (user.role == 'student') {
            return '/student/events';
          } else if (user.role == 'enterprise') {
            return '/enterprise/events';
          }
        }
      }
      return null;
    },
  );
});