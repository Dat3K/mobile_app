import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import '../entities/student_entity.dart';
import '../repositories/student_repository.dart';

class GetStudentByUserIdParams {
  final String userId;

  GetStudentByUserIdParams({required this.userId});
}

class GetStudentByUserIdUseCase implements UseCase<StudentEntity, GetStudentByUserIdParams> {
  final IStudentRepository _repository;

  GetStudentByUserIdUseCase(this._repository);

  @override
  Future<Either<Failure, StudentEntity>> call(GetStudentByUserIdParams params) {
    return _repository.getStudentByUserId(params.userId);
  }
}
