import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/models/pagination/paging_model.dart';
import 'package:mobile_app/core/utils/logger.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_local_data_source.dart';
import '../datasources/student_remote_data_source.dart';
import '../models/student_filter_model.dart';
import '../models/student_model.dart';

class StudentRepository implements IStudentRepository {
  final IStudentRemoteDataSource _remoteDataSource;
  final IStudentLocalDataSource _localDataSource;
  final LoggerService _logger;

  StudentRepository({
    required IStudentRemoteDataSource remoteDataSource,
    required IStudentLocalDataSource localDataSource,
    required LoggerService logger,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _logger = logger;

  @override
  Future<Either<Failure, StudentEntity>> getStudent(String id) async {
    try {
      // Try to get from local cache first
      final localStudent = await _localDataSource.getStudent(id);
      if (localStudent != null) {
        _logger.d('Retrieved student from local cache: $id');
        return Right(localStudent.toDomain());
      }

      // If not in cache, fetch from remote
      final remoteStudent = await _remoteDataSource.getStudent(id);

      // Save to local cache
      await _localDataSource.saveStudent(remoteStudent);

      return Right(remoteStudent.toDomain());
    } on ServerException catch (e) {
      _logger.e('Server error while getting student', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while getting student', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while getting student', e);
      return Left(ServerFailure('Failed to get student: $e'));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentByUserId(String userId) async {
    try {
      // Try to get from local cache first
      final localStudent = await _localDataSource.getStudentByUserId(userId);
      if (localStudent != null) {
        _logger.d('Retrieved student by userId from local cache: $userId');
        return Right(localStudent.toDomain());
      }

      // If not in cache, fetch from remote
      final remoteStudent = await _remoteDataSource.getStudentByUserId(userId);

      // Save to local cache
      await _localDataSource.saveStudent(remoteStudent);

      return Right(remoteStudent.toDomain());
    } on ServerException catch (e) {
      _logger.e('Server error while getting student by userId', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while getting student by userId', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while getting student by userId', e);
      return Left(ServerFailure('Failed to get student by userId: $e'));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllStudents() async {
    try {
      // Try to get from local cache first
      final localStudents = await _localDataSource.getAllStudents();
      if (localStudents.isNotEmpty) {
        _logger.d('Retrieved all students from local cache: ${localStudents.length} students');
        return Right(localStudents.map((model) => model.toDomain()).toList());
      }

      // If not in cache, fetch from remote
      final remoteStudents = await _remoteDataSource.getAllStudents();

      // Save to local cache
      for (final student in remoteStudents) {
        await _localDataSource.saveStudent(student);
      }

      return Right(remoteStudents.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      _logger.e('Server error while getting all students', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while getting all students', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while getting all students', e);
      return Left(ServerFailure('Failed to get all students: $e'));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<StudentEntity>>> getStudents({
    StudentFilterModel? filter,
    PagingModel? paging,
  }) async {
    try {
      // For paginated results, we always fetch from remote to ensure data is up-to-date
      final paginatedResult = await _remoteDataSource.getStudents(
        filter: filter,
        paging: paging,
      );

      // Save fetched students to local cache
      for (final student in paginatedResult.items) {
        await _localDataSource.saveStudent(student);
      }

      // Convert StudentModel to StudentEntity in the paginated result
      final paginatedEntities = PaginatedResult<StudentEntity>(
        items: paginatedResult.items.map((model) => model.toDomain()).toList(),
        total: paginatedResult.total,
        currentPage: paginatedResult.currentPage,
        totalPages: paginatedResult.totalPages,
        pageSize: paginatedResult.pageSize,
        hasNext: paginatedResult.hasNext,
        hasPrevious: paginatedResult.hasPrevious,
      );

      return Right(paginatedEntities);
    } on ServerException catch (e) {
      _logger.e('Server error while getting paginated students', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while saving paginated students', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while getting paginated students', e);
      return Left(ServerFailure('Failed to get paginated students: $e'));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> createStudent(StudentEntity student) async {
    try {
      final studentModel = StudentModel.fromDomain(student);
      final createdStudent = await _remoteDataSource.createStudent(studentModel);

      // Save to local cache
      await _localDataSource.saveStudent(createdStudent);

      return Right(createdStudent.toDomain());
    } on ServerException catch (e) {
      _logger.e('Server error while creating student', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while creating student', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while creating student', e);
      return Left(ServerFailure('Failed to create student: $e'));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> updateStudent(StudentEntity student) async {
    try {
      final studentModel = StudentModel.fromDomain(student);
      final updatedStudent = await _remoteDataSource.updateStudent(studentModel);

      // Update in local cache
      await _localDataSource.saveStudent(updatedStudent);

      return Right(updatedStudent.toDomain());
    } on ServerException catch (e) {
      _logger.e('Server error while updating student', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while updating student', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while updating student', e);
      return Left(ServerFailure('Failed to update student: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String id) async {
    try {
      final success = await _remoteDataSource.deleteStudent(id);

      if (success) {
        // Delete from local cache
        await _localDataSource.deleteStudent(id);
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to delete student'));
      }
    } on ServerException catch (e) {
      _logger.e('Server error while deleting student', e);
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      _logger.e('Cache error while deleting student', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      _logger.e('Unexpected error while deleting student', e);
      return Left(ServerFailure('Failed to delete student: $e'));
    }
  }
}