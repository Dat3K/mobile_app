import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Provider cho Hive Box
final userBoxProvider = Provider<Box>((ref) {
  throw UnimplementedError('Initialize in main.dart');
});

/// Provider cho Secure Storage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
}); 