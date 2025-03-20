import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/network/graphql/graphql_client_adapter.dart';
import 'package:mobile_app/features/student/data/datasources/student_local_data_source.dart';
import 'package:mobile_app/features/student/data/datasources/student_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'student_data_source_providers.g.dart';

@riverpod
IStudentLocalDataSource studentLocalDataSource(Ref ref) {
  final hiveStorage = ref.watch(hiveStorageServiceProvider);
  final logger = ref.watch(loggerServiceProvider);

  return StudentLocalDataSource(
    hiveStorage: hiveStorage,
    logger: logger,
  );
}

@riverpod
IStudentRemoteDataSource studentRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(graphQLClientAdapterProvider);
  final logger = ref.watch(loggerServiceProvider);

  return StudentRemoteDataSource(
    apiClient: apiClient,
    logger: logger,
  );
} 