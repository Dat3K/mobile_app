import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_filter_model.freezed.dart';
part 'student_filter_model.g.dart';

/// Model for filtering students
@freezed
class StudentFilterModel with _$StudentFilterModel {
  const factory StudentFilterModel({
    /// Filter by student ID
    String? id,
    
    /// Filter by user ID
    String? userId,
    
    /// Filter by major
    String? major,
    
    /// Filter by graduation year
    int? graduationYear,
    
    /// Filter by enrollment year
    int? enrollmentYear,
    
    /// Filter by skills (contains any of the skills)
    List<String>? skills,
    
    /// Filter by current enterprise ID
    String? currentEnterpriseId,
    
    /// Filter by graduation status
    bool? isGraduated,
    
    /// Search term to match against multiple fields
    String? searchTerm,
  }) = _StudentFilterModel;

  factory StudentFilterModel.fromJson(Map<String, dynamic> json) => _$StudentFilterModelFromJson(json);
}
