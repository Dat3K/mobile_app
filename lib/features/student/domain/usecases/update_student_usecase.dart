import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import '../entities/student_entity.dart';
import '../repositories/student_repository.dart';

class UpdateStudentParams {
  final StudentEntity student;

  UpdateStudentParams({required this.student});
}

class UpdateStudentUseCase implements UseCase<StudentEntity, UpdateStudentParams> {
  final IStudentRepository _repository;

  UpdateStudentUseCase(this._repository);

  @override
  Future<Either<Failure, StudentEntity>> call(UpdateStudentParams params) {
    return _repository.updateStudent(params.student);
  }
}
