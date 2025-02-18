import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/rest/cookie_service.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'data_source_providers.dart';

/// Repository family cho các repository cần auth
final authRepositoryFamily = Provider.family<AuthRepository, bool>((ref, useAuth) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final cookieService = ref.watch(cookieServiceProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    cookieService: cookieService,
    secureStorage: secureStorage,
  );
});

/// Auth repository mặc định với auth
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ref.watch(authRepositoryFamily(true));
});