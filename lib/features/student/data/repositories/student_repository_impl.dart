import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/network/graphql/base_graphql_service.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/features/student/data/models/student_model.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

final studentRepositoryProvider = Provider<IStudentRepository>((ref) {
  final graphQLService = ref.watch(baseGraphQLServiceProvider);
  final storageService = ref.watch(hiveStorageServiceProvider);
  return StudentRepositoryImpl(graphQLService, storageService);
});

class StudentRepositoryImpl implements IStudentRepository {
  final BaseGraphQLService _graphQLService;
  final IStorageService _storageService;

  StudentRepositoryImpl(this._graphQLService, this._storageService);

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudents() async {
    try {
      // First try to get from local storage
      final localStudents = await _storageService.getAll<StudentModel>(StorageKeys.studentBox);
      
      if (localStudents.isNotEmpty) {
        return Right(localStudents.map((model) => model.toDomain()).toList());
      }

      // If local is empty, fetch from API
      const query = r'''
        query GetStudents {
          students {
            id
            name
            email
            grade
            createdAt
          }
        }
      ''';

      final result = await _graphQLService.query<List<StudentModel>>(
        query: query,
        fromJson: (data) => (data['students'] as List)
            .map((json) => StudentModel.fromJson(json))
            .toList(),
      );

      return result.fold(
        (failure) => Left(failure),
        (models) async {
          final students = models.map((model) => model.toDomain()).toList();
          // Cache the results
          final entries = {for (var model in models) model.id: model};
          await _storageService.putAll(entries, StorageKeys.studentBox);
          return Right(students);
        },
      );
    } catch (e) {
      return Left(CacheFailure('Failed to get students: $e'));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentById(String id) async {
    try {
      // First try to get from local storage
      final localStudent = await _storageService.get<StudentModel>(id, StorageKeys.studentBox);
      
      if (localStudent != null) {
        return Right(localStudent.toDomain());
      }

      // If not in local storage, fetch from API
      const query = r'''
        query GetStudent($id: ID!) {
          student(id: $id) {
            id
            name
            email
            grade
            createdAt
          }
        }
      ''';

      final result = await _graphQLService.query<StudentModel>(
        query: query,
        variables: {'id': id},
        fromJson: (data) => StudentModel.fromJson(data['student']),
      );

      return result.fold(
        (failure) => Left(failure),
        (model) async {
          final student = model.toDomain();
          // Cache the result
          await _storageService.put(id, model, StorageKeys.studentBox);
          return Right(student);
        },
      );
    } catch (e) {
      return Left(StudentFailure('Failed to get student: $e'));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> createStudent(StudentEntity student) async {
    if (!student.isValid) {
      return Left(StudentFailure('Invalid student data'));
    }

    const mutation = r'''
      mutation CreateStudent($input: CreateStudentInput!) {
        createStudent(input: $input) {
          id
          name
          email
          grade
          createdAt
        }
      }
    ''';

    final model = StudentModel.fromDomain(student);
    final result = await _graphQLService.mutation<StudentModel>(
      mutation: mutation,
      variables: {'input': model.toCreateJson()},
      fromJson: (data) => StudentModel.fromJson(data['createStudent']),
    );

    return result.fold(
      (failure) => Left(failure),
      (model) async {
        final newStudent = model.toDomain();
        // Cache the new student
        await _storageService.put(model.id, model, StorageKeys.studentBox);
        return Right(newStudent);
      },
    );
  }

  @override
  Future<Either<Failure, StudentEntity>> updateStudent(StudentEntity student) async {
    if (!student.canUpdate) {
      return Left(ValidationFailure('Cannot update student'));
    }

    const mutation = r'''
      mutation UpdateStudent($id: ID!, $input: UpdateStudentInput!) {
        updateStudent(id: $id, input: $input) {
          id
          name
          email
          grade
          createdAt
        }
      }
    ''';

    final model = StudentModel.fromDomain(student);
    final result = await _graphQLService.mutation<StudentModel>(
      mutation: mutation,
      variables: {
        'id': model.id,
        'input': model.toUpdateJson(),
      },
      fromJson: (data) => StudentModel.fromJson(data['updateStudent']),
    );

    return result.fold(
      (failure) => Left(failure),
      (model) async {
        final updatedStudent = model.toDomain();
        // Update cache
        await _storageService.put(model.id, model, StorageKeys.studentBox);
        return Right(updatedStudent);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> deleteStudent(String id) async {
    const mutation = r'''
      mutation DeleteStudent($id: ID!) {
        deleteStudent(id: $id)
      }
    ''';

    final result = await _graphQLService.mutation<bool>(
      mutation: mutation,
      variables: {'id': id},
      fromJson: (data) => data['deleteStudent'] as bool,
    );

    return result.fold(
      (failure) => Left(failure),
      (success) async {
        if (success) {
          try {
            // Remove from cache
            await _storageService.delete(id, StorageKeys.studentBox);
          } catch (e) {
            return Left(CacheFailure('Failed to delete from cache: $e'));
          }
        }
        return Right(success);
      },
    );
  }
} 