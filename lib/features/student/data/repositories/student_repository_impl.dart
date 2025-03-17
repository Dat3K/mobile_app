import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';
import '../../data/datasources/student_local_data_source.dart';
import '../../data/datasources/student_remote_data_source.dart';
import '../../data/models/student_model.dart';

class StudentRepositoryImpl implements IStudentRepository {
  final IStudentLocalDataSource _localDataSource;
  final IStudentRemoteDataSource _remoteDataSource;

  StudentRepositoryImpl({
    required IStudentLocalDataSource localDataSource,
    required IStudentRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudents() async {

    // If local is empty, fetch from API
    final remoteResult = await _remoteDataSource.getStudents();
    return remoteResult.fold(
      (failure) => Left(failure),
      (models) async {
        // Cache the results
        for (var model in models) {
          await _localDataSource.saveStudent(model);
        }
        return Right(models.map((model) => model.toDomain()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentById(String id) async {
    // First try to get from local storage
    final localStudent = await _localDataSource.getStudent(id);
    if (localStudent != null) {
      return Right(localStudent.toDomain());
    }

    // If not in local storage, fetch from API
    final remoteResult = await _remoteDataSource.getStudentById(id);
    return remoteResult.fold(
      (failure) => Left(failure),
      (model) async {
        // Cache the result
        await _localDataSource.saveStudent(model);
        return Right(model.toDomain());
      },
    );
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentByUserId(String userId) async {
    // First try to get from local storage
    final localStudent = await _localDataSource.getStudentByUserId(userId);
    if (localStudent != null) {
      return Right(localStudent.toDomain());
    }

    // If not in local storage, fetch from API
    final remoteResult = await _remoteDataSource.getStudentByUserId(userId);
    return remoteResult.fold(
      (failure) => Left(failure),
      (model) async {
        // Cache the result
        await _localDataSource.saveStudent(model);
        return Right(model.toDomain());
      },
    );
  }

  @override
  Future<Either<Failure, StudentEntity>> createStudent(StudentEntity student) async {
    await _remoteDataSource.addStudent(StudentModel.fromDomain(student));
    // Cache the new student
    await _localDataSource.saveStudent(StudentModel.fromDomain(student));
    return Right(student);
  }

  @override
  Future<Either<Failure, StudentEntity>> updateStudent(StudentEntity student) async {
    await _remoteDataSource.updateStudent(StudentModel.fromDomain(student));
    // Update cache
    await _localDataSource.saveStudent(StudentModel.fromDomain(student));
    return Right(student);
  }

  @override
  Future<Either<Failure, bool>> deleteStudent(String id) async {
    final remoteResult = await _remoteDataSource.deleteStudent(id);
    return remoteResult.fold(
      (failure) => Left(failure),
      (success) async {
        if (success) {
          // Remove from cache
          await _localDataSource.clearStudent(id);
        }
        return Right(success);
      },
    );
  }
}