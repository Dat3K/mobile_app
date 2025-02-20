import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

class GetStudents {
  final IStudentRepository _repository;

  GetStudents(this._repository);

  Future<Either<Failure, List<StudentEntity>>> call() async {
    return _repository.getStudents();
  }
} 