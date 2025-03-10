import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

class GetStudents {
  final IStudentRepository _repository;

  GetStudents({required IStudentRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<StudentEntity>>> call() async {
    return await _repository.getStudents();
  }
}