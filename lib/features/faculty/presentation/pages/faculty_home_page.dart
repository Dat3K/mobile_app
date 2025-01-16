import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class FacultyHomePage extends ConsumerWidget {
  const FacultyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user?.email}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            const _FacultyDashboardGrid(),
          ],
        ),
      ),
    );
  }
}

class _FacultyDashboardGrid extends StatelessWidget {
  const _FacultyDashboardGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _DashboardCard(
          icon: Icons.class_,
          title: 'My Classes',
          onTap: () {
            // TODO: Navigate to classes
          },
        ),
        _DashboardCard(
          icon: Icons.assignment,
          title: 'Assignments',
          onTap: () {
            // TODO: Navigate to assignments
          },
        ),
        _DashboardCard(
          icon: Icons.people,
          title: 'Students',
          onTap: () {
            // TODO: Navigate to students
          },
        ),
        _DashboardCard(
          icon: Icons.calendar_today,
          title: 'Schedule',
          onTap: () {
            // TODO: Navigate to schedule
          },
        ),
      ],
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
