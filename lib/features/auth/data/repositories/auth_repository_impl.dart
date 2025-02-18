import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/rest/cookie_service.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/value_objects/user_role.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final CookieService _cookieService;
  final SecureStorageService _secureStorage;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required CookieService cookieService,
    required SecureStorageService secureStorage,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _cookieService = cookieService,
        _secureStorage = secureStorage;

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
      // 1. Gọi API logout
      await _remoteDataSource.logout();
      
      // 2. Xóa dữ liệu local
      await Future.wait([
        _localDataSource.clearUser(),
        _cookieService.clearCookies(),
        _secureStorage.deleteAll(), // Xóa tất cả tokens trong secure storage
      ]);
      
      return const Right(null);
    } on ServerFailure catch (failure) {
      // Nếu lỗi server, vẫn xóa dữ liệu local
      try {
        await Future.wait([
          _localDataSource.clearUser(),
          _cookieService.clearCookies(),
          _secureStorage.deleteAll(),
        ]);
      } catch (e) {
        // Ignore local storage errors
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
