import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/pagination/paging_model.dart';
import '../entities/student_entity.dart';
import '../../data/models/student_filter_model.dart';

abstract class IStudentRepository {
  /// Get a student by ID
  Future<Either<Failure, StudentEntity>> getStudent(String id);

  /// Get a student by user ID
  Future<Either<Failure, StudentEntity>> getStudentByUserId(String userId);

  /// Get all students
  Future<Either<Failure, List<StudentEntity>>> getAllStudents();

  /// Get students with pagination and filtering
  Future<Either<Failure, PaginatedResult<StudentEntity>>> getStudents({
    StudentFilterModel? filter,
    PagingModel? paging,
  });

  /// Create a new student
  Future<Either<Failure, StudentEntity>> createStudent(StudentEntity student);

  /// Update an existing student
  Future<Either<Failure, StudentEntity>> updateStudent(StudentEntity student);

  /// Delete a student
  Future<Either<Failure, void>> deleteStudent(String id);
}