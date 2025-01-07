import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/domain/value_objects/user_role.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/faculty/presentation/pages/faculty_home_page.dart';
import '../../features/student/presentation/pages/student_home_page.dart';
import '../../features/enterprise/presentation/pages/enterprise_home_page.dart';
import '../constants/app_routes.dart';
import '../error/error_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  String? getHomePathForRole(UserRole role) {
    switch (role) {
      case UserRole.faculty:
        return AppRoutes.faculty;
      case UserRole.student:
        return AppRoutes.student;
      case UserRole.enterprise:
        return AppRoutes.enterprise;
    }
  }

  return GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.initial,
        redirect: (context, state) {
          if (authState.user == null) {
            return AppRoutes.login;
          }
          return getHomePathForRole(authState.user!.role);
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterPage(),
      ),
      // Faculty Routes
      GoRoute(
        path: AppRoutes.faculty,
        builder: (context, state) => const FacultyHomePage(),
        redirect: (context, state) {
          if (authState.user == null) {
            return AppRoutes.login;
          }
          if (authState.user!.role != UserRole.faculty) {
            return getHomePathForRole(authState.user!.role);
          }
          return null;
        },
      ),
      // Student Routes
      GoRoute(
        path: AppRoutes.student,
        builder: (context, state) => const StudentHomePage(),
        redirect: (context, state) {
          if (authState.user == null) {
            return AppRoutes.login;
          }
          if (authState.user!.role != UserRole.student) {
            return getHomePathForRole(authState.user!.role);
          }
          return null;
        },
      ),
      // Enterprise Routes
      GoRoute(
        path: AppRoutes.enterprise,
        builder: (context, state) => const EnterpriseHomePage(),
        redirect: (context, state) {
          if (authState.user == null) {
            return AppRoutes.login;
          }
          if (authState.user!.role != UserRole.enterprise) {
            return getHomePathForRole(authState.user!.role);
          }
          return null;
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});
