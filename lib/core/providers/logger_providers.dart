import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/utils/logger.dart';

/// Provider cho LoggerService
final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerService();
});