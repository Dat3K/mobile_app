import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/value_objects/user_role.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthResult>> login(
      String email, String password) async {
    try {
      final response = await _remoteDataSource.login(email, password);

      // Save session to local storage
      await _localDataSource.saveUser(response.user);

      return Right(AuthResult(
        user: response.user.toDomain(),
      ));
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, AuthResult>> register(
      String email, String password, String fullName, UserRole role) async {
      try {
        final response =
            await _remoteDataSource.register(email, password, fullName, role);

        // Save session to local storage
        await _localDataSource.saveUser(response.user);

        return Right(AuthResult(
          user: response.user.toDomain(),
        ));
      } on Failure catch (failure) {
        return Left(failure);
      }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.clearUser();
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final cachedUser = await _localDataSource.getUser();
      if (cachedUser != null) {
        return Right(cachedUser.toDomain());
      }

      return Left(AuthFailure('No authenticated user found'));
    } catch (e) {
      return Left(AuthFailure('Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
