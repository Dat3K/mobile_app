import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/widgets/error_display.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../providers/student_provider.dart';

class StudentProfilePage extends ConsumerStatefulWidget {
  const StudentProfilePage({super.key});

  @override
  ConsumerState<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends ConsumerState<StudentProfilePage> {
  @override
  void initState() {
    super.initState();
    // Load student data when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStudentData();
    });
  }

  Future<void> _loadStudentData() async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      await ref.read(studentNotifierProvider.notifier).getStudentByUserId(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentNotifierProvider);
    final student = studentState.currentStudent;
    final isLoading = studentState.isLoading;
    final error = studentState.failure;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? ErrorDisplay(
                  failure: error,
                  onRetry: _loadStudentData,
                )
              : student == null
                  ? const Center(child: Text('No student data found'))
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile header
                          ShadCard(
                            title: Text('Student Information'),
                            description: Text('Your academic profile details'),
                            child: Padding(
                              padding: EdgeInsets.all(16.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow('Major', student.major),
                                  SizedBox(height: 8.h),
                                  _buildInfoRow('Enrollment Year', student.enrollmentYear.toString()),
                                  SizedBox(height: 8.h),
                                  _buildInfoRow('Graduation Year', student.graduationYear.toString()),
                                  SizedBox(height: 8.h),
                                  _buildInfoRow('Years of Study', student.yearsOfStudy.toString()),
                                  SizedBox(height: 8.h),
                                  _buildInfoRow('Status', student.isGraduated ? 'Graduated' : 'Enrolled'),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Skills',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 8.h),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    children: student.skills.map((skill) {
                                      return ShadBadge.outline(
                                        child: Text(skill),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Edit button
                          ShadButton(
                            onPressed: () {
                              // Navigate to edit profile page
                            },
                            child: const Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
