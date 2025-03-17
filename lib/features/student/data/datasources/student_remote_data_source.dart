import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/features/student/data/models/student_model.dart';

abstract class IStudentRemoteDataSource {
  Future<Either<Failure, List<StudentModel>>> getStudents();
  Future<Either<Failure, StudentModel>> getStudentById(String id);
  Future<Either<Failure, StudentModel>> getStudentByUserId(String userId);
  Future<Either<Failure, bool>> addStudent(StudentModel student);
  Future<Either<Failure, bool>> updateStudent(StudentModel student);
  Future<Either<Failure, bool>> deleteStudent(String id);
} 

class StudentRemoteDataSource implements IStudentRemoteDataSource {
  final GraphQLClient _client;
  final LoggerService _logger;

  StudentRemoteDataSource({
    required GraphQLClient client,
    required LoggerService logger,
  })  : _client = client,
        _logger = logger;

  @override
  Future<Either<Failure, List<StudentModel>>> getStudents() async {
    _logger.i('Fetching students from remote source');
    final QueryOptions options = QueryOptions(
      document: gql(r'''
        query GetStudents {
          students {
            id
            userId
            fullName
            major
            graduationYear
            enrollmentYear
            skills
          }
        }
      '''),
    );

    final result = await _client.query(options);

    if (result.hasException) {
      _logger.e('Error fetching students: ${result.exception}');
      return Left(ServerFailure('Error fetching students'));
    }

    final List<StudentModel> students = (result.data!['students'] as List)
        .map((json) => StudentModel.fromJson(json))
        .toList();
    _logger.i('Fetched ${students.length} students from remote source');
    return Right(students);
  }

  @override
  Future<Either<Failure, StudentModel>> getStudentById(String id) async {
    _logger.i('Fetching student with ID: $id');
    final QueryOptions options = QueryOptions(
      document: gql(r'''
        query GetStudentById(
          $id: String!
        ) {
          student(id: $id) {
            id
            userId
            fullName
            major
            graduationYear
            enrollmentYear
            skills
          }
        }
      '''),
      variables: {'id': id},
    );

    final result = await _client.query(options);

    if (result.hasException) {
      _logger.e('Error fetching student: ${result.exception}');
      throw Exception('Failed to fetch student');
    }

    return Right(StudentModel.fromJson(result.data?['student']));
  }

  @override
  Future<Either<Failure, StudentModel>> getStudentByUserId(String userId) async {
    try {
      final response = await _client.query(QueryOptions(
        document: gql(r'''
          query GetStudentByUserId(
            $userId: String!
          ) {
            student(userId: $userId) {
              id
              userId
              fullName
              major
              graduationYear
              enrollmentYear
              skills
            }
          }
        '''),
        variables: {'userId': userId},
      ));
      
      if (response.hasException) {
        _logger.e('Error fetching student by user ID: ${response.exception}');
        throw Exception('Failed to fetch student by user ID');
      }

      final studentData = response.data?['student'];
      if (studentData == null) {
        return Left(ServerFailure('Student not found'));
      }
      return Right(StudentModel.fromJson(studentData));
    } catch (e) {
      return Left(ServerFailure('Error getting student by user ID: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> addStudent(StudentModel student) async {
    _logger.i('Adding student: ${student.fullName}');
    final MutationOptions options = MutationOptions(
      document: gql(r'''
        mutation AddStudent(
          $student: StudentInput!
        ) {
          addStudent(student: $student) {
            id
          }
        }
      '''),
      variables: {'student': student.toJson()},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('Error adding student: ${result.exception}');
      return Left(ServerFailure('Error adding student'));
    }
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> updateStudent(StudentModel student) async {
    _logger.i('Updating student: ${student.fullName}');
    final MutationOptions options = MutationOptions(
      document: gql(r'''
        mutation UpdateStudent(
          $student: StudentInput!
        ) {
          updateStudent(student: $student) {
            id
          }
        }
      '''),
      variables: {'student': student.toJson()},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('Error updating student: ${result.exception}');
      return Left(ServerFailure('Error updating student'));
    }
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> deleteStudent(String id) async {
    _logger.i('Deleting student with ID: $id');
    final MutationOptions options = MutationOptions(
      document: gql(r'''
        mutation DeleteStudent(
          $id: String!
        ) {
          deleteStudent(id: $id) {
            id
          }
        }
      '''),
      variables: {'id': id},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('Error deleting student: ${result.exception}');
      return Left(ServerFailure('Error deleting student'));
    }
    return Right(true);
  }
}