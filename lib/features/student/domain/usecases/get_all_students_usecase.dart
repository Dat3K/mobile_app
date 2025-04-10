import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import '../entities/student_entity.dart';
import '../repositories/student_repository.dart';

class GetAllStudentsUseCase implements UseCase<List<StudentEntity>, NoParams> {
  final IStudentRepository _repository;

  GetAllStudentsUseCase(this._repository);

  @override
  Future<Either<Failure, List<StudentEntity>>> call(NoParams params) {
    return _repository.getAllStudents();
  }
}
