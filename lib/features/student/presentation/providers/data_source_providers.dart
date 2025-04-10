import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/network/graphql/graphql_client_adapter.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/student_local_data_source.dart';
import '../../data/datasources/student_remote_data_source.dart';

part 'data_source_providers.g.dart';

/// Provider for StudentLocalDataSource
@riverpod
StudentLocalDataSource studentLocalDataSource(Ref ref) {
  final storage = ref.watch(hiveStorageServiceProvider);
  final logger = ref.watch(loggerServiceProvider);
  
  return StudentLocalDataSource(
    storage: storage,
    logger: logger,
  );
}

/// Provider for StudentRemoteDataSource
@riverpod
StudentRemoteDataSource studentRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(graphQLClientAdapterProvider);
  final logger = ref.watch(loggerServiceProvider);
  
  return StudentRemoteDataSource(
    apiClient: apiClient,
    logger: logger,
  );
}
