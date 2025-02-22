import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/network/rest/dio_client.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import 'storage_providers.dart';

part 'data_source_providers.g.dart';

/// Provider cho AuthLocalDataSource
@riverpod
AuthLocalDataSource authLocalDataSource(ref) {
  final storage = ref.watch(authStorageServicesProvider);
  final logger = ref.watch(loggerServiceProvider);
  return AuthLocalDataSource(
    hiveStorage: storage.hive,
    secureStorage: storage.secure,
    logger: logger,
  );
}

/// Provider cho AuthRemoteDataSource
@riverpod
AuthRemoteDataSource authRemoteDataSource(ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRemoteDataSource(dioClient);
}
