import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/core/widgets/error_display.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/student_entity.dart';
import '../providers/student_provider.dart';

class StudentFormPage extends ConsumerStatefulWidget {
  final StudentEntity? student;
  final bool isEditing;

  const StudentFormPage({
    super.key,
    this.student,
    this.isEditing = false,
  });

  @override
  ConsumerState<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends ConsumerState<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _majorController;
  late final TextEditingController _enrollmentYearController;
  late final TextEditingController _graduationYearController;
  late final TextEditingController _skillsController;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if editing
    _majorController = TextEditingController(text: widget.student?.major ?? '');
    _enrollmentYearController = TextEditingController(
      text: widget.student?.enrollmentYear.toString() ?? DateTime.now().year.toString(),
    );
    _graduationYearController = TextEditingController(
      text: widget.student?.graduationYear.toString() ?? (DateTime.now().year + 4).toString(),
    );
    _skillsController = TextEditingController(
      text: widget.student?.skills.join(', ') ?? '',
    );
  }

  @override
  void dispose() {
    _majorController.dispose();
    _enrollmentYearController.dispose();
    _graduationYearController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final skills = _skillsController.text
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();

        final enrollmentYear = int.parse(_enrollmentYearController.text);
        final graduationYear = int.parse(_graduationYearController.text);

        if (widget.isEditing && widget.student != null) {
          // Update existing student
          final updatedStudent = widget.student!.copyWith(
            major: _majorController.text,
            enrollmentYear: enrollmentYear,
            graduationYear: graduationYear,
            skills: skills,
          );

          await ref.read(studentNotifierProvider.notifier).updateStudent(updatedStudent);
        } else {
          // Create new student
          final user = ref.read(currentUserProvider);
          if (user == null) {
            throw Exception('User not found');
          }

          final newStudent = StudentEntity(
            id: const Uuid().v4(),
            userId: user.id,
            major: _majorController.text,
            enrollmentYear: enrollmentYear,
            graduationYear: graduationYear,
            skills: skills,
          );

          await ref.read(studentNotifierProvider.notifier).createStudent(newStudent);
        }

        if (mounted) {
          ref.read(navigationServiceProvider).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentNotifierProvider);
    final error = studentState.failure;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Student Profile' : 'Create Student Profile'),
      ),
      body: error != null
          ? ErrorDisplay(
              failure: error,
              onRetry: () {
                ref.read(studentNotifierProvider.notifier).clearError();
              },
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadCard(
                      title: Text(widget.isEditing ? 'Update Your Profile' : 'Create Your Profile'),
                      description: Text('Please fill in your academic information'),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Major field
                            ShadInputFormField(
                              controller: _majorController,
                              label: Text('Major'),
                              placeholder: Text('Enter your major'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Major is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),

                            // Enrollment Year field
                            ShadInputFormField(
                              controller: _enrollmentYearController,
                              label: Text('Enrollment Year'),
                              placeholder: Text('Enter enrollment year'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enrollment year is required';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid year';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),

                            // Graduation Year field
                            ShadInputFormField(
                              controller: _graduationYearController,
                              label: Text('Graduation Year'),
                              placeholder: Text('Enter graduation year'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Graduation year is required';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid year';
                                }
                                final enrollmentYear = int.tryParse(_enrollmentYearController.text) ?? 0;
                                final graduationYear = int.tryParse(value) ?? 0;
                                if (graduationYear <= enrollmentYear) {
                                  return 'Graduation year must be after enrollment year';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),

                            // Skills field
                            ShadInputFormField(
                              controller: _skillsController,
                              label: Text('Skills'),
                              placeholder: Text('Enter skills (comma separated)'),
                              description: Text('Separate skills with commas (e.g., Java, Flutter, SQL)'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Submit button
                    ShadButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      child: _isSubmitting
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const Text('Saving...'),
                              ],
                            )
                          : Text(widget.isEditing ? 'Update Profile' : 'Create Profile'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
