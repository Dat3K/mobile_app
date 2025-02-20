import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/network/graphql/base_graphql_service.dart';
import 'package:mobile_app/features/student/data/models/student_model.dart';
import 'package:mobile_app/features/student/domain/entities/student.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

final studentRepositoryProvider = Provider<IStudentRepository>((ref) {
  final graphQLService = ref.watch(baseGraphQLServiceProvider);
  return StudentRepositoryImpl(graphQLService);
});

class StudentRepositoryImpl implements IStudentRepository {
  final BaseGraphQLService _graphQLService;
  static const String _boxName = 'students';

  StudentRepositoryImpl(this._graphQLService);

  // Helper method to get Hive box
  Future<Box<Student>> _getBox() async {
    return await Hive.openBox<Student>(_boxName);
  }

  @override
  Future<Either<Failure, List<Student>>> getStudents() async {
    try {
      // First try to get from local storage
      final box = await _getBox();
      final localStudents = box.values.toList();
      
      if (localStudents.isNotEmpty) {
        return Right(localStudents);
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
          final students = models.map((model) => model.toEntity()).toList();
          // Cache the results
          await box.addAll(students);
          return Right(students);
        },
      );
    } catch (e) {
      return Left(CacheFailure.notFound());
    }
  }

  @override
  Future<Either<Failure, Student>> getStudentById(String id) async {
    try {
      // First try to get from local storage
      final box = await _getBox();
      final localStudent = box.get(id);
      
      if (localStudent != null) {
        return Right(localStudent);
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
          final student = model.toEntity();
          // Cache the result
          await box.put(student.id, student);
          return Right(student);
        },
      );
    } catch (e) {
      return Left(StudentFailure.notFound());
    }
  }

  @override
  Future<Either<Failure, Student>> createStudent(Student student) async {
    if (!student.isValid) {
      return Left(StudentFailure.invalidData());
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

    final model = StudentModel.fromEntity(student);
    final result = await _graphQLService.mutation<StudentModel>(
      mutation: mutation,
      variables: {'input': model.toCreateJson()},
      fromJson: (data) => StudentModel.fromJson(data['createStudent']),
    );

    return result.fold(
      (failure) => Left(failure),
      (model) async {
        final newStudent = model.toEntity();
        // Cache the new student
        final box = await _getBox();
        await box.put(newStudent.id, newStudent);
        return Right(newStudent);
      },
    );
  }

  @override
  Future<Either<Failure, Student>> updateStudent(Student student) async {
    if (!student.canUpdate) {
      return Left(ValidationFailure.invalidValue());
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

    final model = StudentModel.fromEntity(student);
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
        final updatedStudent = model.toEntity();
        // Update cache
        final box = await _getBox();
        await box.put(updatedStudent.id, updatedStudent);
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
            final box = await _getBox();
            await box.delete(id);
          } catch (e) {
            return Left(CacheFailure.writeError());
          }
        }
        return Right(success);
      },
    );
  }
} 