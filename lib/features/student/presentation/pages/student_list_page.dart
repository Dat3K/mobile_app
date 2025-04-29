import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/core/widgets/error_display.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../domain/entities/student_entity.dart';
import '../providers/student_provider.dart';

class StudentListPage extends ConsumerStatefulWidget {
  const StudentListPage({super.key});

  @override
  ConsumerState<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends ConsumerState<StudentListPage> {
  @override
  void initState() {
    super.initState();
    // Load students when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStudents();
    });
  }

  Future<void> _loadStudents() async {
    await ref.read(studentNotifierProvider.notifier).getAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentNotifierProvider);
    final students = studentState.students;
    final isLoading = studentState.isLoading;
    final error = studentState.failure;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : _loadStudents,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? ErrorDisplay(
                  failure: error,
                  onRetry: _loadStudents,
                )
              : students.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No students found',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 16.h),
                          ShadButton(
                            onPressed: _loadStudents,
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return _buildStudentCard(context, student);
                      },
                    ),
    );
  }

  Widget _buildStudentCard(BuildContext context, StudentEntity student) {
    return ShadCard(
      padding: EdgeInsets.all(16.sp),
      child: InkWell(
        onTap: () {
          // Set as current student and navigate to profile page
          ref.read(studentNotifierProvider.notifier).getStudent(student.id);
          ref.read(navigationServiceProvider).push(
            RoutePaths.studentProfile,
            params: {'id': student.id},
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Major: ${student.major}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Enrollment: ${student.enrollmentYear} - Graduation: ${student.graduationYear}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  student.isGraduated
                      ? ShadBadge.destructive(
                          child: Text('Graduated'),
                        )
                      : ShadBadge.outline(
                          child: Text('Enrolled'),
                        ),
                ],
              ),
              SizedBox(height: 8.h),
              if (student.skills.isNotEmpty) ...[
                Text(
                  'Skills:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: student.skills.map((skill) {
                    return ShadBadge.secondary(
                      child: Text(skill),
                    );
                  }).toList(),
                ),
              ],
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadButton.outline(
                    onPressed: () {
                      // Handle delete student
                      _showDeleteConfirmation(context, student);
                    },
                    leading: Icon(Icons.delete, size: 16.sp),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, StudentEntity student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () => ref.read(navigationServiceProvider).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(navigationServiceProvider).pop();
              ref
                  .read(studentNotifierProvider.notifier)
                  .deleteStudent(student.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
