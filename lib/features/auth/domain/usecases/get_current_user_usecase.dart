import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final IAuthRepository _repository;

  GetCurrentUserUseCase({required IAuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _repository.getCurrentUser();
  }
}
