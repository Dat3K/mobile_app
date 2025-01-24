import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/core/constants/app_routes.dart';

class StudentScaffold extends StatelessWidget {
  final Widget child;

  const StudentScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          NavigationDestination(
            icon: Icon(Icons.grade_outlined),
            selectedIcon: Icon(Icons.grade),
            label: 'Grades',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Events',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('${AppRoutes.student}/courses')) return 1;
    if (location.startsWith('${AppRoutes.student}/assignments')) return 2;
    if (location.startsWith('${AppRoutes.student}/grades')) return 3;
    if (location.startsWith('${AppRoutes.student}/events')) return 4;
    return 0; // Home page
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.student);
        break;
      case 1:
        context.go('${AppRoutes.student}/courses');
        break;
      case 2:
        context.go('${AppRoutes.student}/assignments');
        break;
      case 3:
        context.go('${AppRoutes.student}/grades');
        break;
      case 4:
        context.go('${AppRoutes.student}/events');
        break;
    }
  }
}
