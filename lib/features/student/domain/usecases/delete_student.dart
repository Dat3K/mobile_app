import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';

class DeleteStudentUseCase implements UseCase<void, String> {
  final IStudentRepository _repository;

  DeleteStudentUseCase({required IStudentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await _repository.deleteStudent(id);
  }
} 