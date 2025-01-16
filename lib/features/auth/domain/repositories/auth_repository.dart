import 'package:dartz/dartz.dart';
import 'package:mobile_app/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/session.dart';
import '../value_objects/user_role.dart';

class AuthResult {
  final UserEntity user;
  final Session session;

  AuthResult({required this.user, required this.session});
}

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login(String email, String password);
  Future<Either<Failure, AuthResult>> register(String email, String password, String fullName, UserRole role);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> forgotPassword(String email);
}
