import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import '../repositories/student_repository.dart';

class DeleteStudentParams {
  final String id;

  DeleteStudentParams({required this.id});
}

class DeleteStudentUseCase implements UseCase<void, DeleteStudentParams> {
  final IStudentRepository _repository;

  DeleteStudentUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(DeleteStudentParams params) {
    return _repository.deleteStudent(params.id);
  }
}
