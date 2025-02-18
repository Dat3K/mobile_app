import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/network/rest/dio_client.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import 'storage_providers.dart';

/// Provider cho Local Data Source
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final userBox = ref.watch(userBoxProvider);
  return AuthLocalDataSourceImpl(userBox);
});

/// Provider cho Remote Data Source
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(dioClientProvider);
  return AuthRemoteDataSourceImpl(client: apiClient);
}); 