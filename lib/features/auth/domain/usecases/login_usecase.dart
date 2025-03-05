import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<AuthResult, LoginParams> {
  final IAuthRepository _repository;

  LoginUseCase({required IAuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, AuthResult>> call(LoginParams params) async {
    return await _repository.login(params.email, params.password);
  
  }
}
