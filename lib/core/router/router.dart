import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_app/features/student/presentation/pages/student_home_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import 'package:mobile_app/core/widgets/error_page.dart';

part 'router.g.dart';

/// Provider cho router - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Có thể watch auth state để redirect
  // final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RoutePaths.login,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    routes: [
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.student,
        name: 'student',
        builder: (context, state) => const StudentHomePage(),
      ),
      GoRoute(
        path: RoutePaths.enterprise,
        name: 'enterprise',
        builder: (context, state) => const EnterpriseHomePage(),
      ),
    ],
  );
} 