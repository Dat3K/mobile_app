import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

class GetCurrentStudentUseCase implements UseCase<StudentEntity, String> {
  final IStudentRepository _repository;

  GetCurrentStudentUseCase({required IStudentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, StudentEntity>> call(String userId) async {
    return await _repository.getStudentByUserId(userId);
  }
}
