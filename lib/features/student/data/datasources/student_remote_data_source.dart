import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/models/pagination/paging_model.dart';
import 'package:mobile_app/core/network/graphql/graphql_client_adapter.dart';
import 'package:mobile_app/core/utils/logger.dart';
import '../graphql/student_queries.dart';
import '../models/paginated_students_response.dart';
import '../models/student_filter_model.dart';
import '../models/student_model.dart';

abstract class IStudentRemoteDataSource {
  /// Gets a student from the API by ID
  Future<StudentModel> getStudent(String id);

  /// Gets a student from the API by user ID
  Future<StudentModel> getStudentByUserId(String userId);

  /// Gets all students from the API
  Future<List<StudentModel>> getAllStudents();

  /// Gets students with pagination and filtering
  Future<PaginatedResult<StudentModel>> getStudents({
    StudentFilterModel? filter,
    PagingModel? paging,
  });

  /// Creates a new student in the API
  Future<StudentModel> createStudent(StudentModel student);

  /// Updates an existing student in the API
  Future<StudentModel> updateStudent(StudentModel student);

  /// Deletes a student from the API
  Future<bool> deleteStudent(String id);
}

class StudentRemoteDataSource implements IStudentRemoteDataSource {
  final GraphQLClientAdapter _apiClient;
  final LoggerService _logger;

  StudentRemoteDataSource({
    required GraphQLClientAdapter apiClient,
    required LoggerService logger,
  })  : _apiClient = apiClient,
        _logger = logger;

  @override
  Future<StudentModel> getStudent(String id) async {
    try {
      final result = await _apiClient.fetch(
        endpoint: StudentQueries.getStudent,
        params: {'id': id},
        fromJson: (data) => StudentModel.fromJson(data['student']),
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (student) => student,
      );
    } catch (e) {
      _logger.e('Error fetching student from API', e);
      throw ServerException('Failed to fetch student: $e');
    }
  }

  @override
  Future<StudentModel> getStudentByUserId(String userId) async {
    try {
      final result = await _apiClient.fetch(
        endpoint: StudentQueries.getStudentByUserId,
        params: {'userId': userId},
        fromJson: (data) => StudentModel.fromJson(data['studentByUserId']),
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (student) => student,
      );
    } catch (e) {
      _logger.e('Error fetching student by userId from API', e);
      throw ServerException('Failed to fetch student by userId: $e');
    }
  }

  @override
  Future<List<StudentModel>> getAllStudents() async {
    try {
      final result = await _apiClient.fetch(
        endpoint: StudentQueries.getAllStudents,
        fromJson: (data) => (data['students'] as List)
            .map((student) => StudentModel.fromJson(student))
            .toList(),
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (students) => students,
      );
    } catch (e) {
      _logger.e('Error fetching all students from API', e);
      throw ServerException('Failed to fetch all students: $e');
    }
  }

  @override
  Future<PaginatedResult<StudentModel>> getStudents({
    StudentFilterModel? filter,
    PagingModel? paging,
  }) async {
    try {
      final variables = <String, dynamic>{
        'input': filter?.toJson() ?? {},
        'page': paging?.toJson() ?? {'take': 10, 'index': 1},
      };

      final result = await _apiClient.fetch(
        endpoint: StudentQueries.getStudents,
        params: variables,
        fromJson: (data) {
          final response = PaginatedStudentsResponse.fromJson(data['getStudents']);
          return response.toPaginatedResult();
        },
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (paginatedResult) => paginatedResult,
      );
    } catch (e) {
      _logger.e('Error fetching students with pagination from API', e);
      throw ServerException('Failed to fetch students with pagination: $e');
    }
  }

  @override
  Future<StudentModel> createStudent(StudentModel student) async {
    try {
      final result = await _apiClient.send(
        endpoint: StudentQueries.createStudent,
        data: {'input': student.toCreateJson()},
        fromJson: (data) => StudentModel.fromJson(data['createStudent']),
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (student) => student,
      );
    } catch (e) {
      _logger.e('Error creating student in API', e);
      throw ServerException('Failed to create student: $e');
    }
  }

  @override
  Future<StudentModel> updateStudent(StudentModel student) async {
    try {
      final result = await _apiClient.update(
        endpoint: StudentQueries.updateStudent,
        data: {'input': student.toUpdateJson()},
        params: {'id': student.id},
        fromJson: (data) => StudentModel.fromJson(data['updateStudent']),
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (student) => student,
      );
    } catch (e) {
      _logger.e('Error updating student in API', e);
      throw ServerException('Failed to update student: $e');
    }
  }

  @override
  Future<bool> deleteStudent(String id) async {
    try {
      final result = await _apiClient.remove(
        endpoint: StudentQueries.deleteStudent,
        params: {'id': id},
        fromJson: (data) => data['deleteStudent']['success'] as bool,
      );

      return result.fold(
        (failure) => throw ServerException(failure.message),
        (success) => success,
      );
    } catch (e) {
      _logger.e('Error deleting student from API', e);
      throw ServerException('Failed to delete student: $e');
    }
  }
}