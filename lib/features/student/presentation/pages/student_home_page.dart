import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/student_provider.dart';

class StudentHomePage extends ConsumerWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
              padding: EdgeInsets.all(16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${user?.email}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  _StudentDashboardGrid(authState),
                ],
              ),
            ),
    );
  }
}

class _StudentDashboardGrid extends ConsumerWidget {
  const _StudentDashboardGrid(this.authState);

  final AuthState authState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.read(navigationServiceProvider);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.h,
      children: [
        _DashboardCard(
          icon: Icons.person,
          title: 'My Profile',
          onTap: () {
            // Load current user's student profile
            final user = authState.user;
            if (user != null) {
              ref.read(studentNotifierProvider.notifier).getStudentByUserId(user.id);
              navigationService.push(RoutePaths.studentProfile);
            }
          },
        ),
        _DashboardCard(
          icon: Icons.edit,
          title: 'Edit Profile',
          onTap: () {
            // Load current user's student profile and navigate to edit form
            final user = authState.user;
            if (user != null) {
              ref.read(studentNotifierProvider.notifier).getStudentByUserId(user.id);
              final student = ref.read(studentNotifierProvider).currentStudent;
              if (student != null) {
                navigationService.push(RoutePaths.studentEdit, params: {'id': student.id});
              } else {
                navigationService.push(RoutePaths.studentForm);
              }
            }
          },
        ),
        _DashboardCard(
          icon: Icons.people,
          title: 'All Students',
          onTap: () {
            navigationService.push(RoutePaths.studentList);
          },
        ),
        _DashboardCard(
          icon: Icons.filter_list,
          title: 'Search Students',
          onTap: () {
            navigationService.push(RoutePaths.studentPaginatedList);
          },
        ),
        _DashboardCard(
          icon: Icons.event,
          title: 'Events',
          onTap: () {
            // Navigate to events page (to be implemented)
            // Will use navigationService when implemented
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
            Icon(icon, size: 48.sp),
            SizedBox(height: 8.h),
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
