import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'data_source_providers.dart';

/// Repository family cho các repository cần auth
final authRepositoryFamily = Provider.family<IAuthRepository, bool>((ref, useAuth) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  
    return AuthRepository(
      remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// Auth repository mặc định với auth
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.watch(authRepositoryFamily(true));
});