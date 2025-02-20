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
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(LoginParams params) async {
    final result = await repository.login(params.email, params.password);
    return result.fold(
      (failure) => Left(failure),
      (authResult) => Right(authResult),
    );
  }
}
