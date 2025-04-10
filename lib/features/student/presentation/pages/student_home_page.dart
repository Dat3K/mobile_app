import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/student_provider.dart';
import 'student_form_page.dart';
import 'student_list_page.dart';
import 'student_paginated_list_page.dart';
import 'student_profile_page.dart';

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StudentProfilePage(),
                ),
              );
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentFormPage(
                    student: student,
                    isEditing: student != null,
                  ),
                ),
              );
            }
          },
        ),
        _DashboardCard(
          icon: Icons.people,
          title: 'All Students',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StudentListPage(),
              ),
            );
          },
        ),
        _DashboardCard(
          icon: Icons.filter_list,
          title: 'Search Students',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StudentPaginatedListPage(),
              ),
            );
          },
        ),
        _DashboardCard(
          icon: Icons.event,
          title: 'Events',
          onTap: () {
            // Navigate to events page (to be implemented)
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
