import 'package:dartz/dartz.dart';
import 'package:mobile_app/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/failures.dart';

class AuthResult {
  final UserEntity user;

  AuthResult({required this.user});
}

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
}
