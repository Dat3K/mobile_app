import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

class DeleteStudent {
  final IStudentRepository _repository;

  DeleteStudent({required IStudentRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call(String id) async {
    return await _repository.deleteStudent(id);
  }
} 