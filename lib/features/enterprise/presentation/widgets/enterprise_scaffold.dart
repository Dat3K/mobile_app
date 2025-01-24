import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/core/constants/app_routes.dart';
import 'package:mobile_app/shared/theme/app_colors.dart';

class EnterpriseScaffold extends StatelessWidget {
  final Widget child;

  const EnterpriseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _calculateSelectedIndex(context),
            onDestinationSelected: (index) => _onItemTapped(index, context),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.work_outlined),
                selectedIcon: Icon(Icons.work),
                label: 'Jobs',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outlined),
                selectedIcon: Icon(Icons.people),
                label: 'Applicants',
              ),
              NavigationDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: 'Analytics',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                selectedIcon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('${AppRoutes.enterprise}/jobs')) return 1;
    if (location.startsWith('${AppRoutes.enterprise}/applicants')) return 2;
    if (location.startsWith('${AppRoutes.enterprise}/analytics')) return 3;
    if (location.startsWith('${AppRoutes.enterprise}/profile')) return 4;
    return 0; // Home page
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.enterprise);
        break;
      case 1:
        context.go('${AppRoutes.enterprise}/jobs');
        break;
      case 2:
        context.go('${AppRoutes.enterprise}/applicants');
        break;
      case 3:
        context.go('${AppRoutes.enterprise}/analytics');
        break;
      case 4:
        context.go('${AppRoutes.enterprise}/profile');
        break;
    }
  }
}
