import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';
import 'data_source_providers.dart';

part 'repository_providers.g.dart';

/// Provider cho AuthRepository
@Riverpod(keepAlive: true)
IAuthRepository authRepository(Ref ref) {
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  
  return AuthRepository(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
}