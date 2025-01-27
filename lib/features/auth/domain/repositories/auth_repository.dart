import 'package:dartz/dartz.dart';
import 'package:mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import '../../../../core/error/failures.dart';

class AuthResult {
  final UserEntity user;

  AuthResult({required this.user});
}

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login(String email, String password);
  Future<Either<Failure, AuthResult>> register(String email, String password, String fullName, UserRole role);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> forgotPassword(String email);
}
