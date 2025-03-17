import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import 'package:mobile_app/features/student/domain/entities/student_entity.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

class GetStudentsUseCase implements UseCase<List<StudentEntity>, NoParams> {
  final IStudentRepository _repository;

  GetStudentsUseCase({required IStudentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<StudentEntity>>> call(NoParams params) async {
    return await _repository.getStudents();
  }
}