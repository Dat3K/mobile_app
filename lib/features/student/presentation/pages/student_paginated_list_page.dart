import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/core/widgets/error_display.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../data/models/student_filter_model.dart';
import '../../domain/entities/student_entity.dart';
import '../providers/student_provider.dart';

class StudentPaginatedListPage extends ConsumerStatefulWidget {
  const StudentPaginatedListPage({super.key});

  @override
  ConsumerState<StudentPaginatedListPage> createState() => _StudentPaginatedListPageState();
}

class _StudentPaginatedListPageState extends ConsumerState<StudentPaginatedListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  String? _selectedMajor;
  int? _selectedYear;

  StudentFilterModel get _currentFilter => StudentFilterModel(
    major: _selectedMajor,
    graduationYear: _selectedYear,
    searchTerm: _searchController.text.isNotEmpty ? _searchController.text : null,
  );

  @override
  void initState() {
    super.initState();

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);

    // Load students when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStudents(resetList: true);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final studentState = ref.read(studentNotifierProvider);
      if (!studentState.isLoading && studentState.hasMorePages) {
        ref.read(studentNotifierProvider.notifier).loadMoreStudents(
          filter: _currentFilter,
        );
      }
    }
  }

  Future<void> _loadStudents({bool resetList = false}) async {
    await ref.read(studentNotifierProvider.notifier).getStudents(
      filter: _currentFilter,
      resetList: resetList,
    );
  }

  void _applyFilters() {
    _loadStudents(resetList: true);
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedMajor = null;
      _selectedYear = null;
    });
    _loadStudents(resetList: true);
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentNotifierProvider);
    final students = studentState.students;
    final isLoading = studentState.isLoading;
    final error = studentState.failure;
    final hasMorePages = studentState.hasMorePages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : () => _loadStudents(resetList: true),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter section
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadInputFormField(
                  controller: _searchController,
                  label: Text('Search'),
                  placeholder: Text('Search by name, major, skills...'),
                  trailing: const Icon(Icons.search),
                  onSubmitted: (_) => _applyFilters(),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadButton.outline(
                      onPressed: _resetFilters,
                      child: const Text('Reset'),
                    ),
                    SizedBox(width: 8.w),
                    ShadButton(
                      onPressed: _applyFilters,
                      child: const Text('Apply Filters'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          const Divider(),

          // Results count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Results: ${studentState.paginatedStudents?.total ?? students.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                if (studentState.paginatedStudents != null)
                  Text(
                    'Page ${studentState.currentPage} of ${studentState.paginatedStudents!.totalPages}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),

          // Student list
          Expanded(
            child: error != null
                ? ErrorDisplay(
                    failure: error,
                    onRetry: () => _loadStudents(resetList: true),
                  )
                : students.isEmpty
                    ? const Center(
                        child: Text('No students found'),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16.sp),
                        itemCount: students.length + (hasMorePages ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == students.length) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.sp),
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          }

                          final student = students[index];
                          return _buildStudentCard(context, student);
                        },
                      ),
          ),
        ],
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}
