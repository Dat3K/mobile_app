import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/core/models/pagination/paging_model.dart';
import 'student_model.dart';

part 'paginated_students_response.freezed.dart';
part 'paginated_students_response.g.dart';

/// Response model for paginated students
@freezed
class PaginatedStudentsResponse with _$PaginatedStudentsResponse {
  const PaginatedStudentsResponse._(); // Private constructor for adding methods

  const factory PaginatedStudentsResponse({
    /// List of students for the current page
    required List<StudentModel> items,

    /// Total number of students
    required int total,

    /// Current page index
    required int currentPage,

    /// Total number of pages
    required int totalPages,

    /// Number of students per page
    required int pageSize,

    /// Whether there is a next page
    required bool hasNext,

    /// Whether there is a previous page
    required bool hasPrevious,
  }) = _PaginatedStudentsResponse;

  factory PaginatedStudentsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedStudentsResponseFromJson(json);

  /// Convert to PaginatedResult
  PaginatedResult<StudentModel> toPaginatedResult() {
    return PaginatedResult<StudentModel>(
      items: items,
      total: total,
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      hasNext: hasNext,
      hasPrevious: hasPrevious,
    );
  }
}
