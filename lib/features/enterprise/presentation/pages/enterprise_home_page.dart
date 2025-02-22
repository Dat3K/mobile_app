import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class EnterpriseHomePage extends ConsumerWidget {
  const EnterpriseHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enterprise Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => {},
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
            const _EnterpriseDashboardGrid(),
          ],
        ),
      ),
    );
  }
}

class _EnterpriseDashboardGrid extends StatelessWidget {
  const _EnterpriseDashboardGrid();

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
          icon: Icons.work,
          title: 'Job Postings',
          onTap: () {
            // TODO: Navigate to job postings
          },
        ),
        _DashboardCard(
          icon: Icons.people_outline,
          title: 'Applicants',
          onTap: () {
            // TODO: Navigate to applicants
          },
        ),
        _DashboardCard(
          icon: Icons.business,
          title: 'Company Profile',
          onTap: () {
            // TODO: Navigate to company profile
          },
        ),
        _DashboardCard(
          icon: Icons.analytics,
          title: 'Analytics',
          onTap: () {
            // TODO: Navigate to analytics
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
