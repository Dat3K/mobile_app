import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import '../entities/student_entity.dart';

abstract class IStudentRepository {
  Future<Either<Failure, List<StudentEntity>>> getStudents();
  Future<Either<Failure, StudentEntity>> getStudentById(String id);
  Future<Either<Failure, StudentEntity>> createStudent(StudentEntity student);
  Future<Either<Failure, StudentEntity>> updateStudent(StudentEntity student);
  Future<Either<Failure, bool>> deleteStudent(String id);
} 