import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import '../entities/student_entity.dart';
import '../repositories/student_repository.dart';

class CreateStudentParams {
  final StudentEntity student;

  CreateStudentParams({required this.student});
}

class CreateStudentUseCase implements UseCase<StudentEntity, CreateStudentParams> {
  final IStudentRepository _repository;

  CreateStudentUseCase(this._repository);

  @override
  Future<Either<Failure, StudentEntity>> call(CreateStudentParams params) {
    return _repository.createStudent(params.student);
  }
}
