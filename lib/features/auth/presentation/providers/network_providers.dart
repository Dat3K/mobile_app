import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/network/rest/dio_client.dart';
import 'package:mobile_app/core/services/logger_service.dart';
import 'package:mobile_app/core/providers/storage_providers.dart';

/// Base Dio instance không có interceptors
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

/// Provider cho LoggerService
final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerService();
});

/// Provider cho DioClient với đầy đủ interceptors và cấu hình
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(
    ref.watch(dioProvider),
    logger: ref.watch(loggerServiceProvider),
    storage: ref.watch(secureStorageServiceProvider),
  );
});
