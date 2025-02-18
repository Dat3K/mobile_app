import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_app/features/student/presentation/pages/student_home_page.dart';
import 'package:mobile_app/features/enterprise/presentation/pages/enterprise_home_page.dart';
import 'package:mobile_app/core/widgets/error_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.login,
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.student,
        builder: (context, state) => const StudentHomePage(),
      ),
      GoRoute(
        path: RoutePaths.enterprise,
        builder: (context, state) => const EnterpriseHomePage(),
      ),
    ],
  );
}); 