import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final IAuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required IAuthRemoteDataSource remoteDataSource,
    required IAuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthResult>> login(
      String email, String password) async {
    try {
      final response = await _remoteDataSource.login(email, password);

      // Save session to local storage
      await _localDataSource.saveUser(response);

      return Right(AuthResult(
        user: response.toDomain(),
      ));
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // 1. Call logout API first
      await _remoteDataSource.logout();
      
      // 2. Only clear local data after successful logout
      await _localDataSource.clearAllData();
      
      return const Right(null);
    } on ServerFailure catch (failure) {
      try {
        // Even if server logout fails, we should still clear local data
        await _localDataSource.clearAllData();
      } catch (e) {
        return Left(ServerFailure(e.toString()));        
      }
      return Left(failure);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
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
