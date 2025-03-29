import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/features/student/data/models/student_model.dart';
import 'package:mobile_app/core/network/api_client_interface.dart';

/// GraphQL endpoints for student operations
class StudentEndpoints {
  static const String getStudents = 'GetStudents';
  static const String getStudentById = 'GetStudentById';
  static const String getStudentByUserId = 'GetStudentByUserId';
  static const String addStudent = 'AddStudent';
  static const String updateStudent = 'UpdateStudent';
  static const String deleteStudent = 'DeleteStudent';
}

abstract class IStudentRemoteDataSource {
  Future<Either<Failure, List<StudentModel>>> getStudents({Map<String, dynamic>? filters});
  Future<Either<Failure, StudentModel>> getStudentById(String id);
  Future<Either<Failure, StudentModel>> getStudentByUserId(String userId);
  Future<Either<Failure, bool>> addStudent(StudentModel student);
  Future<Either<Failure, bool>> updateStudent(StudentModel student);
  Future<Either<Failure, bool>> deleteStudent(String id);
}

class StudentRemoteDataSource implements IStudentRemoteDataSource {
  final IApiClient _apiClient;
  final LoggerService _logger;

  StudentRemoteDataSource({
    required IApiClient apiClient,
    required LoggerService logger,
  })  : _apiClient = apiClient,
        _logger = logger;

  @override
  Future<Either<Failure, List<StudentModel>>> getStudents({Map<String, dynamic>? filters}) async {
    _logger.i('Fetching students from remote source with filters: $filters');
    
    // Create the input object for the query
    final Map<String, dynamic> input = filters ?? {};
    
    return await _apiClient.fetch<List<StudentModel>>(
      endpoint: StudentEndpoints.getStudents,
      params: {'input': input},
      fromJson: (data) {
        if (data['getStudents'] == null) {
          return [];
        }
        
        return (data['getStudents'] as List)
          .map((json) => StudentModel.fromJson(json))
          .toList();
      },
    ).then((result) {
      return result.fold(
        (failure) {
          _logger.e('Error fetching students: $failure');
          return Left(failure);
        },
        (students) {
          _logger.i('Fetched ${students.length} students from remote source');
          return Right(students);
        }
      );
    });
  }

  @override
  Future<Either<Failure, StudentModel>> getStudentById(String id) async {
    _logger.i('Fetching student with ID: $id');
    
    return await _apiClient.fetch<StudentModel>(
      endpoint: StudentEndpoints.getStudentById,
      params: {'id': id},
      fromJson: (data) {
        if (data['student'] == null) {
          throw StudentFailure.notFound();
        }
        return StudentModel.fromJson(data['student']);
      },
    ).then((result) {
      return result.fold(
        (failure) {
          _logger.e('Error fetching student: $failure');
          return Left(failure);
        },
        (student) {
          _logger.i('Fetched student: ${student.userId}');
          return Right(student);
        }
      );
    });
  }

  @override
  Future<Either<Failure, StudentModel>> getStudentByUserId(String userId) async {
    _logger.i('Fetching student with user ID: $userId');
    
    return await _apiClient.fetch<StudentModel>(
      endpoint: StudentEndpoints.getStudentByUserId,
      params: {'userId': userId},
      fromJson: (data) {
        if (data['student'] == null) {
          throw StudentFailure.notFound();
        }
        return StudentModel.fromJson(data['student']);
      },
    ).then((result) {
      return result.fold(
        (failure) {
          _logger.e('Error fetching student by user ID: $failure');
          return Left(failure);
        },
        (student) {
          _logger.i('Fetched student: ${student.userId}');
          return Right(student);
        }
      );
    });
  }

  @override
  Future<Either<Failure, bool>> addStudent(StudentModel student) async {
    _logger.i('Adding student: ${student.userId}');
    
    return await _apiClient.send<bool>(
      endpoint: StudentEndpoints.addStudent,
      data: {'student': student.toJson()},
      fromJson: (data) {
        if (data['addStudent'] == null) {
          throw ServerFailure('Error adding student');
        }
        return true;
      },
    ).then((result) {
      return result.fold(
        (failure) {
          _logger.e('Error adding student: $failure');
          return Left(failure);
        },
        (_) {
          _logger.i('Student added successfully: ${student.userId}');
          return const Right(true);
        }
      );
    });
  }

  @override
  Future<Either<Failure, bool>> updateStudent(StudentModel student) async {
    _logger.i('Updating student: ${student.userId}');
    
    return await _apiClient.send<bool>(
      endpoint: StudentEndpoints.updateStudent,
      data: {'student': student.toJson()},
      fromJson: (data) {
        if (data['updateStudent'] == null) {
          throw ServerFailure('Error updating student');
        }
        return true;
      },
    ).then((result) {
      return result.fold(
        (failure) {
          _logger.e('Error updating student: $failure');
          return Left(failure);
        },
        (_) {
          _logger.i('Student updated successfully: ${student.userId}');
          return const Right(true);
        }
      );
    });
  }

  @override
  Future<Either<Failure, bool>> deleteStudent(String id) async {
    _logger.i('Deleting student with ID: $id');
    
    return await _apiClient.send<bool>(
      endpoint: StudentEndpoints.deleteStudent,
      data: {'id': id},
      fromJson: (data) {
        if (data['deleteStudent'] == null) {
          throw ServerFailure('Error deleting student');
        }
        return true;
      },
    ).then((result) {
      return result.fold(
        (failure) {
          _logger.e('Error deleting student: $failure');
          return Left(failure);
        },
        (_) {
          _logger.i('Student deleted successfully with ID: $id');
          return const Right(true);
        }
      );
    });
  }
}