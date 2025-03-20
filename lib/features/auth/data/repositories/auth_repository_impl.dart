import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final IAuthLocalDataSource _localDataSource;

  AuthRepository({
    required IAuthRemoteDataSource remoteDataSource,
    required IAuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthResult>> login(
      String email, String password) async {
    try {
      final response = await _remoteDataSource.login(email, password);

      await _localDataSource.saveUser(response);

      return Right(AuthResult(
        user: response.toDomain(),
      ));
    } on Failure catch (failure) {
      _localDataSource.clearAllData();
      return Left(failure);
    } catch (e) {
      return Left(
          ServerFailure('Lỗi đăng nhập không xác định: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();

      await _localDataSource.clearAllData();

      return const Right(null);
    } on Failure catch (failure) {
      _localDataSource.clearAllData();
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Lỗi đăng xuất không xác định: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final cachedUser = await _localDataSource.getUser();
      if (cachedUser != null) {
        return Right(cachedUser.toDomain());
      }

      return Left(CacheFailure.notFound());
    } catch (e) {
      return Left(CacheFailure.notFound());
    }
  }
}
