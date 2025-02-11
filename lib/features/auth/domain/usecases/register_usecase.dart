import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../value_objects/user_role.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;
  final String fullName;
  final UserRole role;

  RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.role,
  });
}

class RegisterUseCase implements UseCase<AuthResult, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(RegisterParams params) async {
    final result = await repository.register(
      params.email,
      params.password,
      params.fullName,
      params.role,
    );
    return result.fold(
      (failure) => Left(failure),
      (authResult) => Right(authResult),
    );
  }
}
