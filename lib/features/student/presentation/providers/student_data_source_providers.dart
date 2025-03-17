import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import '../../data/datasources/student_local_data_source.dart';
import '../../data/datasources/student_remote_data_source.dart';
import 'package:mobile_app/core/network/graphql/graphql_client.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'student_data_source_providers.g.dart';

@riverpod
StudentLocalDataSource studentLocalDataSource(Ref ref) {
  final hiveStorage = ref.watch(hiveStorageServiceProvider);
  final logger = ref.watch(loggerServiceProvider);

  return StudentLocalDataSource(
    hiveStorage: hiveStorage,
    logger: logger,
  );
}

@riverpod
StudentRemoteDataSource studentRemoteDataSource(Ref ref) {
  final client = ref.watch(graphQLClientProvider);
  final logger = ref.watch(loggerServiceProvider);

  return StudentRemoteDataSource(
    client: client,
    logger: logger,
  );
} 